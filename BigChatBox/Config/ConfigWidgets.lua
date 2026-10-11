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
    local sf = BCB.CreateScrollFrame(nil, parent)

    -- -24 leaves room for the MinimalScrollBar, which every client now gets
    -- (BCB.CreateScrollFrame swaps it in on Classic; Classic needed -28 before).
    local sbOffset = -24

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
            local offset = sbOffset
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
-- No mouse wheel on a slider: the wheel scrolls the page (as BNB, Dukul 2026-09-28;
-- BCB 2026-10-11). MinimalSliderWithSteppersTemplate takes the wheel itself (inner
-- Slider and the stepper arrows), so leaving out our own OnMouseWheel is not enough.
-- With the wheel off, the event falls through to the scroll frame below.
--------------------------------------------------------------------------------
local function NoSliderWheel(frame)
    pcall(frame.EnableMouseWheel, frame, false)
    if frame.HasScript and frame:HasScript("OnMouseWheel") then
        pcall(frame.SetScript, frame, "OnMouseWheel", nil)
    end
    for _, child in ipairs({ frame:GetChildren() }) do NoSliderWheel(child) end
end

--------------------------------------------------------------------------------
-- Slider with label and value display
-- MinimalSliderWithSteppersTemplate on every client: the Classic clients ship it
-- too (BNB uses it everywhere, its DEP-05). The hand-built Classic slider went on
-- 2026-10-11 once the template was tested on all three Classic clients (ALL-07).
--------------------------------------------------------------------------------
function Config.CreateSlider(parent, label, mn, mx, cur, def, onChange, fmt)
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
    NoSliderWheel(h)
    return h
end

--------------------------------------------------------------------------------
-- Dropdown (WowStyle1DropdownTemplate - native Blizzard Retail)
--------------------------------------------------------------------------------
-- One font object per font file, shared by every font dropdown (GLB-04)
local fontPvCache, fontPvCount = {}, 0
function Config.GetCachedPreviewFont(fontPath)
    local fo = fontPvCache[fontPath]
    if not fo then
        fontPvCount = fontPvCount + 1
        fo = CreateFont("BCBFontPv_" .. fontPvCount)
        pcall(fo.SetFont, fo, fontPath, 13, "")
        fontPvCache[fontPath] = fo
    end
    return fo
end

function Config.CreateWowDropdown(parent, label, getEntries, selected, onChange, pvType)
    local c = CreateFrame("Frame", nil, parent); c:SetHeight(48)
    local lb = c:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); lb:SetPoint("TOPLEFT", PAD, 0); lb:SetText(label)

    -- Use WowStyle1DropdownTemplate if available, fallback to custom
    local useNative = C_XMLUtil and C_XMLUtil.GetTemplateInfo and C_XMLUtil.GetTemplateInfo("WowStyle1DropdownTemplate")
    if useNative then
        local dd = CreateFrame("DropdownButton", nil, c, "WowStyle1DropdownTemplate")
        dd:SetPoint("TOPLEFT", PAD, -18); dd:SetPoint("RIGHT", -PAD, 0)
        local curSel = selected or "Default"

        -- Font previews share one cache across every dropdown (GLB-04): the
        -- per-dropdown counter created the same BCBFontPv_N name twice
        local GetCachedFont = Config.GetCachedPreviewFont

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
        local sf = BCB.CreateScrollFrame(nil, pp); sf:SetPoint("TOPLEFT", 4, -4); sf:SetPoint("BOTTOMRIGHT", -4, 4)
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

--------------------------------------------------------------------------------
-- KEYBIND CAPTURE BUTTON (BUG-01, CMP-02)
-- One implementation for every keybind button. Left-click captures a key,
-- right-click unbinds. A key already bound elsewhere asks first; the popup gets
-- the action in `data`, so it always binds the action that asked for it.
--------------------------------------------------------------------------------
local MODIFIER_KEYS = { LSHIFT=true, RSHIFT=true, LCTRL=true, RCTRL=true, LALT=true, RALT=true }

function Config.ApplyKeybind(action, fullKey)
    if InCombatLockdown() then return false end
    local k1, k2 = GetBindingKey(action)
    if k1 then SetBinding(k1, nil) end
    if k2 then SetBinding(k2, nil) end
    SetBinding(fullKey, action)
    SaveBindings(GetCurrentBindingSet())
    return true
end

StaticPopupDialogs["BCB_KEYBIND_CONFLICT"] = {
    text = "%s", button1 = YES, button2 = NO,
    OnAccept = function(_, data)
        if data and Config.ApplyKeybind(data.action, data.fullKey) and data.onDone then data.onDone() end
    end,
    timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
}

-- opts.tooltipBound: format string for the tooltip when bound (gets the key text)
-- opts.width: button width (default 140)
-- Returns the button; button.Refresh() updates its text.
function Config.CreateKeybindButton(parent, action, opts)
    opts = opts or {}
    local btn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    btn:SetSize(opts.width or 140, 24)
    btn:RegisterForClicks("AnyUp")

    local function Refresh()
        local key = GetBindingKey(action)
        btn:SetText(key and GetBindingText(key) or L["KEYBIND_NOT_BOUND"])
    end
    btn.Refresh = Refresh
    Refresh()

    -- Stay in sync with WoW's Key Bindings screen (own frame, so the parent's
    -- OnEvent script is left alone)
    local watcher = CreateFrame("Frame", nil, btn)
    BCB.SafeRegisterEvent(watcher, "UPDATE_BINDINGS")
    watcher:SetScript("OnEvent", Refresh)

    local function StopCapture()
        btn:EnableKeyboard(false); btn:SetScript("OnKeyDown", nil); Refresh()
    end

    local function OnKeyCaptured(_, key)
        if MODIFIER_KEYS[key] then return end
        if key == "ESCAPE" or InCombatLockdown() then StopCapture(); return end
        local mods = {}
        if IsAltKeyDown()     then mods[#mods+1] = "ALT"   end
        if IsControlKeyDown() then mods[#mods+1] = "CTRL"  end
        if IsShiftKeyDown()   then mods[#mods+1] = "SHIFT" end
        mods[#mods+1] = key
        local fullKey = table.concat(mods, "-")
        StopCapture()
        local existing = GetBindingAction(fullKey)
        if existing and existing ~= "" and existing ~= action then
            local msg = string.format(L["KEYBIND_CONFLICT"], GetBindingText(fullKey), GetBindingName(existing))
            StaticPopup_Show("BCB_KEYBIND_CONFLICT", msg, nil, { action = action, fullKey = fullKey, onDone = Refresh })
            return
        end
        if Config.ApplyKeybind(action, fullKey) then Refresh() end
    end

    btn:SetScript("OnClick", function(self, button)
        if button == "RightButton" then
            if InCombatLockdown() then return end
            local k1, k2 = GetBindingKey(action)
            if k1 then SetBinding(k1, nil) end
            if k2 then SetBinding(k2, nil) end
            if k1 or k2 then SaveBindings(GetCurrentBindingSet()) end
            Refresh(); GameTooltip:Hide()
        else
            self:SetText(L["KEYBIND_PRESS_KEY"]); self:EnableKeyboard(true)
            self:SetScript("OnKeyDown", OnKeyCaptured)
        end
    end)

    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        local key = GetBindingKey(action)
        if key then
            GameTooltip:AddLine(string.format(opts.tooltipBound or "%s", GetBindingText(key)), 1, 1, 1)
            GameTooltip:AddLine(L["KEYBIND_TOOLTIP_UNBIND"], 0.6, 0.6, 0.6)
        else
            GameTooltip:AddLine(L["KEYBIND_TOOLTIP_SET"], 1, 1, 1)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    return btn
end
