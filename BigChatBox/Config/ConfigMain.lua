-- BigChatBox Config/ConfigMain.lua — Window frame, tab system, static popups
-- Tab builder functions live in their own files (GeneralTab.lua, etc.)
-- Widget constructors live in ConfigWidgets.lua.

local BCB = BigChatBox
local L = BCB.L or {}
local Config = BCB.Config

local TABS = {
    { name = function() return L["TAB_GENERAL"]   or "General"   end, key = "general" },
    { name = function() return L["TAB_DESIGNER"]  or "Designer"  end, key = "designer" },
    { name = function() return L["TAB_PLACEMENT"] or "Placement" end, key = "placement" },
    { name = function() return L["TAB_FEATURES"]  or "Features"  end, key = "features" },
    { name = function() return L["TAB_SNIPPETS"]  or "Snippets"  end, key = "snippets" },
    { name = function() return L["TAB_HISTORY"]   or "History"   end, key = "history" },
    { name = function() return L["TAB_ADVANCED"]  or "Advanced"  end, key = "advanced" },
    { name = function() return L["TAB_RESET"]     or "Reset"     end, key = "reset", red = true },
}

local configFrame, currentTab, tabContainers = nil, "general", {}

--------------------------------------------------------------------------------
-- Help Window (draggable, like Baganator search help)
--------------------------------------------------------------------------------
function BCB.ShowHelpWindow()
    if BCB.helpFrame and BCB.helpFrame:IsShown() then BCB.helpFrame:Hide(); return end
    if not BCB.helpFrame then
        local h = CreateFrame("Frame", "BCBHelpWindow", UIParent, "ButtonFrameTemplate")
        h:SetSize(460, 520); h:SetPoint("CENTER", 200, 50); h:SetToplevel(true); h:EnableMouse(true); h:SetMovable(true); h:SetClampedToScreen(true)
        h:RegisterForDrag("LeftButton"); h:SetScript("OnDragStart", function() h:StartMoving() end); h:SetScript("OnDragStop", function() h:StopMovingOrSizing() end)
        ButtonFrameTemplate_HidePortrait(h); ButtonFrameTemplate_HideButtonBar(h); if h.Inset then h.Inset:Hide() end; BCB.SeatChrome(h)  -- Forever border offset (Utils.lua)
        h:SetTitle(L["HELP_WINDOW_TITLE"] or "BigChatBox Help")
        tinsert(UISpecialFrames, "BCBHelpWindow")

        -- Scrollable help text
        local sf = BCB.CreateScrollFrame(nil, h)
        sf:SetPoint("TOPLEFT", 16, -60); sf:SetPoint("BOTTOMRIGHT", -24, 16)
        local ct = CreateFrame("Frame", nil, sf); ct:SetWidth(sf:GetWidth() - 10)
        sf:SetScrollChild(ct)

        local txt = ct:CreateFontString(nil, "OVERLAY", "GameFontHighlight"); txt:SetPoint("TOPLEFT", 0, 0); txt:SetWidth(ct:GetWidth()); txt:SetJustifyH("LEFT"); txt:SetJustifyV("TOP"); txt:SetSpacing(3)
        txt:SetText(L["HELP_BODY_MAIN"] or "")
        ct:SetHeight(txt:GetStringHeight() + 20)
        BCB.helpFrame = h
    end
    BCB.helpFrame:Show(); BCB.helpFrame:Raise()
end

--------------------------------------------------------------------------------
-- Main Window
--------------------------------------------------------------------------------
local TAB_BUILDERS = {
    general   = Config.BuildGeneralTab,
    designer  = Config.BuildDesignerTab,
    placement = Config.BuildPlacementTab,
    features  = Config.BuildFeaturesTab,
    snippets  = Config.BuildSnippetsTab,
    history   = Config.BuildHistoryTab,
    advanced  = Config.BuildAdvancedTab,
    reset     = Config.BuildResetTab,
}

local function CreateConfigWindow()
    if configFrame then return configFrame end
    -- Compute window height based on screen resolution (75% of screen, clamped 700-950)
    Config.WINDOW_HEIGHT = math.min(math.max(math.floor(UIParent:GetHeight() * 0.75), 700), 950)
    local f = CreateFrame("Frame", "BCBConfigWindow", UIParent, "ButtonFrameTemplate")
    f:SetSize(Config.WINDOW_WIDTH, Config.WINDOW_HEIGHT); f:SetPoint("CENTER"); f:SetToplevel(true); f:EnableMouse(true); f:SetMovable(true); f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton"); f:SetScript("OnDragStart", function() f:StartMoving(); f:SetUserPlaced(false) end); f:SetScript("OnDragStop", function() f:StopMovingOrSizing(); f:SetUserPlaced(false) end)
    f:SetScript("OnMouseWheel", function() end); f:Hide()
    ButtonFrameTemplate_HidePortrait(f); ButtonFrameTemplate_HideButtonBar(f); if f.Inset then f.Inset:Hide() end; BCB.SeatChrome(f)  -- Forever border offset (Utils.lua)
    f:SetTitle("Customize BigChatBox")
    if f.Bg then f.Bg:SetAlpha(0.95) end
    f.CloseButton:SetScript("OnClick", function() f:Hide() end)
    f:HookScript("OnHide", function()
        -- UIParent-parented overlays won't hide automatically
        for _, c in pairs(tabContainers) do
            if c.previewWidget then
                if c.previewWidget.HideAutocompletePreview then c.previewWidget:HideAutocompletePreview() end
                if c.previewWidget.HideCharCounterPreview then c.previewWidget:HideCharCounterPreview() end
            end
        end
    end)
    tinsert(UISpecialFrames, "BCBConfigWindow")
    BCB.SafeRegisterEvent(f, "PLAYER_REGEN_DISABLED"); f:SetScript("OnEvent", function(self, event) if event == "PLAYER_REGEN_DISABLED" and self:IsShown() then self:Hide(); BCB:Print(L["COMBAT_CLOSE"]) end end)
    configFrame = f; Config.configFrame = f  -- Set early so tab builders can reference it

    local containers, lastTab, tabList = {}, nil, {}
    local StyleTabs  -- defined after the tabs exist; marks the selected tab
    for i, tab in ipairs(TABS) do
        local tc = CreateFrame("Frame", nil, f); tc:SetPoint("TOPLEFT", 4, -60); tc:SetPoint("BOTTOMRIGHT", -4, 4); tc:Hide()
        tabContainers[tab.key] = tc; TAB_BUILDERS[tab.key](tc)
        local tpl = "PanelTabButtonTemplate"; if C_XMLUtil and C_XMLUtil.GetTemplateInfo and C_XMLUtil.GetTemplateInfo("PanelTopTabButtonTemplate") then tpl = "PanelTopTabButtonTemplate" end
        local tb = CreateFrame("Button", "BCBCfgTab"..i, f, tpl); tb:SetText(tab.name())
        if tpl == "PanelTopTabButtonTemplate" then PanelTemplates_TabResize(tb, 15, nil, 70) else PanelTemplates_TabResize(tb, 0) end
        if lastTab then tb:SetPoint("LEFT", lastTab, "RIGHT", 5, 0) else tb:SetPoint("TOPLEFT", 7, -25) end
        lastTab = tb; tc.button = tb
        tb:SetScript("OnClick", function()
            -- Don't allow clicking disabled tabs
            if tab.key == "snippets" and BigChatBoxDB.snippetEnabled == false then return end
            if tab.key == "history" and BigChatBoxDB.historyEnabled == false then return end
            for _, c in ipairs(containers) do
                PanelTemplates_DeselectTab(c.button); c:Hide()
                -- Hide UIParent-parented overlays when leaving any tab
                if c.previewWidget and c.previewWidget.HideAutocompletePreview then
                    c.previewWidget:HideAutocompletePreview()
                end
                if c.previewWidget and c.previewWidget.HideCharCounterPreview then
                    c.previewWidget:HideCharCounterPreview()
                end
            end
            PanelTemplates_SelectTab(tb); tc:Show(); currentTab = tab.key
            if StyleTabs then StyleTabs(); C_Timer.After(0, StyleTabs) end
            -- Refresh preview widget on this tab to reflect latest settings
            if tc.previewWidget and tc.previewWidget.Refresh then tc.previewWidget:Refresh() end
            -- Show placement-only overlays only on the Placement tab
            if tab.key == "placement" and tc.previewWidget then
                if tc.previewWidget.ShowAutocompletePreview then tc.previewWidget:ShowAutocompletePreview() end
                if tc.previewWidget.ShowCharCounterPreview then tc.previewWidget:ShowCharCounterPreview() end
            end
        end)
        -- Store tab button reference by key
        tb.tabKey = tab.key
        table.insert(tabList, tb); table.insert(containers, tc)
    end
    f.Tabs = tabList; PanelTemplates_SetNumTabs(f, #tabList)

    -- Keep the tab row inside the window (UI-01). The template sizing BCB used
    -- (15 padding, 70 minimum per tab) made eight tabs far wider than the window.
    -- Now each tab is sized to its name with little padding, and the room left
    -- over is shared out as extra padding, so the row fills the window width at
    -- full height. Only when even the minimum does not fit (long translations) is
    -- the row scaled down as a whole.
    -- Two template details (Blizzard_SharedXML SharedUIPanelTemplates):
    --  * PanelTemplates_TabResize sets the tab text box to exactly the text width,
    --    and the box is 10 high; a fractional width squeezes some names, so tabs
    --    looked like they had different font sizes. The text box is freed after
    --    sizing (SetWidth(0) = size to the text) and tab widths are whole numbers.
    --  * The tab art is a fixed-height texture set (cropped to 75% in OnLoad), so
    --    the tab's own SetHeight does not change it. TAB_EXTRA_HEIGHT grows the art
    --    and the tab together.
    -- Re-applied after every show and click: the template resizes itself on show,
    -- and HookScript runs after the template's own handler.
    local TAB_LEFT, TAB_RIGHT, TAB_GAP, TAB_TOP = 7, 12, 5, -25
    local TAB_MIN_PAD = 6
    local TAB_EXTRA_HEIGHT = 6   -- taller tabs: extra height for the tab art (0 = template height)
    local fitting = false

    local function TabText(tb)
        return tb.Text or tb:GetFontString()
    end

    -- Taller tab art, once per tab (top-tab template only; Classic tabs keep theirs)
    if TAB_EXTRA_HEIGHT ~= 0 then
        for _, tb in ipairs(tabList) do
            if tb.TabTextures then
                for _, tex in ipairs(tb.TabTextures) do tex:SetHeight(tex:GetHeight() + TAB_EXTRA_HEIGHT) end
                tb:SetHeight(tb:GetHeight() + TAB_EXTRA_HEIGHT)
            end
        end
    end

    local function SizeTabs(pad)
        local total = TAB_GAP * (#tabList - 1)
        for _, tb in ipairs(tabList) do
            PanelTemplates_TabResize(tb, pad)
            tb:SetWidth(math.floor(tb:GetWidth() + 0.5))
            total = total + tb:GetWidth()
        end
        return total
    end

    local function FitTabs()
        if fitting then return end
        fitting = true
        local first = tabList[1]
        local avail = f:GetWidth() - TAB_LEFT - TAB_RIGHT
        local scale = 1
        local total = SizeTabs(TAB_MIN_PAD)
        if total > avail then
            scale = avail / total
        else
            -- Width gained per padding unit, measured, so any template works
            local total2 = SizeTabs(TAB_MIN_PAD + 10)
            local perUnit = (total2 - total) / 10
            local pad = TAB_MIN_PAD
            if perUnit > 0 then pad = TAB_MIN_PAD + math.floor((avail - total) / perUnit) end
            total = SizeTabs(pad)
            while total > avail and pad > TAB_MIN_PAD do  -- rounding safety
                pad = pad - 1
                total = SizeTabs(pad)
            end
        end
        -- Let each name size itself, so no name is squeezed or cut off
        for _, tb in ipairs(tabList) do
            local fs = TabText(tb)
            if fs then fs:SetWidth(0) end
        end
        local h = first:GetHeight()
        for _, tb in ipairs(tabList) do tb:SetScale(scale) end
        -- Offsets of a scaled frame are in its own units, hence the division
        first:ClearAllPoints()
        first:SetPoint("BOTTOMLEFT", f, "TOPLEFT", TAB_LEFT / scale, (TAB_TOP - h + TAB_EXTRA_HEIGHT) / scale)
        fitting = false
    end
    for _, tb in ipairs(tabList) do
        tb:HookScript("OnShow", FitTabs)
        tb:HookScript("OnClick", FitTabs)  -- selecting a tab can resize it on some clients
    end
    f:HookScript("OnShow", function() FitTabs(); C_Timer.After(0, FitTabs) end)
    FitTabs()

    -- Tab colours (UI-02): the selected tab has white text and an accent bar under
    -- its name, the others gold, Reset red, disabled grey. One function sets them
    -- all, so a tab can never be left in the wrong colour. Called after every select
    -- and state change, and one frame later because the template recolours on select.
    local ACCENT = { 0.33, 0.60, 1.00 }  -- |cff5599ff
    StyleTabs = function()
        for i, tb in ipairs(tabList) do
            local fs = tb:GetFontString()
            local key, isRed = tb.tabKey, TABS[i].red
            local disabled = (key == "snippets" and BigChatBoxDB.snippetEnabled == false) or
                             (key == "history" and BigChatBoxDB.historyEnabled == false)
            local selected = (key == currentTab) and not disabled
            if not tb._bcbAccent then
                local bar = tb:CreateTexture(nil, "OVERLAY")
                bar:SetHeight(1)
                bar:SetPoint("BOTTOMLEFT", 8, 3); bar:SetPoint("BOTTOMRIGHT", -8, 3)
                bar:SetColorTexture(ACCENT[1], ACCENT[2], ACCENT[3], 1)
                tb._bcbAccent = bar
            end
            tb._bcbAccent:SetShown(selected)
            if fs then
                if disabled then fs:SetTextColor(0.4, 0.4, 0.4)
                elseif selected then
                    if isRed then fs:SetTextColor(1, 0.55, 0.55) else fs:SetTextColor(1, 1, 1) end
                elseif isRed then fs:SetTextColor(0.85, 0.3, 0.3)
                else fs:SetTextColor(1, 0.82, 0) end
            end
        end
    end
    for _, tb in ipairs(tabList) do
        tb:HookScript("OnShow", function() StyleTabs() end)
        tb:HookScript("OnLeave", function() StyleTabs() end)  -- hover may recolour the text
    end

    -- Function to update tab enabled/disabled states
    function BCB.UpdateTabStates()
        for _, tb in ipairs(tabList) do
            local key = tb.tabKey
            local disabled = (key == "snippets" and BigChatBoxDB.snippetEnabled == false) or
                             (key == "history" and BigChatBoxDB.historyEnabled == false)
            tb:SetEnabled(not disabled)
            if disabled then
                -- If currently on a disabled tab, switch to tools
                if currentTab == key then
                    for _, c in ipairs(containers) do PanelTemplates_DeselectTab(c.button); c:Hide() end
                    for _, c in ipairs(containers) do
                        if c.button.tabKey == "features" then PanelTemplates_SelectTab(c.button); c:Show(); currentTab = "features"; break end
                    end
                end
            end
        end
        StyleTabs(); C_Timer.After(0.05, StyleTabs)
    end
    BCB.UpdateTabStates() -- Apply initial state
    containers[1].button:Click()
    f:HookScript("OnShow", function(self)
        if self._stale then self._stale = nil; BCB.RefreshConfigTab() end
    end)
    configFrame = f; Config.configFrame = f; return f
end

function BCB.RefreshConfigTab()
    if not configFrame then return end
    -- PERF-01: never rebuild a hidden window. Every sent message calls this; with the
    -- window closed that rebuilt the History tab (hundreds of frames, never freed)
    -- on every Enter. Mark it stale and rebuild once when the window opens.
    if not configFrame:IsShown() then configFrame._stale = true; return end
    -- Rebuild dynamic tabs
    for _, key in ipairs({"history", "snippets"}) do
        if currentTab == key and tabContainers[key] then
            local tc = tabContainers[key]; for _, k in ipairs({tc:GetChildren()}) do k:Hide(); k:SetParent(nil) end
            for _, r in ipairs({tc:GetRegions()}) do r:Hide() end
            TAB_BUILDERS[key](tc); tc:Show()
        end
    end
    for _, key in ipairs({"general", "designer", "placement"}) do if tabContainers[key] and tabContainers[key].previewWidget then tabContainers[key].previewWidget:Refresh() end end
end

-- Called by ApplyStyleData (WelcomePanel, GeneralTab) to sync config widgets after a style change
function BCB.RefreshConfigAfterStyleApply(styleName)
    if not configFrame then return end
    -- Sync style dropdown (now lives in DesignerTab)
    local dc = tabContainers["designer"]
    if dc and dc.styleDropdown then dc.styleDropdown:SetSelected(styleName or BigChatBoxDB.activeStyle or "Default") end
    -- Refresh preview on any visible tab that has one
    for _, tc in pairs(tabContainers) do
        if tc.previewWidget and tc.previewWidget.Refresh then tc.previewWidget:Refresh() end
    end
    -- Refresh all Designer tab widgets to reflect new DB values
    if dc and dc.RefreshDesignerWidgets then dc.RefreshDesignerWidgets() end
end


function BCB.OpenConfigWindow()
    if InCombatLockdown() then BCB:Print(L["COMBAT_BLOCKED"]); return end
    if SettingsPanel and SettingsPanel:IsShown() then HideUIPanel(SettingsPanel) end
    if not configFrame then CreateConfigWindow() end; configFrame:ClearAllPoints(); configFrame:SetPoint("CENTER"); configFrame:Show(); configFrame:Raise()
end

-- Popups (same as v5.0.0)
StaticPopupDialogs["BCB_RESET_ALL"] = { text = L["POPUP_RESET_ALL"], button1 = L["BTN_RESET_ALL_CONFIRM"], button2 = L["CANCEL"],
    -- Reset position, size and the whole look to the defaults. The look reuses
    -- ApplyStyleData(nil) instead of a second copy of every default (CMP-01).
    OnAccept = function()
        BCB.ResetPosition()
        if BCB.ApplyStyleData then BCB.ApplyStyleData(nil, "Default") end
        BigChatBoxDB.historyLength = 100
        BCB:Print(L["PRINT_RESET_ALL"]); C_UI.Reload()
    end, timeout=0, whileDead=true, hideOnEscape=true, preferredIndex = 3 }
StaticPopupDialogs["BCB_RESET_APPEARANCE"] = { text = L["POPUP_RESET_APPEARANCE"], button1 = L["RESET"], button2 = L["CANCEL"],
    OnAccept = function() BigChatBoxDB.bgAlpha=0.95; BigChatBoxDB.borderAlpha=1.0; BigChatBoxDB.bgColor={r=0.1,g=0.1,b=0.1}; BigChatBoxDB.borderColor={r=1,g=1,b=1}; BigChatBoxDB.bgTexture=BCB.defaults.bgTexture; BigChatBoxDB.borderTexture=BCB.defaults.borderTexture; BigChatBoxDB.bgTextureName="Solid"; BigChatBoxDB.borderTextureName="Default"; BigChatBoxDB.font=BCB.defaults.font; BigChatBoxDB.channelFont=BCB.defaults.channelFont; BigChatBoxDB.fontName="Default"; BigChatBoxDB.channelFontName="Default"; BigChatBoxDB.fontSize=14; BigChatBoxDB.channelFontSize=16; BigChatBoxDB.scale=1; BigChatBoxDB.bgScale=100; BigChatBoxDB.bgChannelTint=false; BigChatBoxDB.bgTintIntensity=50; BigChatBoxDB.fontOutline="None"; BigChatBoxDB.boxDropShadow=false; BigChatBoxDB.textAlign="LEFT"; BigChatBoxDB.borderThickness=16; BigChatBoxDB.dynamicHeight=false; BigChatBoxDB.dynamicWidth=false; BigChatBoxDB.activeStyle="Default"
        if BCB.UpdateBackdrop then BCB.UpdateBackdrop() end; if BCB.UpdateFontSize then BCB.UpdateFontSize() end; BCB:Print(L["PRINT_RESET_APPEARANCE"]); C_UI.Reload() end, timeout=0, whileDead=true, hideOnEscape=true, preferredIndex = 3 }
-- History tab "Wipe Entire History": clears chat history AND Recent Whispers, and
-- says so; no reload needed, the tab refreshes (CMP-06, Open question 14). The
-- channel-name menu's "Clear Chat History" (BCB_CLEAR_HISTORY) clears chat history only.
StaticPopupDialogs["BCB_WIPE_HISTORY"] = { text = L["POPUP_WIPE_HISTORY_ALL"], button1 = L["BTN_WIPE_CONFIRM"], button2 = L["CANCEL"],
    OnAccept = function()
        BigChatBoxDB.history = {}; BigChatBoxDB.whisperHistory = {}
        BCB:Print(L["PRINT_HISTORY_WIPED_ALL"])
        if BCB.RefreshConfigTab then BCB.RefreshConfigTab() end
    end, timeout=0, whileDead=true, hideOnEscape=true, preferredIndex = 3 }
StaticPopupDialogs["BCB_WIPE_COMMANDS"] = { text = L["POPUP_WIPE_COMMANDS"], button1 = L["BTN_WIPE_CONFIRM"], button2 = L["CANCEL"],
    OnAccept = function()
        if BigChatBoxDB.history then
            local newHist = {}
            for _, entry in ipairs(BigChatBoxDB.history) do
                local text = type(entry) == "table" and entry.text or entry
                if not text or not text:match("^/") then
                    table.insert(newHist, entry)
                end
            end
            BigChatBoxDB.history = newHist
        end
        C_UI.Reload()
    end, timeout=0, whileDead=true, hideOnEscape=true, preferredIndex = 3 }
StaticPopupDialogs["BCB_SAVE_STYLE"] = { text = L["POPUP_SAVE_STYLE_TEXT"], hasEditBox = true, button1 = L["SAVE"], button2 = L["CANCEL"],
    OnAccept = function(self) local name = self.EditBox:GetText(); if name and name ~= "" then if not BigChatBoxDB.styles then BigChatBoxDB.styles = {} end
        local function DoSave()
            local keys = {"bgAlpha","bgColor","bgTexture","bgTextureName","bgScale","bgChannelTint","bgTintIntensity","borderAlpha","borderColor","borderTexture","borderTextureName","borderThickness","font","fontName","channelFont","channelFontName","fontSize","channelFontSize","scale","fontOutline","boxDropShadow","textAlign","colorTypedText","width","height","dynamicHeight","dynamicWidth"}
            local s = {}; for _, k in ipairs(keys) do s[k] = BigChatBoxDB[k] end; BigChatBoxDB.styles[name] = s; BigChatBoxDB.activeStyle = name; BCB:Print(string.format(L["PRINT_STYLE_SAVED"], name))
        end
        if BigChatBoxDB.styles[name] then
            StaticPopup_Show("BCB_OVERWRITE_STYLE", name, nil, { saveFn = DoSave })
        else DoSave() end
    end end, timeout=0, whileDead=true, hideOnEscape=true, preferredIndex = 3 }
StaticPopupDialogs["BCB_OVERWRITE_STYLE"] = { text = L["POPUP_OVERWRITE_STYLE"], button1 = L["BTN_OVERWRITE_CONFIRM"], button2 = L["CANCEL"],
    OnAccept = function(self, data) if data and data.saveFn then data.saveFn() end end, timeout=0, whileDead=true, hideOnEscape=true, preferredIndex = 3 }
StaticPopupDialogs["BCB_EXPORT_STYLE"] = { text = L["POPUP_EXPORT_STYLE_TEXT"], hasEditBox = true, button1 = L["CLOSE"], maxLetters = 0, editBoxWidth = 350,
    OnShow = function(self)
        local keys = {"bgAlpha","bgColor","bgTexture","bgTextureName","bgScale","bgChannelTint","bgTintIntensity","borderAlpha","borderColor","borderTexture","borderTextureName","borderThickness","font","fontName","channelFont","channelFontName","fontSize","channelFontSize","scale","fontOutline","boxDropShadow","textAlign","colorTypedText","width","height","dynamicHeight","dynamicWidth"}
        local styleTable = {}; for _, k in ipairs(keys) do styleTable[k] = BigChatBoxDB[k] end
        local encoded = BCB.EncodeStyleString and BCB.EncodeStyleString(styleTable)
        if encoded then
            self.EditBox:SetText(encoded)
        else
            -- Fallback to legacy format if encoding unavailable
            local p = {}; for _, k in ipairs(keys) do local v = BigChatBoxDB[k]; if type(v)=="table" then p[#p+1]=k.."="..(v.r or 1)..",".. (v.g or 1)..",".. (v.b or 1) elseif type(v)=="boolean" then p[#p+1]=k.."="..(v and "1" or "0") elseif v ~= nil then p[#p+1]=k.."="..tostring(v) end end
            self.EditBox:SetText("BCB:"..table.concat(p, ";"))
        end
        self.EditBox:HighlightText()
    end, timeout=0, whileDead=true, hideOnEscape=true, preferredIndex = 3 }
StaticPopupDialogs["BCB_IMPORT_STYLE"] = { text = L["POPUP_IMPORT_STYLE_TEXT"], hasEditBox = true, button1 = L["IMPORT"], button2 = L["CANCEL"], maxLetters = 0, editBoxWidth = 350,
    OnAccept = function(self)
        local t = self.EditBox:GetText()
        if not t or t == "" then BCB:Print(L["PRINT_NO_STYLE_STRING"]); return end
        t = t:match("^%s*(.-)%s*$")  -- trim
        local imported = false
        local decoded = nil
        -- New compact format: !BCB1:...
        if BCB.IsEncodedStyleString and BCB.IsEncodedStyleString(t) then
            decoded = BCB.DecodeStyleString(t)
            if decoded then
                imported = true
            else
                BCB:Print(L["PRINT_STYLE_DECODE_FAIL"])
            end
        -- Legacy format: BCB:key=val;key=val;...
        elseif t:sub(1,4) == "BCB:" then
            decoded = {}
            local d = t:sub(5)
            for pair in d:gmatch("[^;]+") do local k, v = pair:match("^(.+)=(.+)$"); if k and v then if v:find(",") then local r,g,b = v:match("([^,]+),([^,]+),([^,]+)"); decoded[k]={r=tonumber(r) or 1, g=tonumber(g) or 1, b=tonumber(b) or 1}
                elseif v=="true" or v=="1" then decoded[k]=true elseif v=="false" or v=="0" then decoded[k]=false elseif tonumber(v) then decoded[k]=tonumber(v) else decoded[k]=v end end end
            imported = true
        else
            BCB:Print(L["PRINT_STYLE_INVALID"])
        end
        if imported and decoded then
            -- ApplyStyleData resets all style keys to defaults first, then overlays — prevents
            -- stale keys (e.g. bgChannelTint) from a previous style bleeding through
            if BCB.ApplyStyleData then
                BCB.ApplyStyleData(decoded, "Imported")
            else
                for k, v in pairs(decoded) do BigChatBoxDB[k] = v end
                if BCB.frame then BCB.frame:SetSize(BigChatBoxDB.width or 400, BigChatBoxDB.height or 50); BCB.frame:SetScale(BigChatBoxDB.scale or 1) end
                if BCB.UpdateBackdrop then BCB.UpdateBackdrop() end
                if BCB.UpdateFontSize then BCB.UpdateFontSize() end
                if BCB.UpdateChannelFontSize then BCB.UpdateChannelFontSize() end
            end
            if BCB.RefreshConfigTab then BCB.RefreshConfigTab() end
            BCB:Print(L["PRINT_STYLE_IMPORTED"])
            -- Prompt to save as a named style
            C_Timer.After(0.1, function() StaticPopup_Show("BCB_NAME_IMPORTED_STYLE") end)
        end
    end, timeout=0, whileDead=true, hideOnEscape=true, preferredIndex = 3 }
StaticPopupDialogs["BCB_NAME_IMPORTED_STYLE"] = { text = L["POPUP_NAME_IMPORT_STYLE"], hasEditBox = true, button1 = L["SAVE"], button2 = L["BTN_SKIP"],
    OnAccept = function(self)
        local name = self.EditBox:GetText()
        if not name or name == "" then return end
        if not BigChatBoxDB.styles then BigChatBoxDB.styles = {} end
        local keys = {"bgAlpha","bgColor","bgTexture","bgTextureName","bgScale","bgChannelTint","bgTintIntensity","borderAlpha","borderColor","borderTexture","borderTextureName","borderThickness","font","fontName","channelFont","channelFontName","fontSize","channelFontSize","scale","fontOutline","boxDropShadow","textAlign","colorTypedText","width","height","dynamicHeight","dynamicWidth"}
        local s = {}; for _, k in ipairs(keys) do s[k] = BigChatBoxDB[k] end
        if BigChatBoxDB.styles[name] then
            StaticPopup_Show("BCB_OVERWRITE_STYLE", name, nil, { saveFn = function()
                BigChatBoxDB.styles[name] = s; BigChatBoxDB.activeStyle = name
                BCB:Print(string.format(L["PRINT_STYLE_SAVED"], name))
                if BCB.RefreshConfigTab then BCB.RefreshConfigTab() end
            end })
        else
            BigChatBoxDB.styles[name] = s; BigChatBoxDB.activeStyle = name
            BCB:Print(string.format(L["PRINT_STYLE_SAVED"], name))
            if BCB.RefreshConfigTab then BCB.RefreshConfigTab() end
        end
    end, timeout=0, whileDead=true, hideOnEscape=true, preferredIndex = 3 }
StaticPopupDialogs["BCB_HELP"] = { text = "|cff5599ffBigChatBox Help|r\n\n|cffffd100Left-click|r channel name above input box to cycle channels.\n|cffffd100Right-click|r channel name for config and history.\n|cffffd100/bcb|r or |cffffd100/bcb config|r to open settings.\n|cffffd100Anchor Editor|r lets you drag and resize.\n|cffffd100Arrow keys|r nudge 1 pixel at a time.\n|cffffd100Shift+drag|r resizes symmetrically.\n|cffffd100Styles|r to save and load presets.\n|cffffd100Export/Import|r to share with others.",
    button1 = L["PATCHNOTES_GOT_IT"], timeout=0, whileDead=true, hideOnEscape=true, wide=true, preferredIndex = 3 }

StaticPopupDialogs["BCB_RESET_PLACEMENT"] = { text = L["POPUP_RESET_PLACEMENT"], button1 = L["RESET"], button2 = L["CANCEL"],
    OnAccept = function() BCB.ResetPosition(); BigChatBoxDB.scale = 1; BigChatBoxDB.width = 400; BigChatBoxDB.height = 50
        BCB:Print(L["PRINT_RESET_PLACEMENT"]); C_UI.Reload() end, timeout=0, whileDead=true, hideOnEscape=true, preferredIndex = 3 }
StaticPopupDialogs["BCB_RESET_HISTORY"] = { text = L["POPUP_RESET_HISTORY"], button1 = L["RESET"], button2 = L["CANCEL"],
    OnAccept = function() BigChatBoxDB.history={}; BigChatBoxDB.whisperHistory={}; BigChatBoxDB.historyLength=100; BCB:Print(L["PRINT_RESET_HISTORY"]); C_UI.Reload() end, timeout=0, whileDead=true, hideOnEscape=true, preferredIndex = 3 }

StaticPopupDialogs["BCB_RESET_SNIPPETS"] = { text = L["POPUP_RESET_SNIPPETS"], button1 = L["RESET"], button2 = L["CANCEL"],
    OnAccept = function() BigChatBoxDB.snippets = {}; BCB:Print(L["PRINT_SNIPPETS_REMOVED"]); C_UI.Reload() end, timeout=0, whileDead=true, hideOnEscape=true, preferredIndex = 3 }

StaticPopupDialogs["BCB_SHARE_SNIPPET"] = { text = L["POPUP_SHARE_SNIPPET_TEXT"], button1 = L["CLOSE"], hasEditBox = true, editBoxWidth = 350,
    OnShow = function(self, data)
        local eb = self.editBox or _G[self:GetName().."EditBox"]
        if eb and data then eb:SetText(data.encoded or ""); eb:HighlightText(); eb:SetFocus() end
    end,
    EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end, timeout=0, whileDead=true, hideOnEscape=true, preferredIndex=3 }

StaticPopupDialogs["BCB_IMPORT_SNIPPETS"] = { text = L["POPUP_IMPORT_SNIPPET_TEXT"], button1 = L["IMPORT"], button2 = L["CANCEL"], hasEditBox = true, editBoxWidth = 350,
    OnAccept = function(self)
        local eb = self.editBox or _G[self:GetName().."EditBox"]
        if not eb then return end
        local input = eb:GetText()
        if not BigChatBoxDB.snippets then BigChatBoxDB.snippets = {} end
        local added, skipped = 0, 0
        local decoded = BCB.DecodeSnippetString and BCB.DecodeSnippetString(input)
        if decoded then
            for trigger, data in pairs(decoded) do
                if BigChatBoxDB.snippets[trigger] then skipped = skipped + 1
                else BCB.AddSnippet(trigger, data.text, { enabled = data.enabled, channel = data.channel, global = data.global }); added = added + 1 end
            end
        else
            BCB:Print(L["PRINT_SNIPPET_INVALID"]); return
        end
        BCB:Print(string.format(L["PRINT_SNIPPETS_IMPORTED"], added) .. (skipped > 0 and string.format(L["PRINT_SNIPPETS_SKIPPED"], skipped) or ""))
        if BCB.RefreshConfigTab then BCB.RefreshConfigTab() end
    end, EditBoxOnEnterPressed = function(self) self:GetParent().button1:Click() end,
    timeout=0, whileDead=true, hideOnEscape=true, preferredIndex=3 }

StaticPopupDialogs["BCB_DELETE_SNIPPET"] = { text = L["POPUP_DELETE_SNIPPET"], button1 = L["BTN_DELETE_CONFIRM"], button2 = L["CANCEL"],
    OnAccept = function(self, data)
        if data and data.trigger and BigChatBoxDB.snippets then
            BigChatBoxDB.snippets[data.trigger] = nil
            BCB:Print(string.format(L["PRINT_SNIPPET_REMOVED"], data.trigger))
            if BCB.RefreshConfigTab then BCB.RefreshConfigTab() end
        end
    end, timeout=0, whileDead=true, hideOnEscape=true, preferredIndex = 3 }

StaticPopupDialogs["BCB_RESET_STYLES"] = { text = L["POPUP_RESET_STYLES"], button1 = L["BTN_RESET_STYLES_CONFIRM"], button2 = L["CANCEL"],
    OnAccept = function() BigChatBoxDB.styles = {}; BigChatBoxDB.activeStyle = "Default"; BCB:Print(L["PRINT_STYLES_REMOVED"]); C_UI.Reload() end, timeout=0, whileDead=true, hideOnEscape=true, preferredIndex = 3 }

StaticPopupDialogs["BCB_DELETE_STYLE"] = { text = L["POPUP_DELETE_STYLE"], button1 = L["BTN_DELETE_CONFIRM"], button2 = L["CANCEL"],
    OnAccept = function()
        local name = BigChatBoxDB.activeStyle
        if not name or name == "Default" then BCB:Print(L["PRINT_CANT_DELETE_DEFAULT"]); return end
        if BigChatBoxDB.styles then BigChatBoxDB.styles[name] = nil end
        BigChatBoxDB.activeStyle = "Default"
        local d = BCB.defaults or {}
        BigChatBoxDB.bgAlpha=0.95; BigChatBoxDB.borderAlpha=1.0; BigChatBoxDB.bgColor={r=0.1,g=0.1,b=0.1}; BigChatBoxDB.borderColor={r=1,g=1,b=1}
        BigChatBoxDB.bgTexture=d.bgTexture; BigChatBoxDB.borderTexture=d.borderTexture; BigChatBoxDB.bgTextureName="Solid"; BigChatBoxDB.borderTextureName="Default"
        BigChatBoxDB.font=d.font; BigChatBoxDB.channelFont=d.channelFont; BigChatBoxDB.fontName="Default"; BigChatBoxDB.channelFontName="Default"
        BigChatBoxDB.fontSize=14; BigChatBoxDB.channelFontSize=16; BigChatBoxDB.scale=1; BigChatBoxDB.fontOutline="None"
        BigChatBoxDB.boxDropShadow=false; BigChatBoxDB.textAlign="LEFT"; BigChatBoxDB.borderThickness=16; BigChatBoxDB.bgScale=100; BigChatBoxDB.dynamicHeight=false; BigChatBoxDB.dynamicWidth=false
        BigChatBoxDB.bgChannelTint=false; BigChatBoxDB.bgTintIntensity=50
        if BCB.UpdateBackdrop then BCB.UpdateBackdrop() end
        if BCB.UpdateFontSize then BCB.UpdateFontSize() end
        BCB:Print(string.format(L["PRINT_STYLE_DELETED"], name))
        if BCB.RefreshConfigTab then BCB.RefreshConfigTab() end
    end, timeout=0, whileDead=true, hideOnEscape=true, preferredIndex = 3 }

-- Welcome Panel popups (v5.5.0)
StaticPopupDialogs["BCB_QUIT_SETUP"] = {
    text = L["POPUP_QUIT_SETUP"],
    button1 = L["BTN_QUIT_SETUP_CONFIRM"], button2 = L["CANCEL"],
    OnAccept = function()
        BigChatBoxDB.setupComplete = true
        if BCB.welcomePanel then BCB.welcomePanel:Hide() end
        BCB:Print(L["PRINT_SETUP_SKIPPED"])
    end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3
}

StaticPopupDialogs["BCB_RESTART_SETUP"] = {
    text = L["POPUP_RESTART_SETUP"],
    button1 = L["BTN_RESTART_SETUP_CONFIRM"], button2 = L["CANCEL"],
    OnAccept = function()
        -- Reset every setting: InitializeDB() re-applies all defaults on the next
        -- load. Player content is kept (SV-06, Open question 8): snippets, saved
        -- styles, chat and whisper history. BigChatBoxLocale is a separate
        -- SavedVariable, so the setup reopens in the player's language.
        local db = BigChatBoxDB or {}
        BigChatBoxDB = {
            snippets = db.snippets, styles = db.styles,
            history = db.history, whisperHistory = db.whisperHistory,
            dbVersion = db.dbVersion, seenPatchVersion = db.seenPatchVersion,
        }
        C_UI.Reload()
    end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

StaticPopupDialogs["BCB_CHANGE_LANGUAGE"] = {
    text = L["POPUP_CHANGE_LANGUAGE"],
    button1 = L["BTN_RELOAD_CONFIRM"], button2 = L["CANCEL"],
    OnAccept = function()
        local code = BCB._pendingLangCode
        if code == "client" then
            BigChatBoxLocale = nil
        else
            BigChatBoxLocale = code
        end
        BCB._pendingLangCode = nil
        C_UI.Reload()
    end,
    OnCancel = function() BCB._pendingLangCode = nil end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3
}

StaticPopupDialogs["BCB_WIZARD_CHANGE_LANGUAGE"] = {
    text = L["POPUP_WIZARD_CHANGE_LANGUAGE"],
    button1 = L["BTN_RELOAD_CONFIRM"], button2 = L["CANCEL"],
    OnAccept = function()
        local code = BCB._pendingLangCode
        BigChatBoxDB.setupComplete = false  -- re-run wizard in new language
        if code == "client" then
            BigChatBoxLocale = nil
        else
            BigChatBoxLocale = code
        end
        BCB._pendingLangCode = nil
        C_UI.Reload()
    end,
    OnCancel = function() BCB._pendingLangCode = nil end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3
}

--------------------------------------------------------------------------------
-- SECURE CONTENT HELP WINDOW (moved from WelcomePanel.lua so Classic has it, CMPT-03)
--------------------------------------------------------------------------------
function BCB.ShowSecureContentHelp()
    if BCB.secureHelpFrame and BCB.secureHelpFrame:IsShown() then BCB.secureHelpFrame:Hide(); return end
    if not BCB.secureHelpFrame then
        local h = CreateFrame("Frame", "BCBSecureHelpWindow", UIParent, "ButtonFrameTemplate")
        h:SetSize(460, 480); h:SetPoint("CENTER", 200, 50); h:SetToplevel(true); h:EnableMouse(true); h:SetMovable(true); h:SetClampedToScreen(true)
        h:RegisterForDrag("LeftButton"); h:SetScript("OnDragStart", function() h:StartMoving() end); h:SetScript("OnDragStop", function() h:StopMovingOrSizing() end)
        ButtonFrameTemplate_HidePortrait(h); ButtonFrameTemplate_HideButtonBar(h); if h.Inset then h.Inset:Hide() end; BCB.SeatChrome(h)  -- Forever border offset (Utils.lua)
        h:SetTitle(L["WELCOME_SECURE_TITLE"]); tinsert(UISpecialFrames, "BCBSecureHelpWindow")
        local sf = BCB.CreateScrollFrame(nil, h)
        sf:SetPoint("TOPLEFT", 16, -60); sf:SetPoint("BOTTOMRIGHT", -24, 16)
        local ct = CreateFrame("Frame", nil, sf); ct:SetWidth(sf:GetWidth() - 10); sf:SetScrollChild(ct)
        local txt = ct:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        txt:SetPoint("TOPLEFT", 0, 0); txt:SetWidth(ct:GetWidth()); txt:SetJustifyH("LEFT"); txt:SetJustifyV("TOP"); txt:SetSpacing(3)
        txt:SetText(L[BCB.IsClassic and "HELP_BODY_SECURE_CLASSIC" or "HELP_BODY_SECURE"] or "")
        ct:SetHeight(txt:GetStringHeight() + 20)
        BCB.secureHelpFrame = h
    end
    BCB.secureHelpFrame:Show(); BCB.secureHelpFrame:Raise()
end

--------------------------------------------------------------------------------
-- SHIFT-CLICK / LINK INSERTION HELP WINDOW
--------------------------------------------------------------------------------
function BCB.ShowShiftClickHelp()
    if BCB.shiftClickHelpFrame and BCB.shiftClickHelpFrame:IsShown() then BCB.shiftClickHelpFrame:Hide(); return end
    if not BCB.shiftClickHelpFrame then
        local h = CreateFrame("Frame", "BCBShiftClickHelpWindow", UIParent, "ButtonFrameTemplate")
        h:SetSize(460, 500); h:SetPoint("CENTER", 200, 50); h:SetToplevel(true); h:EnableMouse(true); h:SetMovable(true); h:SetClampedToScreen(true)
        h:RegisterForDrag("LeftButton"); h:SetScript("OnDragStart", function() h:StartMoving() end); h:SetScript("OnDragStop", function() h:StopMovingOrSizing() end)
        ButtonFrameTemplate_HidePortrait(h); ButtonFrameTemplate_HideButtonBar(h); if h.Inset then h.Inset:Hide() end; BCB.SeatChrome(h)  -- Forever border offset (Utils.lua)
        h:SetTitle(L["WELCOME_SHIFTCLICK_TITLE"]); tinsert(UISpecialFrames, "BCBShiftClickHelpWindow")
        local sf = BCB.CreateScrollFrame(nil, h)
        sf:SetPoint("TOPLEFT", 16, -60); sf:SetPoint("BOTTOMRIGHT", -24, 16)
        local ct = CreateFrame("Frame", nil, sf); ct:SetWidth(sf:GetWidth() - 10); sf:SetScrollChild(ct)
        local txt = ct:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        txt:SetPoint("TOPLEFT", 0, 0); txt:SetWidth(ct:GetWidth()); txt:SetJustifyH("LEFT"); txt:SetJustifyV("TOP"); txt:SetSpacing(3)
        txt:SetText(L["HELP_BODY_SHIFTCLICK"] or "")
        ct:SetHeight(txt:GetStringHeight() + 20)
        BCB.shiftClickHelpFrame = h
    end
    BCB.shiftClickHelpFrame:Show(); BCB.shiftClickHelpFrame:Raise()
end
