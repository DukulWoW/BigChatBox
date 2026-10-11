-- BigChatBox Core/SlashCommands.lua — Slash commands and static popup dialogs

local BCB = BigChatBox
local L = BCB.L

--------------------------------------------------------------------------------
-- SLASH COMMANDS
--------------------------------------------------------------------------------
function BCB.RegisterSlashCommands()
    SLASH_BIGCHATBOX1 = "/bigchatbox"
    SLASH_BIGCHATBOX2 = "/bcb"

    SlashCmdList["BIGCHATBOX"] = function(msg)
        local cmd = string.lower(msg or "")

        if cmd == "reset" then
            BCB.ResetPosition()  -- BUG-02: one position model, so this sticks after /reload
            BCB:Print(L["SLASH_POSITION_RESET"])
        elseif cmd == "edit" or cmd == "visual" then
            if BCB.ToggleVisualEditor then BCB.ToggleVisualEditor() else BCB:Print(L["SLASH_ANCHOR_UNAVAILABLE"]) end
        elseif cmd == "blizzard" or cmd == "default" then
            BCB_UseBlizzardChat()
        else
            -- Default: open config window
            if BCB.OpenConfigWindow then
                BCB.OpenConfigWindow()
            elseif Settings and Settings.OpenToCategory and BCB.settingsCategory then
                Settings.OpenToCategory(BCB.settingsCategory:GetID())
            end
        end
    end
end

--------------------------------------------------------------------------------
-- STATIC POPUP DIALOGS
--------------------------------------------------------------------------------
StaticPopupDialogs["BCB_CLEAR_HISTORY"] = {
    text = L["POPUP_WIPE_HISTORY"],
    button1 = L["BTN_WIPE_CONFIRM"],
    button2 = L["CANCEL"],
    OnAccept = function()
        BigChatBoxDB.history = {}
        print(L["SLASH_HISTORY_CLEARED"])
    end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

StaticPopupDialogs["BCB_CLEAR_WHISPERS"] = {
    text = L["POPUP_WIPE_WHISPERS"],
    button1 = L["BTN_WIPE_CONFIRM"],
    button2 = L["CANCEL"],
    OnAccept = function()
        BCB.ClearWhisperHistory()
    end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

-- (BCB_RESET_APPEARANCE is defined in Config/ConfigMain.lua; an older copy here was
-- overwritten at load and reset frames that no longer exist, DEAD-04.)

--------------------------------------------------------------------------------
-- ADDON COMPARTMENT FRAME (global wrappers referenced in .toc)
--------------------------------------------------------------------------------
function BCB_OnAddonCompartmentClick(addonName, buttonName)
    if BCB.OnAddonCompartmentClick then BCB.OnAddonCompartmentClick(addonName, buttonName) end
end
function BCB_OnAddonCompartmentEnter(addonName, menuButtonFrame)
    if BCB.OnAddonCompartmentEnter then BCB.OnAddonCompartmentEnter(addonName, menuButtonFrame) end
end
function BCB_OnAddonCompartmentLeave()
    if BCB.OnAddonCompartmentLeave then BCB.OnAddonCompartmentLeave() end
end
