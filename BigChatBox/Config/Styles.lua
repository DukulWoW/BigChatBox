-- BigChatBox Config/Styles.lua — Built-in style presets and style application
-- Shared by the Designer tab, style import and the setup wizard, so it loads on
-- every client (moved out of WelcomePanel.lua, CMPT-03).

local BCB = BigChatBox

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
BCB.BUILTIN_STYLE_DATA = WELCOME_STYLES  -- decoded presets: { name, data }
