-- BigChatBox Editbox/ChatIntercept.lua — Default editbox hook & command parsing
--
-- ██  CRITICAL TAINT-SENSITIVE FILE  ██
-- The HookScript("OnShow") on ChatFrame1EditBox MUST early-return during lockdown.
-- This file should be short and auditable. Every line that touches a secure frame
-- is documented.

local BCB = BigChatBox
local L = BCB.L

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
                        -- BUG-18: text from the locale table (string reads only)
                        local reason = L["LOCKDOWN_REASON_COMBAT"]
                        if C_ChallengeMode and C_ChallengeMode.IsChallengeModeActive and C_ChallengeMode.IsChallengeModeActive() then
                            reason = L["LOCKDOWN_REASON_KEYSTONE"]
                        else
                            local _, instanceType = IsInInstance()
                            if instanceType == "arena" then reason = L["LOCKDOWN_REASON_ARENA"]
                            elseif instanceType == "pvp" then reason = L["LOCKDOWN_REASON_RATED_BG"] end
                        end
                        if BigChatBoxDB.showLockdownWarning == nil or BigChatBoxDB.showLockdownWarning then
                            BCB:Print(string.format(L["LOCKDOWN_PAUSED"], reason))
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
                        -- BUG-08: restore a whisper or channel type only when its target is
                        -- known. After a reload Blizzard's box has no target, and BCB would
                        -- otherwise open a whisper to nobody. (Only BCB's own box is affected.)
                        local last = BigChatBoxDB.lastChatType
                        local needsTarget = last == "WHISPER" or last == "BN_WHISPER" or last == "CHANNEL"
                        local hasTarget = (last == "CHANNEL" and channelTarget ~= nil)
                            or ((last == "WHISPER" or last == "BN_WHISPER") and (tellTarget or "") ~= "")
                        if last and (stickyType or chatType == "SAY") and (not needsTarget or hasTarget) then
                            chatType = last
                        elseif chatType == "SAY" then
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

    -- WOW FOREVER (FOR-11): Blizzard leaves the chat editbox shown (faded) after a
    -- message is sent with Enter and after login/reload; only Escape hides it. The
    -- OnShow hook above then never fires on the next Enter, so BCB never takes over.
    -- Hide the box when chat closes, as Retail does, so the OnShow hook keeps working.
    -- Uses BCB.IsForever (FOR-02) when present, else the same check computed here.
    local isForever = BCB.IsForever
    if isForever == nil then
        local interface = select(4, GetBuildInfo()) or 0
        isForever = interface >= 16000 and interface < 20000
    end
    if isForever then
        local function IsHookedBox(box)
            for _, b in pairs(BCB.defaultEditBoxes or {}) do
                if b == box then return true end
            end
            return false
        end

        local function HideIdleBlizzardBox(box)
            box = box or ChatFrame1EditBox
            if not box or not IsHookedBox(box) then return end
            -- TAINT GUARD: never touch the box during lockdown; combat end re-runs this
            if not BCB.IsSafeToTouchBlizzard() then return end
            if box:IsShown() and not box:HasFocus() then
                box:Hide()  -- TAINT: touches ChatFrameNEditBox (safe -- checked above)
            end
        end

        -- Post-hooks only (hooksecurefunc): Blizzard's function runs untouched first.
        -- ChatEdit_DeactivateChat is a wrapper around ChatFrameUtil.DeactivateChat on
        -- 12.x, so hooking the table member catches both call paths.
        if ChatFrameUtil and ChatFrameUtil.DeactivateChat then
            hooksecurefunc(ChatFrameUtil, "DeactivateChat", HideIdleBlizzardBox)
        elseif ChatEdit_DeactivateChat then
            hooksecurefunc("ChatEdit_DeactivateChat", HideIdleBlizzardBox)
        end

        -- Login/reload, loading screens and combat (the guard skips the hide) also
        -- leave the box shown.
        HideIdleBlizzardBox()
        BCB.RegisterEvent("PLAYER_REGEN_ENABLED", function() HideIdleBlizzardBox() end)
        BCB.RegisterEvent("PLAYER_ENTERING_WORLD", function()
            C_Timer.After(0.5, function() HideIdleBlizzardBox() end)
        end)
    end
end
