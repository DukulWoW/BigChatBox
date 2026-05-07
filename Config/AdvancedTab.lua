-- BigChatBox Config/AdvancedTab.lua — Advanced tab (profiles, behavior, keybinds, resets)

local BCB = BigChatBox
local L = BCB.L or {}
local Config = BCB.Config
local PAD = Config.PAD

function Config.BuildAdvancedTab(container)
    local ct = CreateFrame("Frame", nil, container); ct:SetAllPoints()
    local y = -8

    -- Language
    local ASSET = "Interface\\AddOns\\BigChatBox\\assets\\"
    -- { code, label, flag, available }
    -- available=true → selectable; available=false → greyed "Coming soon"
    local LANG_LIST = {
        { code = "client", label = L["LANGUAGE_CLIENT"], flag = nil,                    available = true  },
        { code = "enUS",   label = "English",            flag = ASSET .. "flag-en",     available = true  },
        { code = "deDE",   label = "Deutsch",            flag = ASSET .. "flag-de",     available = true  },
        { code = "frFR",   label = "Français",           flag = ASSET .. "flag-fr",     available = true  },
        { code = "esES",   label = "Español",            flag = ASSET .. "flag-es",     available = true  },
        { code = "ptBR",   label = "Português",          flag = ASSET .. "flag-br",     available = true  },
        { code = "itIT",   label = "Italiano",           flag = ASSET .. "flag-it",     available = true  },
        { code = "jaJP",   label = "日本語",              flag = ASSET .. "flag-ja",     available = true  },
        { code = "koKR",   label = "한국어",              flag = ASSET .. "flag-ko",     available = true  },
        { code = "zhCN",   label = "简体中文",            flag = ASSET .. "flag-cn",     available = true  },
        { code = "zhTW",   label = "繁體中文",            flag = ASSET .. "flag-tw",     available = true  },
    }

    local curLangCode  = (BigChatBoxLocale and BigChatBoxLocale ~= "") and BigChatBoxLocale or "client"
    local COMING_SOON  = L["LANGUAGE_COMING_SOON"] or "|cff888888(Coming soon)|r"
    local GREY         = "|cff888888"

    -- Build label for the selected entry (shown on the closed button)
    local function MakeLabel(entry)
        if entry.flag then
            return "|T" .. entry.flag .. ":14:20:0:0:32:32|t " .. entry.label
        end
        return entry.label
    end

    local curLangLabel = MakeLabel(LANG_LIST[1])  -- default fallback
    for _, e in ipairs(LANG_LIST) do
        if e.code == curLangCode then curLangLabel = MakeLabel(e); break end
    end

    -- Language override (retail only — LoadSavedVariablesFirst:1 not available in Classic)
    if not BCB.IsClassicLocale then
    local lgH = ct:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); lgH:SetPoint("TOPLEFT", PAD, y); lgH:SetText(L["SECTION_LANGUAGE"]); lgH:SetTextColor(1,0.82,0); y = y - 20
    local lgD = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); lgD:SetPoint("TOPLEFT", PAD, y); lgD:SetWidth(Config.WINDOW_WIDTH - 80); lgD:SetJustifyH("LEFT")
    lgD:SetText(L["LANGUAGE_DESC"]); lgD:SetTextColor(0.7,0.7,0.7); y = y - 18

    local useNative = C_XMLUtil and C_XMLUtil.GetTemplateInfo and C_XMLUtil.GetTemplateInfo("WowStyle1DropdownTemplate")
    if useNative then
        local lgDrop = CreateFrame("DropdownButton", nil, ct, "WowStyle1DropdownTemplate")
        lgDrop:SetPoint("TOPLEFT", PAD, y); lgDrop:SetPoint("RIGHT", -PAD, 0)
        local curSel = curLangLabel

        lgDrop:SetupMenu(function(_, rootDescription)
            for _, entry in ipairs(LANG_LIST) do
                local displayLabel = MakeLabel(entry)
                if entry.available then
                    -- Normal selectable radio
                    rootDescription:CreateRadio(displayLabel,
                        function() return curSel == displayLabel end,
                        function()
                            curSel = displayLabel
                            lgDrop:GenerateMenu()
                            BCB._pendingLangCode = entry.code
                            StaticPopup_Show("BCB_CHANGE_LANGUAGE")
                        end)
                else
                    -- Greyed, unclickable entry with "Coming soon" suffix
                    local greyLabel = GREY .. (entry.flag and ("|T" .. entry.flag .. ":14:20:0:0:32:32|t ") or "") .. entry.label .. "|r  " .. COMING_SOON
                    local dummy = rootDescription:CreateRadio(greyLabel,
                        function() return false end,
                        function() end)  -- noop — click does nothing
                    dummy:AddInitializer(function(button)
                        -- Visually disable: grey text, no hover, block clicks
                        if button.fontString then
                            button.fontString:SetTextColor(0.5, 0.5, 0.5)
                        end
                        button:SetEnabled(false)
                        if button.highlight then button.highlight:SetAlpha(0) end
                    end)
                end
            end
            rootDescription:SetScrollMode(30 * 20)
        end)
    else
        -- Fallback: plain button list, coming-soon entries shown grey and non-clickable
        local lgBtn = CreateFrame("Button", nil, ct, "BackdropTemplate")
        lgBtn:SetHeight(24); lgBtn:SetPoint("TOPLEFT", PAD, y); lgBtn:SetPoint("RIGHT", -PAD, 0)
        lgBtn:SetBackdrop({bgFile="Interface\\Buttons\\White8x8", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", edgeSize=12, insets={left=2,right=2,top=2,bottom=2}})
        lgBtn:SetBackdropColor(0.1,0.1,0.1,0.9); lgBtn:SetBackdropBorderColor(0.4,0.4,0.4,1)
        local lgSt = lgBtn:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); lgSt:SetPoint("LEFT", 8, 0); lgSt:SetPoint("RIGHT", -22, 0); lgSt:SetJustifyH("LEFT"); lgSt:SetText(curLangLabel)
        local lgAr = lgBtn:CreateTexture(nil, "ARTWORK"); lgAr:SetSize(14,14); lgAr:SetPoint("RIGHT", -3, 0); lgAr:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
        local lgPp = CreateFrame("Frame", nil, lgBtn, "BackdropTemplate"); lgPp:SetFrameStrata("FULLSCREEN_DIALOG"); lgPp:SetFrameLevel(500); lgPp:SetClampedToScreen(true)
        lgPp:SetBackdrop({bgFile="Interface\\Buttons\\White8x8", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", edgeSize=12, insets={left=2,right=2,top=2,bottom=2}})
        lgPp:SetBackdropColor(0.06,0.06,0.06,0.97); lgPp:SetBackdropBorderColor(0.5,0.5,0.5,1); lgPp:Hide(); lgPp:EnableMouse(true)
        local lgSf = CreateFrame("ScrollFrame", nil, lgPp, "ScrollFrameTemplate"); lgSf:SetPoint("TOPLEFT", 4, -4); lgSf:SetPoint("BOTTOMRIGHT", -4, 4)
        local lgSc = CreateFrame("Frame", nil, lgSf); lgSf:SetScrollChild(lgSc)
        lgBtn:SetScript("OnClick", function()
            if lgPp:IsShown() then lgPp:Hide(); return end
            for _, ch in ipairs({lgSc:GetChildren()}) do ch:Hide(); ch:SetParent(nil) end
            local rH, tH = 22, 0; lgSc:SetWidth(lgPp:GetWidth() - 12)
            for _, entry in ipairs(LANG_LIST) do
                local row = CreateFrame("Button", nil, lgSc); row:SetHeight(rH); row:SetPoint("TOPLEFT", 0, -tH); row:SetPoint("RIGHT")
                local lbl = MakeLabel(entry)
                local fs = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); fs:SetPoint("LEFT", 6, 0)
                if entry.available then
                    fs:SetText(lbl)
                    local hl = row:CreateTexture(nil, "HIGHLIGHT"); hl:SetAllPoints(); hl:SetColorTexture(0.3,0.5,0.8,0.3)
                    row:SetScript("OnClick", function() lgSt:SetText(lbl); lgPp:Hide(); BCB._pendingLangCode = entry.code; StaticPopup_Show("BCB_CHANGE_LANGUAGE") end)
                else
                    fs:SetText(GREY .. entry.label .. "|r  " .. COMING_SOON)
                    fs:SetTextColor(0.5, 0.5, 0.5)
                    row:SetEnabled(false)
                end
                tH = tH + rH
            end
            lgSc:SetHeight(math.max(tH, 1)); lgPp:SetHeight(math.min(tH + 10, 300))
            lgPp:SetWidth(lgBtn:GetWidth()); lgPp:ClearAllPoints()
            if (lgBtn:GetBottom() or 0) - 300 < 0 then lgPp:SetPoint("BOTTOMLEFT", lgBtn, "TOPLEFT", 0, 2) else lgPp:SetPoint("TOPLEFT", lgBtn, "BOTTOMLEFT", 0, -2) end
            lgPp:Show()
        end)
    end
    y = y - 52

    end -- not BCB.IsClassicLocale

    -- Profiles (moved from General)
    local pH = ct:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); pH:SetPoint("TOPLEFT", PAD, y); pH:SetText(L["SECTION_PROFILES"]); pH:SetTextColor(1,0.82,0); y = y - 20
    local pD = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); pD:SetPoint("TOPLEFT", PAD, y); pD:SetWidth(Config.WINDOW_WIDTH - 80); pD:SetJustifyH("LEFT")
    pD:SetText(L["PROFILES_DESC"]); pD:SetTextColor(0.7,0.7,0.7); y = y - 18
    local gC = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); gC:SetPoint("TOPLEFT", PAD, y)
    gC.text = gC:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); gC.text:SetPoint("LEFT", gC, "RIGHT", 4, 0); gC.text:SetText(L["CB_GLOBAL_PROFILE"])
    gC:SetChecked(BigChatBoxDB.useGlobalProfile or false); gC:SetScript("OnClick", function(self) BigChatBoxDB.useGlobalProfile = self:GetChecked() end)
    y = y - 40

    -- Behavior
    local bhH = ct:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); bhH:SetPoint("TOPLEFT", PAD, y); bhH:SetText(L["BEHAVIOR"]); bhH:SetTextColor(1,0.82,0); y = y - 22
    local koC = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); koC:SetPoint("TOPLEFT", PAD, y)
    koC.text = koC:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); koC.text:SetPoint("LEFT", koC, "RIGHT", 4, 0); koC.text:SetText(L["KEEP_OPEN"])
    koC:SetChecked(BigChatBoxDB.keepOpen or false)
    koC:SetScript("OnClick", function(self) BigChatBoxDB.keepOpen = self:GetChecked() end)
    local koHelp = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); koHelp:SetPoint("TOPLEFT", PAD + 30, y - 22); koHelp:SetTextColor(0.5,0.5,0.5)
    koHelp:SetText(L["KEEP_OPEN_HELP"])
    y = y - 52

    local clC = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); clC:SetPoint("TOPLEFT", PAD, y)
    clC.text = clC:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); clC.text:SetPoint("LEFT", clC, "RIGHT", 4, 0); clC.text:SetText(L["SHOW_LOCKDOWN_WARNING"])
    clC:SetChecked(BigChatBoxDB.showLockdownWarning == nil or BigChatBoxDB.showLockdownWarning)
    clC:SetScript("OnClick", function(self) BigChatBoxDB.showLockdownWarning = self:GetChecked() end)
    local clHelp = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); clHelp:SetPoint("TOPLEFT", PAD + 30, y - 22); clHelp:SetTextColor(0.5,0.5,0.5)
    clHelp:SetText(L["SHOW_LOCKDOWN_WARNING_HELP"])
    y = y - 52

    local icC = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); icC:SetPoint("TOPLEFT", PAD, y)
    icC.text = icC:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); icC.text:SetPoint("LEFT", icC, "RIGHT", 4, 0); icC.text:SetText(L["IGNORE_COMMANDS_HISTORY"])
    icC:SetChecked(BigChatBoxDB.ignoreCommandsInHistory or false)
    icC:SetScript("OnClick", function(self)
        BigChatBoxDB.ignoreCommandsInHistory = self:GetChecked()
        if BCB._wipeCommandsBtn then
            if self:GetChecked() then BCB._wipeCommandsBtn:Hide() else BCB._wipeCommandsBtn:Show() end
        end
    end)
    local icHelp = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); icHelp:SetPoint("TOPLEFT", PAD + 30, y - 22); icHelp:SetTextColor(0.5,0.5,0.5)
    icHelp:SetText(L["IGNORE_COMMANDS_HISTORY_HELP"])
    y = y - 52

    local mmC = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); mmC:SetPoint("TOPLEFT", PAD, y)
    mmC.text = mmC:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); mmC.text:SetPoint("LEFT", mmC, "RIGHT", 4, 0); mmC.text:SetText(L["SHOW_MINIMAP_BUTTON"])
    mmC:SetChecked(not (BigChatBoxDB.minimapIcon and BigChatBoxDB.minimapIcon.hide))
    mmC:SetScript("OnClick", function(self)
        BigChatBoxDB.showMinimapButton = self:GetChecked()
        if BCB.SetMinimapButtonShown then BCB.SetMinimapButtonShown(self:GetChecked()) end
    end)
    local mmHelp = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); mmHelp:SetPoint("TOPLEFT", PAD + 30, y - 22); mmHelp:SetTextColor(0.5,0.5,0.5)
    mmHelp:SetText(L["SHOW_MINIMAP_BUTTON_HELP"])
    y = y - 52

    local hlC = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); hlC:SetPoint("TOPLEFT", PAD, y)
    hlC.text = hlC:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); hlC.text:SetPoint("LEFT", hlC, "RIGHT", 4, 0); hlC.text:SetText(L["HIDE_LOGIN_MSG"])
    hlC:SetChecked(BigChatBoxDB.hideLoginMessage or false)
    hlC:SetScript("OnClick", function(self) BigChatBoxDB.hideLoginMessage = self:GetChecked() end)
    local hlHelp = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); hlHelp:SetPoint("TOPLEFT", PAD + 30, y - 22); hlHelp:SetTextColor(0.5,0.5,0.5)
    hlHelp:SetText(L["HIDE_LOGIN_MSG_HELP"])
    y = y - 52

    -- Keybinding: Open Blizzard Chat
    local MODIFIER_KEYS = { LSHIFT=true, RSHIFT=true, LCTRL=true, RCTRL=true, LALT=true, RALT=true }
    local KB_ACTION = "BIGCHATBOX_USE_BLIZZARD_CHAT"

    local kbLabel = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); kbLabel:SetPoint("TOPLEFT", PAD + 4, y + 2); kbLabel:SetText(L["KEYBIND_OPEN_BLIZZARD"])
    local kbBtn = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); kbBtn:SetSize(140, 24); kbBtn:SetPoint("LEFT", kbLabel, "RIGHT", 8, 0)
    kbBtn:RegisterForClicks("AnyUp")

    local function UpdateKBText()
        local key = GetBindingKey(KB_ACTION)
        kbBtn:SetText(key and GetBindingText(key) or L["KEYBIND_NOT_BOUND"])
    end
    UpdateKBText()

    -- Stay in sync with WoW's Key Bindings UI
    ct:RegisterEvent("UPDATE_BINDINGS")
    ct:SetScript("OnEvent", function(_, event) if event == "UPDATE_BINDINGS" then UpdateKBText() end end)

    local function StopCapture(btn)
        btn:EnableKeyboard(false); btn:SetScript("OnKeyDown", nil); UpdateKBText()
    end

    local function ApplyBind(fullKey)
        local k1, k2 = GetBindingKey(KB_ACTION)
        if k1 then SetBinding(k1, nil) end
        if k2 then SetBinding(k2, nil) end
        SetBinding(fullKey, KB_ACTION)
        SaveBindings(GetCurrentBindingSet())
        UpdateKBText()
    end

    -- Conflict confirmation dialog
    if not StaticPopupDialogs["BCB_KEYBIND_CONFLICT"] then
        StaticPopupDialogs["BCB_KEYBIND_CONFLICT"] = {
            text = "%s", button1 = YES, button2 = NO, timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
            OnAccept = function(_, data) ApplyBind(data.fullKey) end,
        }
    end

    local function OnKeyCaptured(btn, key)
        if MODIFIER_KEYS[key] then return end
        if key == "ESCAPE" or InCombatLockdown() then StopCapture(btn); return end
        local mods = {}
        if IsAltKeyDown() then mods[#mods+1] = "ALT" end
        if IsControlKeyDown() then mods[#mods+1] = "CTRL" end
        if IsShiftKeyDown() then mods[#mods+1] = "SHIFT" end
        mods[#mods+1] = key
        local fullKey = table.concat(mods, "-")
        StopCapture(btn)
        local existing = GetBindingAction(fullKey)
        if existing and existing ~= "" and existing ~= KB_ACTION then
            local msg = string.format(L["KEYBIND_CONFLICT"], GetBindingText(fullKey), GetBindingName(existing))
            StaticPopup_Show("BCB_KEYBIND_CONFLICT", msg, nil, { fullKey = fullKey })
            return
        end
        ApplyBind(fullKey)
    end

    kbBtn:SetScript("OnClick", function(btn, button)
        if button == "RightButton" then
            local k1, k2 = GetBindingKey(KB_ACTION)
            if k1 then SetBinding(k1, nil) end
            if k2 then SetBinding(k2, nil) end
            if k1 or k2 then SaveBindings(GetCurrentBindingSet()) end
            UpdateKBText(); GameTooltip:Hide()
        else
            btn:SetText(L["KEYBIND_PRESS_KEY"]); btn:EnableKeyboard(true); btn:SetScript("OnKeyDown", OnKeyCaptured)
        end
    end)

    kbBtn:SetScript("OnEnter", function(btn)
        GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
        local key = GetBindingKey(KB_ACTION)
        if key then
            GameTooltip:AddLine(string.format(L["KEYBIND_TOOLTIP_BOUND"], GetBindingText(key)), 1,1,1)
            GameTooltip:AddLine(L["KEYBIND_TOOLTIP_UNBIND"], 0.6,0.6,0.6)
        else
            GameTooltip:AddLine(L["KEYBIND_TOOLTIP_SET"], 1,1,1)
        end
        GameTooltip:Show()
    end)
    kbBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    local kbHelp = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); kbHelp:SetPoint("TOPLEFT", PAD + 30, y - 20); kbHelp:SetTextColor(0.5,0.5,0.5)
    kbHelp:SetText(L["KEYBIND_HELP"])
    y = y - 52
end
