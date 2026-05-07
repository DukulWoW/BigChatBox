-- BigChatBox Config/FeaturesTab.lua — Features tab (feature toggles, utilities)

local BCB = BigChatBox
local L = BCB.L or {}
local Config = BCB.Config
local PAD = Config.PAD

function Config.BuildFeaturesTab(container)
    local sf, ct = Config.CreateSmartScrollFrame(container, 0)
    local y = -8

    local hdr = ct:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); hdr:SetPoint("TOPLEFT", PAD, y); hdr:SetText(L["SECTION_FEATURE_TOGGLES"]); hdr:SetTextColor(1,0.82,0); y = y - 26
    local desc = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); desc:SetPoint("TOPLEFT", PAD, y); desc:SetWidth(Config.WINDOW_WIDTH - 80); desc:SetJustifyH("LEFT")
    desc:SetText(L["FEATURE_TOGGLES_DESC"]); desc:SetTextColor(0.7,0.7,0.7); y = y - 24

    -- Snippet system
    local snH = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightMedium"); snH:SetPoint("TOPLEFT", PAD, y); snH:SetText(L["SECTION_SNIPPET_SYSTEM"]); y = y - 22
    local snEn = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); snEn:SetPoint("TOPLEFT", PAD + 10, y)
    snEn.text = snEn:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); snEn.text:SetPoint("LEFT", snEn, "RIGHT", 2, 0); snEn.text:SetText(L["CB_ENABLE_SNIPPETS"])
    snEn:SetChecked(BigChatBoxDB.snippetEnabled ~= false)
    snEn:SetScript("OnClick", function(self)
        BigChatBoxDB.snippetEnabled = self:GetChecked()
        if BCB.UpdateTabStates then BCB.UpdateTabStates() end
    end)
    y = y - 34

    -- Autocomplete
    local acH = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightMedium"); acH:SetPoint("TOPLEFT", PAD, y); acH:SetText(L["SECTION_AUTOCOMPLETE"]); y = y - 22
    local acCmd = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); acCmd:SetPoint("TOPLEFT", PAD + 10, y)
    acCmd.text = acCmd:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); acCmd.text:SetPoint("LEFT", acCmd, "RIGHT", 2, 0); acCmd.text:SetText(L["CB_AC_COMMANDS"])
    acCmd:SetChecked(BigChatBoxDB.acCommandEnabled ~= false)
    acCmd:SetScript("OnClick", function(self) BigChatBoxDB.acCommandEnabled = self:GetChecked() end)
    y = y - 28
    local acWh = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); acWh:SetPoint("TOPLEFT", PAD + 10, y)
    acWh.text = acWh:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); acWh.text:SetPoint("LEFT", acWh, "RIGHT", 2, 0); acWh.text:SetText("Whisper name autocomplete (/w <n>)")
    acWh:SetChecked(BigChatBoxDB.acWhisperEnabled ~= false)
    acWh:SetScript("OnClick", function(self) BigChatBoxDB.acWhisperEnabled = self:GetChecked() end)
    y = y - 28
    local acSn = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); acSn:SetPoint("TOPLEFT", PAD + 10, y)
    acSn.text = acSn:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); acSn.text:SetPoint("LEFT", acSn, "RIGHT", 2, 0); acSn.text:SetText(L["CB_AC_SNIPPETS"])
    acSn:SetChecked(BigChatBoxDB.acSnippetEnabled ~= false)
    acSn:SetScript("OnClick", function(self) BigChatBoxDB.acSnippetEnabled = self:GetChecked() end)
    y = y - 28
    local acBn = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); acBn:SetPoint("TOPLEFT", PAD + 10, y)
    acBn.text = acBn:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); acBn.text:SetPoint("LEFT", acBn, "RIGHT", 2, 0); acBn.text:SetText(L["CB_AC_BNET"])
    acBn:SetChecked(BigChatBoxDB.acBnetEnabled ~= false)
    acBn:SetScript("OnClick", function(self) BigChatBoxDB.acBnetEnabled = self:GetChecked() end)
    y = y - 34

    -- History
    local hiH = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightMedium"); hiH:SetPoint("TOPLEFT", PAD, y); hiH:SetText(L["SECTION_HISTORY"]); y = y - 22
    local hiEn = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); hiEn:SetPoint("TOPLEFT", PAD + 10, y)
    hiEn.text = hiEn:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); hiEn.text:SetPoint("LEFT", hiEn, "RIGHT", 2, 0); hiEn.text:SetText(L["CB_ENABLE_HISTORY"])
    hiEn:SetChecked(BigChatBoxDB.historyEnabled ~= false)
    hiEn:SetScript("OnClick", function(self)
        BigChatBoxDB.historyEnabled = self:GetChecked()
        if BCB.UpdateTabStates then BCB.UpdateTabStates() end
    end)
    y = y - 28
    local mwEn = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); mwEn:SetPoint("TOPLEFT", PAD + 10, y)
    mwEn.text = mwEn:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); mwEn.text:SetPoint("LEFT", mwEn, "RIGHT", 2, 0); mwEn.text:SetText(L["CB_MOUSEWHEEL_HISTORY"])
    mwEn:SetChecked(BigChatBoxDB.enableMouseWheelHistory ~= false)
    mwEn:SetScript("OnClick", function(self) BigChatBoxDB.enableMouseWheelHistory = self:GetChecked() end)
    y = y - 40

    -- Link Hover
    local lhH = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightMedium"); lhH:SetPoint("TOPLEFT", PAD, y); lhH:SetText(L["SECTION_LINK_HOVER"]); y = y - 22
    local lhEn = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); lhEn:SetPoint("TOPLEFT", PAD + 10, y)
    lhEn.text = lhEn:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); lhEn.text:SetPoint("LEFT", lhEn, "RIGHT", 2, 0); lhEn.text:SetText(L["CB_LINK_HOVER"])
    lhEn:SetChecked(BigChatBoxDB.enableLinkHover ~= false)
    lhEn:SetScript("OnClick", function(self) BigChatBoxDB.enableLinkHover = self:GetChecked() end)
    y = y - 40

    -- Emoji & Emoticons
    local emH = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightMedium"); emH:SetPoint("TOPLEFT", PAD, y); emH:SetText(L["SECTION_EMOJI"] or "Emoji & Emoticons"); y = y - 22
    local emEn = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); emEn:SetPoint("TOPLEFT", PAD + 10, y)
    emEn.text = emEn:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); emEn.text:SetPoint("LEFT", emEn, "RIGHT", 2, 0); emEn.text:SetText(L["CB_SHOW_EMOJI_PICKER"] or "Show emoji/emoticon picker button")
    emEn:SetChecked(BigChatBoxDB.showEmojiPicker ~= false)
    emEn:SetScript("OnClick", function(self)
        BigChatBoxDB.showEmojiPicker = self:GetChecked()
        if BCB.RepositionEmojiIcon then BCB.RepositionEmojiIcon() end
    end)
    y = y - 40

    -- ── Multiline Input Box ──────────────────────────────────────────────────
    local mlH = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightMedium")
    mlH:SetPoint("TOPLEFT", PAD, y); mlH:SetText(L["SECTION_MULTILINE"] or "Multiline Input Box"); y = y - 22

    -- Enable checkbox + description
    local mlEn = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); mlEn:SetPoint("TOPLEFT", PAD + 10, y)
    mlEn.text = mlEn:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    mlEn.text:SetPoint("LEFT", mlEn, "RIGHT", 2, 0)
    mlEn.text:SetText(L["CB_ENABLE_MULTILINE"] or "Enable multiline input box")
    mlEn:SetChecked(BigChatBoxDB.multilineEnabled ~= false)
    mlEn:SetScript("OnClick", function(self)
        BigChatBoxDB.multilineEnabled = self:GetChecked()
        if not self:GetChecked() and BCB.multilineFrame and BCB.multilineFrame:IsShown() then
            BCB.CloseMultiline()
        end
    end)
    y = y - 28

    local mlHelp = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    mlHelp:SetPoint("TOPLEFT", PAD + 30, y); mlHelp:SetWidth(Config.WINDOW_WIDTH - 100)
    mlHelp:SetJustifyH("LEFT"); mlHelp:SetTextColor(0.5, 0.5, 0.5)
    mlHelp:SetText(L["CB_ENABLE_MULTILINE_HELP"] or "Open a large multiline box to compose multi-line messages. Each line is sent separately.")
    y = y - mlHelp:GetStringHeight() - 10

    -- "Use Default style" checkbox
    local mlDefCb = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); mlDefCb:SetPoint("TOPLEFT", PAD + 10, y)
    mlDefCb.text = mlDefCb:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    mlDefCb.text:SetPoint("LEFT", mlDefCb, "RIGHT", 2, 0)
    mlDefCb.text:SetText(L["CB_MULTILINE_DEFAULT_STYLE"] or "Use Default style")
    mlDefCb:SetChecked(BigChatBoxDB.multilineUseDefaultStyle ~= false)
    mlDefCb:SetScript("OnClick", function(self)
        BigChatBoxDB.multilineUseDefaultStyle = self:GetChecked()
        if BCB.RefreshMultilineStyle then BCB.RefreshMultilineStyle() end
    end)
    y = y - 28

    local mlDefHelp = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    mlDefHelp:SetPoint("TOPLEFT", PAD + 30, y); mlDefHelp:SetWidth(Config.WINDOW_WIDTH - 100)
    mlDefHelp:SetJustifyH("LEFT"); mlDefHelp:SetTextColor(0.5, 0.5, 0.5)
    mlDefHelp:SetText(L["CB_MULTILINE_DEFAULT_STYLE_HELP"] or "When checked, the multiline box always uses the Default style. Uncheck to use your current active style.")
    y = y - mlDefHelp:GetStringHeight() - 10

    -- Keybind row: label + capture button + "(Default: Shift+M)" hint inline
    local MODIFIER_KEYS = { LSHIFT=true, RSHIFT=true, LCTRL=true, RCTRL=true, LALT=true, RALT=true }
    local KB_ACTION_ML  = "BIGCHATBOX_OPEN_MULTILINE"

    local kbLabel = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    kbLabel:SetPoint("TOPLEFT", PAD + 10, y + 2)
    kbLabel:SetText(L["KEYBIND_OPEN_MULTILINE"] or "Open Multiline Box:")

    local kbBtn = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate")
    kbBtn:SetSize(140, 24); kbBtn:SetPoint("LEFT", kbLabel, "RIGHT", 8, 0)
    kbBtn:RegisterForClicks("AnyUp")

    -- "(Default: Shift+M)" grey hint to the right of the button
    local kbDefault = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    kbDefault:SetPoint("LEFT", kbBtn, "RIGHT", 8, 0)
    kbDefault:SetTextColor(0.5, 0.5, 0.5)
    kbDefault:SetText("(Default: Shift+M)")

    local function UpdateMLKBText()
        local key = GetBindingKey(KB_ACTION_ML)
        kbBtn:SetText(key and GetBindingText(key) or L["KEYBIND_NOT_BOUND"])
    end
    UpdateMLKBText()

    -- Stay in sync with WoW's Key Bindings screen
    ct:RegisterEvent("UPDATE_BINDINGS")
    ct:HookScript("OnEvent", function(_, event)
        if event == "UPDATE_BINDINGS" then UpdateMLKBText() end
    end)

    local function StopMLCapture(btn)
        btn:EnableKeyboard(false); btn:SetScript("OnKeyDown", nil); UpdateMLKBText()
    end

    local function ApplyMLBind(fullKey)
        local k1, k2 = GetBindingKey(KB_ACTION_ML)
        if k1 then SetBinding(k1, nil) end
        if k2 then SetBinding(k2, nil) end
        SetBinding(fullKey, KB_ACTION_ML)
        SaveBindings(GetCurrentBindingSet())
        UpdateMLKBText()
    end

    -- Reuse conflict dialog if AdvancedTab already registered it
    if not StaticPopupDialogs["BCB_KEYBIND_CONFLICT"] then
        StaticPopupDialogs["BCB_KEYBIND_CONFLICT"] = {
            text = "%s", button1 = YES, button2 = NO, timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
            OnAccept = function(_, data) if data then ApplyMLBind(data.fullKey) end end,
        }
    end

    local function OnMLKeyCaptured(btn, key)
        if MODIFIER_KEYS[key] then return end
        if key == "ESCAPE" or InCombatLockdown() then StopMLCapture(btn); return end
        local mods = {}
        if IsAltKeyDown()     then mods[#mods+1] = "ALT"   end
        if IsControlKeyDown() then mods[#mods+1] = "CTRL"  end
        if IsShiftKeyDown()   then mods[#mods+1] = "SHIFT" end
        mods[#mods+1] = key
        local fullKey = table.concat(mods, "-")
        StopMLCapture(btn)
        local existing = GetBindingAction(fullKey)
        if existing and existing ~= "" and existing ~= KB_ACTION_ML then
            local msg = string.format(L["KEYBIND_CONFLICT"], GetBindingText(fullKey), GetBindingName(existing))
            StaticPopup_Show("BCB_KEYBIND_CONFLICT", msg, nil, { fullKey = fullKey })
            return
        end
        ApplyMLBind(fullKey)
    end

    kbBtn:SetScript("OnClick", function(btn, button)
        if button == "RightButton" then
            local k1, k2 = GetBindingKey(KB_ACTION_ML)
            if k1 then SetBinding(k1, nil) end
            if k2 then SetBinding(k2, nil) end
            if k1 or k2 then SaveBindings(GetCurrentBindingSet()) end
            UpdateMLKBText(); GameTooltip:Hide()
        else
            btn:SetText(L["KEYBIND_PRESS_KEY"]); btn:EnableKeyboard(true)
            btn:SetScript("OnKeyDown", OnMLKeyCaptured)
        end
    end)

    kbBtn:SetScript("OnEnter", function(btn)
        GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
        local key = GetBindingKey(KB_ACTION_ML)
        if key then
            GameTooltip:AddLine(string.format(L["KEYBIND_TOOLTIP_BOUND"] or "Open Multiline Box (%s)", GetBindingText(key)), 1,1,1)
            GameTooltip:AddLine(L["KEYBIND_TOOLTIP_UNBIND"], 0.6,0.6,0.6)
        else
            GameTooltip:AddLine(L["KEYBIND_TOOLTIP_SET"], 1,1,1)
        end
        GameTooltip:Show()
    end)
    kbBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    y = y - 36

    -- Message Splitting (unchanged — always at bottom)
    local msH = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightMedium"); msH:SetPoint("TOPLEFT", PAD, y); msH:SetText(L["SECTION_LONG_MESSAGES"]); y = y - 22
    local splitOptions = {"Off", "Silent", "Notice", "Confirm"}
    local splitMap = { Off = "off", Silent = "silent", Notice = "notice", Confirm = "confirm" }
    local splitRev = { off = "Off", silent = "Silent", notice = "Notice", confirm = "Confirm" }
    local curSplit = BigChatBoxDB.messageSplitMode or "notice"
    local msD = Config.CreateWowDropdown(ct, L["LABEL_MSG_EXCEEDS_255"],
        function() return splitOptions end,
        splitRev[curSplit] or "Notice",
        function(n) BigChatBoxDB.messageSplitMode = splitMap[n] or "notice" end)
    msD:SetPoint("TOPLEFT", 0, y); msD:SetPoint("RIGHT"); y = y - 52
    local msDesc = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); msDesc:SetPoint("TOPLEFT", PAD + 10, y)
    msDesc:SetWidth(Config.WINDOW_WIDTH - 80); msDesc:SetJustifyH("LEFT"); msDesc:SetSpacing(2)
    msDesc:SetTextColor(0.6, 0.6, 0.6)
    msDesc:SetText(L["LONG_MSG_OPTIONS_DESC"])
    y = y - msDesc:GetStringHeight() - 12

    ct:SetHeight(math.abs(y) + 20); sf:UpdateScrollbar()
end
