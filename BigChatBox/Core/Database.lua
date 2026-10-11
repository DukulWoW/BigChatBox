-- BigChatBox Core/Database.lua — SavedVariables initialization & migration
-- Handles first-run defaults, media validation, and future DB migrations.

local BCB = BigChatBox
local defaults = BCB.defaults

--------------------------------------------------------------------------------
-- MEDIA VALIDATION
-- If a LibSharedMedia font/texture was provided by another addon that got
-- removed, revert the saved name back to "Default" so the user doesn't get
-- invisible text or missing borders.
--------------------------------------------------------------------------------
local function ValidateMedia()
    local lsm = LibStub and LibStub("LibSharedMedia-3.0", true)
    if not lsm then return end

    -- Register BCB built-in textures
    lsm:Register("statusbar", "Solid", "Interface\\BUTTONS\\WHITE8X8")

    local function mediaExists(mediaType, name)
        if not name or name == "Default" or name == "None" or name == "Solid" then return true end
        for _, v in ipairs(lsm:List(mediaType)) do
            if v == name then return true end
        end
        return false
    end

    if not mediaExists("font", BigChatBoxDB.fontName) then
        BigChatBoxDB.fontName = "Default"; BigChatBoxDB.font = defaults.font
    end
    if not mediaExists("font", BigChatBoxDB.channelFontName) then
        BigChatBoxDB.channelFontName = "Default"; BigChatBoxDB.channelFont = defaults.channelFont
    end
    if not mediaExists("statusbar", BigChatBoxDB.bgTextureName) then
        BigChatBoxDB.bgTextureName = "Default"; BigChatBoxDB.bgTexture = defaults.bgTexture
    end
    if not mediaExists("border", BigChatBoxDB.borderTextureName) then
        BigChatBoxDB.borderTextureName = "Default"; BigChatBoxDB.borderTexture = defaults.borderTexture
    end
end

--------------------------------------------------------------------------------
-- MIGRATIONS (SV-03)
-- Each step runs exactly once per SavedVariables file, in order. Add new steps at
-- the bottom with the next number; never change a step that has shipped.
--------------------------------------------------------------------------------
-- Current version: 4 (the last step below).
local function MigrateDB(db)
    local v = db.dbVersion or 0
    if v < 1 then
        -- One position model (SV-02): xOffset/yOffset -> point/x/y
        if not db.point then
            db.point = defaults.position.point
            db.x = db.xOffset or defaults.position.x
            db.y = db.yOffset or defaults.position.y
        end
        db.xOffset, db.yOffset = nil, nil
        v = 1
    end
    if v < 2 then
        -- Was in DesignerTab.lua: outline booleans -> fontOutline
        if db.fontOutline == nil then
            db.fontOutline = (db.showOutline and "Outline") or (db.showShadow and "Drop Shadow") or "None"
        end
        db.showOutline, db.showShadow = nil, nil
        v = 2
    end
    if v < 3 then
        -- Was in Snippets.lua: string snippets -> tables
        for k, d in pairs(db.snippets or {}) do
            if type(d) == "string" then
                db.snippets[k] = { text = d, enabled = true, channel = "anywhere", global = true }
            end
        end
        v = 3
    end
    if v < 4 then
        -- Was in Minimap.lua: old minimap keys -> LibDBIcon's table (SV-05)
        if db.minimapAngle or db.showMinimapButton == false then
            db.minimapIcon = db.minimapIcon or { hide = false, minimapPos = db.minimapAngle or 220 }
            if db.showMinimapButton == false then db.minimapIcon.hide = true end
        end
        db.minimapAngle, db.showMinimapButton = nil, nil
        -- "Use for all characters" never did anything; settings are account-wide (BUG-13)
        db.useGlobalProfile = nil
        v = 4
    end
    -- Never lower the number, so an older BCB version cannot re-run steps later
    if v > (db.dbVersion or 0) then db.dbVersion = v end
end

--------------------------------------------------------------------------------
-- INITIALIZE DB
-- Called at ADDON_LOADED and again at login (idempotent). Sets missing keys to
-- default values, then runs the migrations.
--------------------------------------------------------------------------------
function BCB.InitializeDB()
    BigChatBoxDB = BigChatBoxDB or {}
    local db = BigChatBoxDB

    -- Size & font
    if db.width           == nil then db.width           = defaults.size.width end
    if db.height          == nil then db.height          = defaults.size.height end
    if db.fontSize        == nil then db.fontSize        = defaults.fontSize end
    if db.channelFontSize == nil then db.channelFontSize = defaults.channelFontSize end
    if db.alpha           == nil then db.alpha           = defaults.alpha end

    -- History
    if db.history        == nil then db.history        = {} end
    if db.whisperHistory == nil then db.whisperHistory = {} end
    if db.historyLength  == nil then db.historyLength  = 100 end
    if db.colorTypedText == nil then db.colorTypedText = false end

    -- Textures & colors
    if db.bgAlpha          == nil then db.bgAlpha          = defaults.bgAlpha end
    if db.borderAlpha      == nil then db.borderAlpha      = defaults.borderAlpha end
    if db.bgTexture        == nil then db.bgTexture        = defaults.bgTexture end
    if db.borderTexture    == nil then db.borderTexture    = defaults.borderTexture end
    if db.font             == nil then db.font             = defaults.font end
    if db.channelFont      == nil then db.channelFont      = defaults.channelFont end

    -- "Default" font means Friz Quadrata in the saved data. A CJK language swaps in its
    -- own font at display time (UpdateFontSize / UpdateChannelFontSize), so switching
    -- back to a Latin language brings Friz Quadrata back (BUG-14).
    if db.fontName == nil or db.fontName == "Default" then db.font = defaults.font end
    if db.channelFontName == nil or db.channelFontName == "Default" then db.channelFont = defaults.channelFont end
    if db.bgColor          == nil then db.bgColor          = { r = defaults.bgColor.r, g = defaults.bgColor.g, b = defaults.bgColor.b } end
    if db.borderColor      == nil then db.borderColor      = { r = 1, g = 1, b = 1 } end
    if db.bgTextureName    == nil then db.bgTextureName    = defaults.bgTextureName or "Solid" end
    if db.borderTextureName== nil then db.borderTextureName= "Default" end
    if db.fontName         == nil then db.fontName         = "Default" end
    if db.channelFontName  == nil then db.channelFontName  = "Default" end
    if db.keepOpen         == nil then db.keepOpen         = false end
    if db.showChannelName  == nil then db.showChannelName  = true  end

    -- Feature toggles
    if db.enableLinkHover        == nil then db.enableLinkHover        = true end
    if db.enableMouseWheelHistory== nil then db.enableMouseWheelHistory= true end
    if db.historyEnabled         == nil then db.historyEnabled         = true end

    -- Welcome panel / setup wizard (v5.5.0)
    -- setupComplete: nil/false = show welcome panel on login, true = skip
    -- bgScale: background texture scale percentage (50-150, default 100)
    if db.bgScale == nil then db.bgScale = 100 end

    -- Channel color tint on background (default off, intensity 50%)
    if db.bgChannelTint    == nil then db.bgChannelTint    = false end
    if db.bgTintIntensity  == nil then db.bgTintIntensity  = 50 end

    -- Message splitting for long messages (default: "notice")
    -- Values: "off", "silent", "notice", "confirm"
    if db.messageSplitMode == nil then db.messageSplitMode = "notice" end

    -- Character counter position (default: "inside_right")
    -- Values: "off", "inside_right", "outside_topleft", "outside_topright", "outside_bottomleft", "outside_bottomright"
    if db.charCounterPos == nil then db.charCounterPos = "inside_right" end

    -- Dynamic sizing (default off)
    if db.dynamicHeight == nil then db.dynamicHeight = false end
    if db.dynamicWidth  == nil then db.dynamicWidth  = false end

    -- Emoji/emoticon picker icon on editbox (default on)
    if db.showEmojiPicker == nil then db.showEmojiPicker = true end
    if db.recentEmoticons == nil then db.recentEmoticons = {} end

    -- Auto-open config after reload (used by welcome panel finish)
    if db.openConfigOnLogin == nil then db.openConfigOnLogin = false end

    -- Patch notes popup: nil = never seen → show popup on next login
    -- Stores the last version string whose popup was acknowledged ("5.6.0" etc.)
    -- No default needed — nil is the correct initial state (triggers popup).

    -- Multiline input box (v5.7.0)
    if db.multilineEnabled          == nil then db.multilineEnabled          = true  end
    if db.multilineUseDefaultStyle  == nil then db.multilineUseDefaultStyle  = true  end

    MigrateDB(db)
end

-- Media is validated at login, not at ADDON_LOADED: other addons register their
-- LibSharedMedia fonts and textures by then (SV-01).
BCB.ValidateMedia = ValidateMedia
