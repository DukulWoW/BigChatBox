-- BigChatBox Editbox/ChatIntercept.lua — Default editbox hook & command parsing
--
-- ██  CRITICAL TAINT-SENSITIVE FILE  ██
-- The HookScript("OnShow") on ChatFrame1EditBox MUST early-return during lockdown.
-- This file should be short and auditable. Every line that touches a secure frame
-- is documented.

local BCB = BigChatBox

--------------------------------------------------------------------------------
-- PARSE CHAT COMMANDS
-- Detects /s, /g, /p, /r, /w, /1, etc. in typed text and switches channel.
--------------------------------------------------------------------------------
local function ParseChatCommand(text)
    if not text or text == "" then return end

    local command = text:match("^(/[%w]+)")
    if not command then return end
    local lowerCommand = command:lower()

    -- Whispers require a target name
    if lowerCommand == "/w" or lowerCommand == "/whisper" or lowerCommand == "/t" or lowerCommand == "/tell" then
        local target = text:match("^/[%w]+ ([^ ]+)")
        if target and text:match("^/[%w]+ [^ ]+ ") then
            BCB.editBox:SetAttribute("chatType", "WHISPER")
            BCB.editBox:SetAttribute("tellTarget", target)
            BCB.UpdateChannelDisplay()
            local newText = text:gsub("^/[%w]+ [^ ]+ ", "")
            BCB.editBox:SetText(newText)
            BCB.editBox:SetCursorPosition(#newText)
            return true
        end
        return false
    end

    -- Channel numbers /1 /2 /3
    local channelNum = text:match("^/(%d+) ")
    if channelNum then
        channelNum = tonumber(channelNum)
        local channels = {GetChannelList()}
        for i = 1, #channels, 3 do
            if channels[i] == channelNum then
                BCB.editBox:SetAttribute("chatType", "CHANNEL")
                BCB.editBox:SetAttribute("channelTarget", channelNum)
                BCB.UpdateChannelDisplay()
                local newText = text:gsub("^/%d+ ", "")
                BCB.editBox:SetText(newText)
                BCB.editBox:SetCursorPosition(#newText)
                return true
            end
        end
    end

    -- Standard commands
    local newChatType = BCB.COMMAND_MAP[lowerCommand]
    if newChatType and text:match("^/[%w]+ ") then
        BCB.editBox:SetAttribute("chatType", newChatType)
        BCB.UpdateChannelDisplay()
        local newText = text:gsub("^/[%w]+ ", "")
        BCB.editBox:SetText(newText)
        BCB.editBox:SetCursorPosition(#newText)
        return true
    end

    return false
end
BCB.ParseChatCommand = ParseChatCommand

--------------------------------------------------------------------------------
-- HOOK DEFAULT EDITBOXES
-- Hooks OnShow on all ChatFrameNEditBox frames to redirect to BCB.
-- The first check in the hook is ALWAYS IsSecureContentActive() — if true,
-- the function returns immediately and Blizzard handles everything.
--------------------------------------------------------------------------------
function BCB.HookDefaultEditBox()
    for i = 1, NUM_CHAT_WINDOWS do
        local chatFrame = _G["ChatFrame" .. i]
        if chatFrame and chatFrame.editBox then
            local defaultEditBox = chatFrame.editBox

            -- On Classic we can use SetScript directly — no taint risk, no secure frame
            -- lockdown system. This eliminates the brief flicker of the Blizzard editbox
            -- appearing before BCB takes over (which happened because HookScript appends
            -- after Blizzard's own OnShow, meaning BCB ran after the box was already shown).
            -- On Midnight (retail) we must use HookScript to avoid taint from overriding
            -- a protected frame's script handler.
            local hookFn = BCB.IsClassic and "SetScript" or "HookScript"

            defaultEditBox[hookFn](defaultEditBox, "OnShow", function(self)
                -- TAINT GUARD: during lockdown, pass through to Blizzard
                if BCB.IsSecureContentActive() then
                    if not BCB._lockdownNotified then
                        BCB._lockdownNotified = true
                        local reason = "combat"
                        if C_ChallengeMode and C_ChallengeMode.IsChallengeModeActive and C_ChallengeMode.IsChallengeModeActive() then
                            reason = "an active M+ keystone"
                        else
                            local _, instanceType = IsInInstance()
                            if instanceType == "arena" then reason = "arena"
                            elseif instanceType == "pvp" then reason = "a rated battleground" end
                        end
                        if BigChatBoxDB.showLockdownWarning == nil or BigChatBoxDB.showLockdownWarning then
                            print("|cff00ff00BigChatBox|r: Paused during " .. reason .. " — using Blizzard's default chat. BCB will resume when you're out.")
                        end
                    end
                    return  -- ← CRITICAL: let Blizzard handle it
                end

                if BCB._suppressEditBoxHook then return end
                if BCB._useBlizzardChat then return end

                -- Tab-click guard: PreClick on ChatFrameNTab sets this flag BEFORE
                -- FCF_Tab_OnClick runs and triggers editBox:Show(). PostClick clears
                -- it next frame. This catches all tab-click-triggered shows reliably.
                if BCB._tabClickInProgress then return end

                -- Mouse-click guard: catches chat body clicks and any other mouse-
                -- triggered shows not covered by the tab-click guard. If the left
                -- mouse button is held when OnShow fires, this wasn't an Enter press.
                -- Shift+Click link insertion is exempted via IsModifiedClick.
                if IsMouseButtonDown("LeftButton") and not IsModifiedClick("CHATLINK") then return end

                -- BCB already visible — likely a link insertion
                if BCB.frame and BCB.frame:IsShown() then
                    C_Timer.After(0.02, function()
                        if not BCB.frame or not BCB.editBox then return end
                        if not BCB.IsSafeToTouchBlizzard() then return end
                        local blizzText = self:GetText() or ""
                        if blizzText ~= "" then
                            for link in blizzText:gmatch("|c%x+|H.-|h%[.-%]|h|r") do
                                BCB.InsertLinkIntoBCB(link)
                            end
                            if not blizzText:find("|c%x+|H") then
                                for link in blizzText:gmatch("|H.-|h%[.-%]|h") do
                                    BCB.InsertLinkIntoBCB(link)
                                end
                            end
                            self:SetText("")  -- TAINT: touches ChatFrame1EditBox (safe — checked above)
                        end
                        self:Hide()  -- TAINT: touches ChatFrame1EditBox (safe — checked above)
                        if BCB.frame:IsShown() then BCB.editBox:SetFocus() end
                    end)
                    return
                end

                -- Normal chat open (Enter, Reply, etc.) — redirect to BCB
                if BCB.editBox then
                    self:SetAlpha(0)

                    local defaultText = self:GetText()
                    local hasSlashCommand = defaultText and defaultText:match("^/")

                    -- On Classic, SetScript replaces Blizzard's OnShow entirely, so
                    -- Shift+Click links land here (BCB closed) rather than in the
                    -- "BCB already visible" branch above. Detect and insert them now.
                    local hasLink = defaultText and (
                        defaultText:find("|c%x+|H.-|h%[.-%]|h|r") or
                        defaultText:find("|H.-|h%[.-%]|h")
                    )
                    if BCB.IsClassic and hasLink then
                        BCB.editBox:SetText("")
                        BCB.editBox:SetCursorPosition(0)
                        -- Copy channel state from Blizzard editbox
                        BCB.editBox:SetAttribute("chatType",      self:GetAttribute("chatType"))
                        BCB.editBox:SetAttribute("stickyType",    self:GetAttribute("stickyType"))
                        BCB.editBox:SetAttribute("tellTarget",    self:GetAttribute("tellTarget"))
                        BCB.editBox:SetAttribute("channelTarget", self:GetAttribute("channelTarget"))
                        BCB.UpdateChannelDisplay()
                        BCB.frame:Show()
                        BCB.editBox:SetFocus()
                        self:SetText(""); self:Hide(); self:SetAlpha(1)
                        -- Insert link(s) into BCB
                        C_Timer.After(0.02, function()
                            if not BCB.InsertLinkIntoBCB then return end
                            for link in defaultText:gmatch("|c%x+|H.-|h%[.-%]|h|r") do
                                BCB.InsertLinkIntoBCB(link)
                            end
                            if not defaultText:find("|c%x+|H") then
                                for link in defaultText:gmatch("|H.-|h%[.-%]|h") do
                                    BCB.InsertLinkIntoBCB(link)
                                end
                            end
                        end)
                        return
                    end

                    BCB.editBox:SetText("")
                    BCB.editBox:SetCursorPosition(0)

                    -- Copy attributes from Blizzard's editbox
                    local chatType      = self:GetAttribute("chatType")
                    local stickyType    = self:GetAttribute("stickyType")
                    local tellTarget    = self:GetAttribute("tellTarget")
                    local channelTarget = self:GetAttribute("channelTarget")

                    local isExplicitWhisper = (chatType == "WHISPER" or chatType == "BN_WHISPER") and tellTarget and tellTarget ~= ""
                    if not isExplicitWhisper then
                        if BigChatBoxDB.lastChatType and (stickyType or chatType == "SAY") then
                            chatType = BigChatBoxDB.lastChatType
                        elseif chatType == "SAY" and not BigChatBoxDB.lastChatType then
                            -- Smart default: guild if in guild, otherwise stay on SAY
                            if IsInGuild and IsInGuild() then chatType = "GUILD" end
                        end
                    end

                    BCB.editBox:SetAttribute("chatType", chatType)
                    BCB.editBox:SetAttribute("stickyType", stickyType)
                    BCB.editBox:SetAttribute("tellTarget", self:GetAttribute("tellTarget"))
                    BCB.editBox:SetAttribute("channelTarget", self:GetAttribute("channelTarget"))

                    if hasSlashCommand then
                        BCB.editBox:SetText(defaultText)
                        BCB.editBox:SetCursorPosition(#defaultText)
                    end

                    BCB.UpdateChannelDisplay()
                    BCB.frame:Show()
                    BCB.editBox:SetFocus()

                    self:Hide()      -- TAINT: safe — checked above
                    self:SetAlpha(1)
                end
            end)

            BCB.defaultEditBoxes = BCB.defaultEditBoxes or {}
            BCB.defaultEditBoxes[i] = defaultEditBox
        end
    end

    -- Hook chat tab buttons via PreClick — fires BEFORE OnClick and therefore
    -- before FCF_Tab_OnClick, which internally shows/hides the editbox.
    -- This ensures _tabClickInProgress is true when the OnShow hook fires.
    -- (hooksecurefunc on FCF_Tab_OnClick fires AFTER — too late to block OnShow.)
    -- Chat tab buttons are not secure frames — HookScript is safe here.
    for i = 1, NUM_CHAT_WINDOWS do
        local tab = _G["ChatFrame" .. i .. "Tab"]
        if tab then
            tab:HookScript("PreClick", function()
                BCB._tabClickInProgress = true
            end)
            tab:HookScript("PostClick", function()
                -- Clear next frame so it doesn't persist across events.
                -- C_Timer.After(0) fires on the next frame update.
                C_Timer.After(0, function()
                    BCB._tabClickInProgress = false
                end)
            end)
        end
    end
end
