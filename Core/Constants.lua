-- BigChatBox Core/Constants.lua — Default settings and constant tables
-- All magic numbers and default values live here.

local BCB = BigChatBox

--------------------------------------------------------------------------------
-- DEFAULT SETTINGS
-- These are used when BigChatBoxDB doesn't have a value set.
-- Keep in sync with Core/Database.lua InitializeDB().
--------------------------------------------------------------------------------
BCB.defaults = {
    position = { point = "CENTER", x = 0, y = -200 },
    size     = { width = 400, height = 50 },
    fontSize        = 14,
    channelFontSize = 16,
    alpha           = 0.95,

    bgAlpha     = 0.95,
    borderAlpha = 1.0,
    bgTexture     = "Interface\\BUTTONS\\WHITE8X8",
    bgTextureName = "Solid",
    borderTexture = "Interface\\Tooltips\\UI-Tooltip-Border",
    font        = "Fonts\\FRIZQT__.TTF",
    channelFont = "Fonts\\FRIZQT__.TTF",

    showEmojiPicker  = true,
    recentEmoticons  = {},

    bgColor     = { r = 0.1, g = 0.1, b = 0.1 },
    borderColor = { r = 1, g = 1, b = 1 },
    borderTextureName = "Default",
    fontName        = "Default",
    channelFontName = "Default",
}

--------------------------------------------------------------------------------
-- SLASH COMMAND → CHAT TYPE MAP
-- Used by ParseChatCommand in Editbox/ChatIntercept.lua
--------------------------------------------------------------------------------
BCB.COMMAND_MAP = {
    ["/s"]        = "SAY",       ["/say"]      = "SAY",
    ["/y"]        = "YELL",      ["/yell"]     = "YELL",
    ["/p"]        = "PARTY",     ["/party"]    = "PARTY",
    ["/raid"]     = "RAID",      ["/r"]        = "RAID",     ["/ra"] = "RAID",
    ["/g"]        = "GUILD",     ["/guild"]    = "GUILD",
    ["/o"]        = "OFFICER",   ["/officer"]  = "OFFICER",
    ["/i"]        = "INSTANCE_CHAT", ["/instance"] = "INSTANCE_CHAT",
}

--------------------------------------------------------------------------------
-- SNIPPET CHANNEL MAP
-- Maps snippet channel keywords to WoW chat types
--------------------------------------------------------------------------------
BCB.SNIPPET_CHANNEL_MAP = {
    guild    = "GUILD",
    party    = "PARTY",
    raid     = "RAID",
    say      = "SAY",
    yell     = "YELL",
    instance = "INSTANCE_CHAT",
}

--------------------------------------------------------------------------------
-- CHAT TYPE → SINGLE LETTER MAP
-- Used by History for channel-colored display (v5.5.0)
--------------------------------------------------------------------------------
BCB.CHAT_TYPE_LETTERS = {
    SAY = "S", YELL = "Y", GUILD = "G", OFFICER = "O",
    PARTY = "P", RAID = "R", INSTANCE_CHAT = "I",
    WHISPER = "W", BN_WHISPER = "W", CHANNEL = "C",
}

