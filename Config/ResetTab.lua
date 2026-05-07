-- BigChatBox Config/ResetTab.lua — Reset tab (all destructive / reload actions)

local BCB = BigChatBox
local L = BCB.L or {}
local Config = BCB.Config
local PAD = Config.PAD

function Config.BuildResetTab(container)
    local ct = CreateFrame("Frame", nil, container); ct:SetAllPoints()
    local y = -8

    -- Warning header
    local wH = ct:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); wH:SetPoint("TOPLEFT", PAD, y)
    wH:SetText(L["RESET_TAB_HEADER"] or "Reset & Restore"); wH:SetTextColor(1, 0.3, 0.3); y = y - 20
    local wD = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); wD:SetPoint("TOPLEFT", PAD, y)
    wD:SetWidth(Config.WINDOW_WIDTH - PAD * 2 - 20); wD:SetJustifyH("LEFT")
    wD:SetText(L["RESET_TAB_DESC"] or "These actions cannot be undone. Most will reload the UI."); wD:SetTextColor(0.7, 0.5, 0.5); y = y - 30

    -- Reset All
    local raB = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); raB:SetSize(200, 28); raB:SetPoint("TOPLEFT", PAD, y)
    raB:SetText(L["RESET_ALL"]); raB:SetScript("OnClick", function() StaticPopup_Show("BCB_RESET_ALL") end)
    raB:GetFontString():SetTextColor(1, 0.4, 0.4)
    local raHelp = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); raHelp:SetPoint("LEFT", raB, "RIGHT", 12, 0)
    raHelp:SetText(L["RESET_ALL_HELP"] or "Resets everything: position, size, appearance, fonts, and behavior."); raHelp:SetTextColor(0.55, 0.55, 0.55)
    y = y - 36

    -- Reset Appearance
    local rapB = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); rapB:SetSize(200, 28); rapB:SetPoint("TOPLEFT", PAD, y)
    rapB:SetText(L["RESET_APPEARANCE"]); rapB:SetScript("OnClick", function() StaticPopup_Show("BCB_RESET_APPEARANCE") end)
    local rapHelp = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); rapHelp:SetPoint("LEFT", rapB, "RIGHT", 12, 0)
    rapHelp:SetText(L["RESET_APPEARANCE_HELP"] or "Resets textures, fonts, colors. Does not affect position or history."); rapHelp:SetTextColor(0.55, 0.55, 0.55)
    y = y - 36

    -- Reset Placement
    local rpB = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); rpB:SetSize(200, 28); rpB:SetPoint("TOPLEFT", PAD, y)
    rpB:SetText(L["RESET_PLACEMENT"]); rpB:SetScript("OnClick", function() StaticPopup_Show("BCB_RESET_PLACEMENT") end)
    local rpHelp = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); rpHelp:SetPoint("LEFT", rpB, "RIGHT", 12, 0)
    rpHelp:SetText(L["RESET_PLACEMENT_HELP"] or "Resets position and size to defaults. Reloads UI."); rpHelp:SetTextColor(0.55, 0.55, 0.55)
    y = y - 36

    -- Reset History
    local rhB = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); rhB:SetSize(200, 28); rhB:SetPoint("TOPLEFT", PAD, y)
    rhB:SetText(L["RESET_HISTORY_BTN"]); rhB:SetScript("OnClick", function() StaticPopup_Show("BCB_RESET_HISTORY") end)
    local rhHelp = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); rhHelp:SetPoint("LEFT", rhB, "RIGHT", 12, 0)
    rhHelp:SetText(L["RESET_HISTORY_HELP"] or "Clears all chat history and whisper history. Reloads UI."); rhHelp:SetTextColor(0.55, 0.55, 0.55)
    y = y - 36

    -- Reset Snippets
    local rsB = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); rsB:SetSize(200, 28); rsB:SetPoint("TOPLEFT", PAD, y)
    rsB:SetText(L["RESET_SNIPPETS_BTN"]); rsB:SetScript("OnClick", function() StaticPopup_Show("BCB_RESET_SNIPPETS") end)
    local rsHelp = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); rsHelp:SetPoint("LEFT", rsB, "RIGHT", 12, 0)
    rsHelp:SetText(L["RESET_SNIPPETS_HELP"] or "Removes all snippets. Reloads UI."); rsHelp:SetTextColor(0.55, 0.55, 0.55)
    y = y - 36

    -- Reset Styles
    local rstB = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); rstB:SetSize(200, 28); rstB:SetPoint("TOPLEFT", PAD, y)
    rstB:SetText(L["RESET_STYLES_BTN"]); rstB:SetScript("OnClick", function() StaticPopup_Show("BCB_RESET_STYLES") end)
    local rstHelp = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); rstHelp:SetPoint("LEFT", rstB, "RIGHT", 12, 0)
    rstHelp:SetText(L["RESET_STYLES_HELP"] or "Removes all custom styles. Default style becomes active. Reloads UI."); rstHelp:SetTextColor(0.55, 0.55, 0.55)
    y = y - 52

    -- Restart Setup (separate, more prominent)
    local rwB = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); rwB:SetSize(200, 28); rwB:SetPoint("TOPLEFT", PAD, y)
    rwB:SetText(L["RESTART_SETUP"]); rwB:SetScript("OnClick", function() StaticPopup_Show("BCB_RESTART_SETUP") end)
    rwB:GetFontString():SetTextColor(1, 0.4, 0.4)
    local rwHelp = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); rwHelp:SetPoint("LEFT", rwB, "RIGHT", 12, 0)
    rwHelp:SetText(L["RESTART_SETUP_HELP"] or "Resets ALL settings and re-runs the first-time setup wizard."); rwHelp:SetTextColor(0.55, 0.55, 0.55)
end
