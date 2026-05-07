-- BigChatBox Config/HistoryTab.lua — History tab (chat history, whisper history)

local BCB = BigChatBox
local L = BCB.L or {}
local Config = BCB.Config
local PAD = Config.PAD

function Config.BuildHistoryTab(container)
    local ct = CreateFrame("Frame", nil, container); ct:SetAllPoints()
    local y = -8

    -- History length slider
    local hlS = Config.CreateSlider(ct, L["HISTORY_LENGTH_LABEL"], 0, 1000, BigChatBoxDB.historyLength or 100, 100,
        function(v) BigChatBoxDB.historyLength = v; if BigChatBoxDB.history then while #BigChatBoxDB.history > v do table.remove(BigChatBoxDB.history) end end end,
        function(v) local n = math.floor(v); if n > 500 then return "|cffff4444"..n.."|r" else return tostring(n) end end)
    hlS:SetPoint("TOPLEFT", 0, y); hlS:SetPoint("RIGHT", -PAD, 0); y = y - 40

    local wB = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); wB:SetSize(180, 24); wB:SetPoint("TOPLEFT", PAD, y); wB:SetText(L["BTN_WIPE_HISTORY"])
    wB:SetScript("OnClick", function() StaticPopup_Show("BCB_WIPE_HISTORY") end)

    -- Wipe All Commands button - only visible when "Ignore /commands in history" is OFF
    local wcB = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); wcB:SetSize(180, 24); wcB:SetPoint("LEFT", wB, "RIGHT", 8, 0); wcB:SetText(L["BTN_WIPE_COMMANDS"])
    wcB:SetScript("OnClick", function()
        StaticPopup_Show("BCB_WIPE_COMMANDS")
    end)
    if BigChatBoxDB.ignoreCommandsInHistory then wcB:Hide() end
    BCB._wipeCommandsBtn = wcB
    y = y - 34

    -- Chat History header
    local chH = ct:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); chH:SetPoint("TOPLEFT", PAD, y); chH:SetText(L["HISTORY_HEADER"]); chH:SetTextColor(1,0.82,0); y = y - 18
    local chHelp = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); chHelp:SetPoint("TOPLEFT", PAD, y); chHelp:SetTextColor(0.6, 0.6, 0.6)
    chHelp:SetText(L["HISTORY_HELP"]); y = y - 16

    -- Recent Whispers: max 5 rows * 22px = 110, plus header + padding = ~140
    -- Remove button = 30px
    local whisperBlockH = 150  -- reserved at bottom

    -- Search bar
    local CHANNEL_NAMES = {
        SAY = "Say", YELL = "Yell", GUILD = "Guild", OFFICER = "Officer",
        PARTY = "Party", RAID = "Raid", INSTANCE_CHAT = "Instance",
        WHISPER = "Whisper", BN_WHISPER = "Whisper", CHANNEL = "Channel",
    }
    local searchBg = CreateFrame("Frame", nil, ct, "BackdropTemplate")
    searchBg:SetHeight(26); searchBg:SetPoint("TOPLEFT", 4, y); searchBg:SetPoint("RIGHT", ct, "RIGHT", -4, 0)
    searchBg:SetBackdrop({bgFile="Interface\\Buttons\\White8x8", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", edgeSize=8, insets={left=2,right=2,top=2,bottom=2}})
    searchBg:SetBackdropColor(0.05,0.05,0.05,0.8); searchBg:SetBackdropBorderColor(0.3,0.3,0.3,1)
    local searchBox = CreateFrame("EditBox", nil, searchBg)
    searchBox:SetPoint("TOPLEFT", 8, -4); searchBox:SetPoint("BOTTOMRIGHT", -8, 4)
    searchBox:SetAutoFocus(false); searchBox:SetFontObject(ChatFontNormal); searchBox:SetTextColor(1,1,1)
    -- Placeholder text
    local hint = L["HISTORY_SEARCH_HINT"] or "Search history..."
    searchBox:SetText(hint); searchBox:SetTextColor(0.45,0.45,0.45)
    local isPlaceholder = true
    searchBox:SetScript("OnEditFocusGained", function(self)
        if isPlaceholder then self:SetText(""); self:SetTextColor(1,1,1); isPlaceholder = false end
        searchBg:SetBackdropBorderColor(0.5,0.6,0.8,1)
    end)
    searchBox:SetScript("OnEditFocusLost", function(self)
        if self:GetText() == "" then self:SetText(hint); self:SetTextColor(0.45,0.45,0.45); isPlaceholder = true end
        searchBg:SetBackdropBorderColor(0.3,0.3,0.3,1)
    end)
    searchBox:SetScript("OnEscapePressed", function(self) self:SetText(""); self:ClearFocus() end)
    y = y - 32

    -- Scrollable inset for chat history - fills available space dynamically
    local hBox = CreateFrame("Frame", nil, ct, "InsetFrameTemplate")
    hBox:SetPoint("TOPLEFT", 4, y)
    hBox:SetPoint("BOTTOMRIGHT", ct, "BOTTOMRIGHT", -4, whisperBlockH + 36)
    local hBg = hBox:CreateTexture(nil, "BACKGROUND", nil, -1); hBg:SetPoint("TOPLEFT", 3, -3); hBg:SetPoint("BOTTOMRIGHT", -3, 3); hBg:SetColorTexture(0.03, 0.03, 0.03, 0.9)
    local hSF = CreateFrame("ScrollFrame", nil, hBox, "ScrollFrameTemplate"); hSF:SetPoint("TOPLEFT", 6, -4); hSF:SetPoint("BOTTOMRIGHT", -22, 4)
    local hSC = CreateFrame("Frame", nil, hSF); hSC:SetWidth(Config.WINDOW_WIDTH - 60); hSF:SetScrollChild(hSC)

    -- Build (or rebuild) history rows, filtered by query string
    local function BuildHistoryRows(query)
        -- Clear existing children
        local children = {hSC:GetChildren()}
        for _, ch in ipairs(children) do ch:Hide() end
        -- Also clear fontstrings
        local regions = {hSC:GetRegions()}
        for _, r in ipairs(regions) do r:Hide() end

        local lq = query and query:lower() or ""
        local hList = BigChatBoxDB.history or {}
        local hY = 0
        local shown = 0
        local MAX_ROWS = 200

        -- Build filtered list (preserving original indices for removal)
        local filtered = {}
        for i = 1, #hList do
            local line = hList[i]
            local text = type(line) == "table" and (line.text or "") or tostring(line)
            if lq == "" or text:lower():find(lq, 1, true) then
                filtered[#filtered+1] = {idx=i, line=line, text=text}
                if #filtered >= MAX_ROWS then break end
            end
        end

        if #filtered == 0 then
            local e = hSC:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
            e:SetPoint("TOPLEFT", 6, 0)
            e:SetText(lq == "" and L["HISTORY_EMPTY"] or ('No results for "|cffffffff' .. query .. '|r".'))
            e:SetTextColor(0.5,0.5,0.5)
            hY = 20
        else
            for _, entry in ipairs(filtered) do
                local line = entry.line
                local text = entry.text
                local origIdx = entry.idx
                local ts = ""; local chatType = nil
                if type(line) == "table" then ts = line.time or ""; chatType = line.chatType end

                local row = CreateFrame("Frame", nil, hSC)
                row:SetHeight(20); row:SetPoint("TOPLEFT", 0, -hY); row:SetPoint("RIGHT", -4, 0)
                local hl = row:CreateTexture(nil, "HIGHLIGHT"); hl:SetAllPoints(); hl:SetColorTexture(0.2,0.3,0.5,0.2)

                local overlay = CreateFrame("Frame", nil, row); overlay:SetHeight(20)
                overlay:SetPoint("LEFT", 0, 0); overlay:SetPoint("RIGHT", -20, 0)
                overlay:SetFrameLevel(row:GetFrameLevel() + 5)
                local overlayBg = overlay:CreateTexture(nil, "BACKGROUND"); overlayBg:SetAllPoints(); overlayBg:SetColorTexture(0,0,0,0.85)

                local channelLabel = overlay:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
                channelLabel:SetPoint("RIGHT", -4, 0); channelLabel:SetWidth(60); channelLabel:SetJustifyH("RIGHT"); channelLabel:SetWordWrap(false)
                if chatType and CHANNEL_NAMES[chatType] then
                    local cr, cg, cb = 1, 1, 1
                    local typeInfo = ChatTypeInfo[chatType]
                    if typeInfo then cr, cg, cb = typeInfo.r, typeInfo.g, typeInfo.b end
                    channelLabel:SetTextColor(cr, cg, cb); channelLabel:SetText(CHANNEL_NAMES[chatType])
                else
                    channelLabel:SetText("")
                end

                local overlayText = overlay:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
                overlayText:SetPoint("LEFT", 4, 0); overlayText:SetPoint("RIGHT", channelLabel, "LEFT", -6, 0)
                overlayText:SetJustifyH("LEFT"); overlayText:SetWordWrap(false)
                local dash = " — "  -- em dash
                local overlayStr = ""
                if ts ~= "" then
                    overlayStr = "|cff999999"..ts..dash.."|r|cffcccccc"..text.."|r"
                else
                    overlayStr = "|cffcccccc"..text.."|r"
                end
                overlayText:SetText(overlayStr)
                overlay:Hide()

                local txtBtn = CreateFrame("Button", nil, row)
                txtBtn:SetPoint("LEFT", 6, 0); txtBtn:SetPoint("RIGHT", -22, 0); txtBtn:SetHeight(20)
                local txtFS = txtBtn:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
                txtFS:SetAllPoints(); txtFS:SetJustifyH("LEFT"); txtFS:SetText(text); txtFS:SetWordWrap(false)
                txtBtn:SetFontString(txtFS)
                if chatType then
                    local typeInfo = ChatTypeInfo[chatType]
                    if typeInfo then txtFS:SetTextColor(typeInfo.r, typeInfo.g, typeInfo.b) end
                end

                local capturedText = text
                txtBtn:SetScript("OnClick", function()
                    if BCB.editBox and BCB.frame then
                        BCB.frame:Show(); BCB.editBox:SetFocus()
                        BCB.editBox:SetText(capturedText)
                        BCB.editBox:SetCursorPosition(#capturedText)
                        if BCB.Config.configFrame then BCB.Config.configFrame:Hide() end
                    end
                end)

                row:EnableMouse(true)
                local function ShowOverlay() if overlayStr ~= "" then overlay:Show() end end
                local function HideOverlay() overlay:Hide() end
                row:SetScript("OnEnter", ShowOverlay); row:SetScript("OnLeave", HideOverlay)
                txtBtn:SetScript("OnEnter", ShowOverlay); txtBtn:SetScript("OnLeave", HideOverlay)

                local xB = CreateFrame("Button", nil, row)
                xB:SetSize(14,14); xB:SetPoint("RIGHT", -2, 0)
                xB:SetNormalTexture("Interface\\Buttons\\UI-StopButton")
                xB:SetHighlightTexture("Interface\\Buttons\\UI-StopButton", "ADD")
                local idx = origIdx
                xB:SetScript("OnClick", function()
                    if not BCB._historyToRemove then BCB._historyToRemove = {} end
                    if BCB._historyToRemove[idx] then
                        BCB._historyToRemove[idx] = nil
                        row:SetAlpha(1.0)
                        local anyMarked = false
                        for _, v in pairs(BCB._historyToRemove) do if v then anyMarked = true; break end end
                        BCB._historyDirty = anyMarked
                        if BCB._removeEntriesBtn then if anyMarked then BCB._removeEntriesBtn:Enable() else BCB._removeEntriesBtn:Disable() end end
                    else
                        BCB._historyToRemove[idx] = true; BCB._historyDirty = true
                        row:SetAlpha(0.3)
                        if BCB._removeEntriesBtn then BCB._removeEntriesBtn:Enable() end
                    end
                end)

                -- Restore removal state if already marked
                if BCB._historyToRemove and BCB._historyToRemove[origIdx] then row:SetAlpha(0.3) end

                hY = hY + 20
            end
            -- "X more" notice if history is longer than MAX_ROWS (unfiltered only)
            if lq == "" and #hList > MAX_ROWS then
                local m = hSC:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
                m:SetPoint("TOPLEFT", 6, -hY)
                m:SetText(string.format(L["HISTORY_MORE"], #hList - MAX_ROWS))
                m:SetTextColor(0.5,0.5,0.5); hY = hY + 20
            end
        end

        hSC:SetHeight(math.max(hY, 1))
        hSF:SetVerticalScroll(0)
        C_Timer.After(0.05, function()
            local boxH = hBox:GetHeight()
            if hY <= boxH and hSF.ScrollBar then hSF.ScrollBar:Hide()
            elseif hSF.ScrollBar then hSF.ScrollBar:Show() end
        end)
    end

    BuildHistoryRows("")

    -- Search: debounced rebuild on text change
    local searchTimer = nil
    searchBox:SetScript("OnTextChanged", function(self, userInput)
        if not userInput or isPlaceholder then return end
        if searchTimer then searchTimer:Cancel() end
        local q = self:GetText()
        searchTimer = C_Timer.NewTimer(0.25, function()
            BuildHistoryRows(q)
            searchTimer = nil
        end)
    end)

    hBox:SetScript("OnShow", function()
        C_Timer.After(0.05, function()
            local boxH = hBox:GetHeight()
            local hY = hSC:GetHeight()
            if hY <= boxH and hSF.ScrollBar then hSF.ScrollBar:Hide() end
        end)
    end)

    -- Everything below is anchored from the BOTTOM of the container
    -- Remove entries button
    local rmB = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); rmB:SetSize(160, 24)
    rmB:SetPoint("BOTTOMLEFT", ct, "BOTTOMLEFT", PAD, whisperBlockH + 8)
    rmB:SetText(L["BTN_REMOVE_ENTRIES"])
    rmB:SetScript("OnClick", function()
        if BCB._historyToRemove then
            local newHist = {}
            for i, entry in ipairs(BigChatBoxDB.history) do
                if not BCB._historyToRemove[i] then table.insert(newHist, entry) end
            end
            BigChatBoxDB.history = newHist
            BCB._historyToRemove = nil; BCB._historyDirty = false
        end
        BCB.RefreshConfigTab()
    end); rmB:Disable()
    BCB._removeEntriesBtn = rmB
    if BCB._historyDirty then rmB:Enable() end

    -- Recent Whispers header - anchored from bottom
    local whH = ct:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    whH:SetPoint("BOTTOMLEFT", ct, "BOTTOMLEFT", PAD, whisperBlockH - 18)
    whH:SetText(L["WHISPERS_HEADER"]); whH:SetTextColor(1,0.82,0)
    local whHelp = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    whHelp:SetPoint("LEFT", whH, "RIGHT", 8, 0); whHelp:SetText(L["WHISPERS_CLICK_HINT"]); whHelp:SetTextColor(0.5,0.5,0.5)
    local whL = BigChatBoxDB.whisperHistory or {}
    local whY = whisperBlockH - 40
    if #whL == 0 then
        local e = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
        e:SetPoint("BOTTOMLEFT", ct, "BOTTOMLEFT", PAD, whY)
        e:SetText(L["WHISPERS_EMPTY"]); e:SetTextColor(0.5,0.5,0.5)
    else
        local mx = math.min(#whL, 5)
        for i = 1, mx do
            local name = whL[i]
            local row = CreateFrame("Button", nil, ct); row:SetHeight(20)
            row:SetPoint("BOTTOMLEFT", ct, "BOTTOMLEFT", PAD, whY)
            row:SetPoint("RIGHT", ct, "RIGHT", -PAD, 0)
            local hl = row:CreateTexture(nil, "HIGHLIGHT"); hl:SetAllPoints(); hl:SetColorTexture(0.2,0.3,0.5,0.3)
            local txt = row:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); txt:SetPoint("LEFT", 6, 0); txt:SetText(name); txt:SetTextColor(0.8,0.5,1)
            -- Click to whisper this person
            local capturedName = name
            row:SetScript("OnClick", function()
                if not BCB.frame or not BCB.editBox then return end
                -- Determine if this is a BNet friend
                local bnetID
                if BNet_GetBNetIDAccountFromCharacterName then
                    bnetID = BNet_GetBNetIDAccountFromCharacterName(capturedName)
                end
                if not bnetID and BNet_GetBNetIDAccount then
                    bnetID = BNet_GetBNetIDAccount(capturedName)
                end
                BCB.frame:Show()
                BCB.editBox:SetFocus()
                if bnetID then
                    BCB.editBox:SetAttribute("chatType", "BN_WHISPER")
                else
                    BCB.editBox:SetAttribute("chatType", "WHISPER")
                end
                BCB.editBox:SetAttribute("tellTarget", capturedName)
                BCB.editBox:SetText("")
                BCB.editBox:SetCursorPosition(0)
                BigChatBoxDB.lastChatType = BCB.editBox:GetAttribute("chatType")
                if BCB.UpdateChannelDisplay then BCB.UpdateChannelDisplay() end
                if BCB.Config.configFrame then BCB.Config.configFrame:Hide() end
            end)
            row:SetScript("OnEnter", function(self) txt:SetTextColor(1, 0.7, 1) end)
            row:SetScript("OnLeave", function(self) txt:SetTextColor(0.8, 0.5, 1) end)
            local xB = CreateFrame("Button", nil, row); xB:SetSize(14, 14); xB:SetPoint("RIGHT", -2, 0); xB:SetNormalTexture("Interface\\Buttons\\UI-StopButton"); xB:SetHighlightTexture("Interface\\Buttons\\UI-StopButton", "ADD")
            local idx = i; xB:SetScript("OnClick", function() table.remove(BigChatBoxDB.whisperHistory, idx); BCB.RefreshConfigTab() end)
            whY = whY - 22
        end
    end
end
