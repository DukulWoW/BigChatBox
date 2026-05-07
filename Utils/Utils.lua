-- BigChatBox - Utility Functions

local ADDON_NAME = "BigChatBox"

-- Keybinding names (must be global before Bindings.xml is processed)
BINDING_HEADER_BIGCHATBOX = "BigChatBox"
BINDING_NAME_BIGCHATBOX_USE_BLIZZARD_CHAT = "Open Blizzard Chat"
BINDING_NAME_BIGCHATBOX_OPEN_MULTILINE    = "Open Multiline Box"

-- Create namespace
BigChatBox = BigChatBox or {}
local BCB = BigChatBox

-- Color helper
function BCB:ColorText(text, r, g, b)
    return string.format("|cff%02x%02x%02x%s|r", r*255, g*255, b*255, text)
end

-- Print helper
function BCB:Print(message)
    print("|cff00ff00BigChatBox:|r " .. message)
end

-- Returns a font path that can render the current active locale's characters.
-- Falls back to FRIZQT__ (western) for Latin locales.
-- Used to override GameFontNormal on buttons/labels when a CJK locale is forced.
function BCB.GetUIFont()
    local locale = BigChatBoxLocale or GetLocale()
    if locale == "zhCN" or locale == "zhTW" or locale == "jaJP" then
        return "Fonts\\ARKai_T.ttf", 13  -- CJK Unified Ideographs (kanji, zh chars)
    elseif locale == "koKR" then
        return "Fonts\\2002.ttf", 13     -- Korean Hangul
    else
        return "Fonts\\FRIZQT__.TTF", 13 -- Latin / Cyrillic
    end
end
