-- BigChatBox Config/PlacementTab.lua — Placement tab (layout, position)

local BCB = BigChatBox
local L = BCB.L or {}
local Config = BCB.Config
local PAD = Config.PAD

function Config.BuildPlacementTab(container)
    -- Preview at top
    local pv = Config.CreatePreview(container, 160)
    pv:SetPoint("TOPLEFT", 10, -4); pv:SetPoint("TOPRIGHT", -10, -4)
    container.previewWidget = pv
    -- acPreview and ccPreview are shown/hidden by ConfigMain's tab-switch logic, not here

    local sf, ct = Config.CreateSmartScrollFrame(container, -172)
    local y = 0

    -- Layout Options header
    local lH = ct:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); lH:SetPoint("TOPLEFT", PAD, y); lH:SetText(L["SECTION_LAYOUT_OPTIONS"]); lH:SetTextColor(1,0.82,0); y = y - 26

    -- Show channel name toggle
    local chShow = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); chShow:SetPoint("TOPLEFT", PAD, y)
    chShow.text = chShow:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); chShow.text:SetPoint("LEFT", chShow, "RIGHT", 2, 0)
    chShow.text:SetText(L["CB_SHOW_CHANNEL"] or "Show channel name")
    local showEnabled = BigChatBoxDB.showChannelName ~= false
    chShow:SetChecked(showEnabled)
    y = y - 36

    -- Channel text position (top/bottom/left/right)
    local chSideOptions = {"Top", "Bottom", "Left", "Right"}
    local chSideMap = {Top="top", Bottom="bottom", Left="left", Right="right"}
    local chSideRev = {top="Top", bottom="Bottom", left="Left", right="Right"}
    local chSide = BigChatBoxDB.channelTextSide or "top"
    local chSideD = Config.CreateWowDropdown(ct, L["LABEL_CHANNEL_NAME_POS"], function() return chSideOptions end, chSideRev[chSide] or "Top",
        function(n)
            BigChatBoxDB.channelTextSide = chSideMap[n] or "top"
            if BCB.RepositionChannelText then BCB.RepositionChannelText() end
            if container.previewWidget then container.previewWidget:Refresh() end
        end)
    chSideD:SetPoint("TOPLEFT", 0, y); chSideD:SetPoint("RIGHT"); y = y - 52

    -- Channel text auto-hide
    local chHide = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); chHide:SetPoint("TOPLEFT", PAD, y)
    chHide.text = chHide:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); chHide.text:SetPoint("LEFT", chHide, "RIGHT", 2, 0)
    chHide.text:SetText(L["CB_AUTO_HIDE_CHANNEL"])
    chHide:SetChecked(BigChatBoxDB.autoHideChannelText or false)
    chHide:SetScript("OnClick", function(self)
        BigChatBoxDB.autoHideChannelText = self:GetChecked()
        if BCB.UpdateAutoHide then BCB.UpdateAutoHide() end
        if container.previewWidget and container.previewWidget.Refresh then container.previewWidget:Refresh() end
    end)
    y = y - 36

    -- Helper: grey out / restore the position dropdown and auto-hide checkbox
    local function SetChannelDependentsEnabled(enabled)
        -- Position dropdown
        local alpha = enabled and 1 or 0.4
        chSideD:SetAlpha(alpha)
        chSideD:EnableMouse(enabled)
        -- Auto-hide checkbox
        chHide:SetEnabled(enabled)
        chHide.text:SetTextColor(enabled and 1 or 0.4, enabled and 0.82 or 0.4, enabled and 0 or 0.4)
        if enabled then chHide.text:SetTextColor(1, 1, 1) end
    end

    -- Apply initial state
    SetChannelDependentsEnabled(showEnabled)

    -- Wire up the Show channel name checkbox
    chShow:SetScript("OnClick", function(self)
        local checked = self:GetChecked()
        BigChatBoxDB.showChannelName = checked
        SetChannelDependentsEnabled(checked)
        if BCB.UpdateChannelVisibility then BCB.UpdateChannelVisibility() end
        if BCB.UpdateChannelDisplay then BCB.UpdateChannelDisplay() end
        if container.previewWidget and container.previewWidget.Refresh then container.previewWidget:Refresh() end
    end)

    -- Autocomplete position
    local acPos = BigChatBoxDB.autocompletePosition or "bottom"
    local acPosD = Config.CreateWowDropdown(ct, L["LABEL_AUTOCOMPLETE_POS"], function() return {"Top", "Bottom"} end, acPos == "top" and "Top" or "Bottom",
        function(n)
            BigChatBoxDB.autocompletePosition = n == "Top" and "top" or "bottom"
            if container.previewWidget then container.previewWidget:RefreshAutocompletePreview() end
        end)
    acPosD:SetPoint("TOPLEFT", 0, y); acPosD:SetPoint("RIGHT"); y = y - 52

    -- Character counter position
    local ccOptions = {"Off", "Inside (Right)", "Outside: Top-Left", "Outside: Top-Right", "Outside: Middle-Left", "Outside: Middle-Right", "Outside: Bottom-Left", "Outside: Bottom-Right"}
    local ccMap = {["Off"]="off", ["Inside (Right)"]="inside_right", ["Outside: Top-Left"]="outside_topleft", ["Outside: Top-Right"]="outside_topright", ["Outside: Middle-Left"]="outside_middleleft", ["Outside: Middle-Right"]="outside_middleright", ["Outside: Bottom-Left"]="outside_bottomleft", ["Outside: Bottom-Right"]="outside_bottomright"}
    local ccRev = {off="Off", inside_right="Inside (Right)", outside_topleft="Outside: Top-Left", outside_topright="Outside: Top-Right", outside_middleleft="Outside: Middle-Left", outside_middleright="Outside: Middle-Right", outside_bottomleft="Outside: Bottom-Left", outside_bottomright="Outside: Bottom-Right"}
    local curCC = BigChatBoxDB.charCounterPos or "inside_right"
    local ccD = Config.CreateWowDropdown(ct, L["LABEL_CHAR_COUNTER_POS"], function() return ccOptions end, ccRev[curCC] or "Inside (Right)",
        function(n)
            BigChatBoxDB.charCounterPos = ccMap[n] or "inside_right"
            if BCB.RepositionCharCounter then BCB.RepositionCharCounter() end
            if container.previewWidget then container.previewWidget:RefreshCharCounterPreview() end
        end)
    ccD:SetPoint("TOPLEFT", 0, y); ccD:SetPoint("RIGHT"); y = y - 52

    -- Position header (after layout options)
    local pH = ct:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); pH:SetPoint("TOPLEFT", PAD, y); pH:SetText(L["SECTION_POSITION"]); pH:SetTextColor(1,0.82,0); y = y - 28
    local veB = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); veB:SetSize(200, 28); veB:SetPoint("TOPLEFT", PAD + 10, y); veB:SetText(L["BTN_OPEN_ANCHOR_EDITOR"])
    veB:SetScript("OnClick", function() if BCB.ToggleVisualEditor then BCB.ToggleVisualEditor() end; if BCB.Config.configFrame then BCB.Config.configFrame:Hide() end end)
    y = y - 48

    ct:SetHeight(math.abs(y) + 20); sf:UpdateScrollbar()
end
