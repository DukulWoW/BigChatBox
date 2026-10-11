-- BigChatBox Editbox/SendMessage.lua — Dual-mode message dispatch
-- Normal mode: route through Blizzard's ChatFrame1EditBox for full BNet compat
-- Lockdown mode: direct API calls (SendChatMessage, BNSendWhisper)

local BCB = BigChatBox
local L = BCB.L or {}

local CHAT_MSG_LIMIT = 255
local MAX_SPLITS = 5     -- max number of chunks to prevent accidental spam

--------------------------------------------------------------------------------
-- MESSAGE SPLITTING
-- Splits text on word boundaries. Each chunk ≤ CHAT_MSG_LIMIT characters.
--------------------------------------------------------------------------------
local function SplitMessage(text, limit)
    if #text <= limit then return { text } end
    local chunks = {}
    while #text > 0 and #chunks < MAX_SPLITS do
        if #text <= limit then
            chunks[#chunks + 1] = text
            break
        end
        -- Find last space within limit
        local cut = limit
        local space = text:sub(1, limit):find("%s[^%s]*$")
        if space and space > 1 then
            cut = space - 1
        end
        chunks[#chunks + 1] = text:sub(1, cut)
        text = text:sub(cut + 1):match("^%s*(.*)$") or ""  -- trim leading space from remainder
    end
    return chunks
end
BCB.SplitMessage = SplitMessage

-- More messages than this from one multi-line send asks first (BUG-06)
BCB.MULTILINE_CONFIRM_ABOVE = 10

--------------------------------------------------------------------------------
-- SEND A SINGLE CHUNK (extracted from the original dual-mode dispatch)
--------------------------------------------------------------------------------
local function SendSingleMessage(text, chatType, sendTarget, sendChannel)
    if BCB.IsSafeToTouchBlizzard() then
        -- Use ChatFrame1EditBox directly (ChatEdit_ChooseBoxForSend may return nil
        -- after the first send hides the editbox during split message bursts)
        local activeEditBox = ChatFrame1EditBox
        if activeEditBox then
            local actualSendType = chatType
            if chatType == "WHISPER" and sendTarget ~= "" then
                local bnetID = BNet_GetBNetIDAccount and BNet_GetBNetIDAccount(sendTarget)
                if not bnetID then bnetID = BNet_GetBNetIDAccountFromCharacterName and BNet_GetBNetIDAccountFromCharacterName(sendTarget) end
                if bnetID then actualSendType = "BN_WHISPER" end
            elseif chatType == "BN_WHISPER" then
                actualSendType = "BN_WHISPER"
            end
            -- BUG-20: BCB only borrows Blizzard's editbox to send, so keep it invisible
            -- (alpha 0) while it is shown, hide it again straight after the send, then
            -- restore its alpha. Without this it flashes on screen for a moment on every
            -- send. Ctrl+Enter (BCB_UseBlizzardChat) is a separate path and still shows it.
            local wasShown  = activeEditBox:IsShown()
            local prevAlpha = activeEditBox:GetAlpha()
            activeEditBox:SetAlpha(0)
            activeEditBox:Show()
            activeEditBox:SetAttribute("chatType", actualSendType)
            activeEditBox:SetAttribute("tellTarget", sendTarget)
            activeEditBox:SetAttribute("channelTarget", sendChannel)
            activeEditBox:SetText(text)
            ChatEdit_SendText(activeEditBox, 0)
            activeEditBox:SetText("")
            if not wasShown then activeEditBox:Hide() end
            activeEditBox:SetAlpha(prevAlpha)
        end
    else
        BCB.SendDirect(text, chatType, sendTarget, sendChannel)
    end
end

--------------------------------------------------------------------------------
-- DIRECT API SEND (no Blizzard editbox, no secure context needed)
-- Used for: lockdown mode, split message chunks 2+, and confirmation sends.
-- Uses C_ChatInfo.SendChatMessage (Midnight 12.0+) to avoid taint from the
-- deprecated SendChatMessage wrapper in Blizzard_DeprecatedChatInfo.
--------------------------------------------------------------------------------
function BCB.SendDirect(text, chatType, sendTarget, sendChannel)
    local Send = C_ChatInfo and C_ChatInfo.SendChatMessage or SendChatMessage
    if chatType == "BN_WHISPER" then
        local bnID = BNet_GetBNetIDAccount and BNet_GetBNetIDAccount(sendTarget)
        if not bnID then bnID = BNet_GetBNetIDAccountFromCharacterName and BNet_GetBNetIDAccountFromCharacterName(sendTarget) end
        if bnID then BNSendWhisper(bnID, text) end
    elseif chatType == "WHISPER" then
        local bnID = BNet_GetBNetIDAccount and BNet_GetBNetIDAccount(sendTarget)
        if not bnID then bnID = BNet_GetBNetIDAccountFromCharacterName and BNet_GetBNetIDAccountFromCharacterName(sendTarget) end
        if bnID then
            BNSendWhisper(bnID, text)
        else
            Send(text, "WHISPER", nil, sendTarget)
        end
    elseif chatType == "CHANNEL" then
        Send(text, "CHANNEL", nil, sendChannel)
    else
        Send(text, chatType)
    end
end

--------------------------------------------------------------------------------
-- SEND MULTIPLE CHUNKS synchronously
-- All chunks are sent in the same execution frame to preserve the secure
-- hardware event context from the user's Enter keypress. C_Timer.After loses
-- this context and causes ADDON_ACTION_BLOCKED in Midnight 12.0.
-- WoW's server-side chat throttle is generous for normal messages.
--------------------------------------------------------------------------------
local function SendChunks(chunks, chatType, sendTarget, sendChannel)
    for i, chunk in ipairs(chunks) do
        SendSingleMessage(chunk, chatType, sendTarget, sendChannel)
    end
end

--------------------------------------------------------------------------------
-- CONFIRMATION POPUP for split messages
-- OnAccept routes each chunk through the Blizzard editbox synchronously.
-- The popup button click carries a hardware event, so SetAttribute + 
-- ChatEdit_SendText remain taint-free.
--------------------------------------------------------------------------------
StaticPopupDialogs["BCB_CONFIRM_SPLIT"] = {
    text = L["POPUP_CONFIRM_SPLIT"],
    button1 = L["BTN_SEND"],
    button2 = L["CANCEL"],
    OnAccept = function(self, data)
        if not data then return end
        if data.items then
            -- Multi-line send (BUG-06): each item carries its own channel
            for _, it in ipairs(data.items) do
                if it.history then BCB.AddToHistory(it.history, it.chatType) end
                if data.direct then
                    BCB.SendDirect(it.text, it.chatType, it.sendTarget, it.sendChannel)
                else
                    SendSingleMessage(it.text, it.chatType, it.sendTarget, it.sendChannel)
                end
            end
            if data.onDone then data.onDone() end
            return
        end
        for _, chunk in ipairs(data.chunks) do
            SendSingleMessage(chunk, data.chatType, data.sendTarget, data.sendChannel)
        end
    end,
    OnCancel = function(self, data)
        -- Reopen BCB with the original text so the user doesn't lose their message
        if data and data.originalText then
            C_Timer.After(0.1, function()
                if BCB.frame and BCB.editBox then
                    BCB.frame:Show()
                    BCB.editBox:SetText(data.originalText)
                    BCB.editBox:SetCursorPosition(#data.originalText)
                    BCB.editBox:SetFocus()
                end
            end)
        end
    end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

--------------------------------------------------------------------------------
-- MULTI-LINE SENDING (BUG-06, shared by multi-line snippets and the multiline box)
-- Lines that start with "/" block the whole send: BCB is not a macro runner, and
-- sending them as plain text is never what the player meant (Open question 7).
-- Lines over 255 characters are split on word boundaries instead of cut off.
-- Returns items, totalChars; or nil when a slash line blocked the send.
--------------------------------------------------------------------------------
function BCB.BuildMultilineItems(lines, resolve)
    local items, total = {}, 0
    for _, line in ipairs(lines) do
        local trimmed = line:match("^%s*(.-)%s*$") or line
        if trimmed:sub(1, 1) == "/" then
            BCB:Print(L["MULTILINE_SLASH_BLOCKED"])
            return nil
        end
    end
    for _, line in ipairs(lines) do
        local trimmed = line:match("^%s*(.-)%s*$") or line
        if trimmed ~= "" then
            -- resolve(text) -> finalText, chatType, sendTarget, sendChannel (nil = skip)
            local text, chatType, sendTarget, sendChannel = resolve(trimmed)
            if text and text ~= "" then
                total = total + #text
                local chunks = SplitMessage(text, CHAT_MSG_LIMIT)
                for i, chunk in ipairs(chunks) do
                    items[#items + 1] = { text = chunk, chatType = chatType, sendTarget = sendTarget,
                                          sendChannel = sendChannel, history = (i == 1) and text or nil }
                end
            end
        end
    end
    return items, total
end

-- Sends the items now, or asks first when there are many. Returns true when sent.
function BCB.SendMultilineItems(items, total, direct, onDone)
    if #items > BCB.MULTILINE_CONFIRM_ABOVE then
        StaticPopup_Show("BCB_CONFIRM_SPLIT", total, #items, { items = items, direct = direct, onDone = onDone })
        return false
    end
    for _, it in ipairs(items) do
        if it.history then BCB.AddToHistory(it.history, it.chatType) end
        if direct then
            BCB.SendDirect(it.text, it.chatType, it.sendTarget, it.sendChannel)
        else
            SendSingleMessage(it.text, it.chatType, it.sendTarget, it.sendChannel)
        end
    end
    if onDone then onDone() end
    return true
end

--------------------------------------------------------------------------------
-- SEND MESSAGE
-- Called from OnEnterPressed. Handles snippet expansion, RAID→INSTANCE fallback,
-- and the dual-mode dispatch.
--------------------------------------------------------------------------------
function BCB.SendMessage(text, editBox)
    local chatType    = editBox:GetAttribute("chatType") or "SAY"
    local sendTarget  = editBox:GetAttribute("tellTarget") or ""
    local sendChannel = editBox:GetAttribute("channelTarget")

    -- Add to whisper history when actually sending
    if chatType == "WHISPER" or chatType == "BN_WHISPER" then
        if sendTarget ~= "" then BCB.AddToWhisperHistory(sendTarget) end
    end

    -- Expand snippets (returns expanded text + optional channel override)
    local snippetChannel
    if text:sub(1, 1) ~= "/" and BCB.ExpandSnippets then
        text, snippetChannel = BCB.ExpandSnippets(text)
    end
    if not text then return end  -- nil = blocked (throttle/security)

    -- Determine final send type
    local sendType = chatType

    -- Snippet channel override
    if snippetChannel and snippetChannel ~= "anywhere" then
        local chanNum = snippetChannel:match("^channel_(%d+)$")
        if chanNum then
            sendType = "CHANNEL"; sendChannel = tonumber(chanNum); sendTarget = ""
        elseif BCB.SNIPPET_CHANNEL_MAP[snippetChannel] then
            sendType = BCB.SNIPPET_CHANNEL_MAP[snippetChannel]; sendTarget = ""; sendChannel = ""
        end
    end

    -- Smart RAID → INSTANCE_CHAT fallback for public groups (LFR, etc.)
    if sendType == "RAID" and not IsInRaid(LE_PARTY_CATEGORY_HOME) then
        if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
            sendType = "INSTANCE_CHAT"
        elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
            sendType = "PARTY"
        end
    end

    -- Multiline snippet: if the expanded text contains newlines, send each line separately
    if text:find("\n", 1, true) then
        local lines, s = {}, 1
        while true do
            local nl = text:find("\n", s, true)
            lines[#lines + 1] = nl and text:sub(s, nl - 1) or text:sub(s)
            if not nl then break end
            s = nl + 1
        end
        local items, total = BCB.BuildMultilineItems(lines, function(t) return t, sendType, sendTarget, sendChannel end)
        if items then BCB.SendMultilineItems(items, total, false) end
        return
    end

    -- Add to history (with final resolved send type for channel color display)
    BCB.AddToHistory(text, sendType)

    -- Check if message needs splitting
    local splitMode = BigChatBoxDB.messageSplitMode or "notice"
    if #text > CHAT_MSG_LIMIT and splitMode ~= "off" then
        local chunks = SplitMessage(text, CHAT_MSG_LIMIT)
        if #chunks > 1 then
            if splitMode == "confirm" then
                StaticPopup_Show("BCB_CONFIRM_SPLIT", #text, #chunks, {
                    chunks = chunks, chatType = sendType, sendTarget = sendTarget, sendChannel = sendChannel, originalText = text
                })
                return
            end
            -- "silent" or "notice": send immediately
            SendChunks(chunks, sendType, sendTarget, sendChannel)
            if splitMode == "notice" then
                BCB:Print(string.format(L["MSG_SPLIT_NOTICE"], #chunks, #text))
            end
            return
        end
    end

    -- Normal single-message send
    SendSingleMessage(text, sendType, sendTarget, sendChannel)
end

--------------------------------------------------------------------------------
-- "USE BLIZZARD CHAT" KEYBINDING
-- Opens Blizzard's native editbox instead of BCB. Useful for shift-clicking
-- mounts, achievements, toys, talents that don't insert into BCB.
--------------------------------------------------------------------------------
BCB._useBlizzardChat = false

function BCB_UseBlizzardChat()
    if BCB.IsSecureContentActive() then return end

    BCB._useBlizzardChat = true
    BCB._suppressEditBoxHook = true

    if BCB.frame and BCB.frame:IsShown() and BCB.editBox then
        local bcbText = BCB.editBox:GetText() or ""
        BCB.SyncChatTypeToBlizzard()
        BCB.editBox:SetText(""); BCB.editBox:ClearFocus()
        BCB.frame:Hide()

        if ChatFrame1EditBox then
            ChatFrame1EditBox:Show(); ChatFrame1EditBox:SetFocus()
            if bcbText ~= "" then
                ChatFrame1EditBox:SetText(bcbText)
                ChatFrame1EditBox:SetCursorPosition(#bcbText)
            end
        end
    else
        if ChatFrame1EditBox then
            ChatFrame1EditBox:Show(); ChatFrame1EditBox:SetFocus()
        end
    end

    C_Timer.After(0.1, function()
        BCB._useBlizzardChat = false
        BCB._suppressEditBoxHook = false
    end)
end
