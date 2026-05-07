-- BigChatBox Features/MultilineBox.lua
-- Multiline input box — compose multiple lines and send each as a separate chat message.
-- Shift+Enter (default) opens the box. Enter inserts a newline. Shift+Enter (inside) / Send dispatches all lines.
-- Visual style mirrors the main BCB frame exactly. Channel label floats above the frame like the main editbox.

local BCB = BigChatBox
local L   = BCB.L or {}

local CHAT_MSG_LIMIT = 255

local mlFrame
local mlEditBox
local mlScroll
local mlScrollChild
local mlCounter
local mlChannelBtn
local mlCursorFrame
local mlMeasureFS

local WIN_W_DEF  = 500
local WIN_H_DEF  = 200
local WIN_W_MIN  = 320
local WIN_H_MIN  = 100
local INNER      = 12
local BTN_H      = 24
local BOTTOM_BAR = BTN_H + INNER * 2
local SB_W       = 16
local CURSOR_W   = 2
local BLINK_RATE = 0.53

--------------------------------------------------------------------------------
-- LINE HEIGHT — measured from actual rendered font via FontString.
-- "A\nA" gives two-line height; divide by 2 for single line.
-- Cached and invalidated on font change.
--------------------------------------------------------------------------------
local _cachedLineH     = nil
local _cachedLineHFont = nil
local _cachedLineHSize = nil

local function GetLineH()
    if not mlMeasureFS or not mlEditBox then
        local _, size = mlEditBox and mlEditBox:GetFont() or nil, 12
        return math.floor((size or 12) + 0.5)
    end
    local font, size = mlEditBox:GetFont()
    if _cachedLineH and font == _cachedLineHFont and size == _cachedLineHSize then
        return _cachedLineH
    end
    mlMeasureFS:SetFont(font or "Fonts\\FRIZQT__.TTF", size or 12, "")
    mlMeasureFS:SetWidth(0)
    mlMeasureFS:SetText("A\nA")
    local h = mlMeasureFS:GetStringHeight()
    mlMeasureFS:SetText("")
    local lineH = h and h > 0 and math.floor(h / 2 + 0.5) or math.floor((size or 12) + 2)
    _cachedLineH = lineH; _cachedLineHFont = font; _cachedLineHSize = size
    return lineH
end

local function InvalidateLineHCache() _cachedLineH = nil end

--------------------------------------------------------------------------------
-- TEXT LINE UTILITIES
-- Split text into logical lines and locate cursor within them.
--------------------------------------------------------------------------------
local function SplitLines(text)
    local lines = {}
    local s = 1
    while true do
        local nl = text:find("\n", s, true)
        if nl then lines[#lines+1] = text:sub(s, nl-1); s = nl + 1
        else        lines[#lines+1] = text:sub(s); break end
    end
    return lines
end

-- Returns lineNum (1-based), cursorInLine (0-based byte offset within that line)
local function CursorLineInfo(text, cursorPos)
    local lines     = SplitLines(text)
    local lineNum   = 1
    local bytesSeen = 0
    for i, line in ipairs(lines) do
        local lineBytes = #line + 1
        if bytesSeen + lineBytes > cursorPos then lineNum = i; break end
        bytesSeen = bytesSeen + lineBytes
        lineNum = i + 1
    end
    lineNum = math.min(lineNum, #lines)
    local lineStartByte = 0
    for i = 1, lineNum - 1 do lineStartByte = lineStartByte + #lines[i] + 1 end
    local cursorInLine = math.max(0, math.min(cursorPos - lineStartByte, #(lines[lineNum] or "")))
    return lines, lineNum, cursorInLine, lineStartByte
end

-- Measure pixel width of a string using the measuring FontString
local function MeasureStr(str)
    if not mlMeasureFS or not mlEditBox then return 0 end
    local font, size, flags = mlEditBox:GetFont()
    mlMeasureFS:SetFont(font or "Fonts\\FRIZQT__.TTF", size or 12, flags or "")
    mlMeasureFS:SetWidth(0)
    mlMeasureFS:SetText(str)
    local w = mlMeasureFS:GetStringWidth()
    mlMeasureFS:SetText("")
    return w or 0
end

-- Find the character offset within a line that is closest to pixel x.
-- Uses binary-search style iteration over characters.
local function CharOffsetForX(line, targetX)
    if #line == 0 or targetX <= 0 then return 0 end
    -- Walk characters; stop when we overshoot targetX
    -- We compare midpoints between successive character positions
    local prev = 0
    for i = 1, #line do
        local w = MeasureStr(line:sub(1, i))
        -- If targetX is between prev and w, pick whichever edge is closer
        if w >= targetX then
            if (targetX - prev) < (w - targetX) then
                return i - 1
            else
                return i
            end
        end
        prev = w
    end
    return #line  -- past end of line
end

--------------------------------------------------------------------------------
-- MANUAL VERTICAL CURSOR MOVEMENT
-- UP/DOWN arrow in a multiline EditBox: find the cursor's current X pixel,
-- then find the closest character on the target line at that same X.
--------------------------------------------------------------------------------
local function MoveCursorVertical(direction)
    if not mlEditBox then return end
    local text      = mlEditBox:GetText() or ""
    local cursorPos = mlEditBox:GetCursorPosition() or 0

    local lines, lineNum, cursorInLine = CursorLineInfo(text, cursorPos)

    local targetLineNum = lineNum + direction
    if targetLineNum < 1 or targetLineNum > #lines then return end

    -- Current cursor X in pixels
    local curX = MeasureStr((lines[lineNum] or ""):sub(1, cursorInLine))

    -- Find closest character on target line
    local targetLine   = lines[targetLineNum] or ""
    local targetInLine = CharOffsetForX(targetLine, curX)

    -- Convert back to absolute byte position
    local targetByte = 0
    for i = 1, targetLineNum - 1 do targetByte = targetByte + #lines[i] + 1 end
    targetByte = targetByte + targetInLine

    mlEditBox:SetCursorPosition(targetByte)
end

--------------------------------------------------------------------------------
-- FAKE CURSOR
--------------------------------------------------------------------------------
local cursorVisible = true
local cursorElapsed = 0
local cursorLastPos = -1

local function GetCursorChannelColor()
    local chatType = BCB.editBox and BCB.editBox:GetAttribute("chatType") or "SAY"
    local typeInfo = ChatTypeInfo and ChatTypeInfo[chatType]
    if typeInfo then return typeInfo.r, typeInfo.g, typeInfo.b end
    return 1, 1, 1
end

local function PositionCursor()
    if not mlCursorFrame or not mlEditBox or not mlMeasureFS then return end
    if not mlEditBox:HasFocus() then mlCursorFrame:Hide(); return end

    local text      = mlEditBox:GetText() or ""
    local cursorPos = mlEditBox:GetCursorPosition() or 0
    local lineH     = GetLineH()

    local lines, lineNum, cursorInLine = CursorLineInfo(text, cursorPos)

    local textW = MeasureStr((lines[lineNum] or ""):sub(1, cursorInLine))
    local yOff  = -((lineNum - 1) * lineH)

    mlCursorFrame:ClearAllPoints()
    mlCursorFrame:SetPoint("TOPLEFT", mlEditBox, "TOPLEFT", textW, yOff)
    mlCursorFrame:SetHeight(lineH)
    mlCursorFrame:Show()

    local r, g, b = GetCursorChannelColor()
    mlCursorFrame.tex:SetColorTexture(r, g, b, 1)

    -- Scroll viewport to keep cursor line visible
    if mlScroll then
        local viewH      = mlScroll:GetHeight()
        local curScroll  = mlScroll:GetVerticalScroll() or 0
        local cursorTop  = (lineNum - 1) * lineH          -- pixels from top of content
        local cursorBot  = cursorTop + lineH
        if cursorTop < curScroll then
            mlScroll:SetVerticalScroll(cursorTop)
        elseif cursorBot > curScroll + viewH then
            mlScroll:SetVerticalScroll(cursorBot - viewH)
        end
    end
end

local function SetupCursorBlink()
    if not mlEditBox then return end
    mlEditBox:SetScript("OnUpdate", function(self, elapsed)
        if not mlCursorFrame then return end
        cursorElapsed = cursorElapsed + elapsed
        if cursorElapsed >= BLINK_RATE then
            cursorElapsed = 0
            cursorVisible = not cursorVisible
            if self:HasFocus() then mlCursorFrame:SetShown(cursorVisible)
            else mlCursorFrame:Hide() end
        end
        local pos = self:GetCursorPosition()
        if pos ~= cursorLastPos then
            cursorLastPos = pos
            cursorVisible = true; cursorElapsed = 0
            PositionCursor()
        end
    end)
    mlEditBox:HookScript("OnEditFocusGained", function()
        cursorVisible = true; cursorElapsed = 0; PositionCursor()
    end)
    mlEditBox:HookScript("OnEditFocusLost", function()
        if mlCursorFrame then mlCursorFrame:Hide() end
    end)
end

--------------------------------------------------------------------------------
-- CHARACTER COUNTER
--------------------------------------------------------------------------------
local function UpdateCharCounter()
    if not mlCounter or not mlEditBox then return end
    local text = mlEditBox:GetText() or ""
    local lines = SplitLines(text)
    local totalLines = #lines

    local cursorPos = mlEditBox:GetCursorPosition() or 0
    local _, lineNum = CursorLineInfo(text, cursorPos)

    local curLineLen = #(lines[lineNum] or "")
    local totalChars = 0
    for _, line in ipairs(lines) do totalChars = totalChars + #line end

    local label
    if totalLines > 1 then
        label = string.format("Line %d/%d: %d/%d  (Total: %d)",
            lineNum, totalLines, curLineLen, CHAT_MSG_LIMIT, totalChars)
    else
        label = string.format("%d/%d  (Total: %d)", curLineLen, CHAT_MSG_LIMIT, totalChars)
    end

    mlCounter:SetText(label)
    if curLineLen > CHAT_MSG_LIMIT then
        mlCounter:SetTextColor(1, 0.3, 0.3)
    elseif curLineLen > CHAT_MSG_LIMIT - 30 then
        mlCounter:SetTextColor(1, 0.82, 0)
    else
        mlCounter:SetTextColor(0.6, 0.6, 0.6)
    end
    mlCounter:Show()
end

--------------------------------------------------------------------------------
-- CHANNEL LABEL
--------------------------------------------------------------------------------
local function UpdateChannelLabel()
    if not mlChannelBtn or not BCB.editBox then return end
    local chatType   = BCB.editBox:GetAttribute("chatType") or "SAY"
    local chatTarget = BCB.editBox:GetAttribute("tellTarget")
    local chanTarget = BCB.editBox:GetAttribute("channelTarget")

    local displayText
    if chatType == "WHISPER" and chatTarget and chatTarget ~= "" then
        displayText = "To: " .. (Ambiguate and Ambiguate(chatTarget, "short") or chatTarget)
    elseif chatType == "BN_WHISPER" and chatTarget and chatTarget ~= "" then
        displayText = "To: " .. chatTarget
    elseif chatType == "CHANNEL" and chanTarget then
        local _, chanName = GetChannelName(chanTarget)
        displayText = chanName and chanName ~= ""
            and ("[" .. chanTarget .. "] " .. chanName)
            or  ("[" .. chanTarget .. "]")
    else
        displayText = _G["CHAT_MSG_" .. chatType] or chatType
    end

    local typeInfo = ChatTypeInfo and ChatTypeInfo[chatType]
    local r, g, b = 1, 1, 1
    if typeInfo then r, g, b = typeInfo.r, typeInfo.g, typeInfo.b end

    mlChannelBtn.fs:SetText(displayText)
    mlChannelBtn.fs:SetTextColor(r, g, b)
    local btnW = mlChannelBtn.fs:GetStringWidth() or 0
    mlChannelBtn:SetWidth(math.max(80, btnW + 10))
    mlChannelBtn:Show()

    if mlCursorFrame and mlCursorFrame.tex then
        mlCursorFrame.tex:SetColorTexture(r, g, b, 1)
    end
end

--------------------------------------------------------------------------------
-- APPLY STYLE
--------------------------------------------------------------------------------
local function ApplyStyle()
    if not mlFrame then return end
    local def = BCB.defaults
    if not BigChatBoxDB or not def then return end
    -- If "Use Default style" is checked, use default visual values instead of the user's active style
    local db
    if BigChatBoxDB.multilineUseDefaultStyle ~= false then
        db = {
            bgTexture        = def.bgTexture,
            borderTexture    = def.borderTexture,
            bgTextureName    = def.bgTextureName or "Solid",
            borderTextureName= "Default",
            bgAlpha          = def.bgAlpha,
            bgColor          = def.bgColor,
            borderAlpha      = 1.0,
            borderColor      = { r=1, g=1, b=1 },
            bgScale          = 100,
            bgChannelTint    = false,
            bgTintIntensity  = 50,
            borderThickness  = 16,
            font             = def.font,
            fontSize         = def.fontSize or 14,
            fontOutline      = "None",
            alpha            = 1,
        }
    else
        db = BigChatBoxDB
    end

    local bgTex     = db.bgTexture     or def.bgTexture
    local borderTex = db.borderTexture or def.borderTexture
    local edgeSize  = db.borderThickness or 16

    if bgTex     == "" then bgTex     = nil end
    if borderTex == "" then borderTex = nil end
    if db.bgTextureName     == "None" then bgTex     = nil end
    if db.borderTextureName == "None" then borderTex = nil end

    local bgScale = (db.bgScale or 100) / 100
    local bgInset = 4 + ((1 - bgScale) * 20)

    if mlFrame.SetBackdrop then
        if not borderTex then
            mlFrame:SetBackdrop({
                bgFile = bgTex, tile = false, tileSize = 0, edgeSize = 0,
                insets = { left = bgInset, right = bgInset, top = bgInset, bottom = bgInset },
            })
        else
            mlFrame:SetBackdrop({
                bgFile = bgTex, edgeFile = borderTex,
                tile = false, tileSize = 0, edgeSize = edgeSize,
                insets = { left = bgInset, right = bgInset, top = bgInset, bottom = bgInset },
            })
        end
    end

    local bgAlpha = db.bgAlpha or def.bgAlpha
    local bgColor = db.bgColor or def.bgColor
    local bgR, bgG, bgB = bgColor.r, bgColor.g, bgColor.b

    if db.bgChannelTint and BCB.editBox then
        local chatType = BCB.editBox:GetAttribute("chatType") or "SAY"
        local typeInfo = ChatTypeInfo and ChatTypeInfo[chatType]
        if typeInfo then
            local intensity = (db.bgTintIntensity or 50) / 100
            bgR = bgR * (1 - intensity) + typeInfo.r * intensity
            bgG = bgG * (1 - intensity) + typeInfo.g * intensity
            bgB = bgB * (1 - intensity) + typeInfo.b * intensity
        end
    end

    if mlFrame.SetBackdropColor then
        mlFrame:SetBackdropColor(bgR, bgG, bgB, bgAlpha)
    end

    local chatType = BCB.editBox and BCB.editBox:GetAttribute("chatType") or "SAY"
    local typeInfo = ChatTypeInfo and ChatTypeInfo[chatType]
    local cr, cg, cb = 1, 1, 1
    if typeInfo then cr, cg, cb = typeInfo.r, typeInfo.g, typeInfo.b end
    local bdColor = db.borderColor or { r=1, g=1, b=1 }
    local bdAlpha = db.borderAlpha or 1.0
    if mlFrame.SetBackdropBorderColor then
        mlFrame:SetBackdropBorderColor(
            cr * bdColor.r, cg * bdColor.g, cb * bdColor.b, bdAlpha)
    end

    if db.alpha then mlFrame:SetAlpha(db.alpha) end

    if mlEditBox and db.font and db.fontSize and db.fontSize > 0 then
        mlEditBox:SetFont(db.font, db.fontSize, "")
        if mlMeasureFS then mlMeasureFS:SetFont(db.font, db.fontSize, "") end
        InvalidateLineHCache()
    end
end

--------------------------------------------------------------------------------
-- SCROLLBAR SMART HIDE
--------------------------------------------------------------------------------
local function UpdateScrollbarVisibility()
    if not mlScroll or not mlScrollChild then return end
    local sb = mlScroll.ScrollBar
    if not sb then return end
    if mlScrollChild:GetHeight() > mlScroll:GetHeight() + 2 then
        sb:Show()
    else
        sb:Hide()
        mlScroll:SetVerticalScroll(0)
    end
end

--------------------------------------------------------------------------------
-- SYNC EDITBOX SIZE
--------------------------------------------------------------------------------
local function SyncEditBoxSize()
    if not mlScroll or not mlEditBox or not mlScrollChild then return end
    local sw = mlScroll:GetWidth()
    local sh = mlScroll:GetHeight()
    if not sw or sw <= 0 then return end

    local lineH  = GetLineH()
    local text   = mlEditBox:GetText() or ""
    local nLines = 1
    for _ in text:gmatch("\n") do nLines = nLines + 1 end
    local needed = math.max(sh, nLines * lineH + lineH * 2)

    mlScrollChild:SetWidth(sw)
    mlScrollChild:SetHeight(needed)

    UpdateScrollbarVisibility()
end

--------------------------------------------------------------------------------
-- INSERT NEWLINE AT CURSOR
--------------------------------------------------------------------------------
local function InsertNewline()
    if not mlEditBox then return end
    local pos  = mlEditBox:GetCursorPosition()
    local text = mlEditBox:GetText() or ""
    mlEditBox:SetText(text:sub(1, pos) .. "\n" .. text:sub(pos + 1))
    mlEditBox:SetCursorPosition(pos + 1)
end

--------------------------------------------------------------------------------
-- OPEN CHANNEL MENU
--------------------------------------------------------------------------------
local function OpenChannelMenu(anchor)
    local useModern = C_XMLUtil and C_XMLUtil.GetTemplateInfo
        and C_XMLUtil.GetTemplateInfo("WowStyle1DropdownTemplate")
    if not useModern then return end

    if not mlFrame._chanDropdown then
        mlFrame._chanDropdown = CreateFrame("DropdownButton", nil, UIParent, "WowStyle1DropdownTemplate")
        mlFrame._chanDropdown:SetSize(1, 1)
        mlFrame._chanDropdown:SetAlpha(0)
    end

    mlFrame._chanDropdown:ClearAllPoints()
    mlFrame._chanDropdown:SetPoint("TOPLEFT", anchor, "TOPLEFT", 0, 0)

    mlFrame._chanDropdown:SetupMenu(function(_, rootDescription)
        rootDescription:CreateTitle("Chat Channels")
        local function AddChan(label, chatType, disabled)
            local btn = rootDescription:CreateButton(label, function()
                if BCB.SwitchToChannel then BCB.SwitchToChannel(chatType) end
                UpdateChannelLabel()
                C_Timer.After(0.01, function() if mlEditBox then mlEditBox:SetFocus() end end)
            end)
            if disabled then btn:SetEnabled(false) end
        end
        AddChan("Say",      "SAY")
        AddChan("Yell",     "YELL")
        AddChan("Party",    "PARTY",         not IsInGroup(LE_PARTY_CATEGORY_HOME))
        AddChan("Raid",     "RAID",          not IsInRaid(LE_PARTY_CATEGORY_HOME))
        AddChan("Instance", "INSTANCE_CHAT", not IsInGroup(LE_PARTY_CATEGORY_INSTANCE))
        AddChan("Guild",    "GUILD",         not IsInGuild())
        AddChan("Officer",  "OFFICER",       not IsInGuild())

        local channels = {GetChannelList()}
        if #channels > 0 then
            rootDescription:CreateDivider()
            for i = 1, #channels, 3 do
                local id, name = channels[i], channels[i+1]
                if id and name then
                    rootDescription:CreateButton("[" .. id .. "] " .. name, function()
                        if BCB.editBox then
                            BCB.editBox:SetAttribute("chatType",      "CHANNEL")
                            BCB.editBox:SetAttribute("channelTarget", id)
                            BigChatBoxDB.lastChatType = "CHANNEL"
                            if BCB.UpdateChannelDisplay then BCB.UpdateChannelDisplay() end
                        end
                        UpdateChannelLabel()
                        C_Timer.After(0.01, function() if mlEditBox then mlEditBox:SetFocus() end end)
                    end)
                end
            end
        end

        local wh = BigChatBoxDB and BigChatBoxDB.whisperHistory or {}
        if #wh > 0 then
            rootDescription:CreateDivider()
            rootDescription:CreateTitle("Recent Whispers")
            for _, playerName in ipairs(wh) do
                rootDescription:CreateButton(playerName, function()
                    if BCB.editBox then
                        BCB.editBox:SetAttribute("chatType",   "WHISPER")
                        BCB.editBox:SetAttribute("tellTarget", playerName)
                        BigChatBoxDB.lastChatType = "WHISPER"
                        if BCB.UpdateChannelDisplay then BCB.UpdateChannelDisplay() end
                    end
                    UpdateChannelLabel()
                    C_Timer.After(0.01, function() if mlEditBox then mlEditBox:SetFocus() end end)
                end)
            end
        end
    end)
    mlFrame._chanDropdown:OpenMenu()
end

--------------------------------------------------------------------------------
-- BUILD FRAME
--------------------------------------------------------------------------------
local function BuildMultilineFrame()
    if mlFrame then return end

    local f = CreateFrame("Frame", "BCBMultilineFrame", UIParent, "BackdropTemplate")
    f:SetSize(WIN_W_DEF, WIN_H_DEF)
    f:SetResizable(true)
    if f.SetResizeBounds then f:SetResizeBounds(WIN_W_MIN, WIN_H_MIN) end
    f:SetMovable(true)
    f:SetToplevel(true)
    f:SetClampedToScreen(true)
    f:EnableMouse(true)
    f:SetFrameStrata("HIGH")
    f:SetFrameLevel(100)
    f:Hide()
    mlFrame = f
    BCB.multilineFrame = f

    f:SetScript("OnMouseDown", function(_, btn)
        if btn == "LeftButton" then f:StartMoving() end
    end)
    f:SetScript("OnMouseUp", function() f:StopMovingOrSizing() end)

    tinsert(UISpecialFrames, "BCBMultilineFrame")

    -- ── Channel label ─────────────────────────────────────────────────────────
    local chanBtn = CreateFrame("Button", nil, UIParent)
    chanBtn:SetSize(100, 20)
    chanBtn:SetPoint("BOTTOM", f, "TOP", 0, 4)
    chanBtn:RegisterForClicks("LeftButtonUp")
    chanBtn:SetFrameStrata("FULLSCREEN_DIALOG")
    chanBtn:SetFrameLevel(200)

    local chanFS = chanBtn:CreateFontString(nil, "OVERLAY")
    chanFS:SetPoint("CENTER")
    chanFS:SetJustifyH("CENTER")
    do
        local db  = BigChatBoxDB
        local def = BCB.defaults
        local fp  = (db and db.channelFont)     or (def and def.channelFont)     or "Fonts\\FRIZQT__.TTF"
        local fs  = (db and db.channelFontSize) or (def and def.channelFontSize) or 12
        chanFS:SetFont(fp, fs, "")
    end
    chanFS:SetTextColor(1, 1, 1)
    chanBtn.fs = chanFS
    mlChannelBtn = chanBtn

    chanBtn:SetScript("OnClick",  function(self) OpenChannelMenu(self) end)
    chanBtn:SetScript("OnEnter",  function(self) self.fs:SetTextColor(1, 1, 0.5) end)
    chanBtn:SetScript("OnLeave",  function(self)
        local chatType = BCB.editBox and BCB.editBox:GetAttribute("chatType") or "SAY"
        local ti = ChatTypeInfo and ChatTypeInfo[chatType]
        if ti then self.fs:SetTextColor(ti.r, ti.g, ti.b)
        else self.fs:SetTextColor(1, 1, 1) end
    end)

    f:HookScript("OnHide", function() chanBtn:Hide() end)
    f:HookScript("OnShow", function() chanBtn:Show() end)

    -- ── Bottom bar ────────────────────────────────────────────────────────────
    local hintFS = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    hintFS:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", INNER, INNER)
    hintFS:SetTextColor(0.45, 0.45, 0.45)
    hintFS:SetText(L["MULTILINE_HINT"] or "Enter = new line   |   Shift+Enter = send all")

    local sendBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    sendBtn:SetHeight(BTN_H)
    sendBtn:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -INNER, INNER)
    local sendLabel = L["MULTILINE_SEND_BTN"] or "Send"
    sendBtn:SetText(sendLabel)
    local btnFS = sendBtn:GetFontString()
    if btnFS then
        btnFS:SetText(sendLabel)
        sendBtn:SetWidth(math.max(70, btnFS:GetStringWidth() + 28))
    end
    sendBtn:SetScript("OnClick", function() BCB.SendMultilineMessage() end)

    local counter = f:CreateFontString(nil, "OVERLAY")
    counter:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
    counter:SetAlpha(0.85)
    counter:SetPoint("RIGHT", sendBtn, "LEFT", -10, 0)
    counter:Show()
    mlCounter = counter

    -- ── ScrollFrame ───────────────────────────────────────────────────────────
    local scroll = CreateFrame("ScrollFrame", nil, f, "ScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT",     f, "TOPLEFT",     INNER,           -INNER)
    scroll:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -(INNER + SB_W),  BOTTOM_BAR)
    mlScroll = scroll

    if scroll.ScrollBar then scroll.ScrollBar:Hide() end

    local scrollChild = CreateFrame("Frame", nil, scroll)
    scroll:SetScrollChild(scrollChild)
    local initW = WIN_W_DEF - INNER * 2 - SB_W
    scrollChild:SetSize(initW, WIN_H_DEF)
    mlScrollChild = scrollChild

    -- ── Measuring FontString ──────────────────────────────────────────────────
    local measureFS = f:CreateFontString(nil, "OVERLAY")
    measureFS:SetAlpha(0)
    measureFS:SetNonSpaceWrap(false)
    measureFS:SetPoint("TOPLEFT", f, "TOPLEFT", -9000, 0)
    mlMeasureFS = measureFS

    -- ── Fake cursor ───────────────────────────────────────────────────────────
    local curF = CreateFrame("Frame", nil, scrollChild)
    curF:SetSize(CURSOR_W, 14)
    curF:SetFrameLevel(scrollChild:GetFrameLevel() + 10)
    curF:Hide()
    local curTex = curF:CreateTexture(nil, "OVERLAY")
    curTex:SetAllPoints()
    local r, g, b = GetCursorChannelColor()
    curTex:SetColorTexture(r, g, b, 1)
    curF.tex = curTex
    mlCursorFrame = curF

    -- ── EditBox ───────────────────────────────────────────────────────────────
    local eb = CreateFrame("EditBox", nil, scrollChild)
    eb:SetMultiLine(true)
    eb:SetMaxLetters(0)
    eb:SetAutoFocus(false)
    eb:SetFontObject("ChatFontNormal")
    do
        local db = BigChatBoxDB
        if db and db.font and db.fontSize and db.fontSize > 0 then
            eb:SetFont(db.font, db.fontSize, "")
        end
    end
    eb:SetTextColor(1, 1, 1)
    eb:EnableMouse(true)
    eb:SetTextInsets(0, 0, 0, 0)
    eb:SetAllPoints(scrollChild)
    mlEditBox = eb
    BCB.mlEditBox = eb

    SetupCursorBlink()

    eb:SetScript("OnKeyDown", function(self, key)
        -- UP/DOWN: handle manually for line navigation, block WoW bindings
        if key == "UP" then
            self:SetPropagateKeyboardInput(false)
            MoveCursorVertical(-1)
            return
        elseif key == "DOWN" then
            self:SetPropagateKeyboardInput(false)
            MoveCursorVertical(1)
            return
        end

        -- All other keys: block WoW keybind system
        self:SetPropagateKeyboardInput(false)

        if key == "ESCAPE" then
            BCB.CloseMultiline()
        elseif key == "ENTER" or key == "RETURN" then
            if IsShiftKeyDown() then
                BCB.SendMultilineMessage()
            else
                InsertNewline()
            end
        end
    end)

    eb:SetScript("OnEnterPressed", function() end)
    eb:SetScript("OnTextChanged",   function() UpdateCharCounter(); SyncEditBoxSize() end)
    eb:SetScript("OnCursorChanged", function() UpdateCharCounter() end)

    f:HookScript("OnSizeChanged", function() C_Timer.After(0, SyncEditBoxSize) end)

    -- Resize grip
    local resizeBtn = CreateFrame("Button", nil, f)
    resizeBtn:SetSize(16, 16)
    resizeBtn:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -2, 2)
    resizeBtn:SetFrameLevel(f:GetFrameLevel() + 20)
    local rNormal = resizeBtn:CreateTexture(nil, "ARTWORK")
    rNormal:SetAllPoints(); rNormal:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    local rHl = resizeBtn:CreateTexture(nil, "HIGHLIGHT")
    rHl:SetAllPoints(); rHl:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    resizeBtn:SetScript("OnMouseDown", function(_, btn)
        if btn == "LeftButton" then f:StartSizing("BOTTOMRIGHT") end
    end)
    resizeBtn:SetScript("OnMouseUp", function() f:StopMovingOrSizing() end)

    ApplyStyle()

    f:SetScript("OnShow", function()
        ApplyStyle()
        UpdateCharCounter()
        InvalidateLineHCache()
        cursorLastPos = -1
        C_Timer.After(0, function()
            SyncEditBoxSize()
            UpdateChannelLabel()
            if mlEditBox then mlEditBox:SetFocus() end
        end)
    end)
end

--------------------------------------------------------------------------------
-- OPEN / CLOSE
--------------------------------------------------------------------------------
function BCB_OpenMultiline()
    if BigChatBoxDB and BigChatBoxDB.multilineEnabled == false then return end

    if BCB.IsSecureContentActive and BCB.IsSecureContentActive() then
        BCB:Print(L["MULTILINE_BLOCKED_SECURE"] or "Multiline box is not available during M+/Arena/Rated BG.")
        return
    end

    BuildMultilineFrame()

    if mlFrame:IsShown() then
        mlEditBox:SetFocus(); return
    end

    if not mlFrame._positioned then
        mlFrame._positioned = true
        mlFrame:ClearAllPoints()
        if BCB.frame and BCB.frame:IsShown() then
            mlFrame:SetPoint("BOTTOM", BCB.frame, "TOP", 0, 24)
        else
            mlFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 60)
        end
    end

    mlFrame:Show()
    mlFrame:Raise()
end

function BCB.CloseMultiline()
    if not mlFrame then return end
    mlFrame:Hide()
    if mlEditBox then mlEditBox:SetText(""); mlEditBox:ClearFocus() end
    if mlCursorFrame then mlCursorFrame:Hide() end
    BCB._suppressEditBoxHook = true
    C_Timer.After(0.3, function() BCB._suppressEditBoxHook = false end)
end

--------------------------------------------------------------------------------
-- SEND
-- Snapshot channel attributes BEFORE sending any lines and use BCB.SendDirect
-- for all lines. This bypasses ChatFrame1EditBox entirely, preventing the
-- Blizzard editbox OnShow hook from firing between lines and hijacking the
-- channel (e.g. sending SAY lines to GUILD if BCB opens mid-loop).
-- Snippet expansion and history are handled inline here.
--------------------------------------------------------------------------------
function BCB.SendMultilineMessage()
    if not mlEditBox then return end
    local text = mlEditBox:GetText() or ""
    if text == "" then BCB.CloseMultiline(); return end

    if not BCB.editBox then
        BCB:Print("BCB.editBox not available — cannot send.")
        return
    end

    -- Snapshot channel state once — never reads BCB.editBox again during loop
    local chatType    = BCB.editBox:GetAttribute("chatType")    or "SAY"
    local sendTarget  = BCB.editBox:GetAttribute("tellTarget")  or ""
    local sendChannel = BCB.editBox:GetAttribute("channelTarget")

    -- Smart RAID → INSTANCE_CHAT fallback (same as SendMessage.lua)
    if chatType == "RAID" and not IsInRaid(LE_PARTY_CATEGORY_HOME) then
        if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
            chatType = "INSTANCE_CHAT"
        elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
            chatType = "PARTY"
        end
    end

    local lines = SplitLines(text)

    for _, line in ipairs(lines) do
        local trimmed = line:match("^%s*(.-)%s*$") or line
        if trimmed ~= "" then
            -- Expand snippets if applicable
            local finalText = trimmed
            local snippetChannel
            if finalText:sub(1, 1) ~= "/" and BCB.ExpandSnippets then
                finalText, snippetChannel = BCB.ExpandSnippets(finalText)
            end
            if finalText then
                local sendType    = chatType
                local sendTgt     = sendTarget
                local sendChan    = sendChannel
                -- Snippet channel override
                if snippetChannel and snippetChannel ~= "anywhere" then
                    local chanNum = snippetChannel:match("^channel_(%d+)$")
                    if chanNum then
                        sendType = "CHANNEL"; sendChan = tonumber(chanNum); sendTgt = ""
                    elseif BCB.SNIPPET_CHANNEL_MAP and BCB.SNIPPET_CHANNEL_MAP[snippetChannel] then
                        sendType = BCB.SNIPPET_CHANNEL_MAP[snippetChannel]; sendTgt = ""; sendChan = ""
                    end
                end
                BCB.AddToHistory(finalText, sendType)
                -- Use SendDirect — no ChatFrame1EditBox involved, channel can't be hijacked
                BCB.SendDirect(finalText, sendType, sendTgt, sendChan)
            end
        end
    end

    BCB.CloseMultiline()
end

--------------------------------------------------------------------------------
-- STYLE / CHANNEL REFRESH HOOKS
--------------------------------------------------------------------------------
function BCB.RefreshMultilineStyle() ApplyStyle() end

local _origUpdateBackdrop = BCB.UpdateBackdrop
function BCB.UpdateBackdrop(...)
    if _origUpdateBackdrop then _origUpdateBackdrop(...) end
    if mlFrame then ApplyStyle() end
end

local _origUpdateChannelDisplay = BCB.UpdateChannelDisplay
function BCB.UpdateChannelDisplay(...)
    if _origUpdateChannelDisplay then _origUpdateChannelDisplay(...) end
    if mlFrame and mlFrame:IsShown() then UpdateChannelLabel(); ApplyStyle() end
end

--------------------------------------------------------------------------------
-- SECURE CONTENT GUARD
--------------------------------------------------------------------------------
BCB.RegisterEvent("CHALLENGE_MODE_START", function()
    if mlFrame and mlFrame:IsShown() then BCB.CloseMultiline() end
end)

BCB.RegisterEvent("PLAYER_ENTERING_WORLD", function()
    C_Timer.After(1.1, function()
        if BCB.IsSecureContentActive and BCB.IsSecureContentActive() then
            if mlFrame and mlFrame:IsShown() then BCB.CloseMultiline() end
        end
    end)
end)
