-- BigChatBox Core/Security.lua — Taint Firewall
--
-- ██  CRITICAL FILE  ██
-- This is the single source of truth for ALL taint / lockdown detection.
-- Other modules call these functions — they must NEVER inline their own checks.
-- If Blizzard changes taint behavior in a future patch, this is the ONE file
-- to update.
--
-- BACKGROUND (Midnight 12.0):
--   ChatFrame1EditBox is a secure frame that processes /target, /cast, /focus.
--   In M+ keystones, arenas, and rated BGs a broader lockdown than
--   InCombatLockdown() blocks any tainted secure frame interactions.
--   HookScript("OnShow") on this frame creates taint at registration time.
--   If BCB tries to interact with ChatFrame1EditBox during lockdown, it kills
--   the ENTIRE chat system — not just BCB.
--
-- STRATEGY:
--   1. Detect lockdown state via multiple signals
--   2. Every hook and interaction with Blizzard frames checks this FIRST
--   3. During lockdown, BCB passes through and lets Blizzard handle everything

local BCB = BigChatBox

--------------------------------------------------------------------------------
-- IsSecureContentActive()
-- Returns true when BCB must NOT touch any Blizzard secure frames.
-- This covers M+ keystones, arenas, rated BGs, AND combat.
--
-- Check order matters — cheapest checks first:
--   1. InCombatLockdown()         — fastest, covers most cases
--   2. C_ChatInfo messaging lock  — Blizzard's own "don't touch chat" signal
--   3. C_ChallengeMode active     — M+ keystone running
--   4. Instance type checks       — arena / rated BG
--------------------------------------------------------------------------------
local function IsSecureContentActive()
    -- Combat lockdown as first check (fastest)
    if InCombatLockdown() then return true end

    -- Blizzard's chat messaging lockdown API (Midnight)
    if C_ChatInfo and C_ChatInfo.InChatMessagingLockdown then
        if C_ChatInfo.InChatMessagingLockdown() then return true end
    end

    -- Active M+ keystone
    if C_ChallengeMode and C_ChallengeMode.IsChallengeModeActive then
        if C_ChallengeMode.IsChallengeModeActive() then return true end
    end

    -- Arena or rated BG
    local _, instanceType = IsInInstance()
    if instanceType == "arena" then return true end
    if instanceType == "pvp" and C_PvP and C_PvP.IsRatedBattleground then
        if C_PvP.IsRatedBattleground() then return true end
    end

    return false
end

-- Expose on namespace
BCB.IsSecureContentActive = IsSecureContentActive

--------------------------------------------------------------------------------
-- IsSafeToTouchBlizzard()
-- Convenience wrapper: true when it's safe to call SetAttribute, SetText,
-- Hide, Show, etc. on ChatFrame1EditBox and write ACTIVE_CHAT_EDIT_BOX.
-- Identical to "not IsSecureContentActive()" — exists for readability.
--------------------------------------------------------------------------------
function BCB.IsSafeToTouchBlizzard()
    return not IsSecureContentActive()
end

--------------------------------------------------------------------------------
-- Lockdown notification state
-- Used by Editbox/ChatIntercept.lua to show one-time warnings per lockdown.
--------------------------------------------------------------------------------
BCB._lockdownNotified = false
