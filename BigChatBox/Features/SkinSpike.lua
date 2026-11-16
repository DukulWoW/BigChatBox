-- BigChatBox Features/SkinSpike.lua - ALL-11 research spike: type into Blizzard's own box, skinned
--
-- THROWAWAY PROTOTYPE. Off unless turned on with /bcbspike on (it reloads the UI).
-- Remove or replace before any release that is not meant to carry it.
--
-- The question it answers: can BCB move and skin ChatFrame1EditBox (the Chattynator way)
-- and keep its features on top, without taint, through a raid encounter lockdown?
-- Enter is always Blizzard's, so every slash command runs in Blizzard's own code.
--
-- When the spike is on:
--   * Core/Initialize.lua skips BCB.HookDefaultEditBox() (no OnShow hook on Blizzard's box)
--     and calls BCB.StartSkinSpike() instead.
--   * BCB's own box is switched off: BCB.frame:Show and BCB.editBox:SetFocus become no-ops
--     on BCB's own widgets, so BCB's file-level hooks (whisper, channel and link clicks) can
--     never open it; BCB.SyncChatTypeToBlizzard and the two key bindings do nothing.
--   * ChatFrame1EditBox is moved to BCB's position and size, given BCB's font and backdrop
--     (out of lockdown only), and gets three read-mostly additions:
--       1. a character counter (HookScript OnTextChanged, reads only)
--       2. sent-message capture (hooksecurefunc AddHistoryLine, reads only)
--       3. snippet expansion on send (EventRegistry "ChatFrame.OnEditBoxPreSendText",
--          Blizzard's own hook for final edits; writes the text, never in lockdown)
--     /bcbspike hooks off turns 1-3 off (after a reload) for an A/B test, and the position fight too.
--   * Position fight: when another chat addon (Pigeon, ...) moves the box, the spike logs who and
--     puts it back next frame, with a brake (see POSITION FIGHT). Off by default (Dukul, 2026-11-16): /bcbspike fight on.
--   * A log in BigChatBoxDB.spikeLog records lockdown changes, every send, taint probes
--     after each send, Blizzard re-anchoring the box, and ADDON_ACTION_BLOCKED/FORBIDDEN.
--
-- Retail and WoW Forever only (Classic has no chat lockdown; Dukul, 2026-11-16).
-- Plain ASCII strings, English only: this file is a dev tool, not localized.

local BCB = BigChatBox
if BCB.IsClassic then return end

local LOG_MAX = 300
local PREFIX  = "|cff5599ffBCB spike:|r "

local function Say(msg) print(PREFIX .. msg) end
local function IsSecret(v) return issecretvalue ~= nil and issecretvalue(v) end

-- BCB's real lockdown check, kept before anything can wrap it
local function InLockdown()
    return BCB.IsSecureContentActive and BCB.IsSecureContentActive() or false
end

local function LockdownFlags()
    local chat = C_ChatInfo and C_ChatInfo.InChatMessagingLockdown and C_ChatInfo.InChatMessagingLockdown() or false
    local key  = C_ChallengeMode and C_ChallengeMode.IsChallengeModeActive and C_ChallengeMode.IsChallengeModeActive() or false
    local enc  = IsEncounterInProgress and IsEncounterInProgress() or false
    return InCombatLockdown() and true or false, chat and true or false, key and true or false, enc and true or false
end

local function FlagString()
    local combat, chat, key, enc = LockdownFlags()
    return string.format("combat=%s chat=%s key=%s enc=%s",
        combat and "Y" or "n", chat and "Y" or "n", key and "Y" or "n", enc and "Y" or "n")
end

local function Log(kind, msg)
    local db = BigChatBoxDB
    if not db then return end
    db.spikeLog = db.spikeLog or {}
    local log = db.spikeLog
    log[#log + 1] = string.format("%s %s [%s] %s", date("%H:%M:%S"), kind, FlagString(), msg or "")
    while #log > LOG_MAX do table.remove(log, 1) end
end

function BCB.SkinSpikeActive()
    return BigChatBoxDB and BigChatBoxDB.spikeSkinMode == true
end

local function HooksOn()
    return not (BigChatBoxDB and BigChatBoxDB.spikeNoHooks)
end

--------------------------------------------------------------------------------
-- TAINT PROBES: issecurevariable on what Blizzard's send path reads.
-- A tainted entry names the addon that wrote it last.
--------------------------------------------------------------------------------
local GLOBAL_PROBES = { "ACTIVE_CHAT_EDIT_BOX", "LAST_ACTIVE_CHAT_EDIT_BOX" }
local FIELD_PROBES  = { "ignoreTextChange", "lastTabComplete", "tabCompleteText",
                        "tabCompleteTableIndex", "command", "setText", "text", "chatFrame" }

local function TaintReport()
    local bad = {}
    for _, name in ipairs(GLOBAL_PROBES) do
        local ok, by = issecurevariable(name)
        if not ok then bad[#bad + 1] = name .. "<" .. tostring(by) end
    end
    local eb = ChatFrame1EditBox
    if eb then
        for _, key in ipairs(FIELD_PROBES) do
            local ok, by = issecurevariable(eb, key)
            if not ok then bad[#bad + 1] = "eb." .. key .. "<" .. tostring(by) end
        end
    end
    return #bad == 0 and "clean" or ("TAINTED " .. table.concat(bad, ", "))
end

--------------------------------------------------------------------------------
-- LOOK: position, size, scale, font, backdrop (all from BCB's settings)
--------------------------------------------------------------------------------
local skin            -- our backdrop frame, child of ChatFrame1EditBox
local counter         -- our counter font string
local applied = false -- position applied at least once
local stats = { presend = 0, expanded = 0, sends = 0, reanchor = 0, blocked = 0 }

local BLIZZ_TEXTURES = { "Left", "Right", "Mid", "FocusLeft", "FocusRight", "FocusMid" }

local function FontArgs()
    local db, d = BigChatBoxDB, BCB.defaults
    local fontPath = db.font or d.font
    local fontSize = db.fontSize or d.fontSize
    if fontPath == d.font or fontPath == "Fonts\\FRIZQT__.TTF" then
        local cjk = BCB.GetUIFont and BCB.GetUIFont()
        if cjk and cjk ~= d.font then fontPath = cjk end
    end
    local outline, flags = db.fontOutline or "None", ""
    if     outline == "Outline"            then flags = "OUTLINE"
    elseif outline == "Thick Outline"      then flags = "THICKOUTLINE"
    elseif outline == "Monochrome Outline" then flags = "MONOCHROME,OUTLINE"
    end
    return fontPath, fontSize, flags
end

-- Same backdrop as BCB.UpdateBackdrop (Editbox/Editbox.lua), minus the channel tint
local function ApplyBackdrop(f)
    local db, d = BigChatBoxDB, BCB.defaults
    local bgTex, borderTex = db.bgTexture or d.bgTexture, db.borderTexture or d.borderTexture
    if bgTex == "" or db.bgTextureName == "None" then bgTex = nil end
    if borderTex == "" or db.borderTextureName == "None" then borderTex = nil end
    local inset = 4 + ((1 - (db.bgScale or 100) / 100) * 20)
    f:SetBackdrop({
        bgFile = bgTex, edgeFile = borderTex, tile = false, tileSize = 0,
        edgeSize = borderTex and (db.borderThickness or 16) or 0,
        insets = { left = inset, right = inset, top = inset, bottom = inset },
    })
    local c, bc = db.bgColor or d.bgColor, db.borderColor or { r = 1, g = 1, b = 1 }
    f:SetBackdropColor(c.r, c.g, c.b, db.bgAlpha or d.bgAlpha)
    f:SetBackdropBorderColor(bc.r, bc.g, bc.b, db.borderAlpha or d.borderAlpha or 1)
end

-- Blizzard's "im" chat style never hides the box when chat closes: Deactivate keeps it shown
-- at alpha 0.35 with the text cleared and the header hidden (the FOR-11 behaviour; BCB's normal
-- mode hides the box, which the spike skips). Hide only our own skin and counter while the box
-- has no focus, so the idle box is invisible without touching Blizzard's frame.
local function UpdateIdle()
    local eb = ChatFrame1EditBox
    local active = eb and eb:HasFocus()
    if skin then skin:SetShown(active) end
    if counter then counter:SetShown(active) end
end

-- BCB's saved position: point, x, y relative to the same point of UIParent (SV-02)
local function OurPoint()
    local db, p = BigChatBoxDB, BCB.defaults.position
    return db.point or p.point, db.x or p.x, db.y or p.y
end

-- True when the box sits exactly where BCB puts it (another addon may anchor to UIParent too)
local function IsOurAnchor(eb)
    if eb:GetNumPoints() ~= 1 then return false end
    local point, rel, relPoint, x, y = eb:GetPoint(1)
    local ourPoint, ourX, ourY = OurPoint()
    return rel == UIParent and point == ourPoint and relPoint == ourPoint
        and math.abs((x or 0) - ourX) < 0.5 and math.abs((y or 0) - ourY) < 0.5
end

local ownMove = false   -- true while the spike itself calls SetPoint (the hook ignores it)

-- The widget's own methods from its metatable. Another addon may post-hook the box's SetPoint and
-- re-place the box from inside our call (Pigeon does: Chat/EditBox.lua, "The default UI re-anchors
-- the box from time to time; put it back"), so through eb:SetPoint the other addon always wins.
-- Calling the metatable method moves the box without running any instance hook, ours included.
-- Same C function, no taint difference.
local function Raw(eb, method)
    local mt = getmetatable(eb)
    local idx = mt and mt.__index
    local f = type(idx) == "table" and idx[method]
    return f or eb[method]
end

local function ApplyPosition()
    local eb = ChatFrame1EditBox
    local point, x, y = OurPoint()
    -- Another addon may have reparented the box (Pigeon: its chat frame). Keep BCB's size on
    -- screen whatever the parent's scale is.
    local parent = eb:GetParent()
    local scale = (BigChatBoxDB.scale or 1)
    if parent and parent ~= UIParent and parent.GetEffectiveScale then
        scale = scale * UIParent:GetEffectiveScale() / parent:GetEffectiveScale()
    end
    ownMove = true
    Raw(eb, "SetScale")(eb, scale)
    Raw(eb, "ClearAllPoints")(eb)
    Raw(eb, "SetPoint")(eb, point, UIParent, point, x, y)
    Raw(eb, "SetSize")(eb, BCB.frame:GetSize())
    ownMove = false
    eb:SetClampedToScreen(true)
end

-- Out of lockdown only. Returns true when it touched the box.
local function ApplyLook(reason)
    local eb = ChatFrame1EditBox
    if not eb or not BCB.frame then return false end
    if InLockdown() then
        Log("skip", "look not applied in lockdown (" .. reason .. ")")
        return false
    end
    local db, d = BigChatBoxDB, BCB.defaults
    ApplyPosition()

    local font, size, flags = FontArgs()
    eb:SetFont(font, size, flags)
    local header = _G[eb:GetName() .. "Header"]
    if header then header:SetFont(font, db.channelFontSize or size, "") end

    for _, suffix in ipairs(BLIZZ_TEXTURES) do
        local tex = _G[eb:GetName() .. suffix]
        if tex then tex:SetAlpha(0) end
    end

    if not skin then
        skin = CreateFrame("Frame", nil, eb, "BackdropTemplate")
        skin:SetAllPoints(eb)
        skin:EnableMouse(false)
    end
    skin:SetFrameLevel(math.max(0, eb:GetFrameLevel() - 1))
    skin:SetAlpha(db.alpha or d.alpha or 1)   -- BCB's opacity, on our own frame only
    ApplyBackdrop(skin)

    if HooksOn() and not counter then
        counter = eb:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        counter:SetPoint("BOTTOMRIGHT", eb, "BOTTOMRIGHT", -8, 4)
        counter:SetText("")
    end

    if not applied then Log("look", "applied (" .. reason .. ")") end
    applied = true
    UpdateIdle()
    return true
end

--------------------------------------------------------------------------------
-- POSITION FIGHT: another addon (Pigeon, Chattynator, ElvUI, ...) moving the box.
-- Dukul wants BCB's position to win (2026-11-16). A post-hook on the box's SetPoint names the
-- mover (once per addon) and puts the box back next frame. Brake: 6 put-backs in 3 seconds
-- and the spike gives up until the box next gets focus, so two addons never fight every frame.
-- Not in lockdown (caught up on the next PLAYER_REGEN_ENABLED / restriction change).
-- Off by default (Dukul, 2026-11-16: fighting breaks the other addon); /bcbspike fight on to try it.
--------------------------------------------------------------------------------
local FIGHT_MAX, FIGHT_WINDOW = 6, 3
local fightTimes, gaveUp, pending = {}, false, false
local movers = {}

local function FightOn() return BigChatBoxDB and BigChatBoxDB.spikeFight == true end

-- First addon folder on the stack that is not BCB's own; "Blizzard" when there is none
local function Mover()
    local stack = debugstack and debugstack(3, 12, 0) or ""
    for name in stack:gmatch("[Aa]dd[Oo]ns[/\\]([^/\\]+)[/\\]") do
        if name ~= BCB.ADDON_NAME and not name:match("^Blizzard_") then return name end
    end
    return "Blizzard"
end

local function PutBack()
    pending = false
    local eb = ChatFrame1EditBox
    if gaveUp or not FightOn() or InLockdown() or IsOurAnchor(eb) then return end
    local now = GetTime()
    while fightTimes[1] and now - fightTimes[1] > FIGHT_WINDOW do table.remove(fightTimes, 1) end
    if #fightTimes >= FIGHT_MAX then
        gaveUp = true
        Log("fight", "gave up: the box keeps being moved; again on next focus")
        Say("another addon keeps moving the chat box; BCB lets it be until the box opens again.")
        return
    end
    fightTimes[#fightTimes + 1] = now
    stats.putback = (stats.putback or 0) + 1
    ApplyPosition()
end

local function OnBoxMoved()
    if ownMove then return end
    local who = Mover()
    stats.moved = (stats.moved or 0) + 1
    if not movers[who] then
        movers[who] = true
        Log("moved", "SetPoint by " .. who)
    end
    if FightOn() and not pending and not gaveUp then
        pending = true
        C_Timer.After(0, PutBack)
    end
end

-- BCB's settings changing (Designer, Placement, styles): re-apply the look next frame.
-- Hooks on BCB's own functions and frame only. The Designer calls BCB.UpdateBackdrop() and
-- friends by name and sizes BCB.frame directly (Config/DesignerTab.lua, Config/Styles.lua).
local reapplyPending = false
local function ReapplySoon()
    if reapplyPending then return end
    reapplyPending = true
    C_Timer.After(0, function() reapplyPending = false; ApplyLook("settings") end)
end

local function FollowSettings()
    for _, fn in ipairs({ "UpdateBackdrop", "UpdateFontSize", "UpdateChannelFontSize",
                          "ApplyPosition", "ResetPosition", "UpdateDynamicHeight", "UpdateDynamicWidth" }) do
        if type(BCB[fn]) == "function" then hooksecurefunc(BCB, fn, ReapplySoon) end
    end
    BCB.frame:HookScript("OnSizeChanged", ReapplySoon)
end

-- Focus gained: reset the brake and check the position (an addon may move the box on open)
local function OnFocusChanged()
    UpdateIdle()
    local eb = ChatFrame1EditBox
    if eb and eb:HasFocus() then
        gaveUp = false
        if FightOn() and not IsOurAnchor(eb) and not pending then
            pending = true
            C_Timer.After(0, PutBack)
        end
    end
end

--------------------------------------------------------------------------------
-- HOOKS (all read-only except the pre-send snippet expansion)
--------------------------------------------------------------------------------
local function OnTextChanged(eb)
    if not counter then return end
    local text = eb:GetText()
    if IsSecret(text) then counter:SetText("?"); return end
    local n = text and #text or 0
    counter:SetText(n > 0 and (n .. "/255") or "")
    if n >= 240 then counter:SetTextColor(1, 0.3, 0.3) else counter:SetTextColor(0.6, 0.6, 0.6) end
end

local function OnAddHistoryLine(eb, text)
    stats.sends = stats.sends + 1
    local desc = IsSecret(text) and "secret" or (text and ("len " .. #text) or "nil")
    Log("send", desc .. "; probes " .. TaintReport())
end

local spikeOwner = {}
local function OnPreSendText(_, eb)
    stats.presend = stats.presend + 1
    if eb ~= ChatFrame1EditBox then return end
    if InLockdown() then Log("presend", "lockdown: no expansion"); return end
    local text = eb:GetText()
    if IsSecret(text) or not text or text == "" or not BCB.ExpandSnippets then return end
    local out = BCB.ExpandSnippets(text)
    if out == text then return end
    if out == nil then
        eb:SetText("")   -- throttled or blocked: Blizzard's SendText then sends nothing
        Log("presend", "snippet blocked")
        return
    end
    if #out > 255 then Log("presend", "snippet cut to 255 (was " .. #out .. ")") end
    eb:SetText(out)
    stats.expanded = stats.expanded + 1
    Log("presend", "snippet expanded, len " .. #out)
end

local function InstallHooks()
    local eb = ChatFrame1EditBox
    eb:HookScript("OnTextChanged", OnTextChanged)
    hooksecurefunc(eb, "AddHistoryLine", OnAddHistoryLine)
    if EventRegistry and EventRegistry.RegisterCallback then
        EventRegistry:RegisterCallback("ChatFrame.OnEditBoxPreSendText", OnPreSendText, spikeOwner)
    else
        Log("hooks", "no EventRegistry: snippet expansion unavailable")
    end
end

--------------------------------------------------------------------------------
-- BCB's own box out of the way (BCB-owned objects only; nothing of Blizzard's)
--------------------------------------------------------------------------------
local function DisableOwnBox()
    local noop = function() end
    BCB.frame.Show      = noop
    BCB.frame.SetShown  = noop
    BCB.editBox.SetFocus = noop
    BCB.SyncChatTypeToBlizzard = noop
    BCB._useBlizzardChat = true   -- the ChatFrame_OpenChat hook bails on this
    BCB_UseBlizzardChat = function() Say("Ctrl+Enter is off in the skin spike: Enter already opens Blizzard's box.") end
    BCB_OpenMultiline   = function() Say("The multi-line box is off in the skin spike.") end
end

--------------------------------------------------------------------------------
-- WATCHERS: lockdown changes, re-anchoring, blocked actions
--------------------------------------------------------------------------------
local lastFlags
local function WatchLockdown()
    local now = FlagString()
    if now ~= lastFlags then
        Log("state", (lastFlags and ("was " .. lastFlags) or "start") .. "; probes " .. TaintReport())
        lastFlags = now
    end
end

local watcher = CreateFrame("Frame")
local function OnWatcherEvent(_, event, a1, a2)
    if event == "ADDON_ACTION_BLOCKED" or event == "ADDON_ACTION_FORBIDDEN" then
        stats.blocked = stats.blocked + 1
        Log("BLOCKED", event .. " " .. tostring(a1) .. " " .. tostring(a2))
        if a1 == BCB.ADDON_NAME then
            Say("|cffff4444" .. event .. "|r " .. tostring(a2) .. " - logged, see /bcbspike log")
        end
    elseif event == "PLAYER_REGEN_ENABLED" or event == "ADDON_RESTRICTION_STATE_CHANGED" then
        WatchLockdown()
        if not IsOurAnchor(ChatFrame1EditBox) or not applied then ApplyLook(event) end
    elseif event == "PLAYER_ENTERING_WORLD" then
        C_Timer.After(0.5, function() ApplyLook(event) end)
    end
end

local function SafeWatch(event)
    if BCB.SafeRegisterEvent then return BCB.SafeRegisterEvent(watcher, event) end
    return pcall(watcher.RegisterEvent, watcher, event)
end

local function OnEditBoxShow(_, eb)
    if eb ~= ChatFrame1EditBox then return end
    if not IsOurAnchor(eb) then
        stats.reanchor = stats.reanchor + 1
        Log("anchor", "Blizzard re-anchored the box")
        ApplyLook("re-anchor")
    end
end

--------------------------------------------------------------------------------
-- START (called by Core/Initialize.lua instead of BCB.HookDefaultEditBox)
--------------------------------------------------------------------------------
function BCB.StartSkinSpike()
    if not ChatFrame1EditBox then Say("no ChatFrame1EditBox, spike not started"); return end
    DisableOwnBox()
    Log("start", "spike on, hooks " .. (HooksOn() and "on" or "off") .. ", fight " .. (FightOn() and "on" or "off")
        .. ", protected=" .. tostring(ChatFrame1EditBox:IsProtected()))
    if HooksOn() then
        InstallHooks()
        -- The position fight is a hook on Blizzard's box too, so "hooks off" turns it off as well
        hooksecurefunc(ChatFrame1EditBox, "SetPoint", OnBoxMoved)
        hooksecurefunc(ChatFrame1EditBox, "SetAllPoints", OnBoxMoved)
        hooksecurefunc(ChatFrame1EditBox, "SetParent", function(_, parent)
            Log("moved", "SetParent to " .. tostring(parent and parent.GetName and parent:GetName()) .. " by " .. Mover())
        end)
    end
    if EventRegistry and EventRegistry.RegisterCallback then
        EventRegistry:RegisterCallback("ChatFrame.OnEditBoxShow", OnEditBoxShow, watcher)
        EventRegistry:RegisterCallback("ChatFrame.OnEditBoxFocusGained", OnFocusChanged, watcher)
        EventRegistry:RegisterCallback("ChatFrame.OnEditBoxFocusLost", OnFocusChanged, watcher)
    end
    watcher:SetScript("OnEvent", OnWatcherEvent)
    for _, e in ipairs({ "ADDON_ACTION_BLOCKED", "ADDON_ACTION_FORBIDDEN", "PLAYER_REGEN_ENABLED",
                         "PLAYER_ENTERING_WORLD", "ADDON_RESTRICTION_STATE_CHANGED" }) do
        SafeWatch(e)
    end
    ApplyLook("login")
    FollowSettings()
    WatchLockdown()
    C_Timer.NewTicker(0.5, WatchLockdown)
    Say("ON. Typing goes into Blizzard's box with BCB's look. /bcbspike for commands.")
end

--------------------------------------------------------------------------------
-- /bcbspike
--------------------------------------------------------------------------------
local function Status()
    local eb = ChatFrame1EditBox
    Say(string.format("spike=%s hooks=%s fight=%s applied=%s protected=%s",
        tostring(BCB.SkinSpikeActive()), tostring(HooksOn()), tostring(FightOn()), tostring(applied),
        tostring(eb and eb:IsProtected())))
    Say(FlagString())
    Say(string.format("sends=%d presend=%d expanded=%d reanchor=%d blocked=%d moved=%d putback=%d gaveup=%s",
        stats.sends, stats.presend, stats.expanded, stats.reanchor, stats.blocked,
        stats.moved or 0, stats.putback or 0, tostring(gaveUp)))
    local names = {}
    for name in pairs(movers) do names[#names + 1] = name end
    if #names > 0 then Say("moved by: " .. table.concat(names, ", ")) end
    Say("probes " .. TaintReport())
end

SLASH_BCBSPIKE1 = "/bcbspike"
SlashCmdList["BCBSPIKE"] = function(msg)
    local cmd, arg = (msg or ""):lower():match("^%s*(%S*)%s*(%S*)")
    if cmd == "on" or cmd == "off" then
        BigChatBoxDB.spikeSkinMode = (cmd == "on") or nil
        Log("toggle", "spike " .. cmd)
        Say("skin spike " .. cmd .. ", reloading...")
        C_UI.Reload()
    elseif cmd == "hooks" and (arg == "on" or arg == "off") then
        BigChatBoxDB.spikeNoHooks = (arg == "off") or nil
        Say("hooks " .. arg .. " after the next reload (/reload)")
    elseif cmd == "fight" and (arg == "on" or arg == "off") then
        BigChatBoxDB.spikeFight = (arg == "on") or nil
        gaveUp = false
        Log("toggle", "fight " .. arg)
        Say("position fight " .. arg)
        if arg == "on" and not InLockdown() then ApplyPosition() end
    elseif cmd == "status" then
        Status()
    elseif cmd == "log" then
        local log = BigChatBoxDB.spikeLog or {}
        local n = tonumber(arg) or 20
        Say(#log .. " entries, last " .. math.min(n, #log) .. ":")
        for i = math.max(1, #log - n + 1), #log do print("  " .. log[i]) end
    elseif cmd == "clear" then
        BigChatBoxDB.spikeLog = {}
        Say("log cleared")
    elseif cmd == "mark" then
        Log("mark", arg ~= "" and arg or "-")
        Say("mark logged")
    else
        Say("on | off | hooks on|off | fight on|off | status | log [n] | clear | mark <word>")
    end
end
