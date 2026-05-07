-- BigChatBox Core/Events.lua — Central event frame & dispatcher
-- One event frame for the entire addon instead of scattered frames per module.
-- Also handles the lockdown state machine (M+/arena/BG transitions).

local BCB = BigChatBox
local defaults = BCB.defaults

--------------------------------------------------------------------------------
-- EVENT BUS
-- Modules register callbacks via BCB.RegisterEvent(event, callback).
-- All events funnel through a single frame.
--------------------------------------------------------------------------------
local eventFrame = CreateFrame("Frame")
local handlers = {}

function BCB.RegisterEvent(event, callback)
    eventFrame:RegisterEvent(event)
    handlers[event] = handlers[event] or {}
    table.insert(handlers[event], callback)
end

function BCB.UnregisterEvent(event)
    eventFrame:UnregisterEvent(event)
end

eventFrame:SetScript("OnEvent", function(self, event, ...)
    for _, handler in ipairs(handlers[event] or {}) do
        handler(event, ...)
    end
end)

-- Expose for modules that need direct access
BCB.eventFrame = eventFrame

--------------------------------------------------------------------------------
-- WHISPER TRACKING
-- Tracks incoming/outgoing whispers for the Recent Whispers list.
--------------------------------------------------------------------------------
local function OnWhisperEvent(event, msg, sender, ...)
    if not BigChatBoxDB then return end
    if sender and sender ~= "" then
        local name = Ambiguate and Ambiguate(sender, "none") or sender
        BCB.AddToWhisperHistory(name)
    end
end

BCB.RegisterEvent("CHAT_MSG_WHISPER", OnWhisperEvent)
BCB.RegisterEvent("CHAT_MSG_WHISPER_INFORM", OnWhisperEvent)

-- BNet whisper events — retail only (Classic has no Battle.net whisper system)
if not BCB._classicNoBNet then
    BCB.RegisterEvent("CHAT_MSG_BN_WHISPER", OnWhisperEvent)
    BCB.RegisterEvent("CHAT_MSG_BN_WHISPER_INFORM", OnWhisperEvent)
end

--------------------------------------------------------------------------------
-- LOCKDOWN STATE MACHINE
-- Tracks transitions between Normal → Combat → Lockdown modes.
-- Shows user-facing messages and auto-hides BCB when entering lockdown.
--
--   Normal:   Full BCB features, route through Blizzard editbox
--   Combat:   BCB works but InCombatLockdown() gates SetAttribute
--   Lockdown: M+/Arena/Rated BG — BCB passes through entirely
--------------------------------------------------------------------------------
local wasInLockdown = false

local function HideBCBForLockdown()
    if BCB.frame and BCB.frame:IsShown() then
        BCB.frame:Hide()
        if BCB.editBox then BCB.editBox:SetText(""); BCB.editBox:ClearFocus() end
    end
end

local function GetContentName()
    if C_ChallengeMode and C_ChallengeMode.IsChallengeModeActive and C_ChallengeMode.IsChallengeModeActive() then
        return "M+ keystone"
    end
    local _, instanceType = IsInInstance()
    if instanceType == "arena" then return "arena" end
    if instanceType == "pvp" then return "rated battleground" end
    return "restricted content"
end

local function ShouldWarn()
    return BigChatBoxDB.showLockdownWarning == nil or BigChatBoxDB.showLockdownWarning
end

-- ADDON_LOADED / PLAYER_LOGIN — initialization triggers
BCB.RegisterEvent("ADDON_LOADED", function(event, arg1)
    -- Reserved for future use (DB migration on load, etc.)
end)

BCB.RegisterEvent("PLAYER_LOGIN", function()
    C_Timer.After(1, function()
        if BCB.Initialize then BCB.Initialize() end
    end)
end)

-- M+ keystone lifecycle — retail only (Classic has no Mythic+)
if not BCB.IsClassic then
    BCB.RegisterEvent("CHALLENGE_MODE_START", function()
        HideBCBForLockdown()
        wasInLockdown = true
        if ShouldWarn() then
            print("|cff00ff00BigChatBox|r: M+ keystone active — using Blizzard's default chat box for this run.")
        end
    end)

    BCB.RegisterEvent("CHALLENGE_MODE_COMPLETED", function()
        if wasInLockdown then
            wasInLockdown = false
            BCB._lockdownNotified = false
            if ShouldWarn() then
                print("|cff00ff00BigChatBox|r: Keystone complete — BigChatBox is active again.")
            end
        end
    end)

    BCB.RegisterEvent("CHALLENGE_MODE_RESET", function()
        if wasInLockdown then
            wasInLockdown = false
            BCB._lockdownNotified = false
            if ShouldWarn() then
                print("|cff00ff00BigChatBox|r: Keystone complete — BigChatBox is active again.")
            end
        end
    end)
end

-- Combat end — reset notification flag
BCB.RegisterEvent("PLAYER_REGEN_ENABLED", function()
    if not BCB.IsSecureContentActive() then
        BCB._lockdownNotified = false
    end
end)

-- Zone transitions (arena enter/leave, BG enter/leave)
BCB.RegisterEvent("PLAYER_ENTERING_WORLD", function()
    C_Timer.After(1, function()
        local inLockdown = BCB.IsSecureContentActive()
        if inLockdown and not wasInLockdown then
            wasInLockdown = true
            HideBCBForLockdown()
            if ShouldWarn() then
                print("|cff00ff00BigChatBox|r: " .. GetContentName() .. " detected — using Blizzard's default chat box.")
            end
        elseif not inLockdown and wasInLockdown then
            wasInLockdown = false
            BCB._lockdownNotified = false
            if ShouldWarn() then
                print("|cff00ff00BigChatBox|r: BigChatBox is active again.")
            end
        end
    end)
end)
