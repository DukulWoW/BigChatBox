-- BigChatBox - WoW Settings Panel (minimal fallback)
local ADDON_NAME = "BigChatBox"
local BCB = BigChatBox

local function CreateMinimalPanel()
    local panel = CreateFrame("Frame", "BigChatBoxMinimalPanel", UIParent)
    panel.name = "BigChatBox"
    local logo = panel:CreateTexture(nil, "ARTWORK")
    logo:SetSize(128, 128); logo:SetPoint("CENTER", panel, "CENTER", 0, 100)
    logo:SetTexture("Interface\\AddOns\\BigChatBox\\assets\\logo-256")
    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge3")
    title:SetPoint("TOP", logo, "BOTTOM", 0, -8); title:SetText("|cff5599ffBigChatBox|r")
    local version = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    version:SetPoint("TOP", title, "BOTTOM", 0, -4); version:SetText("Version: " .. (BCB.version or "5.0.0")); version:SetTextColor(0.7, 0.7, 0.7)
    local hint = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    hint:SetPoint("TOP", version, "BOTTOM", 0, -8); hint:SetText("Access options with |cffffd100/bcb|r")
    local tpl = "SharedButtonLargeTemplate"
    if not C_XMLUtil or not C_XMLUtil.GetTemplateInfo or not C_XMLUtil.GetTemplateInfo(tpl) then tpl = "UIPanelDynamicResizeButtonTemplate" end
    if not C_XMLUtil or not C_XMLUtil.GetTemplateInfo or not C_XMLUtil.GetTemplateInfo(tpl) then tpl = "UIPanelButtonTemplate" end
    local button = CreateFrame("Button", nil, panel, tpl); button:SetSize(200, 40); button:SetPoint("TOP", hint, "BOTTOM", 0, -16)
    button:SetText("Open Options"); pcall(function() DynamicResizeButton_Resize(button) end)
    local bt = button:GetFontString(); if bt then pcall(function() bt:SetFont("Fonts\\FRIZQT__.TTF", 16, "") end) end
    button:SetScript("OnClick", function() if BCB.OpenConfigWindow then BCB.OpenConfigWindow() end end)
    if Settings and Settings.RegisterCanvasLayoutCategory then
        local cat = Settings.RegisterCanvasLayoutCategory(panel, panel.name); Settings.RegisterAddOnCategory(cat); BCB.settingsCategory = cat
    elseif InterfaceOptions_AddCategory then InterfaceOptions_AddCategory(panel) end
    BCB.minimalPanel = panel
end

local f = CreateFrame("Frame"); f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, _, addon) if addon == ADDON_NAME then CreateMinimalPanel(); self:UnregisterEvent("ADDON_LOADED") end end)
