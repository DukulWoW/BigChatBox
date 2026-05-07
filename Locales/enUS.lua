-- BigChatBox Localization - English (Default)
-- This file defines ALL player-visible strings. Non-English locales override
-- only the keys they translate; missing keys fall back to English automatically.
-- Version: 5.6.0

local ADDON_NAME = "BigChatBox"
BigChatBox = BigChatBox or {}
BigChatBox.L = BigChatBox.L or {}
local L = BigChatBox.L

-- Forced language support: BigChatBoxLocale is a separate SavedVariable so it
-- exists at file-load time (before BigChatBoxDB). "client" or nil = follow WoW
-- client locale. Any other value = force that locale.
local _forced = BigChatBoxLocale and BigChatBoxLocale ~= "client" and BigChatBoxLocale or nil
BigChatBox._forcedLocale = _forced  -- expose for other locale files to read

-- ── Addon identity ────────────────────────────────────────────────────────────
L["ADDON_NAME"]   = "BigChatBox"
L["AUTHOR"]       = "by Dukul"
L["VERSION"]      = "Version"
L["LOADED_MSG"]   = "BigChatBox v%s loaded! Type /bcb for options."

-- ── Config window tabs ────────────────────────────────────────────────────────
L["TAB_GENERAL"]   = "General"
L["TAB_DESIGNER"]  = "Designer"
L["TAB_PLACEMENT"] = "Placement"
L["TAB_FEATURES"]  = "Features"
L["TAB_SNIPPETS"]  = "Snippets"
L["TAB_HISTORY"]   = "History"
L["TAB_ADVANCED"]  = "Advanced"
L["TAB_RESET"]     = "Reset"

-- ── Reset tab ─────────────────────────────────────────────────────────────────
L["RESET_TAB_HEADER"]       = "Reset & Restore"
L["RESET_TAB_DESC"]         = "These actions are permanent and cannot be undone."
L["RESET_ALL_HELP"]         = "Resets everything: position, appearance, history, and snippets."
L["RESET_APPEARANCE_HELP"]  = "Resets background, border, fonts, and colors only."
L["RESET_PLACEMENT_HELP"]   = "Resets position and size to defaults."
L["RESET_HISTORY_HELP"]     = "Clears all saved chat and whisper history."
L["RESET_SNIPPETS_HELP"]    = "Removes all snippets."
L["RESET_STYLES_HELP"]      = "Removes all saved custom styles."
L["RESTART_SETUP_HELP"]     = "Resets all settings and re-runs the first-time setup wizard."

-- ── Shared UI ─────────────────────────────────────────────────────────────────
L["PREVIEW"]      = "Preview"
L["TYPE_SOMETHING"] = "Type something here..."
L["CLOSE"]        = "Close"
L["ACTIONS"]      = "Actions"
L["RESET"]        = "Reset"
L["OK"]           = "OK"
L["CANCEL"]       = "Cancel"
L["YES"]          = "Yes"
L["NO"]           = "No"
L["SAVE"]         = "Save"
L["DELETE"]       = "Delete"
L["EDIT"]         = "Edit"
L["IMPORT"]       = "Import"
L["EXPORT"]       = "Export"
L["DUPLICATE"]    = "Duplicate"
L["SHARE"]        = "Share"
L["ENABLED"]      = "Enabled"
L["DISABLED"]     = "Disabled"

-- ── General tab ───────────────────────────────────────────────────────────────
L["BTN_VIEW_PATCH_NOTES"]     = "View patch notes"
L["BTN_HELP_AND_TIPS"]        = "Help & Tips"
L["BTN_COMBAT_LOCKOUT_INFO"]  = "Combat Lockout Info"
L["BTN_SHIFT_CLICK_INFO"]     = "Shift-Click Info"

-- General tab feature grid cell headers and descriptions
L["CELL_SNIPPETS_HDR"]       = "|cff5599ffSnippets|r"
L["CELL_SNIPPETS_DESC"]      = "Text shortcuts that expand on send.\nManage in the Snippets tab."
L["CELL_ANCHOR_HDR"]         = "|cff5599ffAnchor Editor|r"
L["CELL_ANCHOR_DESC"]        = "Click and drag to reposition.\nArrow keys for pixel precision."
L["CELL_AUTOCOMPLETE_HDR"]   = "|cff5599ffAutocomplete|r"
L["CELL_AUTOCOMPLETE_DESC"]  = "Smart Tab for commands, whispers,\nand snippet triggers (!guild)."
L["CELL_HISTORY_HDR"]        = "|cff5599ffChat History|r"
L["CELL_HISTORY_DESC"]       = "Full history with timestamps.\nScroll with mouse wheel."
L["CELL_CUSTOMIZATION_HDR"]  = "|cff5599ffCustomization|r"
L["CELL_CUSTOMIZATION_DESC"] = "Designer tab for backgrounds, borders,\nfonts, colors. Save & share styles."
L["CELL_SECURE_HDR"]         = "|cffff9900Secure Content|r"
L["CELL_SECURE_DESC"]        = "Auto-pauses in M+, arenas, and\nrated BGs to protect your chat."
L["CELL_SHARING_HDR"]        = "|cff5599ffSharing|r"
L["CELL_SHARING_DESC"]       = "Export styles and snippets as short\nstrings to share with friends."
L["CELL_LONGMSG_HDR"]        = "|cff5599ffLong Messages|r"
L["CELL_LONGMSG_DESC"]       = "Messages over 255 chars split\nautomatically. Silent, notice, or confirm."

-- ── Styles (Designer tab) ─────────────────────────────────────────────────────
L["STYLES"]              = "Styles"
L["ACTIVE_STYLE"]        = "Active Style"
L["BTN_SAVE_STYLE"]      = "Save Style"
L["BTN_DELETE_STYLE"]    = "Delete Style"
L["BTN_EXPORT_STYLE"]    = "Export Style"
L["BTN_IMPORT_STYLE"]    = "Import Style"

-- ── Designer tab sections ─────────────────────────────────────────────────────
L["SECTION_SIZE"]        = "Size"
L["SECTION_BACKGROUND"]  = "Background"
L["SECTION_BORDER"]      = "Border"
L["SECTION_FONTS"]       = "Fonts"
L["SECTION_TEXT_OPTIONS"] = "Text Options"

-- Designer tab slider / dropdown labels
L["LABEL_WIDTH"]              = "Width"
L["LABEL_HEIGHT"]             = "Height"
L["LABEL_SCALE"]              = "Scale"
L["LABEL_BG_TEXTURE"]         = "Background Texture"
L["LABEL_BG_OPACITY"]         = "Background Opacity"
L["LABEL_BG_BRIGHTNESS"]      = "Background Brightness"
L["LABEL_BG_SCALE"]           = "Background Scale"
L["LABEL_TINT_INTENSITY"]     = "Tint Intensity"
L["LABEL_BORDER_TEXTURE"]     = "Border Texture"
L["LABEL_BORDER_OPACITY"]     = "Border Opacity"
L["LABEL_BORDER_BRIGHTNESS"]  = "Border Brightness"
L["LABEL_BORDER_THICKNESS"]   = "Border Thickness"
L["LABEL_CHANNEL_FONT"]       = "Channel Font"
L["LABEL_INPUT_FONT"]         = "Input Font"
L["LABEL_CHANNEL_FONT_SIZE"]  = "Channel Font Size"
L["LABEL_INPUT_FONT_SIZE"]    = "Input Font Size"
L["LABEL_TEXT_ALIGNMENT"]     = "Text Alignment"
L["LABEL_FONT_OUTLINE"]       = "Font Outline"

-- Designer tab checkboxes
L["CB_DYNAMIC_HEIGHT"]   = "Dynamic height"
L["CB_DYNAMIC_WIDTH"]    = "Dynamic width"
L["CB_TINT_BG"]          = "Tint background with channel color"
L["CB_MATCH_TEXT_COLOR"] = "Match text color to channel"

-- ── Placement tab ─────────────────────────────────────────────────────────────
L["SECTION_LAYOUT_OPTIONS"]   = "Layout Options"
L["SECTION_POSITION"]         = "Position"
L["CB_SHOW_CHANNEL"]           = "Show channel name"
L["LABEL_CHANNEL_NAME_POS"]   = "Channel Name Position"
L["LABEL_AUTOCOMPLETE_POS"]   = "Autocomplete Position"
L["LABEL_CHAR_COUNTER_POS"]   = "Character Counter Position"
L["CB_AUTO_HIDE_CHANNEL"]     = "Auto-hide channel name (show on hover)"
L["BTN_OPEN_ANCHOR_EDITOR"]   = "Open Anchor Editor"

-- ── Features tab ─────────────────────────────────────────────────────────────
L["SECTION_FEATURE_TOGGLES"]  = "Feature Toggles"
L["FEATURE_TOGGLES_DESC"]     = "Enable or disable BigChatBox features."
L["SECTION_SNIPPET_SYSTEM"]   = "Snippet System"
L["SECTION_AUTOCOMPLETE"]     = "Autocomplete"
L["SECTION_HISTORY"]          = "History"
L["SECTION_LINK_HOVER"]       = "Link Hover"
L["SECTION_LONG_MESSAGES"]    = "Long Messages"
L["CB_ENABLE_SNIPPETS"]       = "Enable snippet system"
L["CB_AC_COMMANDS"]           = "Slash command autocomplete (/dance, /guild, ...)"
L["CB_AC_WHISPER"]            = "Whisper name autocomplete (/w <n>)"
L["CB_AC_SNIPPETS"]           = "Snippet trigger autocomplete (!guild, ...)"
L["CB_AC_BNET"]               = "Show Battle.net friends in whisper autocomplete"
L["CB_ENABLE_HISTORY"]        = "Enable chat history"
L["CB_MOUSEWHEEL_HISTORY"]    = "Scroll history with mouse wheel"
L["CB_LINK_HOVER"]            = "Show tooltips when hovering links"
L["LABEL_MSG_EXCEEDS_255"]    = "When message exceeds 255 characters"

-- ── Snippets tab ──────────────────────────────────────────────────────────────
L["SNIPPETS_DISABLED_MSG"]    = "Snippet system is disabled.\nEnable it in the Features tab."
L["SNIPPETS_HEADER"]          = "Snippets"
L["SNIPPETS_DESC"]            = "Type a snippet trigger (e.g. !guild) in chat and press Enter to send it."
L["SNIPPET_EDIT_HEADER"]      = "Edit"
L["SNIPPET_ACTIVE"]           = "Snippet active"
L["SNIPPET_TRIGGER_LBL"]      = "Trigger:"
L["SNIPPET_TEXT_LBL"]         = "Text:"
L["SNIPPET_CHANNEL_LBL"]      = "Post in:"
L["SNIPPET_GLOBAL"]           = "Available for all characters"
L["SNIPPET_EMPTY_LIST"]       = "No snippets yet.\nClick New Snippet or\nImport to get started."
L["BTN_NEW_SNIPPET"]          = "New Snippet"
L["BTN_EXPORT_ALL"]           = "Export All"
L["BTN_SHARE_SNIPPET"]        = "Share"
L["BTN_DUPLICATE_SNIPPET"]    = "Duplicate"
L["BTN_DELETE_SNIPPET"]       = "Delete"
L["BTN_IMPORT_SNIPPET"]       = "Import"

-- ── History tab ───────────────────────────────────────────────────────────────
L["HISTORY_HEADER"]           = "Chat History"
L["HISTORY_HELP"]             = "Click text to reuse it. Hover for timestamp. Click X to mark for removal."
L["HISTORY_EMPTY"]            = "No history yet."
L["HISTORY_MORE"]             = "... and %d more"
L["WHISPERS_HEADER"]          = "Recent Whispers"
L["WHISPERS_CLICK_HINT"]      = "(click to whisper)"
L["WHISPERS_EMPTY"]           = "No whisper history."
L["BTN_WIPE_HISTORY"]         = "Wipe Entire History"
L["BTN_WIPE_COMMANDS"]        = "Wipe All /Commands"
L["BTN_REMOVE_ENTRIES"]       = "Remove entries"

-- ── Advanced tab ──────────────────────────────────────────────────────────────
L["SECTION_PROFILES"]         = "Profiles"
L["PROFILES_DESC"]            = "Settings are saved per-character. Enable to share across all characters."
L["CB_GLOBAL_PROFILE"]        = "Use for all characters"
L["BEHAVIOR"]                 = "Behavior"
L["KEEP_OPEN"]                = "Keep input box open until Escape"
L["KEEP_OPEN_HELP"]           = "When enabled, the input box stays visible when you click elsewhere. Press Escape to close."
L["SHOW_LOCKDOWN_WARNING"]    = "Show secure content warning"
L["SHOW_LOCKDOWN_WARNING_HELP"] = "Shows a chat message when BCB pauses during M+ keystones, arenas, and rated battlegrounds."
L["IGNORE_COMMANDS_HISTORY"]  = "Ignore /commands in history"
L["IGNORE_COMMANDS_HISTORY_HELP"] = "Slash commands like /target and /cast won't be saved in chat history."
L["SHOW_MINIMAP_BUTTON"]      = "Show minimap button"
L["SHOW_MINIMAP_BUTTON_HELP"] = "Left-click opens config, right-click opens quick settings. The addon compartment button is always available."
L["HIDE_LOGIN_MSG"]           = "Hide login message"
L["HIDE_LOGIN_MSG_HELP"]      = "Hides the \"BigChatBox loaded\" message on login."
L["KEYBIND_OPEN_BLIZZARD"]    = "Open Blizzard Chat:"
L["KEYBIND_NOT_BOUND"]        = "Not Bound"
L["KEYBIND_PRESS_KEY"]        = "Press a key..."
L["KEYBIND_CONFLICT"]         = "%s is already bound to %s. Override?"
L["KEYBIND_TOOLTIP_BOUND"]    = "Open Blizzard Chat (%s)"
L["KEYBIND_TOOLTIP_UNBIND"]   = "Right-click to unbind"
L["KEYBIND_TOOLTIP_SET"]      = "Click to set a keybinding"
L["KEYBIND_HELP"]             = "Opens Blizzard's native chat for shift-clicking mounts, achievements, toys, talents. Default: Ctrl+Enter."
L["RESET_ALL"]                = "Reset All Settings"
L["RESET_APPEARANCE"]         = "Reset Appearance"
L["RESET_PLACEMENT"]          = "Reset Placement"
L["RESET_HISTORY_BTN"]        = "Reset History"
L["RESET_SNIPPETS_BTN"]       = "Reset Snippets"
L["RESET_STYLES_BTN"]         = "Reset Styles"
L["RESTART_SETUP"]            = "Restart Setup"

-- ── Reset / action confirmations (StaticPopupDialogs) ────────────────────────
L["POPUP_RESET_ALL"]          = "Reset ALL BigChatBox settings to defaults?\nThis includes position, size, appearance, and fonts."
L["POPUP_RESET_APPEARANCE"]   = "Reset appearance to defaults?\nDoes NOT affect position or history."
L["POPUP_RESET_PLACEMENT"]    = "Reset placement to defaults?\nThis will reload the UI."
L["POPUP_RESET_HISTORY"]      = "Reset all chat history and whisper history?\nHistory length will be set to 100.\nThis will reload the UI."
L["POPUP_RESET_SNIPPETS"]     = "Remove all snippets? This will reload the UI."
L["POPUP_RESET_STYLES"]       = "Remove ALL user-created styles?\nThe Default style will remain and become active.\nThis will reload the UI."
L["POPUP_WIPE_HISTORY"]       = "Wipe entire chat history?\nThis will also reload the UI."
L["POPUP_WIPE_COMMANDS"]      = "Remove all /commands from chat history?\nRegular messages will be kept.\nThis will also reload the UI."
L["POPUP_DELETE_STYLE"]       = "Delete the current style?"
L["POPUP_OVERWRITE_STYLE"]    = "A style named '%s' already exists. Overwrite it?"
L["POPUP_SAVE_STYLE_TEXT"]    = "Enter a name for this style:"
L["POPUP_EXPORT_STYLE_TEXT"]  = "Copy the style string below:"
L["POPUP_IMPORT_STYLE_TEXT"]  = "Paste a style string below:"
L["POPUP_NAME_IMPORT_STYLE"]  = "Save imported style as:"
L["POPUP_DELETE_SNIPPET"]     = "Delete snippet '%s'?"
L["POPUP_SHARE_SNIPPET_TEXT"] = "Copy snippet string (Ctrl+C):"
L["POPUP_IMPORT_SNIPPET_TEXT"] = "Paste snippet string (Ctrl+V):"
L["POPUP_RESTART_SETUP"]      = "This will reset ALL settings and restart the welcome setup.\nAre you sure?"
L["POPUP_QUIT_SETUP"]         = "Are you sure you want to quit setup?\nDefault settings will be used."
L["BTN_RESET_ALL_CONFIRM"]    = "Reset All"
L["BTN_WIPE_CONFIRM"]         = "Yes, Wipe"
L["BTN_DELETE_CONFIRM"]       = "Delete"
L["BTN_OVERWRITE_CONFIRM"]    = "Overwrite"
L["BTN_SKIP"]                 = "Skip"
L["BTN_RESTART_SETUP_CONFIRM"] = "Restart Setup"
L["BTN_QUIT_SETUP_CONFIRM"]   = "Quit Setup"
L["BTN_SAVE_CLOSE"]           = "Close"

-- ── Slash commands / print messages ──────────────────────────────────────────
L["SLASH_POSITION_RESET"]     = "Position reset to default"
L["SLASH_ANCHOR_UNAVAILABLE"] = "Anchor editor not available."
L["SLASH_HISTORY_CLEARED"]    = "|cff00ff00BigChatBox:|r Chat history cleared."
L["SLASH_APPEARANCE_RESET"]   = "|cff00ff00BigChatBox:|r Appearance reset to defaults"
L["RESET_DONE"]               = "All settings reset to defaults."
L["COMBAT_CLOSE"]             = "Config closed - entering combat."
L["COMBAT_BLOCKED"]           = "Cannot open config during combat."

-- ── Position / size labels (legacy keys kept for compat) ─────────────────────
L["POSITION"]       = "Position"
L["X_POSITION"]     = "X Position"
L["Y_POSITION"]     = "Y Position"
L["SIZE"]           = "Size"
L["WIDTH"]          = "Width"
L["HEIGHT"]         = "Height"
L["SCALE"]          = "Scale"
L["FONT_SIZES"]     = "Font Sizes"
L["INPUT_FONT_SIZE"]  = "Input Font Size"
L["CHANNEL_FONT_SIZE"] = "Channel Font Size"
L["FONTS"]          = "Fonts"
L["INPUT_FONT"]     = "Input Font"
L["CHANNEL_FONT"]   = "Channel Font"
L["BACKGROUND"]     = "Background"
L["BG_TEXTURE"]     = "Background Texture"
L["BG_TRANSPARENCY"] = "Background Opacity"
L["BG_BRIGHTNESS"]  = "Background Brightness"
L["BG_SCALE"]       = "Background Scale"
L["BORDER"]         = "Border"
L["BORDER_TEXTURE"] = "Border Texture"
L["BORDER_TRANSPARENCY"] = "Border Opacity"
L["BORDER_BRIGHTNESS"]   = "Border Brightness"
L["BORDER_THICKNESS"]    = "Border Thickness"
L["TEXT_OPTIONS"]   = "Text Options"
L["MATCH_TEXT_COLOR"] = "Match text color to channel"
L["SHOW_OUTLINE"]   = "Show outline on text"
L["SHOW_SHADOW"]    = "Show shadow on text"
L["DROP_SHADOW"]    = "Drop shadow on input box"
L["TEXT_ALIGN"]     = "Text Alignment"
L["CHAT_HISTORY"]   = "Chat History"
L["HISTORY_LENGTH"] = "History Length"
L["WIPE_HISTORY"]   = "Wipe Entire History"
L["RECENT_WHISPERS"] = "Recent Whispers"
L["SNIPPETS"]       = "Snippets"
L["SNIPPET_TRIGGER"] = "Trigger"
L["SNIPPET_TEXT"]   = "Text"
L["SNIPPET_SAVE"]   = "Save"
L["SNIPPET_DELETE"] = "Delete"
L["SNIPPET_NEW"]    = "New Snippet"
L["SNIPPET_SHARE"]  = "Share Snippet"
L["SNIPPET_EXPORT"] = "Export All"
L["SNIPPET_IMPORT"] = "Import"
L["SNIPPET_RESET"]  = "Reset Snippets"
L["AUTOCOMPLETE"]   = "Autocomplete"
L["AUTOCOMPLETE_POS"] = "Autocomplete Position"
L["CHANNEL_POS"]    = "Channel Name Position"
L["AUTO_HIDE_CHANNEL"] = "Auto-hide channel name (show on hover)"
L["LAYOUT_OPTIONS"] = "Layout Options"
L["ANCHOR_EDITOR"]  = "Anchor Editor"
L["OPEN_ANCHOR_EDITOR"] = "Open Anchor Editor"
L["ABOUT"]          = "About"
L["ABOUT_DESC"]     = "A large, customizable chat input box with channel display, anchor editor, and full appearance control."
L["PROFILES"]       = "Profiles"
L["STYLES"]         = "Styles"  -- note: duplicate assignment OK, last one wins
L["SAVE_STYLE"]     = "Save Style"
L["DELETE_STYLE"]   = "Delete Style"
L["EXPORT"]         = "Export Style"
L["IMPORT"]         = "Import Style"
L["DYNAMIC_HEIGHT"] = "Dynamic height"
L["DYNAMIC_WIDTH"]  = "Dynamic width"
L["CHAR_COUNTER_POS"] = "Character Counter Position"
L["LONG_MESSAGES"]  = "Long Messages"
L["LONG_MSG_OFF"]   = "Off"
L["LONG_MSG_SILENT"] = "Silent"
L["LONG_MSG_NOTICE"] = "Notice"
L["LONG_MSG_CONFIRM"] = "Confirm"
L["LONG_MSG_DESC_OFF"]     = "Message is cut off at 255 characters (default WoW behavior)."
L["LONG_MSG_DESC_SILENT"]  = "Automatically splits into multiple messages."
L["LONG_MSG_DESC_NOTICE"]  = "Splits and prints how many parts were sent."
L["LONG_MSG_DESC_CONFIRM"] = "Asks for confirmation before splitting."
L["IMPORT_STYLE_BTN"]  = "Import Style String"
L["FINISH_CONFIG_BTN"] = "Finish + Config"
L["BG_COLOR"]          = "Background Color"
L["MSG_SPLIT_NOTICE"]  = "Message split into %d parts (%d characters)."

-- ── v5.3.3 Keybinding strings (kept for compat) ───────────────────────────────
L["HELP_KEYBINDINGS_TITLE"] = "— Keybindings —"
L["HELP_KEYBINDINGS_TEXT"]  = "Ctrl+Enter switches to Blizzard's default chat (works anywhere).\nUseful for shift-clicking items that don't insert into BCB (mounts,\nachievements, toy box, talents, spell book). Type in Blizzard's box,\nthen press Enter to send. BCB resumes on your next Enter press.\n\nYou can rebind or unbind this in the Advanced tab or in\nEsc > Key Bindings > AddOns > BigChatBox."

-- ── v5.5.0 Welcome Panel ─────────────────────────────────────────────────────
L["WELCOME_TITLE"]          = "Welcome to BigChatBox!"
L["WELCOME_SUBTITLE"]       = "First-time Setup"
L["WELCOME_TEXT"]           = "BigChatBox replaces WoW's tiny chat input with a big, fully customizable editbox.\n\nYou can change the size, background, border, fonts, and colors — or pick a ready-made style. Features like chat history, text snippets, and smart autocomplete are built in and can be toggled on or off.\n\nThis quick setup will get you started in under a minute."
L["WELCOME_SETUP_BTN"]      = "Setup BigChatBox"
L["WELCOME_LANG_LBL"]       = "Display language:"
L["WELCOME_STYLE_TITLE"]    = "Select your style!"
L["WELCOME_LAYOUT_TITLE"]   = "Choose your layout"
L["WELCOME_FEATURES_TITLE"] = "Select your features!"
L["WELCOME_ADVANCED_TITLE"] = "Advanced features"
L["WELCOME_FINAL_TITLE"]    = "Almost done!"
L["WELCOME_FINISH_BTN"]     = "Finish!"
L["WELCOME_QUIT_CONFIRM"]   = "Are you sure you want to quit setup? Default settings will be used."
L["WELCOME_KEYBIND_INFO"]   = "Most shift-click link insertions work directly in BigChatBox. For the few that don't (like mounts, toys, and talents), this keybind switches to Blizzard's chat input."
L["WELCOME_LOCKOUT_INFO"]   = "BigChatBox automatically pauses during combat, M+ keystones, arenas, and rated battlegrounds to protect your chat."
L["WELCOME_THANKS"]         = "Thanks for using BigChatBox!"
L["WELCOME_SECURE_TITLE"]   = "Secure Content"
L["WELCOME_KEYBIND_TITLE"]  = "Blizzard Chat Keybind"
L["WELCOME_CONFIG_HINT"]    = "Type /bcb to open the full settings window anytime."
L["FEATURE_HISTORY_DESC"]   = "Saves your sent messages with timestamps."
L["FEATURE_SNIPPETS_DESC"]  = "Text shortcuts that expand when you press Enter."
L["FEATURE_AC_SNIPPETS_DESC"]  = "Autocomplete snippet triggers starting with !"
L["FEATURE_AC_COMMANDS_DESC"]  = "Autocomplete slash commands like /dance, /guild."
L["FEATURE_AC_WHISPERS_DESC"]  = "Autocomplete player names when whispering."
L["FEATURE_MOUSEWHEEL_DESC"]   = "Scroll through previous messages with mouse wheel."
L["FEATURE_GLOBAL_PROFILE_DESC"] = "Share settings across all characters on this account."
L["FEATURE_KEEP_OPEN_DESC"]    = "Input box stays visible when you click elsewhere."
L["RESTART_SETUP_CONFIRM"]  = "This will reset ALL settings and restart the welcome setup. Are you sure?"

-- ── v5.6.0 Patch notes UI ────────────────────────────────────────────────────
L["PATCHNOTES_WINDOW_TITLE"]   = "BigChatBox — What's New"
L["PATCHNOTES_VIEWER_TITLE"]   = "BigChatBox — Patch Notes"
L["PATCHNOTES_DONT_SHOW"]      = "Don't show this again"
L["PATCHNOTES_GOT_IT"]         = "Got it!"
L["PATCHNOTES_PREVIOUS"]       = "— Previous Updates —"

-- ── Keys added during source wiring (v5.6.0 localization pass) ───────────────

-- Features tab
L["LONG_MSG_OPTIONS_DESC"] = "|cffffffffOff|r — Message is cut off at 255 characters (default WoW behavior).\n|cffffffffSilent|r — Automatically splits into multiple messages.\n|cffffffffNotice|r — Splits and prints how many parts were sent.\n|cffffffffConfirm|r — Asks for confirmation before splitting."

-- Snippets tab
L["SNIPPET_NOTHING_TO_EXPORT"] = "No snippets to export."

-- History tab
L["HISTORY_LENGTH_LABEL"] = "History Length"

-- ConfigMain print messages
L["PRINT_RESET_ALL"]         = "All settings reset to defaults. Reloading..."
L["PRINT_RESET_APPEARANCE"]  = "Appearance reset. Reloading..."
L["PRINT_RESET_PLACEMENT"]   = "Placement reset. Reloading..."
L["PRINT_RESET_HISTORY"]     = "History reset. Reloading..."
L["PRINT_SNIPPETS_REMOVED"]  = "All snippets removed."
L["PRINT_STYLES_REMOVED"]    = "All custom styles removed."
L["PRINT_NO_STYLE_STRING"]   = "No style string provided."
L["PRINT_STYLE_DECODE_FAIL"] = "Failed to decode style string. It may be corrupted."
L["PRINT_STYLE_INVALID"]     = "Invalid style string. Expected !BCB1: or BCB: prefix."
L["PRINT_STYLE_IMPORTED"]    = "Style imported!"
L["PRINT_STYLE_SAVED"]       = "Style '%s' saved."
L["PRINT_STYLE_DELETED"]     = "Style '%s' deleted."
L["PRINT_SNIPPET_INVALID"]   = "Invalid snippet string."
L["PRINT_SNIPPET_REMOVED"]   = "Snippet '%s' removed."
L["PRINT_SNIPPETS_IMPORTED"] = "Imported %d snippet(s)."
L["PRINT_SNIPPETS_SKIPPED"]  = " %d skipped (already exist)."
L["PRINT_CANT_DELETE_DEFAULT"] = "Cannot delete the Default style."
L["PRINT_SETUP_SKIPPED"]     = "Setup skipped. Type |cff55ccff/bcb|r anytime to configure."
L["BTN_RESET_STYLES_CONFIRM"] = "Reset Styles"

-- SlashCommands popups
L["POPUP_WIPE_WHISPERS"]     = "Clear whisper history? This cannot be undone."

-- WelcomePanel
L["WELCOME_CHOOSE_STYLE"]      = "Choose a style:"
L["WELCOME_STYLE_NOTE"]        = "Styles marked with addon names require those addons.\nYou can fully customize everything later in the Designer tab."
L["WELCOME_LAYOUT_DESC"]       = "Choose where the channel name and autocomplete appear relative to the input box."
L["WELCOME_CHANNEL_POS_LBL"]   = "Channel name position:"
L["WELCOME_AC_POS_LBL"]        = "Autocomplete position:"
L["WELCOME_AUTOHIDE_HELP"]     = "The channel name fades out until you hover over the input box."
L["WELCOME_CHARCOUNTER_LBL"]   = "Character counter position:"
L["WELCOME_FEATURES_DESC"]     = "Toggle the features you want. All are enabled by default.\nYou can change these anytime in the Features tab."
L["WELCOME_LONGMSG_LBL"]       = "Long messages (over 255 characters):"
L["LONGMSG_DESC_OFF"]          = "Cut off at 255 chars"
L["LONGMSG_DESC_SILENT"]       = "Split automatically"
L["LONGMSG_DESC_NOTICE"]       = "Split with a chat notice"
L["LONGMSG_DESC_CONFIRM"]      = "Ask before splitting"
L["WELCOME_LEARN_MORE_LOCKOUT"] = "Learn more about combat lockout"
L["WELCOME_WHY_KEYBIND"]       = "Why does this exist?"
L["WELCOME_CURRENT_KEYBIND"]   = "Current keybind:"
L["WELCOME_KEYBIND_CLICK_HINT"] = "Click to set · Right-click to unbind"
L["WELCOME_OPEN_HELP"]         = "Open Help & Tips window"
L["WELCOME_HELP_DESC"]         = "All commands, shortcuts, and feature details are available in the help window."
L["WELCOME_RELOAD_NOTE"]       = "Both buttons will reload your UI."
L["WELCOME_COMBAT_PAUSE"]      = "Setup paused — entering combat."
L["WELCOME_SHIFTCLICK_TITLE"]  = "Shift-Click Link Insertion"
L["WELCOME_FEAT_HISTORY"]      = "Chat History"
L["WELCOME_FEAT_SNIPPETS"]     = "Snippet System"
L["WELCOME_FEAT_AC_SNIPPETS"]  = "Autocomplete: !Snippets"
L["WELCOME_FEAT_AC_COMMANDS"]  = "Autocomplete: /Commands"
L["WELCOME_FEAT_AC_WHISPER"]   = "Autocomplete: Whisper names"
L["WELCOME_FEAT_AC_BNET"]      = "Autocomplete: Battle.net friends"
L["WELCOME_FEAT_KEEP_OPEN"]    = "Keep input box open"

-- WelcomePanel navigation
L["BTN_PREVIOUS"]  = "Previous"
L["BTN_NEXT"]      = "Next"

-- ── Language selector (Advanced tab) ─────────────────────────────────────────
L["SECTION_LANGUAGE"]        = "Language"
L["LANGUAGE_DESC"]           = "Override the display language. Requires a UI reload."
L["LANGUAGE_CLIENT"]         = "Client Language"
L["LANGUAGE_RELOAD_MSG"]     = "Language changed. Reloading UI..."
L["POPUP_CHANGE_LANGUAGE"]   = "Change language and reload the UI?"
L["BTN_RELOAD_CONFIRM"]      = "Reload"
L["LANGUAGE_COMING_SOON"]    = "|cff888888(Coming soon)|r"

-- ── Help popup body strings (v5.6.0+) ────────────────────────────────────────
-- These are the scrollable body texts for the three help windows.
-- Translated so non-English players get full benefit of the help system.
-- Color escape sequences (|cff...|r) and slash commands (/bcb etc.) must NOT
-- be translated — only the surrounding prose.

L["HELP_WINDOW_TITLE"] = "BigChatBox Help"

L["HELP_BODY_MAIN"] = [[|cffffd100— Commands —|r
|cffffd100/bcb|r or |cffffd100/bcb config|r — Open settings window.
|cffffd100/bcb edit|r — Open the anchor editor to reposition.
|cffffd100/bcb reset|r — Reset position to default.

|cffffd100— Chat Basics —|r
|cffffd100Left-click|r channel name to cycle channels (Say, Party, Guild, etc.).
|cffffd100Right-click|r channel name for config, history, and wipe options.
|cffffd100Enter|r sends your message. |cffffd100Escape|r clears and closes.
|cffffd100Mouse wheel|r on the input box scrolls through your chat history.

|cffffd100— Autocomplete —|r
Type |cffffd100/|r to see matching slash commands (Tab to cycle, Enter to confirm).
Type |cffffd100!|r to autocomplete snippet triggers (e.g. !guild, !inv).
Whisper names auto-complete from friends, guild, group, and recent whispers.
|cffffd100Tab|r / |cffffd100Shift+Tab|r to cycle through suggestions.

|cffffd100— Snippets —|r
Define text shortcuts that expand when you press Enter.
Example: !guild could expand to "LFM Mythic+ whisper for invite!"
Each snippet can be restricted to specific channels.
Manage, create, import, and export snippets in the |cff5599ffSnippets|r tab.

|cffffd100— Link Insertion —|r
|cffffd100Shift+click|r items, spells, achievements, and more to insert links.
Works from bags, spellbook, achievement panel, professions, and chat output.
|cffffd100Hover|r over links in the input box to preview tooltips.
For panels that don't support direct insertion, see the |cff5599ffShift-Click Info|r button.

|cffffd100— Customization —|r
The |cff5599ffDesigner|r tab lets you customize background, border, fonts, and colors.
|cff5599ffPlacement|r tab has the anchor editor for precise positioning.
Save your look as a named style. Export and import styles as strings to share.
LibSharedMedia textures and fonts are supported if you have LSM installed.

|cffffd100— Tools & Toggles —|r
The |cff5599ffFeatures|r tab lets you enable or disable individual features:
autocomplete, snippets, link hover tooltips, chat history, and more.
|cffffd100Keep Open|r mode keeps the input box visible even when it loses focus.

|cffffd100— Profiles & Styles —|r
Settings are saved per-character by default.
Enable |cffffd100Use for all characters|r in Advanced to share settings globally.
Styles save your visual appearance (background, border, fonts, colors).
Use Export/Import to share styles with friends or between characters.

|cffffd100— Position & Sizing —|r
The Anchor Editor lets you click-drag the box to a new position.
Arrow keys nudge 1 pixel at a time for precision.
Shift+drag resizes the box symmetrically.
|cffffd100Shift+Alt+Click|r on the box resets its position to center.
You can also set exact position and size values in the anchor editor's info panel.

|cffffd100— Long Messages —|r
Messages over 255 characters can be automatically split into multiple sends.
Configure the behavior in the |cff5599ffFeatures|r tab: Off, Silent, Notice, or Confirm.
A character counter shows how close you are to the limit.

|cffffd100— Dynamic Sizing —|r
Enable |cffffd100Dynamic Height|r and |cffffd100Dynamic Width|r in the Designer tab.
Height adjusts to font size, width grows with your message length.]]

L["HELP_BODY_SECURE"] = "|cffffd100— Why does BigChatBox pause during combat / M+ etc. —|r\n\n" ..
    "With the Midnight expansion (12.0), Blizzard introduced major changes to how addons interact with the game during combat. This initiative, called |cff5599ffAddon Disarmament|r, limits what addons can do with combat information.\n\n" ..
    "|cffffd100What changed?|r\n" ..
    "Combat-related data is now treated as |cffff9900\"secret values\"|r. Addons can display this information but cannot read or process it in their code.\n\n" ..
    "Many UI frames are now |cffff9900protected|r during combat. In instanced content (M+ keystones, arenas, rated battlegrounds) the restrictions are even stricter. Any addon that modifies or hooks into these protected frames risks spreading |cffff6666taint|r, which can completely break game functionality. Not just the addon, but core game features like targeting, casting spells, and using abilities.\n\n" ..
    "|cffffd100How does this affect BigChatBox?|r\n" ..
    "WoW's default chat input (ChatFrame1EditBox) is a protected frame because it processes secure slash commands like /target, /cast, and /focus. BigChatBox hooks into this frame to intercept chat input. During combat and instanced competitive content, these hooks can cause taint that would block your entire chat system.\n\n" ..
    "To protect you, BigChatBox |cff00ff00automatically pauses|r during combat and during M+ keystones, arenas, and rated battlegrounds. Blizzard's default chat input takes over seamlessly. When combat ends or the content finishes, BigChatBox resumes automatically.\n\n" ..
    "|cffffd100Why not just fix it?|r\n" ..
    "This is not a |cffff0000bug!|r This is a fundamental restriction in WoW's security model. Every addon that modifies protected frames during combat faces the same limitation. Blizzard designed these restrictions to prevent addons from automating combat decisions, and the chat editbox falls within that protected scope.\n\n" ..
    "|cffffd100The bottom line|r\n" ..
    "BigChatBox pauses during combat and during timed competitive instances (M+, arenas, rated BGs). You can still chat normally during those activities by using Blizzard's built-in chat input instead. BigChatBox resumes automatically when combat ends or the activity completes."

L["HELP_BODY_SHIFTCLICK"] = "|cffffd100— Why don't all shift-clicks work? —|r\n\n" ..
    "Most shift-click link insertions work directly in BigChatBox. However, a few game panels use internal Blizzard functions that only insert links into Blizzard's own chat input, bypassing any addon editbox.\n\n" ..
    "|cff00ff00Works in BigChatBox:|r\n" ..
    "  · Items from personal bags\n" ..
    "  · Pets from the pet journal\n" ..
    "  · Heirlooms from the heirloom panel\n" ..
    "  · Items from vendor panels\n" ..
    "  · Items from the mailbox\n" ..
    "  · Crafting recipes and reagents from the professions panel\n" ..
    "  · Links from the chat window\n\n" ..
    "|cffff9900Needs Blizzard chat:|r\n" ..
    "  · Achievements from the achievement panel\n" ..
    "  · Items from the bank panel\n" ..
    "  · Items from the guild bank panel\n" ..
    "  · Mounts from the mount journal\n" ..
    "  · Talents from the talent panel\n" ..
    "  · Appearances from the wardrobe\n" ..
    "  · Some expansion-specific panels\n\n" ..
    "|cffffd100Why?|r\n" ..
    "These panels use WoW's internal |cff5599ffChatEdit_InsertLink|r function which checks for Blizzard's specific editbox. BigChatBox intercepts most of these calls, but some panels bypass the standard hook entirely due to how Blizzard implemented them. This is a WoW API limitation, not a bug.\n\n" ..
    "|cffffd100The solution|r\n" ..
    "The |cff5599ffBlizzard Chat Keybind|r (default: Ctrl+Enter) instantly switches to Blizzard's native chat input. Type or shift-click what you need there, press Enter to send, and BigChatBox resumes automatically on your next message.\n\n" ..
    "You can rebind or unbind this key in:\n" ..
    "  · |cffffd100/bcb|r > Advanced tab\n" ..
    "  · Esc > Key Bindings > AddOns > BigChatBox"

L["POPUP_WIZARD_CHANGE_LANGUAGE"] = "Switch to %s and restart setup?\nBigChatBox will reload to apply the new language."

-- ── v5.6.1 Emoji & Emoticon picker ───────────────────────────────────────────
L["SECTION_EMOJI"]          = "Emoticon Picker"
L["CB_SHOW_EMOJI_PICKER"]   = "Show emoticon picker button"
L["EMOJI_PICKER_TITLE"]     = "Emoticon Picker"
L["EMOJI_PICKER_TOOLTIP"]   = "Click to open emoticon picker"
L["EMOJI_TAB_LAST"]         = "Last Used"
L["EMOJI_TAB_ASCII"]        = "Emoticons"
L["EMOJI_LAST_EMPTY"]       = "No recent selections yet."

-- ── v5.7.1 Snippets & History ───────────────────────────────────────────────────────────
L["HISTORY_SEARCH_HINT"]        = "Search history..."

L["BTN_SAVE_SNIPPET"]           = "Save"

-- ── v5.7.2 Multiline Default Style ───────────────────────────────────────────
L["CB_MULTILINE_DEFAULT_STYLE"]      = "Use Default style"
L["CB_MULTILINE_DEFAULT_STYLE_HELP"] = "When checked, the multiline box uses the Default style regardless of your active style. Uncheck to match your current BCB appearance."

-- ── v5.7.0 Multiline Input Box ────────────────────────────────────────────────
L["SECTION_MULTILINE"]          = "Multiline Input Box"
L["CB_ENABLE_MULTILINE"]        = "Enable multiline input box"
L["CB_ENABLE_MULTILINE_HELP"]   = "Open a large multiline box to compose multi-line messages. Each line is sent separately."
L["KEYBIND_OPEN_MULTILINE"]     = "Open Multiline Box:"
L["MULTILINE_KEYBIND_HELP"]     = "Default: Shift+Enter. Opens a large input box where Enter adds a new line and Shift+Enter sends all lines."
L["BTN_OPEN_KEYBINDINGS"]       = "Open Key Bindings"
L["MULTILINE_SEND_BTN"]         = "Send"
L["MULTILINE_CHANNEL_LABEL"]    = "Channel: %s"
L["MULTILINE_BLOCKED_SECURE"]   = "Multiline box is not available during M+/Arena/Rated BG."
L["MULTILINE_HINT"]             = "Enter = new line   |   Shift+Enter = send all"
