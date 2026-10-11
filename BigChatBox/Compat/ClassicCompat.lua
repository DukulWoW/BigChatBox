-- BigChatBox Compat/ClassicCompat.lua — Classic client compatibility shim
--
-- Loaded FIRST (before any other BCB file except Init.lua) in all Classic TOC files.
-- Sets BCB.IsClassic = true and patches APIs that differ from Midnight retail.
--
-- Clients covered: TBC Anniversary (20505), Mists Classic (50503), Vanilla Era (11508)
--
-- Patches applied here:
--   1. C_UI.Reload()          — doesn't exist; forward to ReloadUI()
--   2. IsSecureContentActive() — always false: no Midnight lockdown on Classic
--   3. BNet whisper APIs      — absent; SendDirect falls through gracefully already
--   4. CHALLENGE_MODE events  — not registered on Classic (handled by flag check)
--   5. Locale                 — LoadSavedVariablesFirst:1 ignored; use GetLocale()
--   6. Config slider widget   — no patch: the modern template exists on Classic too
--   7. Config dropdown widget — WowStyle1DropdownTemplate absent; custom build
--   8. AddonCompartment       — not registered (omitted from Classic TOC)

BigChatBox = BigChatBox or {}
local BCB = BigChatBox

-- ─── Identity flag ──────────────────────────────────────────────────────────
BCB.IsClassic = true

-- ─── 1. C_UI.Reload ─────────────────────────────────────────────────────────
-- Classic clients have ReloadUI() as a global, not C_UI.Reload().
if not C_UI then
    C_UI = {}
end
if not C_UI.Reload then
    C_UI.Reload = function() ReloadUI() end
end

-- ─── 2. IsSecureContentActive override ──────────────────────────────────────
-- BCB never needs to pause on Classic. The pause exists for Midnight's chat
-- restrictions (chat messaging lockdown in encounters, M+ and PvP; tainted chat
-- edit boxes blocking SendChatMessage), which are on Retail and Forever only.
-- Classic got Midnight's UI (nameplates, raid frames, Edit Mode), not those
-- restrictions, and ChatFrame1EditBox is not a protected frame there. Tested in
-- combat on MoP Classic with no blocked actions (2026-09-30); TBC and Era to confirm.
-- (Before 6.1.0 this returned InCombatLockdown(), so BCB stepped aside in combat.)
-- Keybinding code still checks InCombatLockdown() itself: SetBinding is blocked in
-- combat on every client.
-- We override after BCB.IsSecureContentActive is defined in Security.lua.
-- Use an Event hook so it runs after all files have loaded.
local _securityPatchFrame = CreateFrame("Frame")
_securityPatchFrame:RegisterEvent("ADDON_LOADED")
_securityPatchFrame:SetScript("OnEvent", function(self, event, addonName)
    if addonName == "BigChatBox" then
        -- Override: no lockdown on Classic
        BCB.IsSecureContentActive = function()
            return false
        end
        BCB.IsSafeToTouchBlizzard = function()
            return true
        end
        self:UnregisterEvent("ADDON_LOADED")
    end
end)

-- ─── 3. BNet whisper stubs ───────────────────────────────────────────────────
-- Classic has no Battle.net whisper system. BCB.SendDirect already falls
-- through to SendChatMessage when BNet APIs are nil, so no extra stub needed.
-- Guard the event registrations in Events.lua that reference BN events:
BCB._classicNoBNet = true  -- checked by Events.lua

-- ─── 4. CHALLENGE_MODE event guard ──────────────────────────────────────────
-- Events.lua registers CHALLENGE_MODE_START/COMPLETED/RESET.
-- Classic clients will silently never fire these events, which is fine.
-- No action needed.

-- ─── 5. Locale — use client locale directly ─────────────────────────────────
-- LoadSavedVariablesFirst:1 is a Midnight-only TOC directive.
-- On Classic, BigChatBoxLocale SavedVariable loads AFTER Lua files, so it's
-- nil when locale files run. We set a flag so AdvancedTab doesn't offer the
-- language override option (since it can't work reliably).
BCB.IsClassicLocale = true  -- AdvancedTab checks this to hide language selector

-- ─── 6. Classic slider widget ────────────────────────────────────────────────
-- No longer needed: the Classic clients ship MinimalSliderWithSteppersTemplate,
-- so Config.CreateSlider uses it everywhere (as BNB does). The hand-built Classic
-- slider was removed 2026-10-11 (ALL-07).
-- Scroll bars likewise: BCB.CreateScrollFrame (Utils.lua) swaps Classic's wide
-- WoWClassicScrollBar for MinimalScrollBar.

-- ─── 7. Classic dropdown widget ──────────────────────────────────────────────
-- WowStyle1DropdownTemplate does not exist in Classic.
-- The existing fallback in ConfigWidgets.lua handles this already via:
--   local useNative = C_XMLUtil and C_XMLUtil.GetTemplateInfo and ...
-- Classic clients don't have C_XMLUtil, so useNative = nil = false.
-- The existing custom popup fallback will be used. No extra stub needed.

-- ─── 8. ButtonFrameTemplate helpers ─────────────────────────────────────────
-- ButtonFrameTemplate_HidePortrait and ButtonFrameTemplate_HideButtonBar
-- may not exist in very old clients. Stub them defensively.
if not ButtonFrameTemplate_HidePortrait then
    ButtonFrameTemplate_HidePortrait = function(f)
        if f and f.portrait then f.portrait:Hide() end
    end
end
if not ButtonFrameTemplate_HideButtonBar then
    ButtonFrameTemplate_HideButtonBar = function(f)
        if f and f.ButtonBar then f.ButtonBar:Hide() end
    end
end

-- ─── 9. Ambiguate stub ───────────────────────────────────────────────────────
-- Ambiguate() cleans server-realm suffixes from names. Available in TBC/MoP/Vanilla
-- but stub it just in case a very old build is missing it.
if not Ambiguate then
    Ambiguate = function(name, _) return name end
end

-- ─── 10. StaticPopupDialogs helpers ─────────────────────────────────────────
-- preferredIndex is ignored on older clients — harmless.

-- ─── 11. WHITE_FONT_COLOR stub ───────────────────────────────────────────────
-- Used by the retail slider formatter. Stub for Classic.
if not WHITE_FONT_COLOR then
    WHITE_FONT_COLOR = {
        WrapTextInColorCode = function(self, text)
            return "|cffffffff" .. text .. "|r"
        end
    }
end

-- ─── 12. Multiline and retail-only binding stubs ────────────────────────────
-- MultilineBox.lua is not loaded on Classic. Stub the global so the keybinding
-- defined in Bindings.xml doesn't throw an error if triggered somehow.
function BCB_OpenMultiline()
    -- Multiline box is not available in Classic — silently do nothing.
end

-- Bindings.xml is processed before Lua runs so we can't conditionally omit
-- bindings per client. Instead we clear both retail-only bindings on Classic
-- so Shift+Enter and Ctrl+Enter fall through to whatever the user has bound.
-- We defer to PLAYER_LOGIN so SavedVariables (binding set) are loaded first.
local _bindingClearFrame = CreateFrame("Frame")
_bindingClearFrame:RegisterEvent("PLAYER_LOGIN")
_bindingClearFrame:SetScript("OnEvent", function(self)
    -- Clear BIGCHATBOX_OPEN_MULTILINE (Shift+Enter default) — multiline not available on Classic yet.
    -- Only when something is bound, and never in combat, where SetBinding is blocked (CMPT-09).
    local k1, k2 = GetBindingKey("BIGCHATBOX_OPEN_MULTILINE")
    if not (k1 or k2) then self:UnregisterAllEvents(); return end
    if InCombatLockdown() then self:RegisterEvent("PLAYER_REGEN_ENABLED"); return end
    if k1 then SetBinding(k1, nil) end
    if k2 then SetBinding(k2, nil) end
    -- BIGCHATBOX_USE_BLIZZARD_CHAT (Ctrl+Enter default) — keep this on Classic.
    -- It opens ChatFrame1EditBox directly, which is exactly what Classic users need
    -- to shift-click items, spells, and achievements into chat.
    SaveBindings(GetCurrentBindingSet())
    self:UnregisterAllEvents()
end)
