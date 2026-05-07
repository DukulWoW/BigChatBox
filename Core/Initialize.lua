-- BigChatBox Core/Initialize.lua — Main startup sequence
-- Called from Core/Events.lua on PLAYER_LOGIN.
-- Wires all modules together in the correct order.
-- Non-critical features are wrapped in pcall so one failing module can't crash
-- the entire addon.

local BCB = BigChatBox
local L = BCB.L

local function SafeCall(name, func, ...)
    local ok, err = pcall(func, ...)
    if not ok then
        BCB:Print("|cffff6666Warning:|r " .. name .. " failed to load: " .. tostring(err))
    end
    return ok
end

function BCB.Initialize()
    -- 1. Database (must be first — all other modules read BigChatBoxDB)
    BCB.InitializeDB()

    -- 2. Main frame + editbox (critical — addon doesn't work without these)
    BCB.CreateBigChatBox()
    BCB.CreateChannelDisplay(BCB.frame)
    BCB.CreateEditBox(BCB.frame)
    BCB.SetupEditBoxHandlers()
    BCB.SetupEditBoxHooks()  -- must come AFTER SetupEditBoxHandlers (registers OnTextChanged hooks)
    BCB.SetupMovement()

    -- 2b. Apply saved visual settings (backdrop, bgScale, channel tint, etc.)
    if BCB.UpdateBackdrop then BCB.UpdateBackdrop() end
    if BCB.UpdateFontSize then BCB.UpdateFontSize() end
    if BCB.UpdateChannelFontSize then BCB.UpdateChannelFontSize() end

    -- 3. Features (non-critical — wrapped in pcall)
    if BCB.CreateAutocompleteSystem then
        SafeCall("Autocomplete", BCB.CreateAutocompleteSystem)
    end
    if BCB.SetupLinkHover then
        SafeCall("LinkHover", BCB.SetupLinkHover)
    end
    if BCB.MigrateSnippets then
        SafeCall("Snippets", BCB.MigrateSnippets)
    end
    if BCB.SetupEmojiIcon then
        SafeCall("EmojiPicker", BCB.SetupEmojiIcon)
    end

    -- 4. Hooks (must come after frame creation — critical for chat interception)
    BCB.HookDefaultEditBox()

    -- 5. Slash commands
    BCB.RegisterSlashCommands()

    -- 6. Minimap button (non-critical)
    if BCB.InitMinimapButton then
        SafeCall("Minimap", BCB.InitMinimapButton)
    end

    -- 7. Login message
    if not BigChatBoxDB.hideLoginMessage then
        print(string.format(L["LOADED_MSG"], BCB.ADDON_VERSION))
    end

    -- 8. Welcome panel (first-run setup wizard, v5.5.0)
    if not BigChatBoxDB.setupComplete and BCB.ShowWelcomePanel then
        C_Timer.After(0.5, function()
            SafeCall("WelcomePanel", BCB.ShowWelcomePanel)
        end)
    end

    -- 9. Patch notes popup — show once per version after first login (v5.6.0)
    -- Delayed 2s so it appears after the welcome panel / initial UI settle.
    if BCB.PATCH_NOTES and BCB.PATCH_NOTES[1] then
        local currentVer = BCB.PATCH_NOTES[1].version
        if BigChatBoxDB.seenPatchVersion ~= currentVer then
            C_Timer.After(2, function()
                if BCB.ShowPatchNotesPopup then
                    SafeCall("PatchNotesPopup", BCB.ShowPatchNotesPopup)
                end
            end)
        end
    end

    -- 10. Auto-open config if flagged (from welcome panel "Config" button)
    if BigChatBoxDB.openConfigOnLogin then
        BigChatBoxDB.openConfigOnLogin = false
        C_Timer.After(1, function()
            if BCB.OpenConfigWindow then BCB.OpenConfigWindow() end
        end)
    end
end
