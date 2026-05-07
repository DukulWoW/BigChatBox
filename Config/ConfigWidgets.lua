-- BigChatBox Config/ConfigWidgets.lua — Shared widget constructors
-- CreateSlider, CreateWowDropdown, CreatePreview, CreateSmartScrollFrame.
-- All tab files use these functions via BCB.Config.

local BCB = BigChatBox
local L = BCB.L or {}

BCB.Config = BCB.Config or {}
local Config = BCB.Config

Config.WINDOW_WIDTH = 650
Config.WINDOW_HEIGHT = 700
Config.PAD = 20
local PAD = Config.PAD

-- FitButton(btn, minWidth)
-- Sets a button's width to fit its label text, with a minimum.
-- Call after SetText(). Adds 24px horizontal padding around the label.
function Config.FitButton(btn, minWidth)
    local fs = btn:GetFontString()
    if fs then
        btn:SetWidth(math.max(minWidth or 80, fs:GetStringWidth() + 24))
    end
end

-- Preview channel cycling state (shared across tabs)
Config.PREV_CH = {"SAY","WHISPER","GUILD","PARTY","RAID","OFFICER","YELL","INSTANCE_CHAT","CHANNEL_1"}
Config.PREV_NM = {SAY="Say",WHISPER="Whisper",GUILD="Guild",PARTY="Party",RAID="Raid",OFFICER="Officer",YELL="Yell",INSTANCE_CHAT="Instance",CHANNEL_1="[1] General"}
Config.prevCI = 1
Config.prevBI = 0
Config.NUM_PBG = 7

-- LSM helpers
function Config.GetLSM() return LibStub and LibStub("LibSharedMedia-3.0", true) end
function Config.GetMP(mt,n) local l=Config.GetLSM(); if not l or not n or n=="Default" then return nil end; return l:Fetch(mt,n) end
function Config.GetML(mt) local l=Config.GetLSM(); if not l then return {"Default"} end; local r={"Default"}; for _,v in ipairs(l:List(mt)) do r[#r+1]=v end; return r end

--------------------------------------------------------------------------------
-- Smart ScrollFrame: hides scrollbar when not needed
--------------------------------------------------------------------------------
function Config.CreateSmartScrollFrame(parent, topOffset)
    local sf = CreateFrame("ScrollFrame", nil, parent, "ScrollFrameTemplate")

    -- In Classic, ScrollFrameTemplate's scrollbar is anchored to the RIGHT of the
    -- scrollframe (not inside it), so we need to leave room for it.
    -- Classic scrollbar = ~25px wide. Container is -4 from window. So scrollframe
    -- must end at -28 from container right to keep the bar inside the window.
    -- In retail the scrollbar IS inside the scrollframe chrome, so -24 suffices.
    local sbOffset = BCB.IsClassic and -28 or -24

    sf:SetPoint("TOPLEFT", 0, topOffset or -172)
    sf:SetPoint("BOTTOMRIGHT", sbOffset, 0)

    -- Find the scrollbar child — Classic uses a different key than retail.
    -- Try sf.ScrollBar first, then walk children.
    local scrollBar = sf.ScrollBar
    if not scrollBar then
        for _, child in ipairs({sf:GetChildren()}) do
            if child:IsObjectType("Slider") then scrollBar = child; break end
        end
    end

    local ct = CreateFrame("Frame", nil, sf)
    ct:SetWidth(Config.WINDOW_WIDTH - 55)
    sf:SetScrollChild(ct)

    -- Classic: enable mouse wheel on the scrollframe directly.
    -- The template doesn't wire this up in older clients.
    if BCB.IsClassic then
        sf:EnableMouseWheel(true)
        sf:SetScript("OnMouseWheel", function(self, delta)
            local cur = self:GetVerticalScroll()
            local max = self:GetVerticalScrollRange()
            local step = math.max(self:GetHeight() * 0.08, 20)
            self:SetVerticalScroll(math.max(0, math.min(max, cur - delta * step)))
        end)
    end

    function sf:UpdateScrollbar()
        C_Timer.After(0.1, function()
            local contentH = ct:GetHeight(); local visibleH = sf:GetHeight()
            local offset = BCB.IsClassic and -28 or -24
            if contentH <= visibleH then
                if scrollBar then scrollBar:Hide() end
                sf:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -4, 0)
                ct:SetWidth(Config.WINDOW_WIDTH - 30)
            else
                if scrollBar then scrollBar:Show() end
                sf:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", offset, 0)
                ct:SetWidth(Config.WINDOW_WIDTH - 55)
            end
        end)
    end
    return sf, ct
end

--------------------------------------------------------------------------------
-- Classic slider helper — builds a MinimalSlider look-alike using universally
-- available primitives. Called only when BCB.IsClassic = true.
-- Layout: [Label ............] [−] [track•thumb] [+] [value]
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Classic slider — pure drag/click implementation, no Slider widget.
-- The Slider widget in TBC fires OnValueChanged continuously during drag
-- with raw float values and no SetObeyStepOnDrag, causing wild jumping.
-- Instead we use a transparent drag zone that tracks cursor delta via OnUpdate.
-- Layout (all pixel-based, no relative anchors between siblings):
--   [Label .........] [-] [====track====] [+] [value]
--   Label: LEFT PAD to 45% of row width
--   [-]: 18px button
--   Track: fills middle
--   [+]: 18px button
--   Value: 38px label at RIGHT-PAD
--------------------------------------------------------------------------------
local CL_BTN = 18    -- width and height of − / + buttons
local CL_VAL = 38    -- width of value display
local CL_GAP = 3     -- gap between elements

local function CreateClassicSlider(parent, label, mn, mx, cur, def, onChange, fmt)
    local h = CreateFrame("Frame", nil, parent)
    h:SetHeight(36)

    local fF = fmt or function(v) return tostring(math.floor(v)) end
    local trackedVal = math.max(mn, math.min(mx, math.floor(cur + 0.5)))

    -- Label
    local lbl = label
    if def ~= nil then lbl = label .. "  |cff666666(Default: " .. tostring(def) .. ")|r" end
    h.Label = h:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    h.Label:SetJustifyH("RIGHT")
    h.Label:SetPoint("LEFT", PAD, 0)
    -- Label occupies left 45% of the row; right side has controls
    h.Label:SetPoint("RIGHT", h, "LEFT", math.floor(Config.WINDOW_WIDTH * 0.45), 0)
    h.Label:SetText(lbl)

    -- Value display — anchored RIGHT-PAD, fixed width
    local valStr = h:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    valStr:SetWidth(CL_VAL); valStr:SetJustifyH("CENTER")
    valStr:SetPoint("RIGHT", h, "RIGHT", -PAD, 0)
    valStr:SetText(fF(trackedVal))

    -- + button — right of track, left of value
    local plusBtn = CreateFrame("Button", nil, h, "BackdropTemplate")
    plusBtn:SetSize(CL_BTN, CL_BTN)
    plusBtn:SetPoint("RIGHT", valStr, "LEFT", -CL_GAP, 0)
    plusBtn:SetBackdrop({bgFile="Interface\Buttons\White8x8",
        edgeFile="Interface\Tooltips\UI-Tooltip-Border",
        edgeSize=8, insets={left=1,right=1,top=1,bottom=1}})
    plusBtn:SetBackdropColor(0.12, 0.12, 0.12, 1)
    plusBtn:SetBackdropBorderColor(0.45, 0.45, 0.45, 1)
    local plusTxt = plusBtn:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    plusTxt:SetAllPoints(); plusTxt:SetText("+")

    -- − button — left of track
    local minusBtn = CreateFrame("Button", nil, h, "BackdropTemplate")
    minusBtn:SetSize(CL_BTN, CL_BTN)
    -- Will be anchored after track is created; placeholder first
    minusBtn:SetBackdrop({bgFile="Interface\Buttons\White8x8",
        edgeFile="Interface\Tooltips\UI-Tooltip-Border",
        edgeSize=8, insets={left=1,right=1,top=1,bottom=1}})
    minusBtn:SetBackdropColor(0.12, 0.12, 0.12, 1)
    minusBtn:SetBackdropBorderColor(0.45, 0.45, 0.45, 1)
    local minusTxt = minusBtn:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    minusTxt:SetAllPoints(); minusTxt:SetText("-")

    -- Track container — between label and +button
    local track = CreateFrame("Frame", nil, h, "BackdropTemplate")
    track:SetHeight(14)
    -- Left anchor: 45% + gap + CL_BTN + gap from left
    local trackLeft = math.floor(Config.WINDOW_WIDTH * 0.45) + CL_GAP + CL_BTN + CL_GAP
    track:SetPoint("LEFT", h, "LEFT", trackLeft, 0)
    track:SetPoint("RIGHT", plusBtn, "LEFT", -CL_GAP, 0)
    track:SetBackdrop({bgFile="Interface\Buttons\White8x8",
        edgeSize=0, insets={left=0,right=0,top=0,bottom=0}})
    track:SetBackdropColor(0.18, 0.18, 0.18, 1)

    -- Anchor − button left of track
    minusBtn:SetPoint("RIGHT", track, "LEFT", -CL_GAP, 0)

    -- Fill bar (blue, proportional to value)
    local fill = track:CreateTexture(nil, "ARTWORK")
    fill:SetPoint("LEFT", track, "LEFT", 1, 0)
    fill:SetHeight(12)
    fill:SetColorTexture(0.3, 0.5, 1.0, 1)

    -- Thumb indicator (bright dot on the fill)
    local thumb = track:CreateTexture(nil, "OVERLAY")
    thumb:SetSize(8, 12)
    thumb:SetColorTexture(0.7, 0.85, 1.0, 1)

    local function UpdateTrack(v)
        local ratio = (v - mn) / math.max(mx - mn, 1)
        local w = track:GetWidth() - 2
        if not w or w <= 0 then return end
        local fillW = math.max(ratio * w, 1)
        fill:SetWidth(fillW)
        thumb:ClearAllPoints()
        thumb:SetPoint("LEFT", track, "LEFT", math.max(fillW - 4, 0), 0)
    end

    -- Drag zone — transparent button over the whole track
    local dragZone = CreateFrame("Button", nil, track)
    dragZone:SetAllPoints(track)
    dragZone:RegisterForClicks("LeftButtonUp")
    dragZone:EnableMouse(true)

    -- OnMouseDown: start drag, tracking cursor X position
    local dragStartX, dragStartVal
    dragZone:SetScript("OnMouseDown", function(self, button)
        if button ~= "LeftButton" then return end
        dragStartX = select(1, GetCursorPosition())
        dragStartVal = trackedVal
        self:SetScript("OnUpdate", function()
            local cx = select(1, GetCursorPosition())
            local trackW = track:GetWidth() - 2
            local scale = UIParent:GetEffectiveScale()
            local pixelDelta = (cx - dragStartX) / scale
            local range = mx - mn
            local valueDelta = math.floor(pixelDelta / trackW * range + 0.5)
            local newV = math.max(mn, math.min(mx, dragStartVal + valueDelta))
            if newV ~= trackedVal then
                trackedVal = newV
                valStr:SetText(fF(trackedVal))
                UpdateTrack(trackedVal)
                if onChange then onChange(trackedVal) end
            end
        end)
    end)

    -- Also allow clicking anywhere on the track to jump to that position
    dragZone:SetScript("OnClick", function(self)
        local cx = select(1, GetCursorPosition())
        local tx = track:GetLeft()
        local tw = track:GetWidth()
        if not tx or tw <= 0 then return end
        local scale = UIParent:GetEffectiveScale()
        local ratio = math.max(0, math.min(1, (cx / scale - tx) / tw))
        local newV = math.max(mn, math.min(mx, mn + math.floor(ratio * (mx - mn) + 0.5)))
        if newV ~= trackedVal then
            trackedVal = newV
            valStr:SetText(fF(trackedVal))
            UpdateTrack(trackedVal)
            if onChange then onChange(trackedVal) end
        end
    end)

    dragZone:SetScript("OnMouseUp", function(self)
        self:SetScript("OnUpdate", nil)
    end)

    -- − / + click handlers
    minusBtn:SetScript("OnClick", function()
        local newV = math.max(mn, trackedVal - 1)
        if newV ~= trackedVal then
            trackedVal = newV
            valStr:SetText(fF(trackedVal))
            UpdateTrack(trackedVal)
            if onChange then onChange(trackedVal) end
        end
    end)
    plusBtn:SetScript("OnClick", function()
        local newV = math.min(mx, trackedVal + 1)
        if newV ~= trackedVal then
            trackedVal = newV
            valStr:SetText(fF(trackedVal))
            UpdateTrack(trackedVal)
            if onChange then onChange(trackedVal) end
        end
    end)

    -- Mouse wheel: pass directly to scrollframe (don't consume for slider value)
    -- Use h:EnableMouseWheel(false) so events bubble naturally.
    h:EnableMouseWheel(false)
    track:EnableMouseWheel(false)

    -- Deferred initial render
    C_Timer.After(0.05, function() UpdateTrack(trackedVal) end)

    h.Slider = dragZone  -- expose for external SetValue calls
    function h:SetValue(v)
        trackedVal = math.max(mn, math.min(mx, math.floor(v + 0.5)))
        valStr:SetText(fF(trackedVal))
        C_Timer.After(0.05, function() UpdateTrack(trackedVal) end)
    end
    return h
end

--------------------------------------------------------------------------------
-- Slider with label and value display
-- Routes to Classic build when MinimalSliderWithSteppersTemplate is absent.
--------------------------------------------------------------------------------
function Config.CreateSlider(parent, label, mn, mx, cur, def, onChange, fmt)
    -- Classic path: no MinimalSliderWithSteppersTemplate
    if BCB.IsClassic or not MinimalSliderWithSteppersMixin then
        return CreateClassicSlider(parent, label, mn, mx, cur, def, onChange, fmt)
    end

    -- Retail path (unchanged)
    local h = CreateFrame("Frame", nil, parent); h:SetHeight(36)
    local lbl = label
    if def ~= nil then lbl = label .. "  |cff666666(Default: " .. tostring(def) .. ")|r" end
    h.Label = h:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    h.Label:SetJustifyH("RIGHT"); h.Label:SetPoint("LEFT", PAD, 0); h.Label:SetPoint("RIGHT", h, "CENTER", -40, 0); h.Label:SetText(lbl)
    h.Slider = CreateFrame("Slider", nil, h, "MinimalSliderWithSteppersTemplate")
    h.Slider:SetPoint("LEFT", h, "CENTER", -26, 0); h.Slider:SetPoint("RIGHT", -PAD, 0); h.Slider:SetHeight(20)
    local fF = fmt or function(v) return tostring(math.floor(v)) end
    h.Slider:Init(cur, mn, mx, mx - mn, {
        [MinimalSliderWithSteppersMixin.Label.Right] = CreateMinimalSliderFormatter(MinimalSliderWithSteppersMixin.Label.Right,
            function(v) return WHITE_FONT_COLOR:WrapTextInColorCode(fF(v)) end),
    })
    -- Track current value in closure — GetValue() on MinimalSliderWithSteppersTemplate
    -- returns an internal normalised value, not the display value, so we track it ourselves.
    local trackedVal = cur
    h.Slider:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_,v)
        trackedVal = math.floor(v)
        if onChange then onChange(trackedVal) end
    end)
    function h:SetValue(v) trackedVal = math.floor(v); h.Slider:SetValue(trackedVal) end
    -- Mouse wheel: scroll up = +1, scroll down = -1
    h:EnableMouseWheel(true)
    h:SetScript("OnMouseWheel", function(_, delta)
        local newVal = math.max(mn, math.min(mx, trackedVal + delta))
        if newVal ~= trackedVal then h.Slider:SetValue(newVal) end
    end)
    return h
end

--------------------------------------------------------------------------------
-- Dropdown (WowStyle1DropdownTemplate - native Blizzard Retail)
--------------------------------------------------------------------------------
function Config.CreateWowDropdown(parent, label, getEntries, selected, onChange, pvType)
    local c = CreateFrame("Frame", nil, parent); c:SetHeight(48)
    local lb = c:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); lb:SetPoint("TOPLEFT", PAD, 0); lb:SetText(label)

    -- Use WowStyle1DropdownTemplate if available, fallback to custom
    local useNative = C_XMLUtil and C_XMLUtil.GetTemplateInfo and C_XMLUtil.GetTemplateInfo("WowStyle1DropdownTemplate")
    if useNative then
        local dd = CreateFrame("DropdownButton", nil, c, "WowStyle1DropdownTemplate")
        dd:SetPoint("TOPLEFT", PAD, -18); dd:SetPoint("RIGHT", -PAD, 0)
        local curSel = selected or "Default"

        -- Font object cache for font previews
        local fontCache = {}
        local fontCacheCount = 0
        local function GetCachedFont(fontPath)
            if not fontCache[fontPath] then
                fontCacheCount = fontCacheCount + 1
                local fo = CreateFont("BCBFontPv_" .. fontCacheCount)
                pcall(function() fo:SetFont(fontPath, 13, "") end)
                fontCache[fontPath] = fo
            end
            return fontCache[fontPath]
        end

        dd:SetupMenu(function(_, rootDescription)
            local items = getEntries and getEntries() or {"Default"}
            for _, name in ipairs(items) do
                local displayName = name
                -- For texture previews: prepend |T texture swatch |t
                if pvType == "texture" and name ~= "Default" and name ~= "None" then
                    local lsm = Config.GetLSM()
                    if lsm then
                        local path = lsm:Fetch("statusbar", name)
                        if path then
                            displayName = "|T" .. path .. ":16:80|t " .. name
                        end
                    end
                end
                local radio = rootDescription:CreateRadio(displayName, function() return curSel == name end, function()
                    curSel = name
                    dd:GenerateMenu()
                    if onChange then onChange(name) end
                end)
                -- For font previews: use AddInitializer to set fontObject
                if pvType == "font" and name ~= "Default" then
                    local lsm = Config.GetLSM()
                    if lsm then
                        local fontPath = lsm:Fetch("font", name)
                        if fontPath then
                            radio:AddInitializer(function(button)
                                if button.fontString then
                                    pcall(function() button.fontString:SetFontObject(GetCachedFont(fontPath)) end)
                                end
                            end)
                        end
                    end
                end
            end
            rootDescription:SetScrollMode(30 * 20)
        end)
        c.dropdown = dd
        c.SetSelected = function(self, n)
            curSel = n; dd:GenerateMenu()
            -- Update the button face label directly; strip color codes for clean display
            local label = n and n:gsub("|c%x%x%x%x%x%x%x%x",""):gsub("|r","") or "Default"
            if dd.Text then dd.Text:SetText(label) end
        end
    else
        -- Fallback for Classic and older clients
        local btn = CreateFrame("Button", nil, c, "BackdropTemplate")
        btn:SetHeight(24); btn:SetPoint("TOPLEFT", PAD, -18); btn:SetPoint("RIGHT", -PAD, 0)
        btn:SetBackdrop({bgFile="Interface\\Buttons\\White8x8", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", edgeSize=12, insets={left=2,right=2,top=2,bottom=2}})
        btn:SetBackdropColor(0.1,0.1,0.1,0.9); btn:SetBackdropBorderColor(0.4,0.4,0.4,1)
        local st = btn:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); st:SetPoint("LEFT", 8, 0); st:SetPoint("RIGHT", -22, 0); st:SetJustifyH("LEFT"); st:SetText(selected or "Default")
        local ar = btn:CreateTexture(nil, "ARTWORK"); ar:SetSize(14,14); ar:SetPoint("RIGHT", -3, 0); ar:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
        local pp = CreateFrame("Frame", nil, btn, "BackdropTemplate"); pp:SetFrameStrata("FULLSCREEN_DIALOG"); pp:SetFrameLevel(500); pp:SetClampedToScreen(true)
        pp:SetBackdrop({bgFile="Interface\\Buttons\\White8x8", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", edgeSize=12, insets={left=2,right=2,top=2,bottom=2}})
        pp:SetBackdropColor(0.06,0.06,0.06,0.97); pp:SetBackdropBorderColor(0.5,0.5,0.5,1); pp:Hide(); pp:EnableMouse(true)
        local sf = CreateFrame("ScrollFrame", nil, pp, "ScrollFrameTemplate"); sf:SetPoint("TOPLEFT", 4, -4); sf:SetPoint("BOTTOMRIGHT", -4, 4)
        local sc = CreateFrame("Frame", nil, sf); sf:SetScrollChild(sc)
        local function Pop()
            for _,ch in ipairs({sc:GetChildren()}) do ch:Hide(); ch:SetParent(nil) end
            local items = getEntries and getEntries() or {"Default"}; local rH, tH = 20, 0; sc:SetWidth(pp:GetWidth() - 12)
            for _,nm in ipairs(items) do
                if nm == "---" then
                    -- Separator: thin horizontal line, not clickable
                    local sep = CreateFrame("Frame", nil, sc)
                    sep:SetHeight(8); sep:SetPoint("TOPLEFT", 0, -tH); sep:SetPoint("RIGHT")
                    local line = sep:CreateTexture(nil, "ARTWORK")
                    line:SetHeight(1); line:SetPoint("LEFT", 6, 0); line:SetPoint("RIGHT", -6, 0); line:SetPoint("BOTTOM", 0, 3)
                    line:SetColorTexture(0.4, 0.4, 0.4, 0.8)
                    tH = tH + 8
                else
                    local row = CreateFrame("Button", nil, sc); row:SetHeight(rH); row:SetPoint("TOPLEFT", 0, -tH); row:SetPoint("RIGHT")
                    local hl = row:CreateTexture(nil, "HIGHLIGHT"); hl:SetAllPoints(); hl:SetColorTexture(0.3,0.5,0.8,0.3)
                    local fs = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); fs:SetPoint("LEFT", 6, 0); fs:SetText(nm)
                    row:SetScript("OnClick", function() st:SetText(nm); pp:Hide(); if onChange then onChange(nm) end end)
                    tH = tH + rH
                end
            end
            sc:SetHeight(math.max(tH, 1)); pp:SetHeight(math.min(tH + 10, 300))
        end
        btn:SetScript("OnClick", function() if pp:IsShown() then pp:Hide(); return end; pp:SetWidth(btn:GetWidth()); Pop(); pp:ClearAllPoints()
            if (btn:GetBottom() or 0) - 300 < 0 then pp:SetPoint("BOTTOMLEFT", btn, "TOPLEFT", 0, 2) else pp:SetPoint("TOPLEFT", btn, "BOTTOMLEFT", 0, -2) end; pp:Show() end)
        c.SetSelected = function(self, n) st:SetText(n or "Default") end
    end
    return c
end


--------------------------------------------------------------------------------
-- Preview Widget
--------------------------------------------------------------------------------
function Config.CreatePreview(parent, height)
    local f = CreateFrame("Button", nil, parent, "InsetFrameTemplate")
    local baseH = height or 160
    local dynH = math.max(baseH, (BigChatBoxDB.height or 50) + 80)
    f:SetHeight(math.min(dynH, 250))

    -- Stitch left+right background images
    local bgL = f:CreateTexture(nil, "BACKGROUND", nil, 0)
    local bgR = f:CreateTexture(nil, "BACKGROUND", nil, 0)

    local function SetPBg(idx)
        if idx < 0 then bgL:Hide(); bgR:Hide(); return end
        if idx == Config.NUM_PBG then
            -- Solid white
            bgL:SetColorTexture(1, 1, 1, 1); bgR:SetColorTexture(1, 1, 1, 1)
            bgL:Show(); bgR:Show()
            local fW = math.max(f:GetWidth() - 6, 200); local fH = math.max(f:GetHeight() - 6, 80)
            bgL:ClearAllPoints(); bgR:ClearAllPoints()
            bgL:SetSize(fW/2, fH); bgR:SetSize(fW/2, fH)
            bgL:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 3, 3); bgR:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -3, 3)
            bgL:SetTexCoord(0,1,0,1); bgR:SetTexCoord(0,1,0,1)
            return
        end
        local n = (idx % Config.NUM_PBG) + 1
        pcall(function() bgL:SetTexture("Interface\\AddOns\\BigChatBox\\assets\\previews\\preview-left-" .. n) end)
        pcall(function() bgR:SetTexture("Interface\\AddOns\\BigChatBox\\assets\\previews\\preview-right-" .. n) end)
        bgL:Show(); bgR:Show()
        -- Each image is 1024x1024. Stitch at center, scale to fill width, crop from top
        local fW = math.max(f:GetWidth() - 6, 200)
        local fH = math.max(f:GetHeight() - 6, 80)
        local halfW = fW / 2
        local scale = fW / 2048
        local imgH = 1024 * scale
        bgL:ClearAllPoints(); bgR:ClearAllPoints()
        bgL:SetSize(halfW, math.min(imgH, fH)); bgR:SetSize(halfW, math.min(imgH, fH))
        bgL:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 3, 3); bgR:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -3, 3)
        if imgH > fH then local ct = 1 - (fH / imgH); bgL:SetTexCoord(0,1,ct,1); bgR:SetTexCoord(0,1,ct,1) else bgL:SetTexCoord(0,1,0,1); bgR:SetTexCoord(0,1,0,1) end
    end
    f.SetPreviewBg = SetPBg

    -- Chat box replica
    local box = CreateFrame("Frame", nil, f, "BackdropTemplate")
    local db = BigChatBoxDB; local defs = BCB.defaults or {}

    local function ApplyBox()
        local d = BigChatBoxDB; local df = BCB.defaults or {}; local sc = d.scale or 1
        local ww = math.min((d.width or 400), 500); local hh = d.height or 50
        box:SetSize(ww, hh)
        local bt = d.bgTexture or df.bgTexture; local bdt = d.borderTexture or df.borderTexture
        local es = d.borderThickness or 16
        -- Treat empty string as nil (no texture)
        if bt == "" or d.bgTextureName == "None" then bt = nil end
        if bdt == "" or d.borderTextureName == "None" then bdt = nil end
        -- Calculate insets based on bgScale setting
        local pvBgScale = (d.bgScale or 100) / 100
        local pvBaseInset = 4
        local pvBgInset = pvBaseInset + ((1 - pvBgScale) * 20)
        if not bdt then
            box:SetBackdrop({bgFile=bt, tile=false, tileSize=0, edgeSize=0,
                insets={left=pvBgInset,right=pvBgInset,top=pvBgInset,bottom=pvBgInset}})
        else
            box:SetBackdrop({bgFile=bt, edgeFile=bdt, tile=false, tileSize=0, edgeSize=es,
                insets={left=pvBgInset,right=pvBgInset,top=pvBgInset,bottom=pvBgInset}})
        end
        local pvBgR = (d.bgColor or {r=1,g=1,b=1}).r
        local pvBgG = (d.bgColor or {r=1,g=1,b=1}).g
        local pvBgB = (d.bgColor or {r=1,g=1,b=1}).b
        -- Channel color tint on preview background
        if d.bgChannelTint then
            local ch = Config.PREV_CH[Config.prevCI] or "SAY"
            local lookupCh = ch == "CHANNEL_1" and "CHANNEL1" or ch
            local ti = ChatTypeInfo[lookupCh] or ChatTypeInfo["CHANNEL1"] or ChatTypeInfo["SAY"]
            if ti then
                local intensity = (d.bgTintIntensity or 50) / 100
                pvBgR = pvBgR * (1 - intensity) + ti.r * intensity
                pvBgG = pvBgG * (1 - intensity) + ti.g * intensity
                pvBgB = pvBgB * (1 - intensity) + ti.b * intensity
            end
        end
        box:SetBackdropColor(pvBgR, pvBgG, pvBgB, d.bgAlpha or 0.95)
        local bdc = d.borderColor or {r=1,g=1,b=1}; box:SetBackdropBorderColor(bdc.r, bdc.g, bdc.b, d.borderAlpha or 1.0)
        -- Drop shadow
        if d.boxDropShadow then
            if not box.shadow then
                box.shadow = box:CreateTexture(nil, "BACKGROUND", nil, -2)
                box.shadow:SetPoint("TOPLEFT", -4, 4); box.shadow:SetPoint("BOTTOMRIGHT", 4, -4)
                box.shadow:SetColorTexture(0, 0, 0, 0.5)
            end
            box.shadow:Show()
        elseif box.shadow then box.shadow:Hide() end
    end
    ApplyBox()
    box:SetPoint("CENTER", 0, 0)

    -- Channel label (position reflects user setting)
    local cl = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    pcall(function() cl:SetFont(db.channelFont or "Fonts\\FRIZQT__.TTF", math.min(db.channelFontSize or 16, 18), "") end)
    local chSide = BigChatBoxDB.channelTextSide or "top"
    if chSide == "bottom" then
        cl:SetPoint("TOP", box, "BOTTOM", 0, -4)
    elseif chSide == "left" then
        cl:SetPoint("RIGHT", box, "LEFT", -4, 0)
    elseif chSide == "right" then
        cl:SetPoint("LEFT", box, "RIGHT", 4, 0)
    else
        cl:SetPoint("BOTTOM", box, "TOP", 0, 4)
    end
    cl:SetText("Say"); cl:SetTextColor(1,1,1)

    -- Input text
    local it = box:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    local sampleText = BCB.GetRandomPreviewText and BCB.GetRandomPreviewText() or "Type something here..."
    local function UpdateFont()
        local d = BigChatBoxDB
        local outline = d.fontOutline or "None"
        local flags = ""
        if outline == "Outline" then flags = "OUTLINE"
        elseif outline == "Thick Outline" then flags = "THICKOUTLINE"
        elseif outline == "Monochrome Outline" then flags = "MONOCHROME,OUTLINE"
        end
        pcall(function() it:SetFont(d.font or "Fonts\\FRIZQT__.TTF", math.min(d.fontSize or 14, 18), flags) end)
        pcall(function() cl:SetFont(d.channelFont or "Fonts\\FRIZQT__.TTF", math.min(d.channelFontSize or 16, 18), flags) end)
        if outline == "Drop Shadow" then
            it:SetShadowOffset(1,-1); it:SetShadowColor(0,0,0,0.8)
            cl:SetShadowOffset(1,-1); cl:SetShadowColor(0,0,0,0.8)
        elseif outline == "Strong Drop Shadow" then
            it:SetShadowOffset(2,-2); it:SetShadowColor(0,0,0,1)
            cl:SetShadowOffset(2,-2); cl:SetShadowColor(0,0,0,1)
        elseif outline == "Strongest Drop Shadow" then
            it:SetShadowOffset(3,-3); it:SetShadowColor(0,0,0,1)
            cl:SetShadowOffset(3,-3); cl:SetShadowColor(0,0,0,1)
        else
            it:SetShadowOffset(0,0); cl:SetShadowOffset(0,0)
        end
        it:SetJustifyH(d.textAlign or "LEFT")
    end
    UpdateFont()
    it:SetPoint("LEFT", 10, 0); it:SetPoint("RIGHT", -10, 0); it:SetJustifyH(db.textAlign or "LEFT")
    it:SetText(sampleText); it:SetTextColor(0.8, 0.8, 0.8)

    -- Help text
    local help = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall"); help:SetPoint("BOTTOM", f, "BOTTOM", 0, 5)
    help:SetText("Left click to change preview channel, right click to change background"); help:SetTextColor(1, 1, 1, 0.7)

    f.box = box; f.chanLabel = cl; f.inputText = it

    -- Fake autocomplete preview box (shown on Placement tab and setup layout page)
    local acPreview = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    acPreview:SetBackdrop({bgFile="Interface\\Buttons\\White8x8", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", edgeSize=10, insets={left=2,right=2,top=2,bottom=2}})
    acPreview:SetBackdropColor(0.05, 0.05, 0.08, 0.6); acPreview:SetBackdropBorderColor(0.4, 0.4, 0.5, 0.7)
    acPreview:SetFrameStrata("FULLSCREEN_DIALOG"); acPreview:SetFrameLevel(200)
    acPreview:SetHeight(28); acPreview:Hide()
    local acText = acPreview:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    acText:SetPoint("LEFT", 10, 0); acText:SetText("Autocomplete suggestion preview"); acText:SetTextColor(0.6, 0.6, 0.6)

    local function PositionAcPreview()
        acPreview:ClearAllPoints()
        acPreview:SetWidth(box:GetWidth())
        if (BigChatBoxDB.autocompletePosition or "bottom") == "top" then
            acPreview:SetPoint("BOTTOMLEFT", box, "TOPLEFT", 0, 2)
        else
            acPreview:SetPoint("TOPLEFT", box, "BOTTOMLEFT", 0, -2)
        end
    end

    function f:ShowAutocompletePreview()
        PositionAcPreview()
        acPreview:Show()
    end
    function f:HideAutocompletePreview()
        acPreview:Hide()
    end
    function f:RefreshAutocompletePreview()
        PositionAcPreview()
        if acPreview:IsShown() then acPreview:Show() end
    end

    -- Fake character counter (parented to UIParent so it renders outside clipped frame)
    local ccPreview = CreateFrame("Frame", nil, UIParent)
    ccPreview:SetFrameStrata("HIGH"); ccPreview:SetFrameLevel(50)
    ccPreview:SetSize(60, 20); ccPreview:Hide()
    local ccText = ccPreview:CreateFontString(nil, "OVERLAY")
    ccText:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
    ccText:SetText("42/255"); ccText:SetTextColor(0.6, 0.6, 0.6); ccText:SetAlpha(0.8)
    ccText:SetAllPoints()

    local function PositionCcPreview()
        ccPreview:ClearAllPoints()
        local pos = BigChatBoxDB.charCounterPos or "inside_right"
        if pos == "off" then
            ccPreview:Hide(); return
        elseif pos == "outside_topleft" then
            ccText:SetJustifyH("LEFT")
            ccPreview:SetPoint("BOTTOMLEFT", box, "TOPLEFT", 4, 2)
        elseif pos == "outside_topright" then
            ccText:SetJustifyH("RIGHT")
            ccPreview:SetPoint("BOTTOMRIGHT", box, "TOPRIGHT", -4, 2)
        elseif pos == "outside_bottomleft" then
            ccText:SetJustifyH("LEFT")
            ccPreview:SetPoint("TOPLEFT", box, "BOTTOMLEFT", 4, -2)
        elseif pos == "outside_bottomright" then
            ccText:SetJustifyH("RIGHT")
            ccPreview:SetPoint("TOPRIGHT", box, "BOTTOMRIGHT", -4, -2)
        elseif pos == "outside_middleleft" then
            ccText:SetJustifyH("RIGHT")
            ccPreview:SetPoint("RIGHT", box, "LEFT", -4, 0)
        elseif pos == "outside_middleright" then
            ccText:SetJustifyH("LEFT")
            ccPreview:SetPoint("LEFT", box, "RIGHT", 4, 0)
        else -- inside_right
            ccText:SetJustifyH("RIGHT")
            ccPreview:SetPoint("RIGHT", box, "RIGHT", -8, 0)
        end
        ccPreview:Show()
    end

    function f:ShowCharCounterPreview() PositionCcPreview() end
    function f:HideCharCounterPreview() ccPreview:Hide() end
    function f:RefreshCharCounterPreview() if ccPreview:IsShown() then PositionCcPreview() end end

    -- Hide UIParent-parented overlays when preview hides
    f:HookScript("OnHide", function() acPreview:Hide(); ccPreview:Hide() end)

    -- Clicks: left=cycle channel, right=cycle bg
    f:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    f:SetScript("OnClick", function(self, button)
        sampleText = BCB.GetRandomPreviewText and BCB.GetRandomPreviewText() or "Type something here..."
        it:SetText(sampleText)
        if button == "LeftButton" then
            Config.prevCI = (Config.prevCI % #Config.PREV_CH) + 1; local ch = Config.PREV_CH[Config.prevCI]
            cl:SetText(Config.PREV_NM[ch] or ch)
            self:RefreshChannelColor()
        elseif button == "RightButton" then
            Config.prevBI = Config.prevBI + 1; if Config.prevBI > Config.NUM_PBG then Config.prevBI = -1 end; SetPBg(Config.prevBI)
        end
    end)

    function f:RefreshChannelColor()
        local ch = Config.PREV_CH[Config.prevCI] or "SAY"
        local lookupCh = ch == "CHANNEL_1" and "CHANNEL1" or ch
        local ti = ChatTypeInfo[lookupCh] or ChatTypeInfo["CHANNEL1"] or ChatTypeInfo["SAY"]
        if ti then
            cl:SetTextColor(ti.r, ti.g, ti.b)
            local bdc = BigChatBoxDB.borderColor or {r=1,g=1,b=1}
            box:SetBackdropBorderColor(ti.r*bdc.r, ti.g*bdc.g, ti.b*bdc.b, BigChatBoxDB.borderAlpha or 1.0)
            if BigChatBoxDB.colorTypedText then it:SetTextColor(ti.r, ti.g, ti.b) else it:SetTextColor(0.8, 0.8, 0.8) end
            local d = BigChatBoxDB
            local pvBgR = (d.bgColor or {r=1,g=1,b=1}).r
            local pvBgG = (d.bgColor or {r=1,g=1,b=1}).g
            local pvBgB = (d.bgColor or {r=1,g=1,b=1}).b
            if d.bgChannelTint then
                local intensity = (d.bgTintIntensity or 50) / 100
                pvBgR = pvBgR * (1 - intensity) + ti.r * intensity
                pvBgG = pvBgG * (1 - intensity) + ti.g * intensity
                pvBgB = pvBgB * (1 - intensity) + ti.b * intensity
            end
            box:SetBackdropColor(pvBgR, pvBgG, pvBgB, d.bgAlpha or 0.95)
        end
    end

    function f:Refresh()
        ApplyBox(); UpdateFont()
        cl:ClearAllPoints()
        local s = BigChatBoxDB.channelTextSide or "top"
        if s == "bottom" then cl:SetPoint("TOP", box, "BOTTOM", 0, -4)
        elseif s == "left" then cl:SetPoint("RIGHT", box, "LEFT", -4, 0)
        elseif s == "right" then cl:SetPoint("LEFT", box, "RIGHT", 4, 0)
        else cl:SetPoint("BOTTOM", box, "TOP", 0, 4) end
        if BigChatBoxDB.showChannelName == false then cl:SetAlpha(0)
        elseif BigChatBoxDB.autoHideChannelText then cl:SetAlpha(0.3)
        else cl:SetAlpha(1) end
        SetPBg(Config.prevBI)
        self:RefreshChannelColor()
        self:RefreshCharCounterPreview()
    end
    C_Timer.After(0.05, function() SetPBg(0) end)
    return f
end
