-- BigChatBox - Utility Functions

-- Keybinding names (must be global before Bindings.xml is processed)
BINDING_HEADER_BIGCHATBOX = "BigChatBox"
BINDING_NAME_BIGCHATBOX_USE_BLIZZARD_CHAT = "Open Blizzard Chat"
BINDING_NAME_BIGCHATBOX_OPEN_MULTILINE    = "Open Multiline Box"

-- Create namespace
BigChatBox = BigChatBox or {}
local BCB = BigChatBox


-- Print helper: every chat line from BCB goes through here, with the accent
-- colour prefix (SUG-07)
function BCB:Print(message)
    print("|cff5599ffBigChatBox:|r " .. tostring(message))
end

-- Returns a font path that can render the current active locale's characters.
-- Falls back to FRIZQT__ (western) for Latin locales.
-- Used to override GameFontNormal on buttons/labels when a CJK locale is forced.
function BCB.GetUIFont()
    local locale = BCB._forcedLocale or GetLocale()  -- the language Locales/ actually loaded
    if locale == "zhCN" or locale == "zhTW" or locale == "jaJP" then
        return "Fonts\\ARKai_T.ttf", 13  -- CJK Unified Ideographs (kanji, zh chars)
    elseif locale == "koKR" then
        return "Fonts\\2002.ttf", 13     -- Korean Hangul
    else
        return "Fonts\\FRIZQT__.TTF", 13 -- Latin / Cyrillic
    end
end

--------------------------------------------------------------------------------
-- WINDOW CHROME ON WOW FOREVER (ported from BigNoteBox UI/Chrome.lua)
-- Every BCB window is a ButtonFrameTemplate whose content is anchored to the frame
-- edges with offsets tuned against Retail's border art. Forever draws the same
-- template with different art, so its border sits further inside. Instead of
-- offsetting every content anchor, SeatChrome moves the template's own pieces
-- (border, background, title, close button) outward by one per-side delta, so the
-- border sits where Retail's does. Retail and Classic: nothing is touched.
--
-- Call BCB.SeatChrome(f) right after ButtonFrameTemplate_HidePortrait /
-- HideButtonBar / Inset:Hide and BEFORE any content is created: whatever is a
-- child or region of f at that moment is template chrome.
--------------------------------------------------------------------------------
-- Measured by BNB on Forever (2026-09-23, same template, same client): left 3,
-- top 3, right 4, bottom 3 UI units. Positive = outward.
local FOREVER_CHROME_DELTA = { l = 3, t = 3, r = 4, b = 3 }

local function EdgeShift(relPoint, d)
    local dx, dy
    relPoint = relPoint or "CENTER"
    if relPoint:find("LEFT") then dx = -d.l
    elseif relPoint:find("RIGHT") then dx = d.r
    else dx = (d.r - d.l) / 2 end
    if relPoint:find("TOP") then dy = d.t
    elseif relPoint:find("BOTTOM") then dy = -d.b
    else dy = (d.t - d.b) / 2 end
    return dx, dy
end

local function SeatPieces(f, d)
    local pieces = {}
    local function add(obj)
        local pts, onFrame = {}, false
        for i = 1, obj:GetNumPoints() do
            local p, rel, rp, x, y = obj:GetPoint(i)
            pts[#pts + 1] = { p, rel, rp, x or 0, y or 0 }
            if rel == f then onFrame = true end
        end
        -- Pieces hung off another piece follow it; only those pinned to f move
        if onFrame then pieces[#pieces + 1] = { obj = obj, pts = pts } end
    end
    for _, r in ipairs({ f:GetRegions() })  do add(r) end
    for _, c in ipairs({ f:GetChildren() }) do add(c) end
    for _, pc in ipairs(pieces) do
        local o = pc.obj
        o:ClearAllPoints()
        for _, a in ipairs(pc.pts) do
            local x, y = a[4], a[5]
            if a[2] == f then
                local dx, dy = EdgeShift(a[3], d)
                x, y = x + dx, y + dy
            end
            o:SetPoint(a[1], a[2], a[3], x, y)
        end
    end
end

function BCB.SeatChrome(f)
    if not f or f._bcbSeated or not BCB.IsForever then return end
    f._bcbSeated = true
    pcall(SeatPieces, f, FOREVER_CHROME_DELTA)
end

--------------------------------------------------------------------------------
-- SCROLL FRAME  (same as BNB.CreateScrollFrame, BNB's ALL-171 / ALL-172)
-- Every ScrollFrameTemplate frame is made here. Retail and Forever get the
-- template's MinimalScrollBar. Classic's template builds the wide
-- WoWClassicScrollBar, which stuck out of our windows; the Classic clients ship
-- MinimalScrollBar too, so it is swapped in with Retail's offsets and bound the
-- way the template's ScrollFrame_OnLoad binds its own bar. Done before the caller
-- sets any script: the bind SetScripts OnVerticalScroll, OnScrollRangeChanged and
-- OnMouseWheel.
--------------------------------------------------------------------------------
function BCB.CreateScrollFrame(name, parent)
    local sf = CreateFrame("ScrollFrame", name, parent, "ScrollFrameTemplate")
    local old = sf.ScrollBar
    if BCB.IsClassic and old and ScrollUtil and ScrollUtil.InitScrollFrameWithScrollBar then
        local ok, bar = pcall(CreateFrame, "EventFrame", nil, sf, "MinimalScrollBar")
        if ok and bar then
            old:Hide()
            old:ClearAllPoints()
            bar:SetPoint("TOPLEFT", sf, "TOPRIGHT", 6, 2)
            bar:SetPoint("BOTTOMLEFT", sf, "BOTTOMRIGHT", 6, 5)
            if bar.SetHideIfUnscrollable then bar:SetHideIfUnscrollable(sf.scrollBarHideIfUnscrollable) end
            sf.ScrollBar = bar
            bar:Show()
            ScrollUtil.InitScrollFrameWithScrollBar(sf, bar)
            if bar.Update then bar:Update() end
        end
    end
    return sf
end
