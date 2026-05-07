-- BigChatBox Core/SlashCommands.lua — Slash commands and static popup dialogs

local BCB = BigChatBox
local L = BCB.L
local defaults = BCB.defaults

--------------------------------------------------------------------------------
-- SLASH COMMANDS
--------------------------------------------------------------------------------
function BCB.RegisterSlashCommands()
    SLASH_BIGCHATBOX1 = "/bigchatbox"
    SLASH_BIGCHATBOX2 = "/bcb"

    SlashCmdList["BIGCHATBOX"] = function(msg)
        local cmd = string.lower(msg or "")

        if cmd == "reset" then
            if BCB.frame then
                BCB.frame:ClearAllPoints()
                BCB.frame:SetPoint(defaults.position.point, UIParent, defaults.position.point,
                    defaults.position.x, defaults.position.y)
            end
            BigChatBoxDB.point = nil
            BigChatBoxDB.x = nil
            BigChatBoxDB.y = nil
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

StaticPopupDialogs["BCB_RESET_APPEARANCE"] = {
    text = L["POPUP_RESET_APPEARANCE"],
    button1 = L["RESET"],
    button2 = L["CANCEL"],
    OnAccept = function()
        BigChatBoxDB.bgTexture = defaults.bgTexture
        BigChatBoxDB.borderTexture = defaults.borderTexture
        BigChatBoxDB.font = defaults.font
        BigChatBoxDB.channelFont = defaults.channelFont
        BigChatBoxDB.bgColor = { r = 1, g = 1, b = 1 }
        BigChatBoxDB.borderColor = { r = 1, g = 1, b = 1 }
        BigChatBoxDB.bgAlpha = defaults.bgAlpha
        BigChatBoxDB.borderAlpha = defaults.borderAlpha
        BigChatBoxDB.bgTextureName = "Default"
        BigChatBoxDB.borderTextureName = "Default"
        BigChatBoxDB.fontName = "Default"
        BigChatBoxDB.channelFontName = "Default"

        if BCB.UpdateBackdrop then BCB.UpdateBackdrop() end
        if BCB.UpdateFontSize then BCB.UpdateFontSize() end
        if BCB.UpdateChannelFontSize then BCB.UpdateChannelFontSize() end

        -- Reset config dropdowns if they exist
        for _, name in ipairs({
            "BCBBgTextureDropdown", "BCBBorderTextureDropdown",
            "BCBFontDropdown", "BCBChannelFontDropdown",
        }) do
            if _G[name] then UIDropDownMenu_SetText(_G[name], "Default") end
        end
        for _, pair in ipairs({
            {"BCBBgAlphaSlider", defaults.bgAlpha},
            {"BCBBorderAlphaSlider", defaults.borderAlpha},
            {"BCBBgBrightnessSlider", 1},
            {"BCBBorderBrightnessSlider", 1},
        }) do
            if _G[pair[1]] then _G[pair[1]]:SetValue(pair[2]) end
        end

        print(L["SLASH_APPEARANCE_RESET"])
    end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

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
