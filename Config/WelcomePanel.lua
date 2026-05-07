-- BigChatBox Config/WelcomePanel.lua — First-run setup wizard (v5.5.0)
-- Shows on first login when setupComplete is nil/false.
-- 5 pages: Welcome → Style → Layout → Features → Final
-- Standalone frame — does NOT touch any secure Blizzard frames (taint-safe).

local BCB = BigChatBox
local L = BCB.L or {}
local Config = BCB.Config

--------------------------------------------------------------------------------
-- BUILT-IN STYLE PRESETS
-- Parsed from BCB import format. "Default" uses factory defaults (no overrides).
--------------------------------------------------------------------------------
local WELCOME_STYLES = {}

local function ParseStyleString(str)
    local s = {}
    if not str or str:sub(1,4) ~= "BCB:" then return s end
    for pair in str:sub(5):gmatch("[^;]+") do
        local k, v = pair:match("^(.-)=(.+)$")
        if k and v then
            if v:find(",") then
                local r, g, b = v:match("([^,]+),([^,]+),([^,]+)")
                s[k] = { r = tonumber(r) or 1, g = tonumber(g) or 1, b = tonumber(b) or 1 }
            elseif tonumber(v) then s[k] = tonumber(v)
            elseif v == "true" then s[k] = true
            elseif v == "false" then s[k] = false
            else s[k] = v end
        else
            -- Handle empty value (e.g. borderTexture=)
            local emptyKey = pair:match("^(.-)=$")
            if emptyKey and emptyKey ~= "" then
                s[emptyKey] = ""
            end
        end
    end
    return s
end
BCB.ParseStyleString = ParseStyleString

local RAW_STYLES = {
    { name = "Default", str = nil },
    { name = "Clean (Needs Platynator)", str = "!BCB1:AQEjKAID6APoA+gDAEVJbnRlcmZhY2UvQWRkT25zL1BsYXR5bmF0b3IvQXNzZXRzL0RQSTk2L0JhckJhY2tncm91bmRzL2ZhZGUtbGVmdC5wbmcEABBQbGF0eTogRmFkZSBMZWZ0BQBkBgEHADwIJxAJJxAnECcQCgAkSW50ZXJmYWNlXFRvb2x0aXBzXFVJLVRvb2x0aXAtQm9yZGVyCwAHRGVmYXVsdAwAEA0AEkZvbnRzXEZSSVpRVF9fLlRURg4AB0RlZmF1bHQPABJGb250c1xGUklaUVRfXy5UVEYQAAdEZWZhdWx0EQAOEgAQEycQFAALRHJvcCBTaGFkb3cVABYABExFRlQXABgBAZAZADIaABsA" },
    { name = "The Tracker", str = "!BCB1:AQEjKAInECcQJxADAEpJbnRlcmZhY2VcQWRkb25zXEJsaXp6bGlrZVRleHR1cmVzXHN0YXR1c2JhclxCbGl6elF1ZXN0VHJhY2tlckhlYWRsaW5lLmJscAQAGUJsaXp6UXVlc3RUcmFja2VySGVhZGxpbmUFAG4GAAcAMggnEAknECcQJxAKAAALAAROb25lDAAQDQASRm9udHNcRlJJWlFUX18uVFRGDgAQRnJpeiBRdWFkcmF0YSBUVA8AEkZvbnRzXEZSSVpRVF9fLlRURhAAEEZyaXogUXVhZHJhdGEgVFQRAAwSABITJxAUAAtEcm9wIFNoYWRvdxUAFgAETEVGVBcBGAEBkBkAHhoAGwE=" },
    { name = "ElvUI", str = "!BCB1:AQEbWAIAAAAAAAADABpJbnRlcmZhY2VcQlVUVE9OU1xXSElURThYOAQAB0RlZmF1bHQFAG4GAAcAMggnEAknECcQJxAKAAALAAROb25lDAAQDQAQRm9udHNcQVJJQUxOLlRURg4ADEFyaWFsIE5hcnJvdw8AEEZvbnRzXEFSSUFMTi5UVEYQAAxBcmlhbCBOYXJyb3cRAA4SABQTJxAUAAROb25lFQAWAARMRUZUFwEYAQGQGQAeGgAbAQ==" },
    { name = "LS (Needs LS: Borders)", str = "!BCB1:AQEbWAIAAAAAAAADABpJbnRlcmZhY2VcQlVUVE9OU1xXSElURThYOAQAB0RlZmF1bHQFAFAGAAcAMggnEAknECcQJxAKADhJbnRlcmZhY2VcQWRkT25zXGxzX0JvcmRlcnNcYXNzZXRzXGJvcmRlci10aGljay00LXMxNi1vNAsAFkxTIFRoaWNrICM0IChTOjE2IE86NCkMABMNABJGb250c1xGUklaUVRfXy5UVEYOABBGcml6IFF1YWRyYXRhIFRUDwASRm9udHNcTklNX19fX18udHRmEAAJTmltcm9kIE1UEQAOEgASEycQFAALRHJvcCBTaGFkb3cVABYABkNFTlRFUhcBGAEBkBkAMhoAGwE=" },
    { name = "Platy (Needs Platynator)", str = "!BCB1:AQEjKAIAAAAAAAADAE9JbnRlcmZhY2UvQWRkT25zL1BsYXR5bmF0b3IvQXNzZXRzL1NwZWNpYWwvQmFyQmFja2dyb3VuZHMvYmxpenphcmQtY2FzdC1iYXIucG5nBAAYUGxhdHk6IEJsaXp6YXJkIENhc3QgQmFyBQBkBgEHADIIJxAJJxAnECcQCgAkSW50ZXJmYWNlXFRvb2x0aXBzXFVJLVRvb2x0aXAtQm9yZGVyCwAHRGVmYXVsdAwAEA0AEkZvbnRzXEZSSVpRVF9fLlRURg4AB0RlZmF1bHQPABJGb250c1xGUklaUVRfXy5UVEYQAAdEZWZhdWx0EQAMEgAQEycQFAASU3Ryb25nIERyb3AgU2hhZG93FQAWAARMRUZUFwEYAQGQGQAyGgAbAQ==" },
}
BCB.BUILTIN_STYLES = RAW_STYLES

for _, entry in ipairs(RAW_STYLES) do
    local data = nil
    if entry.str then
        if entry.str:sub(1, 6) == "!BCB1:" then
            -- New compact binary format — BCB.DecodeStyleString is available (Encoding.lua loads first)
            data = BCB.DecodeStyleString(entry.str)
        else
            data = ParseStyleString(entry.str)
        end
    end
    WELCOME_STYLES[#WELCOME_STYLES + 1] = { name = entry.name, data = data }
end

--------------------------------------------------------------------------------
-- STYLE APPLICATION
-- Applies a style's DB keys. nil data = factory defaults.
--------------------------------------------------------------------------------
local STYLE_KEYS = {
    "bgAlpha", "bgColor", "bgTexture", "bgTextureName", "bgScale", "bgChannelTint", "bgTintIntensity",
    "borderAlpha", "borderColor", "borderTexture", "borderTextureName",
    "borderThickness", "font", "fontName", "channelFont", "channelFontName",
    "fontSize", "channelFontSize", "scale", "fontOutline", "boxDropShadow",
    "textAlign", "colorTypedText", "width", "height", "dynamicHeight", "dynamicWidth",
}
BCB.STYLE_KEYS = STYLE_KEYS

local function ApplyStyleData(data, styleName)
    local d = BCB.defaults or {}
    -- Always start from defaults
    BigChatBoxDB.bgAlpha = d.bgAlpha or 0.95
    BigChatBoxDB.borderAlpha = d.borderAlpha or 1.0
    BigChatBoxDB.bgColor = { r = d.bgColor.r, g = d.bgColor.g, b = d.bgColor.b }
    BigChatBoxDB.borderColor = { r = 1, g = 1, b = 1 }
    BigChatBoxDB.bgTexture = d.bgTexture
    BigChatBoxDB.borderTexture = d.borderTexture
    BigChatBoxDB.bgTextureName = d.bgTextureName or "Solid"
    BigChatBoxDB.borderTextureName = "Default"
    BigChatBoxDB.font = d.font
    BigChatBoxDB.channelFont = d.channelFont
    BigChatBoxDB.fontName = "Default"
    BigChatBoxDB.channelFontName = "Default"
    BigChatBoxDB.fontSize = d.fontSize or 14
    BigChatBoxDB.channelFontSize = d.channelFontSize or 16
    BigChatBoxDB.scale = 1
    BigChatBoxDB.bgScale = 100; BigChatBoxDB.bgChannelTint = false; BigChatBoxDB.bgTintIntensity = 50
    BigChatBoxDB.fontOutline = "None"
    BigChatBoxDB.boxDropShadow = false
    BigChatBoxDB.textAlign = "LEFT"
    BigChatBoxDB.colorTypedText = false
    BigChatBoxDB.borderThickness = 16
    BigChatBoxDB.width = d.size and d.size.width or 400
    BigChatBoxDB.height = d.size and d.size.height or 50
    BigChatBoxDB.dynamicHeight = false
    BigChatBoxDB.dynamicWidth = false

    -- Then overlay the style's non-nil values
    if data then
        for _, k in ipairs(STYLE_KEYS) do
            if data[k] ~= nil then
                if type(data[k]) == "table" then
                    BigChatBoxDB[k] = { r = data[k].r, g = data[k].g, b = data[k].b }
                else
                    BigChatBoxDB[k] = data[k]
                end
            end
        end
    end

    BigChatBoxDB.activeStyle = styleName or "Default"

    -- Coerce numeric 0/1 to proper booleans for boolean DB keys
    -- (BCB export format uses 0/1 for booleans, but Lua treats 0 as truthy)
    local boolKeys = { "boxDropShadow", "colorTypedText", "bgChannelTint", "dynamicHeight", "dynamicWidth" }
    for _, k in ipairs(boolKeys) do
        local v = BigChatBoxDB[k]
        if v == 0 then BigChatBoxDB[k] = false
        elseif v == 1 then BigChatBoxDB[k] = true end
    end

    -- Ensure texture name/path consistency after overlay
    if BigChatBoxDB.borderTextureName == "None" then BigChatBoxDB.borderTexture = "" end
    if BigChatBoxDB.bgTextureName == "None" then BigChatBoxDB.bgTexture = "" end
    -- Also handle textures that reference missing addons — if texture is empty, use Default
    if BigChatBoxDB.bgTextureName ~= "None" and BigChatBoxDB.bgTextureName ~= "Default" then
        -- Non-standard bg texture: the texture path came from the style, keep it as-is
    end

    if BCB.frame then
        BCB.frame:SetSize(BigChatBoxDB.width or 400, BigChatBoxDB.height or 50)
        if BigChatBoxDB.scale then BCB.frame:SetScale(BigChatBoxDB.scale) end
    end
    if BCB.UpdateBackdrop then BCB.UpdateBackdrop() end
    if BCB.UpdateFontSize then BCB.UpdateFontSize() end
    if BCB.UpdateChannelFontSize then BCB.UpdateChannelFontSize() end
    -- Refresh config panel widgets if open so Designer tab reflects the new values
    if BCB.RefreshConfigAfterStyleApply then BCB.RefreshConfigAfterStyleApply(styleName or "Default") end
end
BCB.ApplyStyleData = ApplyStyleData
--------------------------------------------------------------------------------
local welcomeFrame, pages, currentPage

local PANEL_WIDTH = 420
local PANEL_HEIGHT = 560
local NUM_PAGES = 5
local MAX_BOX_W = PANEL_WIDTH - 80

local function UpdateNavigation()
    if not welcomeFrame then return end
    local titles = {
        L["WELCOME_TITLE"] or "Welcome to BigChatBox!",
        L["WELCOME_STYLE_TITLE"] or "Select your style!",
        L["WELCOME_LAYOUT_TITLE"] or "Choose your layout",
        L["WELCOME_FEATURES_TITLE"] or "Select your features!",
        L["WELCOME_FINAL_TITLE"] or "Almost done!",
    }
    welcomeFrame.pageTitle:SetText(titles[currentPage] or "")
    welcomeFrame.pageCounter:SetText(currentPage .. " / " .. NUM_PAGES)

    for i, page in ipairs(pages) do
        if i == currentPage then page:Show() else page:Hide() end
    end

    welcomeFrame.prevBtn:SetShown(currentPage > 1)
    welcomeFrame.nextBtn:SetShown(currentPage > 1 and currentPage < NUM_PAGES)

    if (currentPage == 2 or currentPage == 3) and welcomeFrame.preview then
        welcomeFrame.preview:Refresh()
    end
    if currentPage == 3 and welcomeFrame.layoutPreview then
        welcomeFrame.layoutPreview:Refresh()
        if welcomeFrame.layoutPreview.ShowAutocompletePreview then welcomeFrame.layoutPreview:ShowAutocompletePreview() end
        if welcomeFrame.layoutPreview.ShowCharCounterPreview then welcomeFrame.layoutPreview:ShowCharCounterPreview() end
    else
        -- Hide placement-only overlays when not on page 3
        if welcomeFrame.layoutPreview then
            if welcomeFrame.layoutPreview.HideAutocompletePreview then welcomeFrame.layoutPreview:HideAutocompletePreview() end
            if welcomeFrame.layoutPreview.HideCharCounterPreview then welcomeFrame.layoutPreview:HideCharCounterPreview() end
        end
    end
end

local function GoToPage(n)
    currentPage = math.max(1, math.min(n, NUM_PAGES))
    UpdateNavigation()
end

--------------------------------------------------------------------------------
-- SHARED: Constrained preview for the welcome panel
--------------------------------------------------------------------------------
local function CreateWelcomePreview(parent, height)
    local pv = Config.CreatePreview(parent, height or 120)
    if pv.box then
        if pv.box:GetWidth() > MAX_BOX_W then pv.box:SetWidth(MAX_BOX_W) end
        if pv.box:GetHeight() > 60 then pv.box:SetHeight(60) end
    end
    pv:EnableMouse(false)
    pv:SetScript("OnClick", nil)
    for _, region in ipairs({pv:GetRegions()}) do
        if region:IsObjectType("FontString") and region:GetText() and region:GetText():find("Left click") then
            region:Hide()
        end
    end
    local origRefresh = pv.Refresh
    pv.Refresh = function(self)
        if origRefresh then origRefresh(self) end
        if pv.box then
            if pv.box:GetWidth() > MAX_BOX_W then pv.box:SetWidth(MAX_BOX_W) end
            if pv.box:GetHeight() > 60 then pv.box:SetHeight(60) end
        end
    end
    return pv
end

--------------------------------------------------------------------------------
-- PAGE BUILDERS
--------------------------------------------------------------------------------

local function BuildPage1(parent)
    local f = CreateFrame("Frame", nil, parent); f:SetAllPoints(); f:Hide()
    local y = -10
    local logo = f:CreateTexture(nil, "ARTWORK"); logo:SetSize(80, 80); logo:SetPoint("TOP", 0, y)
    logo:SetTexture("Interface\\AddOns\\BigChatBox\\assets\\logo-256"); y = y - 90
    local tit = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge"); tit:SetPoint("TOP", 0, y)
    tit:SetText("|cff5599ffBigChatBox|r"); y = y - 18
    local by = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall"); by:SetPoint("TOP", 0, y)
    by:SetText(L["AUTHOR"]); by:SetTextColor(1,1,1); y = y - 14
    local ver = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall"); ver:SetPoint("TOP", 0, y)
    ver:SetText("v" .. BCB.ADDON_VERSION); ver:SetTextColor(0.6, 0.6, 0.6); y = y - 26

    local txt = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight"); txt:SetPoint("TOP", 0, y)
    txt:SetWidth(PANEL_WIDTH - 60); txt:SetJustifyH("CENTER"); txt:SetSpacing(3)
    txt:SetText(L["WELCOME_TEXT"] or "Welcome to BigChatBox!")
    txt:SetTextColor(0.9, 0.9, 0.9); y = y - (txt:GetStringHeight() + 22)

    -- Language selector (selecting a new language immediately confirms + reloads)
    local lgLbl = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight"); lgLbl:SetPoint("TOP", 0, y)
    lgLbl:SetText(L["WELCOME_LANG_LBL"] or "Display language:"); y = y - 22

    local ASSET = "Interface\\AddOns\\BigChatBox\\assets\\"
    local LANG_LIST = {
        { code = "client", label = L["LANGUAGE_CLIENT"] or "Client Language", flag = nil,                available = true  },
        { code = "enUS",   label = "English",                                 flag = ASSET.."flag-en",   available = true  },
        { code = "deDE",   label = "Deutsch",                                 flag = ASSET.."flag-de",   available = true  },
        { code = "frFR",   label = "Français",                                flag = ASSET.."flag-fr",   available = true  },
        { code = "esES",   label = "Español",                                 flag = ASSET.."flag-es",   available = true  },
        { code = "ptBR",   label = "Português",                               flag = ASSET.."flag-br",   available = true  },
        { code = "itIT",   label = "Italiano",                                flag = ASSET.."flag-it",   available = true  },
        { code = "jaJP",   label = "日本語",                                   flag = ASSET.."flag-ja",   available = true  },
        { code = "koKR",   label = "한국어",                                   flag = ASSET.."flag-ko",   available = true  },
        { code = "zhCN",   label = "简体中文",                                 flag = ASSET.."flag-cn",   available = true  },
        { code = "zhTW",   label = "繁體中文",                                 flag = ASSET.."flag-tw",   available = true  },
    }
    local COMING_SOON = L["LANGUAGE_COMING_SOON"] or "|cff888888(Coming soon)|r"
    local function MakeLangLabel(entry)
        if entry.flag then return "|T"..entry.flag..":14:20:0:0:32:32|t "..entry.label end
        return entry.label
    end
    local curCode = (BigChatBoxLocale and BigChatBoxLocale ~= "") and BigChatBoxLocale or "client"

    local useNative = C_XMLUtil and C_XMLUtil.GetTemplateInfo and C_XMLUtil.GetTemplateInfo("WowStyle1DropdownTemplate")
    if useNative then
        local lgDD = CreateFrame("DropdownButton", nil, f, "WowStyle1DropdownTemplate")
        lgDD:SetPoint("TOPLEFT", 20, y); lgDD:SetPoint("RIGHT", -20, 0)
        lgDD:SetupMenu(function(_, rootDescription)
            for _, entry in ipairs(LANG_LIST) do
                local lbl = MakeLangLabel(entry)
                if entry.available then
                    rootDescription:CreateRadio(lbl,
                        function() return curCode == entry.code end,
                        function()
                            if entry.code == curCode then return end
                            BCB._pendingLangCode = entry.code
                            StaticPopup_Show("BCB_WIZARD_CHANGE_LANGUAGE", entry.label)
                        end)
                else
                    local greyLbl = "|cff888888"..(entry.flag and ("|T"..entry.flag..":14:20:0:0:32:32|t ") or "")..entry.label.."|r  "..COMING_SOON
                    local dummy = rootDescription:CreateRadio(greyLbl, function() return false end, function() end)
                    dummy:AddInitializer(function(btn)
                        if btn.fontString then btn.fontString:SetTextColor(0.5,0.5,0.5) end
                        btn:SetEnabled(false)
                        if btn.highlight then btn.highlight:SetAlpha(0) end
                    end)
                end
            end
        end)
        y = y - 44
    else
        -- Fallback: just show available languages as buttons
        for _, entry in ipairs(LANG_LIST) do
            if entry.available then
                local lb = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
                lb:SetSize(PANEL_WIDTH - 60, 24); lb:SetPoint("TOP", 0, y)
                lb:SetText(MakeLangLabel(entry))
                lb:SetScript("OnClick", function()
                    if entry.code == curCode then return end
                    BCB._pendingLangCode = entry.code
                    StaticPopup_Show("BCB_WIZARD_CHANGE_LANGUAGE", entry.label)
                end)
                y = y - 28
            end
        end
        y = y - 6
    end

    local btn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate"); btn:SetSize(200, 30)
    btn:SetPoint("BOTTOM", 0, 20); btn:SetText(L["WELCOME_SETUP_BTN"] or "Setup BigChatBox")
    btn:SetScript("OnClick", function() GoToPage(2) end)
    return f
end

local function BuildPage2(parent, wFrame)
    local f = CreateFrame("Frame", nil, parent); f:SetAllPoints(); f:Hide()
    local y = -6
    local pv = CreateWelcomePreview(f, 120)
    pv:SetPoint("TOPLEFT", 10, y); pv:SetPoint("TOPRIGHT", -10, y)
    wFrame.preview = pv
    y = y - (pv:GetHeight() + 10)

    local lbl = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); lbl:SetPoint("TOPLEFT", 20, y)
    lbl:SetText(L["WELCOME_CHOOSE_STYLE"]); y = y - 22

    local selectedStyle = 1
    local useNative = C_XMLUtil and C_XMLUtil.GetTemplateInfo and C_XMLUtil.GetTemplateInfo("WowStyle1DropdownTemplate")
    if useNative then
        local dd = CreateFrame("DropdownButton", nil, f, "WowStyle1DropdownTemplate")
        dd:SetPoint("TOPLEFT", 20, y); dd:SetPoint("RIGHT", -20, 0)
        dd:SetupMenu(function(_, rootDescription)
            for i, style in ipairs(WELCOME_STYLES) do
                rootDescription:CreateRadio(style.name, function() return selectedStyle == i end, function()
                    selectedStyle = i
                    ApplyStyleData(style.data, style.name)
                    dd:GenerateMenu()
                    if pv.Refresh then pv:Refresh() end
                end)
            end
        end)
    else
        for i, style in ipairs(WELCOME_STYLES) do
            local btn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
            btn:SetSize(PANEL_WIDTH - 60, 22); btn:SetPoint("TOPLEFT", 20, y)
            btn:SetText(style.name)
            btn:SetScript("OnClick", function()
                selectedStyle = i; ApplyStyleData(style.data, style.name)
                if pv.Refresh then pv:Refresh() end
            end)
            y = y - 26
        end
    end

    local note = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    note:SetPoint("BOTTOM", 0, 40); note:SetWidth(PANEL_WIDTH - 60); note:SetJustifyH("CENTER")
    note:SetText(L["WELCOME_STYLE_NOTE"])
    note:SetTextColor(0.6, 0.6, 0.6)

    -- Import style button
    local impBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate"); impBtn:SetSize(160, 24)
    impBtn:SetPoint("BOTTOM", note, "TOP", 0, 8); impBtn:SetText(L["IMPORT_STYLE_BTN"])
    if Config and Config.FitButton then Config.FitButton(impBtn, 160) end
    impBtn:SetScript("OnClick", function() StaticPopup_Show("BCB_IMPORT_STYLE") end)

    return f
end

local function BuildPage3(parent, wFrame)
    local f = CreateFrame("Frame", nil, parent); f:SetAllPoints(); f:Hide()
    local y = -6
    local pv = CreateWelcomePreview(f, 120)
    pv:SetPoint("TOPLEFT", 10, y); pv:SetPoint("TOPRIGHT", -10, y)
    wFrame.layoutPreview = pv
    y = y - (pv:GetHeight() + 10)

    local desc = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    desc:SetPoint("TOPLEFT", 20, y); desc:SetWidth(PANEL_WIDTH - 60); desc:SetJustifyH("LEFT")
    desc:SetText(L["WELCOME_LAYOUT_DESC"])
    desc:SetTextColor(0.8, 0.8, 0.8); y = y - 32

    local cpLbl = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); cpLbl:SetPoint("TOPLEFT", 20, y)
    cpLbl:SetText(L["WELCOME_CHANNEL_POS_LBL"]); y = y - 22

    local channelPositions = {"Top", "Bottom", "Left", "Right"}
    local channelPosKeys = {Top = "top", Bottom = "bottom", Left = "left", Right = "right"}
    local useNative = C_XMLUtil and C_XMLUtil.GetTemplateInfo and C_XMLUtil.GetTemplateInfo("WowStyle1DropdownTemplate")
    if useNative then
        local cpDD = CreateFrame("DropdownButton", nil, f, "WowStyle1DropdownTemplate")
        cpDD:SetPoint("TOPLEFT", 20, y); cpDD:SetPoint("RIGHT", -20, 0)
        cpDD:SetupMenu(function(_, rootDescription)
            for _, name in ipairs(channelPositions) do
                rootDescription:CreateRadio(name, function() return (BigChatBoxDB.channelTextSide or "top") == channelPosKeys[name] end, function()
                    BigChatBoxDB.channelTextSide = channelPosKeys[name]
                    cpDD:GenerateMenu()
                    if pv.Refresh then pv:Refresh() end
                    if BCB.UpdateChannelDisplay then BCB.UpdateChannelDisplay() end
                end)
            end
        end)
    end
    y = y - 44

    local acLbl = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); acLbl:SetPoint("TOPLEFT", 20, y)
    acLbl:SetText(L["WELCOME_AC_POS_LBL"]); y = y - 22
    local acPositions = {"Top", "Bottom"}
    local acPosKeys = {Top = "top", Bottom = "bottom"}
    if useNative then
        local acDD = CreateFrame("DropdownButton", nil, f, "WowStyle1DropdownTemplate")
        acDD:SetPoint("TOPLEFT", 20, y); acDD:SetPoint("RIGHT", -20, 0)
        acDD:SetupMenu(function(_, rootDescription)
            for _, name in ipairs(acPositions) do
                rootDescription:CreateRadio(name, function() return (BigChatBoxDB.autocompletePosition or "bottom") == acPosKeys[name] end, function()
                    BigChatBoxDB.autocompletePosition = acPosKeys[name]
                    acDD:GenerateMenu()
                    if pv.RefreshAutocompletePreview then pv:RefreshAutocompletePreview() end
                end)
            end
        end)
    end
    y = y - 44

    local ahC = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate"); ahC:SetPoint("TOPLEFT", 20, y)
    ahC.text = ahC:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); ahC.text:SetPoint("LEFT", ahC, "RIGHT", 4, 0)
    ahC.text:SetText(L["CB_AUTO_HIDE_CHANNEL"])
    ahC:SetChecked(BigChatBoxDB.autoHideChannelText or false)
    ahC:SetScript("OnClick", function(self)
        BigChatBoxDB.autoHideChannelText = self:GetChecked()
        if pv.Refresh then pv:Refresh() end
    end)
    local ahHelp = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    ahHelp:SetPoint("TOPLEFT", 52, y - 22); ahHelp:SetWidth(PANEL_WIDTH - 80); ahHelp:SetJustifyH("LEFT")
    ahHelp:SetText(L["WELCOME_AUTOHIDE_HELP"])
    ahHelp:SetTextColor(0.5, 0.5, 0.5)
    y = y - 44

    -- Character counter position
    local ccLbl = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); ccLbl:SetPoint("TOPLEFT", 20, y)
    ccLbl:SetText(L["WELCOME_CHARCOUNTER_LBL"]); y = y - 22
    local ccOptions = {"Off", "Inside (Right)", "Outside: Top-Left", "Outside: Top-Right", "Outside: Middle-Left", "Outside: Middle-Right", "Outside: Bottom-Left", "Outside: Bottom-Right"}
    local ccMap = {["Off"]="off", ["Inside (Right)"]="inside_right", ["Outside: Top-Left"]="outside_topleft", ["Outside: Top-Right"]="outside_topright", ["Outside: Middle-Left"]="outside_middleleft", ["Outside: Middle-Right"]="outside_middleright", ["Outside: Bottom-Left"]="outside_bottomleft", ["Outside: Bottom-Right"]="outside_bottomright"}
    local ccRev = {off="Off", inside_right="Inside (Right)", outside_topleft="Outside: Top-Left", outside_topright="Outside: Top-Right", outside_middleleft="Outside: Middle-Left", outside_middleright="Outside: Middle-Right", outside_bottomleft="Outside: Bottom-Left", outside_bottomright="Outside: Bottom-Right"}
    if useNative then
        local ccDD = CreateFrame("DropdownButton", nil, f, "WowStyle1DropdownTemplate")
        ccDD:SetPoint("TOPLEFT", 20, y); ccDD:SetPoint("RIGHT", -20, 0)
        ccDD:SetupMenu(function(_, rootDescription)
            for _, name in ipairs(ccOptions) do
                rootDescription:CreateRadio(name, function() return ccRev[BigChatBoxDB.charCounterPos or "inside_right"] == name end, function()
                    BigChatBoxDB.charCounterPos = ccMap[name] or "inside_right"
                    if BCB.RepositionCharCounter then BCB.RepositionCharCounter() end
                    ccDD:GenerateMenu()
                    if pv.RefreshCharCounterPreview then pv:RefreshCharCounterPreview() end
                end)
            end
        end)
    end

    return f
end

local function BuildPage4(parent)
    local f = CreateFrame("Frame", nil, parent); f:SetAllPoints(); f:Hide()
    local y = -10
    local desc = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    desc:SetPoint("TOPLEFT", 20, y); desc:SetWidth(PANEL_WIDTH - 60); desc:SetJustifyH("LEFT")
    desc:SetText(L["WELCOME_FEATURES_DESC"])
    desc:SetTextColor(0.8, 0.8, 0.8); y = y - 42

    local features = {
        { key = "historyEnabled",         label = L["WELCOME_FEAT_HISTORY"],               desc = L["FEATURE_HISTORY_DESC"] },
        { key = "snippetEnabled",         label = L["WELCOME_FEAT_SNIPPETS"],             desc = L["FEATURE_SNIPPETS_DESC"] },
        { key = "acSnippetEnabled",       label = L["WELCOME_FEAT_AC_SNIPPETS"],    desc = L["FEATURE_AC_SNIPPETS_DESC"] },
        { key = "acCommandEnabled",       label = L["WELCOME_FEAT_AC_COMMANDS"],    desc = L["FEATURE_AC_COMMANDS_DESC"] },
        { key = "acWhisperEnabled",       label = L["WELCOME_FEAT_AC_WHISPER"],desc = L["FEATURE_AC_WHISPERS_DESC"] },
        { key = "acBnetEnabled",          label = L["WELCOME_FEAT_AC_BNET"], desc = L["CB_AC_BNET"] },
        { key = "keepOpen",               label = L["WELCOME_FEAT_KEEP_OPEN"],        desc = L["FEATURE_KEEP_OPEN_DESC"] or "Keep the chat box open after sending. Press Escape to close.", defVal = false },
    }
    for _, feat in ipairs(features) do
        local cb = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate"); cb:SetPoint("TOPLEFT", 20, y)
        cb.text = cb:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); cb.text:SetPoint("LEFT", cb, "RIGHT", 4, 0)
        cb.text:SetText(feat.label)
        local val = BigChatBoxDB[feat.key]; if val == nil then val = (feat.defVal ~= nil) and feat.defVal or true end
        cb:SetChecked(val)
        cb:SetScript("OnClick", function(self) BigChatBoxDB[feat.key] = self:GetChecked() end)
        local help = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
        help:SetPoint("TOPLEFT", 52, y - 22); help:SetWidth(PANEL_WIDTH - 80); help:SetJustifyH("LEFT")
        help:SetText(feat.desc or ""); help:SetTextColor(0.5, 0.5, 0.5)
        y = y - 46
    end

    -- Long message handling dropdown
    local msLbl = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); msLbl:SetPoint("TOPLEFT", 20, y)
    msLbl:SetText(L["WELCOME_LONGMSG_LBL"]); y = y - 22
    local splitOptions = {
        { key = "off",     label = "Off",     desc = L["LONGMSG_DESC_OFF"]     or "Cut off at 255 chars"       },
        { key = "silent",  label = "Silent",  desc = L["LONGMSG_DESC_SILENT"]  or "Split automatically"        },
        { key = "notice",  label = "Notice",  desc = L["LONGMSG_DESC_NOTICE"]  or "Split with a chat notice"   },
        { key = "confirm", label = "Confirm", desc = L["LONGMSG_DESC_CONFIRM"] or "Ask before splitting"       },
    }
    local splitRev = { off = "off", silent = "silent", notice = "notice", confirm = "confirm" }
    local useNative = C_XMLUtil and C_XMLUtil.GetTemplateInfo and C_XMLUtil.GetTemplateInfo("WowStyle1DropdownTemplate")
    if useNative then
        local msDD = CreateFrame("DropdownButton", nil, f, "WowStyle1DropdownTemplate")
        msDD:SetPoint("TOPLEFT", 20, y); msDD:SetPoint("RIGHT", -20, 0)
        msDD:SetupMenu(function(_, rootDescription)
            for _, opt in ipairs(splitOptions) do
                local displayLabel = opt.label .. "  |cff888888" .. opt.desc .. "|r"
                rootDescription:CreateRadio(displayLabel,
                    function() return (BigChatBoxDB.messageSplitMode or "notice") == opt.key end,
                    function()
                        BigChatBoxDB.messageSplitMode = opt.key
                        msDD:GenerateMenu()
                    end)
            end
        end)
    end
    y = y - 40

    return f
end


local function BuildPage5(parent)
    local f = CreateFrame("Frame", nil, parent); f:SetAllPoints(); f:Hide()
    local y = -10

    -- Secure content with ? button
    local scH = f:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); scH:SetPoint("TOPLEFT", 20, y)
    scH:SetText("|cffff9900" .. (L["WELCOME_SECURE_TITLE"] or L["WELCOME_SECURE_TITLE"]) .. "|r")
    local scWhyBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate"); scWhyBtn:SetSize(24, 24)
    scWhyBtn:SetPoint("LEFT", scH, "RIGHT", 8, 0); scWhyBtn:SetText("?")
    scWhyBtn:SetScript("OnClick", function() BCB.ShowSecureContentHelp() end)
    scWhyBtn:SetScript("OnEnter", function(btn) GameTooltip:SetOwner(btn, "ANCHOR_RIGHT"); GameTooltip:AddLine(L["WELCOME_LEARN_MORE_LOCKOUT"], 1, 1, 1); GameTooltip:Show() end)
    scWhyBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    y = y - 20
    local scT = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight"); scT:SetPoint("TOPLEFT", 20, y)
    scT:SetWidth(PANEL_WIDTH - 60); scT:SetJustifyH("LEFT"); scT:SetSpacing(2)
    scT:SetText(L["WELCOME_LOCKOUT_INFO"] or "BigChatBox automatically pauses during M+ keystones, arenas, and rated battlegrounds to protect your chat.")
    scT:SetTextColor(0.9, 0.9, 0.9)
    y = y - (scT:GetStringHeight() + 16)

    -- Keybind section with ? button
    local kbH = f:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); kbH:SetPoint("TOPLEFT", 20, y)
    kbH:SetText("|cffffd100" .. (L["WELCOME_KEYBIND_TITLE"] or "Blizzard Chat Keybind") .. "|r")
    local whyBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate"); whyBtn:SetSize(24, 24)
    whyBtn:SetPoint("LEFT", kbH, "RIGHT", 8, 0); whyBtn:SetText("?")
    whyBtn:SetScript("OnClick", function() BCB.ShowShiftClickHelp() end)
    whyBtn:SetScript("OnEnter", function(btn) GameTooltip:SetOwner(btn, "ANCHOR_RIGHT"); GameTooltip:AddLine(L["WELCOME_WHY_KEYBIND"], 1, 1, 1); GameTooltip:Show() end)
    whyBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    y = y - 20
    local kbT = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight"); kbT:SetPoint("TOPLEFT", 20, y)
    kbT:SetWidth(PANEL_WIDTH - 60); kbT:SetJustifyH("LEFT"); kbT:SetSpacing(2)
    kbT:SetText(L["WELCOME_KEYBIND_INFO"] or "Most shift-click link insertions work directly in BigChatBox. For the few that don't (like mounts, toys, and talents), this keybind switches to Blizzard's chat input.")
    kbT:SetTextColor(0.9, 0.9, 0.9)
    y = y - (kbT:GetStringHeight() + 12)

    -- Keybind button
    local MODIFIER_KEYS = { LSHIFT=true, RSHIFT=true, LCTRL=true, RCTRL=true, LALT=true, RALT=true }
    local KB_ACTION = "BIGCHATBOX_USE_BLIZZARD_CHAT"
    local kbLabel = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); kbLabel:SetPoint("TOPLEFT", 20, y)
    kbLabel:SetText(L["WELCOME_CURRENT_KEYBIND"])
    local kbBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate"); kbBtn:SetSize(140, 24)
    kbBtn:SetPoint("LEFT", kbLabel, "RIGHT", 8, 0); kbBtn:RegisterForClicks("AnyUp")

    local function UpdateKBText()
        local key = GetBindingKey(KB_ACTION)
        kbBtn:SetText(key and GetBindingText(key) or (L["KEYBIND_NOT_BOUND"] or "Not Bound"))
    end
    UpdateKBText()
    f:RegisterEvent("UPDATE_BINDINGS")
    f:SetScript("OnEvent", function(_, event) if event == "UPDATE_BINDINGS" then UpdateKBText() end end)

    local function StopCapture(btn) btn:EnableKeyboard(false); btn:SetScript("OnKeyDown", nil); UpdateKBText() end
    local function ApplyBind(fullKey)
        local k1, k2 = GetBindingKey(KB_ACTION)
        if k1 then SetBinding(k1, nil) end; if k2 then SetBinding(k2, nil) end
        SetBinding(fullKey, KB_ACTION); SaveBindings(GetCurrentBindingSet()); UpdateKBText()
    end
    local function OnKeyCaptured(btn, key)
        if MODIFIER_KEYS[key] then return end
        if key == "ESCAPE" or InCombatLockdown() then StopCapture(btn); return end
        local mods = {}
        if IsAltKeyDown() then mods[#mods+1] = "ALT" end
        if IsControlKeyDown() then mods[#mods+1] = "CTRL" end
        if IsShiftKeyDown() then mods[#mods+1] = "SHIFT" end
        mods[#mods+1] = key; StopCapture(btn); ApplyBind(table.concat(mods, "-"))
    end
    kbBtn:SetScript("OnClick", function(btn, button)
        if button == "RightButton" then
            local k1, k2 = GetBindingKey(KB_ACTION)
            if k1 then SetBinding(k1, nil) end; if k2 then SetBinding(k2, nil) end
            if k1 or k2 then SaveBindings(GetCurrentBindingSet()) end; UpdateKBText()
        else
            btn:SetText(L["KEYBIND_PRESS_KEY"] or "Press a key..."); btn:EnableKeyboard(true); btn:SetScript("OnKeyDown", OnKeyCaptured)
        end
    end)
    local kbHelp2 = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    kbHelp2:SetPoint("TOPLEFT", 20, y - 20); kbHelp2:SetTextColor(0.5, 0.5, 0.5)
    kbHelp2:SetText(L["WELCOME_KEYBIND_CLICK_HINT"])
    y = y - 50

    -- Help & Tips section
    local htH = f:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); htH:SetPoint("TOPLEFT", 20, y)
    htH:SetText("|cffffd100Help & Tips|r")
    local htBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate"); htBtn:SetSize(24, 24)
    htBtn:SetPoint("LEFT", htH, "RIGHT", 8, 0); htBtn:SetText("?")
    htBtn:SetScript("OnClick", function() BCB.ShowHelpWindow() end)
    htBtn:SetScript("OnEnter", function(btn) GameTooltip:SetOwner(btn, "ANCHOR_RIGHT"); GameTooltip:AddLine(L["WELCOME_OPEN_HELP"], 1, 1, 1); GameTooltip:Show() end)
    htBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    y = y - 20
    local htT = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight"); htT:SetPoint("TOPLEFT", 20, y)
    htT:SetWidth(PANEL_WIDTH - 60); htT:SetJustifyH("LEFT")
    htT:SetText(L["WELCOME_HELP_DESC"])
    htT:SetTextColor(0.8, 0.8, 0.8)
    y = y - 24

    -- /bcb hint
    local cfgT = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight"); cfgT:SetPoint("TOPLEFT", 20, y)
    cfgT:SetWidth(PANEL_WIDTH - 60); cfgT:SetJustifyH("LEFT")
    cfgT:SetText("|cffffd100/bcb|r — " .. (L["WELCOME_CONFIG_HINT"] or "Open the full settings window anytime."))
    cfgT:SetTextColor(0.9, 0.9, 0.9)

    -- Thanks + Finish anchored to bottom
    local thx = f:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    thx:SetPoint("BOTTOM", 0, 76); thx:SetWidth(PANEL_WIDTH - 60); thx:SetJustifyH("CENTER")
    thx:SetText("|cff5599ff" .. (L["WELCOME_THANKS"] or "Thanks for using BigChatBox!") .. "|r")

    local finBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate"); finBtn:SetSize(140, 34)
    finBtn:SetPoint("BOTTOMLEFT", f, "BOTTOM", -148, 32); finBtn:SetText(L["WELCOME_FINISH_BTN"] or "Finish!")
    finBtn:GetFontString():SetTextColor(0.2, 1, 0.2)
    finBtn:SetScript("OnClick", function() BigChatBoxDB.setupComplete = true; C_UI.Reload() end)

    local cfgBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate"); cfgBtn:SetSize(140, 34)
    cfgBtn:SetPoint("BOTTOMRIGHT", f, "BOTTOM", 148, 32); cfgBtn:SetText(L["FINISH_CONFIG_BTN"])
    cfgBtn:SetScript("OnClick", function()
        BigChatBoxDB.setupComplete = true
        BigChatBoxDB.openConfigOnLogin = true
        C_UI.Reload()
    end)

    local reloadNote = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    reloadNote:SetPoint("BOTTOM", f, "BOTTOM", 0, 18); reloadNote:SetTextColor(0.5, 0.5, 0.5)
    reloadNote:SetText(L["WELCOME_RELOAD_NOTE"])

    return f
end

--------------------------------------------------------------------------------
-- SECURE CONTENT HELP WINDOW
--------------------------------------------------------------------------------
function BCB.ShowSecureContentHelp()
    if BCB.secureHelpFrame and BCB.secureHelpFrame:IsShown() then BCB.secureHelpFrame:Hide(); return end
    if not BCB.secureHelpFrame then
        local h = CreateFrame("Frame", "BCBSecureHelpWindow", UIParent, "ButtonFrameTemplate")
        h:SetSize(460, 480); h:SetPoint("CENTER", 200, 50); h:SetToplevel(true); h:EnableMouse(true); h:SetMovable(true); h:SetClampedToScreen(true)
        h:RegisterForDrag("LeftButton"); h:SetScript("OnDragStart", function() h:StartMoving() end); h:SetScript("OnDragStop", function() h:StopMovingOrSizing() end)
        ButtonFrameTemplate_HidePortrait(h); ButtonFrameTemplate_HideButtonBar(h); if h.Inset then h.Inset:Hide() end
        h:SetTitle(L["WELCOME_SECURE_TITLE"]); tinsert(UISpecialFrames, "BCBSecureHelpWindow")
        local sf = CreateFrame("ScrollFrame", nil, h, "ScrollFrameTemplate")
        sf:SetPoint("TOPLEFT", 16, -60); sf:SetPoint("BOTTOMRIGHT", -24, 16)
        local ct = CreateFrame("Frame", nil, sf); ct:SetWidth(sf:GetWidth() - 10); sf:SetScrollChild(ct)
        local txt = ct:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        txt:SetPoint("TOPLEFT", 0, 0); txt:SetWidth(ct:GetWidth()); txt:SetJustifyH("LEFT"); txt:SetJustifyV("TOP"); txt:SetSpacing(3)
        txt:SetText(L["HELP_BODY_SECURE"] or "")
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
        ButtonFrameTemplate_HidePortrait(h); ButtonFrameTemplate_HideButtonBar(h); if h.Inset then h.Inset:Hide() end
        h:SetTitle(L["WELCOME_SHIFTCLICK_TITLE"]); tinsert(UISpecialFrames, "BCBShiftClickHelpWindow")
        local sf = CreateFrame("ScrollFrame", nil, h, "ScrollFrameTemplate")
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

--------------------------------------------------------------------------------
-- CREATE THE MAIN WELCOME FRAME
--------------------------------------------------------------------------------
local function CreateWelcomeFrame()
    if welcomeFrame then return welcomeFrame end
    local f = CreateFrame("Frame", "BCBWelcomePanel", UIParent, "ButtonFrameTemplate")
    f:SetSize(PANEL_WIDTH, PANEL_HEIGHT); f:SetPoint("CENTER")
    f:SetToplevel(true); f:EnableMouse(true); f:SetMovable(true); f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function() f:StartMoving(); f:SetUserPlaced(false) end)
    f:SetScript("OnDragStop", function() f:StopMovingOrSizing(); f:SetUserPlaced(false) end)
    f:SetScript("OnMouseWheel", function() end); f:Hide()
    ButtonFrameTemplate_HidePortrait(f); ButtonFrameTemplate_HideButtonBar(f)
    if f.Inset then f.Inset:Hide() end
    f:SetTitle(L["WELCOME_SUBTITLE"] or "First-time Setup")
    if f.Bg then f.Bg:SetAlpha(0.97) end
    f.CloseButton:SetScript("OnClick", function() StaticPopup_Show("BCB_QUIT_SETUP") end)
    tinsert(UISpecialFrames, "BCBWelcomePanel")
    f:SetScript("OnHide", function()
        if not BigChatBoxDB.setupComplete and not f._hiding then
            f._hiding = true
            C_Timer.After(0.05, function() f:Show(); f._hiding = false; StaticPopup_Show("BCB_QUIT_SETUP") end)
        end
    end)
    f:RegisterEvent("PLAYER_REGEN_DISABLED")
    f:SetScript("OnEvent", function(self, event)
        if event == "PLAYER_REGEN_DISABLED" and self:IsShown() then
            self._hiding = true; self:Hide(); self._hiding = false
            BCB:Print(L["WELCOME_COMBAT_PAUSE"])
        end
    end)

    local pageTitle = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    pageTitle:SetPoint("TOP", 0, -32); pageTitle:SetTextColor(1, 0.82, 0); f.pageTitle = pageTitle
    local pageCounter = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    pageCounter:SetPoint("TOP", pageTitle, "BOTTOM", 0, -2); pageCounter:SetTextColor(0.5, 0.5, 0.5); f.pageCounter = pageCounter

    local content = CreateFrame("Frame", nil, f)
    content:SetPoint("TOPLEFT", 4, -68); content:SetPoint("BOTTOMRIGHT", -4, 50)

    local prevBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate"); prevBtn:SetSize(100, 26)
    prevBtn:SetPoint("BOTTOMLEFT", 16, 14); prevBtn:SetText(L["BTN_PREVIOUS"])
    prevBtn:SetScript("OnClick", function() GoToPage(currentPage - 1) end); f.prevBtn = prevBtn
    local nextBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate"); nextBtn:SetSize(100, 26)
    nextBtn:SetPoint("BOTTOMRIGHT", -16, 14); nextBtn:SetText(L["BTN_NEXT"])
    nextBtn:SetScript("OnClick", function() GoToPage(currentPage + 1) end); f.nextBtn = nextBtn

    pages = {
        BuildPage1(content),
        BuildPage2(content, f),
        BuildPage3(content, f),
        BuildPage4(content),
        BuildPage5(content),
    }

    -- Apply locale-appropriate font to all buttons and font strings in the panel.
    -- GameFontNormal on western clients lacks CJK glyphs; override when needed.
    local uiFont, uiFontSize = BCB.GetUIFont()
    if uiFont ~= "Fonts\\FRIZQT__.TTF" then
        local function ApplyFont(frame)
            for _, child in ipairs({ frame:GetChildren() }) do
                local t = child:GetObjectType()
                if t == "Button" then
                    local fs = child:GetFontString()
                    if fs then pcall(fs.SetFont, fs, uiFont, uiFontSize, "") end
                elseif t == "FontString" then
                    pcall(child.SetFont, child, uiFont, uiFontSize, "")
                elseif t == "Frame" or t == "ScrollFrame" then
                    ApplyFont(child)
                end
            end
            for _, region in ipairs({ frame:GetRegions() }) do
                if region:GetObjectType() == "FontString" then
                    pcall(region.SetFont, region, uiFont, uiFontSize, "")
                end
            end
        end
        ApplyFont(f)
    end
    if BigChatBoxDB.useGlobalProfile == nil then BigChatBoxDB.useGlobalProfile = true end
    welcomeFrame = f; BCB.welcomePanel = f
    return f
end

function BCB.ShowWelcomePanel()
    local f = CreateWelcomeFrame()
    currentPage = 1; UpdateNavigation()
    f._hiding = false; f:Show(); f:Raise()
end
