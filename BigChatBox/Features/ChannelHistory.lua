-- BigChatBox Features/ChannelHistory.lua - Channel history panel (ALL-10)
-- A scrollable panel on the box with the recent messages of the channel being
-- typed in (or all chat), so the box can be used without the chat frame.
--
-- SOURCE: Blizzard's chat tabs. On all five clients every line a tab shows is
-- added with AddMessage(text, r, g, b, infoID, accessID, typeID, ...), where
-- accessID = ChatHistory_GetAccessID(chatCategory, chatTarget) names its channel
-- (ChatFrameUtil.PopOutChat filters on it the same way). The tabs keep only 128
-- lines each, which a busy channel fills in minutes (Trade on Forever), so BCB
-- keeps its own copy per channel for the session: lines are copied by a
-- hooksecurefunc post-hook on each tab's AddMessage, already formatted by
-- Blizzard (colours, class colours, links, its timestamps). Nothing is saved.
--
-- MIDNIGHT: lines added during an encounter or a chat lockdown can carry secret
-- values. They are skipped before any comparison or string operation.

local BCB = BigChatBox
local L   = BCB.L or {}

local LINES_PER_CHANNEL = 200   -- kept per channel (access id)
local LINES_ALL         = 500   -- kept from the main chat tab, for "Show all"
local INSET, HEADER_H, SB_W = 6, 16, 10
local ICON_PATH = "Interface\\AddOns\\BigChatBox\\assets\\history.tga"

local buffers  = {}  -- [accessID] = { line, ... }, oldest first
local allLines = {}  -- lines of DEFAULT_CHAT_FRAME, oldest first
local idInfo   = {}  -- [accessID] = { type =, target = } (ChatHistory_GetChatType, never changes)
local dedupe   = {}  -- [accessID] = { t = GetTime(), seen = { [text] = true } }
local hooked   = {}  -- [chatFrame] = true
local seq      = 0
local seeded   = false

local panel, smf, header, modeBtn, emptyText, toggleBtn
local matchCache = {}   -- [accessID] = bool, for the current filter
local filter            -- the current filter, see CurrentFilter
local stampLines        -- add BCB's own time to lines (Blizzard's timestamps off)

local function IsSecret(v) return issecretvalue ~= nil and issecretvalue(v) end

local function Available()
    return ChatHistory_GetChatType ~= nil and BCB.frame ~= nil and BCB.editBox ~= nil
end
local function Enabled() return BigChatBoxDB ~= nil and BigChatBoxDB.channelHistoryEnabled == true end
local function ShouldShow() return Enabled() and Available() and BigChatBoxDB.channelHistoryShown ~= false end

local OnNewLine  -- forward

--------------------------------------------------------------------------------
-- COLLECTING
--------------------------------------------------------------------------------
local function Push(list, cap, text, r, g, b, t)
    seq = seq + 1
    local line = { text = text, r = r, g = g, b = b, t = t, seq = seq }
    list[#list + 1] = line
    if #list > cap then table.remove(list, 1) end
    return line
end

-- Post-hook on a chat tab's AddMessage. A line shown in several tabs arrives once
-- per tab in the same frame, so a channel keeps one copy of each text per GetTime()
-- tick (GetTime is fixed within a frame).
local function Capture(frame, text, r, g, b, _, accessID)
    if not Enabled() then return end
    if IsSecret(text) or IsSecret(accessID) or IsSecret(r) or IsSecret(g) or IsSecret(b) then return end
    if type(text) ~= "string" or text == "" then return end
    local now = time()
    if frame == DEFAULT_CHAT_FRAME then
        local line = Push(allLines, LINES_ALL, text, r, g, b, now)
        if OnNewLine then OnNewLine(line, "all") end
    end
    if type(accessID) ~= "number" then return end
    local tick = GetTime()
    local d = dedupe[accessID]
    if not d then d = { seen = {} }; dedupe[accessID] = d end
    if d.t ~= tick then d.t = tick; wipe(d.seen) end
    if d.seen[text] then return end
    d.seen[text] = true
    local list = buffers[accessID]
    if not list then list = {}; buffers[accessID] = list end
    local line = Push(list, LINES_PER_CHANNEL, text, r, g, b, now)
    if OnNewLine then OnNewLine(line, accessID) end
end

local function ChatFrames()
    local list = {}
    if type(CHAT_FRAMES) == "table" then
        for _, name in ipairs(CHAT_FRAMES) do
            local f = _G[name]
            if f and f.AddMessage then list[#list + 1] = f end
        end
    else
        for i = 1, (NUM_CHAT_WINDOWS or 10) do
            local f = _G["ChatFrame" .. i]
            if f and f.AddMessage then list[#list + 1] = f end
        end
    end
    return list
end

-- Temporary whisper windows are made later; CHAT_FRAMES lists them too. The
-- combat log tab holds no chat lines and adds many in combat, so it is skipped.
local function HookFrames()
    for _, frame in ipairs(ChatFrames()) do
        if not hooked[frame] and frame ~= COMBATLOG then
            hooked[frame] = true
            hooksecurefunc(frame, "AddMessage", Capture)
        end
    end
end

-- Lines already in the tabs when collecting starts (login, or the feature switched
-- on mid-session). ForEachMessage hands out the raw entries newest first; an
-- entry's timestamp is GetTime() when it was added, extraData[2] its access id.
local function ReadFrame(frame)
    local out = {}
    if not frame.ForEachMessage then return out end
    local ok = pcall(frame.ForEachMessage, frame, function(entry) out[#out + 1] = entry end)
    return ok and out or {}
end

local function Seed()
    wipe(buffers); wipe(allLines); wipe(dedupe)
    local offset = time() - GetTime()
    local seen, collected = {}, {}
    for fi, frame in ipairs(ChatFrames()) do
        local entries = ReadFrame(frame)
        local n = #entries
        for i = n, 1, -1 do  -- oldest first
            local e = entries[i]
            local text, ts = e.message, e.timestamp
            local accessID = type(e.extraData) == "table" and e.extraData[2] or nil
            if not IsSecret(text) and not IsSecret(accessID) and not IsSecret(ts)
                and not IsSecret(e.r) and not IsSecret(e.g) and not IsSecret(e.b)
                and type(text) == "string" and text ~= "" and type(ts) == "number" then
                local t = math.floor(offset + ts)
                if frame == DEFAULT_CHAT_FRAME then Push(allLines, LINES_ALL, text, e.r, e.g, e.b, t) end
                if type(accessID) == "number" then
                    local s = seen[accessID]
                    if not s then s = {}; seen[accessID] = s end
                    local key = tostring(ts) .. "\001" .. text
                    if not s[key] then
                        s[key] = true
                        collected[#collected + 1] = { id = accessID, text = text, r = e.r, g = e.g, b = e.b,
                            ts = ts, t = t, order = fi * 100000 + (n - i) }
                    end
                end
            end
        end
    end
    table.sort(collected, function(a, b)
        if a.ts ~= b.ts then return a.ts < b.ts end
        return a.order < b.order
    end)
    for _, c in ipairs(collected) do
        local list = buffers[c.id]
        if not list then list = {}; buffers[c.id] = list end
        Push(list, LINES_PER_CHANNEL, c.text, c.r, c.g, c.b, c.t)
    end
end

--------------------------------------------------------------------------------
-- FILTER
-- Mirrors how Blizzard keys a line: CHANNEL on the channel number, WHISPER on
-- the full name in upper case, everything else on its chat category (PARTY_LEADER
-- -> PARTY, RAID_WARNING -> RAID, ...). BCB can hold a bare "Name" as the whisper
-- target, so names are compared through Ambiguate. Battle.net whispers are keyed
-- on a |K token that BCB's target does not carry: they show all Battle.net
-- whispers for now.
--------------------------------------------------------------------------------
local function NormName(n)
    if type(n) ~= "string" or n == "" or IsSecret(n) then return nil end
    if Ambiguate then n = Ambiguate(n, "none") end
    return strlower(n)
end

local function Category(chatType)
    if ChatFrameUtil and ChatFrameUtil.GetChatCategory then
        return ChatFrameUtil.GetChatCategory(chatType) or chatType
    end
    return chatType
end

local function CurrentFilter()
    local eb = BCB.editBox
    local chatType = eb:GetAttribute("chatType") or "SAY"
    local f = { type = chatType }
    if chatType == "CHANNEL" then
        local ch = eb:GetAttribute("channelTarget")
        f.target = ch and tostring(ch)
    elseif chatType == "WHISPER" then
        f.target = NormName(eb:GetAttribute("tellTarget"))
    elseif chatType ~= "BN_WHISPER" then
        f.category = strupper(Category(chatType))
    end
    f.key = chatType .. ";" .. tostring(f.target or f.category or "")
    return f
end

local function Matches(f, accessID)
    local info = idInfo[accessID]
    if not info then
        local t, target = ChatHistory_GetChatType(accessID)
        info = { type = t, target = target }
        idInfo[accessID] = info
    end
    local t, target = info.type, info.target
    if type(t) ~= "string" or IsSecret(t) or IsSecret(target) then return false end
    t = strupper(t)
    if f.type == "CHANNEL" then
        return t == "CHANNEL" and f.target ~= nil and tostring(target) == f.target
    elseif f.type == "WHISPER" then
        return t == "WHISPER" and f.target ~= nil and NormName(target) == f.target
    elseif f.type == "BN_WHISPER" then
        return t == "BN_WHISPER"
    end
    return t == f.category
end

local function IsMatch(accessID)
    local m = matchCache[accessID]
    if m == nil then m = Matches(filter, accessID); matchCache[accessID] = m end
    return m
end

local function LinesForFilter()
    if BigChatBoxDB.channelHistoryAll then return allLines end
    local lists = {}
    for id, list in pairs(buffers) do
        if IsMatch(id) then lists[#lists + 1] = list end
    end
    if #lists == 0 then return {} end
    if #lists == 1 then return lists[1] end
    local merged = {}
    for _, list in ipairs(lists) do
        for _, line in ipairs(list) do merged[#merged + 1] = line end
    end
    table.sort(merged, function(a, b) return a.seq < b.seq end)
    return merged
end

--------------------------------------------------------------------------------
-- DISPLAY
--------------------------------------------------------------------------------
local function BlizzardTimestampsOn()
    if ChatFrameUtil and ChatFrameUtil.GetTimestampFormat then
        local ok, fmt = pcall(ChatFrameUtil.GetTimestampFormat)
        if ok then return fmt ~= nil end
    end
    return CHAT_TIMESTAMP_FORMAT ~= nil
end

local function Format(line)
    if stampLines and line.t then
        return "|cff808080" .. date("%H:%M", line.t) .. "|r " .. line.text
    end
    return line.text
end

local function Refocus()
    C_Timer.After(0, function()
        if BCB.frame and BCB.frame:IsShown() and BCB.editBox and not BCB.editBox:HasFocus() then
            BCB.editBox:SetFocus()
        end
    end)
end

-- Same skin as the box, which is tinted with the channel colour: copied on every
-- render so the panel follows channel switches and Designer changes.
local function Skin()
    local f = BCB.frame
    local bd = f.GetBackdrop and f:GetBackdrop()
    if bd then
        panel:SetBackdrop(bd)
        panel:SetBackdropColor(f:GetBackdropColor())
        panel:SetBackdropBorderColor(f:GetBackdropBorderColor())
    else
        panel:SetBackdrop(nil)
    end
end

local function Layout()
    local db = BigChatBoxDB
    local below = db.channelHistorySide == "below"
    local labelSide = db.channelTextSide or "top"
    -- The channel name sits between box and panel when both are on the same side
    local gap = 4
    if db.showChannelName ~= false and ((not below and labelSide == "top") or (below and labelSide == "bottom")) then
        gap = ((BCB.channelButton and BCB.channelButton:GetHeight()) or 20) + 6
    end
    panel:ClearAllPoints()
    if below then
        panel:SetPoint("TOPLEFT",  BCB.frame, "BOTTOMLEFT",  0, -gap)
        panel:SetPoint("TOPRIGHT", BCB.frame, "BOTTOMRIGHT", 0, -gap)
    else
        panel:SetPoint("BOTTOMLEFT",  BCB.frame, "TOPLEFT",  0, gap)
        panel:SetPoint("BOTTOMRIGHT", BCB.frame, "TOPRIGHT", 0, gap)
    end
    local _, size = ChatFontNormal:GetFont()
    size = size or 14
    local lines = db.channelHistoryLines or 8
    panel:SetHeight(math.floor(lines * (size + 2) + HEADER_H + 2 * INSET + 4))
end

local function UpdateHeader()
    if BigChatBoxDB.channelHistoryAll then
        header:SetText(L["CHANNEL_HISTORY_HEADER_ALL"] or "All chat")
        header:SetTextColor(1, 0.82, 0)
        modeBtn.text:SetText(L["CHANNEL_HISTORY_BTN_CHANNEL"] or "This channel")
    else
        header:SetText(BCB.channelText and BCB.channelText:GetText() or "")
        local ti = ChatTypeInfo and filter and ChatTypeInfo[filter.type]
        if ti then header:SetTextColor(ti.r, ti.g, ti.b) else header:SetTextColor(1, 1, 1) end
        modeBtn.text:SetText(L["CHANNEL_HISTORY_BTN_ALL"] or "Show all")
    end
    modeBtn:SetWidth(modeBtn.text:GetStringWidth() + 4)
end

local function Render()
    if not panel or not panel:IsVisible() then return end
    local f = CurrentFilter()
    if not filter or f.key ~= filter.key then wipe(matchCache) end
    filter = f
    stampLines = BigChatBoxDB.channelHistoryTimestamps ~= false and not BlizzardTimestampsOn()
    Skin(); Layout()
    smf:Clear()
    local lines = LinesForFilter()
    for i = math.max(1, #lines - LINES_ALL + 1), #lines do
        local line = lines[i]
        smf:AddMessage(Format(line), line.r, line.g, line.b)
    end
    smf:ScrollToBottom()
    emptyText:SetShown(#lines == 0)
    UpdateHeader()
end

local renderPending = false
local function RequestRender()
    if renderPending then return end
    renderPending = true
    C_Timer.After(0, function() renderPending = false; Render() end)
end

-- A line arrived while the panel is open: append it if it belongs here. The
-- message frame keeps the reader's scroll position when they have scrolled up.
OnNewLine = function(line, kind)
    if not panel or not panel:IsVisible() or not filter then return end
    if BigChatBoxDB.channelHistoryAll then
        if kind ~= "all" then return end
    elseif kind == "all" or not IsMatch(kind) then
        return
    end
    smf:AddMessage(Format(line), line.r, line.g, line.b)
    emptyText:Hide()
end

local LINK_TOOLTIP = { item = true, spell = true, achievement = true, currency = true, quest = true,
    enchant = true, talent = true, mount = true, instancelock = true }

local function CreatePanel()
    if panel then return end
    panel = CreateFrame("Frame", "BigChatBoxHistoryPanel", BCB.frame, "BackdropTemplate")
    panel:SetFrameLevel(BCB.frame:GetFrameLevel() + 5)
    panel:EnableMouse(true)
    panel:Hide()
    BCB.channelHistoryPanel = panel

    modeBtn = CreateFrame("Button", nil, panel)
    modeBtn:SetHeight(HEADER_H - 2)
    modeBtn:SetPoint("TOPRIGHT", panel, "TOPRIGHT", -(INSET + 2), -INSET)
    modeBtn.text = modeBtn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    modeBtn.text:SetPoint("RIGHT")
    modeBtn.text:SetTextColor(0.6, 0.6, 0.6)
    modeBtn:SetScript("OnEnter", function(self) self.text:SetTextColor(1, 1, 0.5) end)
    modeBtn:SetScript("OnLeave", function(self) self.text:SetTextColor(0.6, 0.6, 0.6) end)
    modeBtn:SetScript("OnClick", function()
        BigChatBoxDB.channelHistoryAll = not BigChatBoxDB.channelHistoryAll
        Render(); Refocus()
    end)

    header = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    header:SetPoint("TOPLEFT", panel, "TOPLEFT", INSET + 4, -INSET - 1)
    header:SetPoint("RIGHT", modeBtn, "LEFT", -8, 0)
    header:SetJustifyH("LEFT")
    header:SetWordWrap(false)

    smf = CreateFrame("ScrollingMessageFrame", nil, panel)
    smf:SetPoint("TOPLEFT", panel, "TOPLEFT", INSET + 4, -(INSET + HEADER_H))
    smf:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -(INSET + SB_W + 6), INSET + 2)
    smf:SetFontObject(ChatFontNormal)
    smf:SetJustifyH("LEFT")
    smf:SetFading(false)
    smf:SetMaxLines(LINES_ALL)
    if smf.SetIndentedWordWrap then smf:SetIndentedWordWrap(true) end
    smf:SetHyperlinksEnabled(true)
    smf:EnableMouse(true)
    smf:SetScript("OnHyperlinkClick", function(self, link, text, button)
        SetItemRef(link, text, button, DEFAULT_CHAT_FRAME)
        Refocus()
    end)
    smf:SetScript("OnHyperlinkEnter", function(self, link)
        if BigChatBoxDB.enableLinkHover == false or type(link) ~= "string" then return end
        local kind = link:match("^(%a+):")
        if not kind or not LINK_TOOLTIP[kind] then return end
        GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
        if pcall(GameTooltip.SetHyperlink, GameTooltip, link) then GameTooltip:Show() else GameTooltip:Hide() end
    end)
    smf:SetScript("OnHyperlinkLeave", function() GameTooltip:Hide() end)

    -- The modern bar on every client (Classic ships MinimalScrollBar too, see
    -- BCB.CreateScrollFrame); the mouse wheel alone if it cannot be made.
    local ok, bar = pcall(CreateFrame, "EventFrame", nil, panel, "MinimalScrollBar")
    if ok and bar and ScrollUtil and ScrollUtil.InitScrollingMessageFrameWithScrollBar then
        bar:SetPoint("TOPLEFT",    smf, "TOPRIGHT",    6, 0)
        bar:SetPoint("BOTTOMLEFT", smf, "BOTTOMRIGHT", 6, 0)
        if bar.SetHideIfUnscrollable then bar:SetHideIfUnscrollable(true) end
        ScrollUtil.InitScrollingMessageFrameWithScrollBar(smf, bar)
    else
        if ok and bar then bar:Hide() end
        smf:EnableMouseWheel(true)
        smf:SetScript("OnMouseWheel", function(self, delta)
            if delta > 0 then self:ScrollUp() else self:ScrollDown() end
        end)
    end

    emptyText = panel:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    emptyText:SetPoint("CENTER", smf, "CENTER")
    emptyText:SetText(L["CHANNEL_HISTORY_EMPTY"] or "No messages here yet.")
    emptyText:Hide()
end

--------------------------------------------------------------------------------
-- BUTTON ON THE BOX
-- Placed by EmojiPicker.lua's UpdateAnchors (BCB.RepositionEmojiIcon), which owns
-- the icon row at the box's right edge.
--------------------------------------------------------------------------------
local function UpdateToggleButton()
    if not toggleBtn then return end
    toggleBtn:SetShown(Enabled())
    toggleBtn.iconTex:SetAlpha(BigChatBoxDB.channelHistoryShown ~= false and 0.9 or 0.4)
end

local function CreateToggleButton()
    if toggleBtn then return end
    toggleBtn = CreateFrame("Button", "BCBHistoryIconBtn", BCB.frame)
    toggleBtn:SetSize(18, 18)
    toggleBtn:SetFrameLevel(BCB.frame:GetFrameLevel() + 15)
    toggleBtn:Hide()
    BCB.channelHistoryBtn = toggleBtn

    local tex = toggleBtn:CreateTexture(nil, "ARTWORK")
    tex:SetAllPoints()
    tex:SetTexture(ICON_PATH)
    toggleBtn.iconTex = tex
    local hl = toggleBtn:CreateTexture(nil, "HIGHLIGHT")
    hl:SetAllPoints(); hl:SetColorTexture(1, 1, 1, 0.15)

    toggleBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
        GameTooltip:SetText(L["CHANNEL_HISTORY_TITLE"] or "Channel History", 1, 1, 1)
        GameTooltip:AddLine(L["CHANNEL_HISTORY_TOOLTIP"] or "Click to show or hide recent messages", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    toggleBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    toggleBtn:SetScript("OnClick", function()
        BigChatBoxDB.channelHistoryShown = not (BigChatBoxDB.channelHistoryShown ~= false)
        BCB.ApplyChannelHistorySettings()
        Refocus()
    end)
end

--------------------------------------------------------------------------------
-- PUBLIC
--------------------------------------------------------------------------------
-- Called at setup and by the Features tab whenever a setting changes.
function BCB.ApplyChannelHistorySettings()
    if not Available() or not toggleBtn then return end
    if Enabled() then
        if not seeded then Seed(); seeded = true end  -- before hooking: no line is missed or doubled
        HookFrames()
    elseif seeded then
        wipe(buffers); wipe(allLines); wipe(dedupe); wipe(matchCache)
        seeded = false
    end
    if ShouldShow() then
        CreatePanel(); panel:Show(); RequestRender()
    elseif panel then
        panel:Hide()
    end
    UpdateToggleButton()
    if BCB.RepositionEmojiIcon then BCB.RepositionEmojiIcon() end
end

function BCB.SetupChannelHistory()
    if not Available() then return end
    CreateToggleButton()
    BCB.frame:HookScript("OnShow", function()
        if not ShouldShow() then return end
        HookFrames()  -- picks up temporary whisper windows opened since
        RequestRender()
    end)
    -- Every channel switch sets one of these on the box (ChatIntercept, the menus,
    -- Tab cycling), so the panel follows without touching those files.
    BCB.editBox:HookScript("OnAttributeChanged", function(_, name)
        if type(name) ~= "string" then return end
        name = strlower(name)
        if name == "chattype" or name == "telltarget" or name == "channeltarget" then RequestRender() end
    end)
    if FCF_OpenTemporaryWindow then
        hooksecurefunc("FCF_OpenTemporaryWindow", function() if Enabled() then HookFrames() end end)
    end
    BCB.ApplyChannelHistorySettings()
end
