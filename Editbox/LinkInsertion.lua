-- BigChatBox Editbox/LinkInsertion.lua — Shift-click link insertion
-- Two-tier approach:
--   Tier 1: Panels that call ChatEdit_InsertLink or HandleModifiedItemClick
--   Tier 2: Panels that show ChatFrame1EditBox with a link (OnShow hook grabs it)
--
-- ██  TAINT-SENSITIVE  ██
-- All hooks use hooksecurefunc. Never replaces global functions directly.
-- Never touches ChatFrame1EditBox during lockdown.

local BCB = BigChatBox

-- Debounce state
BCB._suppressEditBoxHook = false
BCB._lastLinkInsertTime  = 0
local lastInsertedLink = nil
local lastInsertTime   = 0

--------------------------------------------------------------------------------
-- INSERT LINK INTO BCB's EDITBOX
--------------------------------------------------------------------------------
local function InsertLinkIntoBCB(link)
    if not link or not BCB.editBox or not BCB.frame then return false end
    -- Debounce: same link within 0.15s
    local now = GetTime()
    if link == lastInsertedLink and (now - lastInsertTime) < 0.15 then return true end
    -- Already in text
    local currentText = BCB.editBox:GetText() or ""
    if currentText:find(link, 1, true) then return true end

    if BCB.frame:IsShown() or BCB.editBox:HasFocus() then
        if not BCB.editBox:HasFocus() then BCB.editBox:SetFocus() end
        BCB.editBox:Insert(link)
        lastInsertedLink = link
        lastInsertTime   = now
        BCB._lastLinkInsertTime = now
        return true
    end
    return false
end
BCB.InsertLinkIntoBCB = InsertLinkIntoBCB

--------------------------------------------------------------------------------
-- SYNC CHAT TYPE TO BLIZZARD
-- Copies BCB's chatType/tellTarget/channelTarget to ChatFrame1EditBox
-- so Blizzard's GetActiveChatType() works correctly.
--------------------------------------------------------------------------------
function BCB.SyncChatTypeToBlizzard()
    if BCB.IsSecureContentActive() then return end
    if not BCB.editBox or not ChatFrame1EditBox then return end
    local chatType      = BCB.editBox:GetAttribute("chatType")      or "SAY"
    local tellTarget    = BCB.editBox:GetAttribute("tellTarget")    or ""
    local channelTarget = BCB.editBox:GetAttribute("channelTarget") or ""
    ChatFrame1EditBox:SetAttribute("chatType", chatType)
    ChatFrame1EditBox:SetAttribute("tellTarget", tellTarget)
    ChatFrame1EditBox:SetAttribute("channelTarget", channelTarget)
end

--------------------------------------------------------------------------------
-- GRAB LINK FROM BLIZZARD'S EDITBOX
-- Used after Tier 2 panels inject text into ChatFrame1EditBox.
--------------------------------------------------------------------------------
local function GrabLinkFromBlizzardEditBox()
    if BCB.IsSecureContentActive() then return end
    if not ChatFrame1EditBox or not BCB.editBox or not BCB.frame then return end
    if not BCB.frame:IsShown() then return end

    local blizzText = ChatFrame1EditBox:GetText() or ""
    if blizzText == "" then return end

    local foundLink = false
    for link in blizzText:gmatch("|c%x+|H.-|h%[.-%]|h|r") do
        InsertLinkIntoBCB(link); foundLink = true
    end
    if not foundLink then
        for link in blizzText:gmatch("|H.-|h%[.-%]|h") do
            InsertLinkIntoBCB(link); foundLink = true
        end
    end

    ChatFrame1EditBox:SetText("")
    ChatFrame1EditBox:Hide()
end

--------------------------------------------------------------------------------
-- HOOKS (all use hooksecurefunc — taint-safe)
--------------------------------------------------------------------------------

-- Tier 1: ChatEdit_InsertLink
hooksecurefunc("ChatEdit_InsertLink", function(link)
    if not BCB.frame or not BCB.frame:IsShown() then return end
    if not link then return end
    BCB._suppressEditBoxHook = true
    InsertLinkIntoBCB(link)
    C_Timer.After(0.01, function()
        GrabLinkFromBlizzardEditBox()
        BCB._suppressEditBoxHook = false
    end)
end)

-- Tier 1: HandleModifiedItemClick — items, spells, recipes
if HandleModifiedItemClick then
    hooksecurefunc("HandleModifiedItemClick", function(link)
        if not link then return end
        if not IsModifiedClick("CHATLINK") then return end
        InsertLinkIntoBCB(link)
    end)
end

-- Tier 1: HandleChatLink — crafting orders, some profession panels
if HandleChatLink then
    hooksecurefunc("HandleChatLink", function(link)
        InsertLinkIntoBCB(link)
    end)
end

--------------------------------------------------------------------------------
-- CHAT CLICK HOOKS
-- Clicking a player/BNplayer/channel name in the chat output.
-- Uses hooksecurefunc on SetItemRef.
--------------------------------------------------------------------------------
hooksecurefunc("SetItemRef", function(link, text, button, chatFrame)
    if not link or not BCB.frame or not BCB.editBox then return end
    local linkType, linkData = link:match("^(%a+):(.+)")
    if not linkType then return end

    -- Player link — left-click → open whisper
    if linkType == "player" and button == "LeftButton" then
        local fullName = linkData:match("^([^:]+)")
        if not fullName then return end
        local playerName = Ambiguate(fullName, "none")
        local bnetID
        if BNet_GetBNetIDAccountFromCharacterName then bnetID = BNet_GetBNetIDAccountFromCharacterName(fullName) end
        if not bnetID and BNet_GetBNetIDAccount then bnetID = BNet_GetBNetIDAccount(fullName) end
        BCB.frame:Show(); BCB.editBox:SetFocus()
        if bnetID then
            BCB.editBox:SetAttribute("chatType", "BN_WHISPER")
            BCB.editBox:SetAttribute("tellTarget", fullName)
        else
            BCB.editBox:SetAttribute("chatType", "WHISPER")
            BCB.editBox:SetAttribute("tellTarget", playerName)
        end
        BigChatBoxDB.lastChatType = BCB.editBox:GetAttribute("chatType")
        if BCB.UpdateChannelDisplay then BCB.UpdateChannelDisplay() end
        return
    end

    -- BNet friend link
    if linkType == "BNplayer" and button == "LeftButton" then
        local presenceName = linkData:match("^([^:]+):(%d+)")
        if presenceName then
            BCB.frame:Show(); BCB.editBox:SetFocus()
            BCB.editBox:SetAttribute("chatType", "BN_WHISPER")
            BCB.editBox:SetAttribute("tellTarget", presenceName)
            BigChatBoxDB.lastChatType = "BN_WHISPER"
            if BCB.UpdateChannelDisplay then BCB.UpdateChannelDisplay() end
        end
        return
    end

    -- Channel link
    if linkType == "channel" then
        local chanNum = tonumber(linkData)
        if chanNum then
            BCB.frame:Show(); BCB.editBox:SetFocus()
            BCB.editBox:SetAttribute("chatType", "CHANNEL")
            BCB.editBox:SetAttribute("channelTarget", chanNum)
            BigChatBoxDB.lastChatType = "CHANNEL"
            if BCB.UpdateChannelDisplay then BCB.UpdateChannelDisplay() end
        end
        return
    end
end)

-- SendTell / SendBNetTell hooks — right-click menu, friends list, etc.
local function OnSendTell(name)
    if not name or name == "" then return end
    if not BCB.frame or not BCB.editBox then return end
    local bnetID
    if BNet_GetBNetIDAccountFromCharacterName then bnetID = BNet_GetBNetIDAccountFromCharacterName(name) end
    if not bnetID and BNet_GetBNetIDAccount then bnetID = BNet_GetBNetIDAccount(name) end
    if bnetID then
        BCB.editBox:SetAttribute("chatType", "BN_WHISPER")
    else
        BCB.editBox:SetAttribute("chatType", "WHISPER")
    end
    BCB.editBox:SetAttribute("tellTarget", name)
    BCB.editBox:SetText(""); BCB.editBox:SetCursorPosition(0)
    BigChatBoxDB.lastChatType = BCB.editBox:GetAttribute("chatType")
    if BCB.UpdateChannelDisplay then BCB.UpdateChannelDisplay() end
end
if ChatFrame_SendTell then hooksecurefunc("ChatFrame_SendTell", OnSendTell) end
if ChatFrameUtil and ChatFrameUtil.SendTell then hooksecurefunc(ChatFrameUtil, "SendTell", OnSendTell) end

local function OnSendBNetTell(presenceName)
    if not presenceName or presenceName == "" then return end
    if not BCB.frame or not BCB.editBox then return end
    BCB.frame:Show(); BCB.editBox:SetFocus()
    BCB.editBox:SetAttribute("chatType", "BN_WHISPER")
    BCB.editBox:SetAttribute("tellTarget", presenceName)
    BCB.editBox:SetText(""); BCB.editBox:SetCursorPosition(0)
    BigChatBoxDB.lastChatType = "BN_WHISPER"
    if BCB.UpdateChannelDisplay then BCB.UpdateChannelDisplay() end
end
if ChatFrame_SendBNetTell then hooksecurefunc("ChatFrame_SendBNetTell", OnSendBNetTell) end
if ChatFrameUtil and ChatFrameUtil.SendBNetTell then hooksecurefunc(ChatFrameUtil, "SendBNetTell", OnSendBNetTell) end

-- ChatFrame_OpenChat hook — redirect to BCB
hooksecurefunc("ChatFrame_OpenChat", function(text, chatFrame)
    if BCB.IsSecureContentActive() then return end
    if BCB._useBlizzardChat then return end
    if BCB.frame and BCB.editBox then
        BCB.frame:Show(); BCB.editBox:SetFocus()
        if text and text ~= "" then
            BCB.editBox:SetText(text)
            BCB.editBox:SetCursorPosition(#text)
        end
    end
end)
