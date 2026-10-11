-- BigChatBox Core/Events.lua — Central event frame & dispatcher
-- One event frame for the entire addon instead of scattered frames per module.
-- Also handles the lockdown state machine (M+/arena/BG transitions).

local BCB = BigChatBox
local L = BCB.L

--------------------------------------------------------------------------------
-- EVENT BUS
-- Modules register callbacks via BCB.RegisterEvent(event, callback).
-- All events funnel through a single frame.
--------------------------------------------------------------------------------
local eventFrame = CreateFrame("Frame")
local handlers = {}

-- Registering an event this client does not know throws and aborts the calling
-- file (seen on WoW Forever). Skip it and report once instead (FOR-04).
local function CanRegister(event)
    if C_EventUtils and C_EventUtils.IsEventValid then return C_EventUtils.IsEventValid(event) end
    return true
end

function BCB.SafeRegisterEvent(frame, event)
    if not CanRegister(event) then
        geterrorhandler()("BigChatBox: event " .. tostring(event) .. " is unknown on this client, skipped")
        return false
    end
    local ok, err = pcall(frame.RegisterEvent, frame, event)
    if not ok then geterrorhandler()(err) end
    return ok
end

function BCB.RegisterEvent(event, callback)
    if not handlers[event] then
        if not BCB.SafeRegisterEvent(eventFrame, event) then return end
        handlers[event] = {}
    end
    table.insert(handlers[event], callback)
end

-- Removes one handler; the frame event is unregistered only when none are left.
function BCB.UnregisterEvent(event, callback)
    local list = handlers[event]
    if not list then return end
    for i = #list, 1, -1 do
        if list[i] == callback then table.remove(list, i) end
    end
    if #list == 0 then
        handlers[event] = nil
        eventFrame:UnregisterEvent(event)
    end
end

-- Each handler runs protected: one failing handler is reported and the others
-- for the same event still run (ARCH-01).
eventFrame:SetScript("OnEvent", function(self, event, ...)
    for _, handler in ipairs(handlers[event] or {}) do
        local ok, err = pcall(handler, event, ...)
        if not ok then geterrorhandler()(err) end
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
    -- Midnight restrictions can hand addons "secret" values that cannot be compared
    -- or stored; skip those rather than erroring on every whisper (DEP-02, FOR-07).
    if issecretvalue and issecretvalue(sender) then return end
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
        return L["LOCKDOWN_CONTENT_KEYSTONE"]
    end
    local _, instanceType = IsInInstance()
    if instanceType == "arena" then return L["LOCKDOWN_CONTENT_ARENA"] end
    if instanceType == "pvp" then return L["LOCKDOWN_CONTENT_RATED_BG"] end
    return L["LOCKDOWN_CONTENT_OTHER"]
end

local function ShouldWarn()
    return BigChatBoxDB.showLockdownWarning == nil or BigChatBoxDB.showLockdownWarning
end

-- ADDON_LOADED / PLAYER_LOGIN — initialization triggers
-- SavedVariables are available at our ADDON_LOADED: fill in defaults and run
-- migrations there, so event handlers never see a half-empty table (SV-01).
BCB.RegisterEvent("ADDON_LOADED", function(event, name)
    if name == BCB.ADDON_NAME and BCB.InitializeDB then BCB.InitializeDB() end
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
            BCB:Print(L["LOCKDOWN_KEYSTONE_START"])
        end
    end)

    BCB.RegisterEvent("CHALLENGE_MODE_COMPLETED", function()
        if wasInLockdown then
            wasInLockdown = false
            BCB._lockdownNotified = false
            if ShouldWarn() then
                BCB:Print(L["LOCKDOWN_KEYSTONE_DONE"])
            end
        end
    end)

    BCB.RegisterEvent("CHALLENGE_MODE_RESET", function()
        if wasInLockdown then
            wasInLockdown = false
            BCB._lockdownNotified = false
            if ShouldWarn() then
                BCB:Print(L["LOCKDOWN_KEYSTONE_DONE"])
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
                BCB:Print(string.format(L["LOCKDOWN_DETECTED"], GetContentName()))
            end
        elseif not inLockdown and wasInLockdown then
            wasInLockdown = false
            BCB._lockdownNotified = false
            if ShouldWarn() then
                BCB:Print(L["LOCKDOWN_ACTIVE_AGAIN"])
            end
        end
    end)
end)
