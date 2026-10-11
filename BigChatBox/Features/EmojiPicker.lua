-- BigChatBox Features/EmojiPicker.lua
-- A smile icon (assets/smile.tga) on the right edge of the editbox opens a compact picker.
-- Two tabs: Last Used (max 10, no scrollbar) | Emoticons (ScrollFrameTemplate, always shown).
-- Panel width matches BCB.frame width. Opens above or below depending on screen position.
-- Panel is locked (not movable). ESC closes picker first; second ESC closes the editbox.

local BCB = BigChatBox
local L   = BCB.L or {}

--------------------------------------------------------------------------------
-- LAST USED  (session-only, max 10 — fits without scrollbar)
--------------------------------------------------------------------------------
local LAST_USED_MAX = 10

-- lastUsed is backed by BigChatBoxDB.recentEmoticons so it persists across reloads/relogs.
-- DB is not ready at file-load time, so we access it lazily via this helper.
local function GetLastUsed()
    if BigChatBoxDB and BigChatBoxDB.recentEmoticons then
        return BigChatBoxDB.recentEmoticons
    end
    return {}  -- DB not ready yet (should never happen post-init)
end

local function PushLastUsed(entry)
    local t = GetLastUsed()
    for i = #t, 1, -1 do
        if t[i].text == entry.text then table.remove(t, i) end
    end
    table.insert(t, 1, entry)
    if #t > LAST_USED_MAX then t[#t] = nil end
end

--------------------------------------------------------------------------------
-- ASCII EMOTICONS  (WoW-safe chars -- enUS ARIALN only, no CJK/fullwidth)
--------------------------------------------------------------------------------
local EMOTICONS = {
    "(^_^)",            "(^.^)",
    "(^-^)",            "(^o^)",
    "(^_~)",            "(-_-)",
    "(>_<)",            "(._.)",
    "(T_T)",            "(;_;)",
    "(^_^;)",           "(^.^;)",
    "o/",               "\\o",
    "o7",               "\\o/",
    "<o/",              "\\o>",
    "(>^_^)>",          "<(^_^<)",
    "(>^_^)> <(^_^<)",  "(^_^)/~~",
    "(^_^)b",           "(*_*)",
    "(*.*)",            "(^0^)",
    "(>o<)",            "(^3^)",
    "(^_^*)",           "(^-^)v",
    "(^_^)y",           "(^_^o)",
    "(^.^)y",           "(-.-)",
    "(^-^*)",           "(>_<)o",
    "(^_^)o",           "(^o^)o",
    "(^_^)v",           "(*^_^*)",
    "(>_^)",            "(^.^)b",
    "(>_>)",            "(<_<)",
    "<3",               "</3",
    "(*^3^*)",          "(^3^)",
    ":)",               ":D",
    ":P",               "XD",
    "^_^",              ">w<",
}

--------------------------------------------------------------------------------
-- INSERT AT CURSOR  (taint-safe -- BCB.editBox is our own unsecured frame)
--------------------------------------------------------------------------------
function BCB.InsertAtCursor(text)
    local eb = BCB.editBox
    if not eb then return end
    local pos = eb:GetCursorPosition()
    local cur = eb:GetText()
    eb:SetText(cur:sub(1, pos) .. text .. cur:sub(pos + 1))
    eb:SetCursorPosition(pos + #text)
    eb:SetFocus()
end

--------------------------------------------------------------------------------
-- TAB BUTTON  -- plain custom, no PanelTopTabButtonTemplate
--------------------------------------------------------------------------------
local TAB_H = 22

local function CreateTabBtn(parent, label)
    local btn = CreateFrame("Button", nil, parent)
    btn:SetHeight(TAB_H)
    local bg = btn:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints(); btn.bg = bg
    local hl = btn:CreateTexture(nil, "HIGHLIGHT")
    hl:SetAllPoints(); hl:SetColorTexture(1, 1, 1, 0.07)
    local fs = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    fs:SetPoint("CENTER"); fs:SetText(label); btn.fs = fs
    local border = btn:CreateTexture(nil, "BORDER")
    border:SetHeight(1)
    border:SetPoint("BOTTOMLEFT"); border:SetPoint("BOTTOMRIGHT")
    border:SetColorTexture(0.4, 0.35, 0.1, 1); btn.border = border

    function btn:SetActive(on)
        if on then
            self.bg:SetColorTexture(0.18, 0.18, 0.22, 1)
            self.fs:SetTextColor(1, 1, 1, 1)
            self.border:Hide()
        else
            self.bg:SetColorTexture(0.08, 0.08, 0.10, 1)
            self.fs:SetTextColor(0.55, 0.55, 0.55, 1)
            self.border:Show()
        end
    end
    btn:SetActive(false)
    return btn
end

--------------------------------------------------------------------------------
-- PICKER PANEL  -- built lazily on first click, sized to match BCB.frame width
--------------------------------------------------------------------------------
local pickerFrame
local rebuildLastUsed

-- Layout constants
local BORDER   = 3
local PAD      = 6
local AC_BTN_H = 22
local AC_COLS  = 2
local AC_GAP   = 3
local SB_INSET = 22   -- right inset for ScrollFrameTemplate scrollbar (matches Config pattern)

-- Visible emoticon rows before scrolling (panel height is fixed to this)
local VISIBLE_ROWS = 5
local CONTENT_H    = VISIBLE_ROWS * (AC_BTN_H + AC_GAP) + PAD
local PANEL_H      = BORDER + TAB_H + 1 + PAD + CONTENT_H + BORDER

local function BuildPickerPanel()
    if pickerFrame then return end

    local f = CreateFrame("Frame", "BCBEmojiPicker", UIParent, "BackdropTemplate")
    f:SetSize(300, PANEL_H)   -- width overridden in AnchorPicker()
    f:SetToplevel(true)
    f:EnableMouse(true)
    -- Intentionally NOT movable -- panel is locked in place
    f:SetClampedToScreen(true)
    f:Hide()
    f:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 12,
        insets   = { left=BORDER, right=BORDER, top=BORDER, bottom=BORDER },
    })
    f:SetBackdropColor(0.08, 0.08, 0.10, 0.97)
    f:SetBackdropBorderColor(0.40, 0.33, 0.10, 1)
    tinsert(UISpecialFrames, "BCBEmojiPicker")
    pickerFrame          = f
    BCB.emojiPickerFrame = f   -- used by Handlers.lua OnEscapePressed

    -- TABS
    local tabLast  = CreateTabBtn(f, L["EMOJI_TAB_LAST"]  or "Last Used")
    local tabAscii = CreateTabBtn(f, L["EMOJI_TAB_ASCII"] or "Emoticons")

    tabLast:SetPoint("TOPLEFT",  f, "TOPLEFT",  BORDER, -BORDER)
    tabAscii:SetPoint("TOPLEFT", tabLast, "TOPRIGHT", 0, 0)
    f.tabLast  = tabLast
    f.tabAscii = tabAscii

    -- Separator line below tabs
    local sep = f:CreateTexture(nil, "BORDER")
    sep:SetHeight(1)
    sep:SetPoint("TOPLEFT",  f, "TOPLEFT",  BORDER, -(BORDER + TAB_H))
    sep:SetPoint("TOPRIGHT", f, "TOPRIGHT", -BORDER, -(BORDER + TAB_H))
    sep:SetColorTexture(0.40, 0.33, 0.10, 0.8)

    -- CONTENT area top offset (below tabs + separator + padding)
    local CONTENT_Y = -(BORDER + TAB_H + 1 + PAD)

    -- ── LAST USED TAB ────────────────────────────────────────────────────────
    -- Plain frame, no scrollbar. Max 10 entries always fit in PANEL_H.
    local lastContent = CreateFrame("Frame", nil, f)
    lastContent:SetPoint("TOPLEFT",     f, "TOPLEFT",     PAD, CONTENT_Y)
    lastContent:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -PAD, BORDER)
    lastContent:Hide()

    local lastPool = {}
    local function GetOrMakeLastBtn(i)
        if lastPool[i] then return lastPool[i] end
        local btn = CreateFrame("Button", nil, lastContent)
        local bg  = btn:CreateTexture(nil, "BACKGROUND"); btn.bg = bg
        local lbl = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        lbl:SetJustifyH("CENTER"); lbl:SetJustifyV("MIDDLE"); btn.lbl = lbl
        local hl = btn:CreateTexture(nil, "HIGHLIGHT")
        hl:SetAllPoints(); hl:SetColorTexture(0.4, 0.6, 1.0, 0.25)
        lastPool[i] = btn
        return btn
    end

    rebuildLastUsed = function()
        local lastUsed = GetLastUsed()
        for _, b in ipairs(lastPool) do b:Hide() end
        if #lastUsed == 0 then
            if not lastContent.hint then
                local h = lastContent:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
                h:SetPoint("CENTER", 0, 8)
                h:SetText(L["EMOJI_LAST_EMPTY"] or "No recent selections yet.")
                h:SetTextColor(0.5, 0.5, 0.5)
                lastContent.hint = h
            end
            lastContent.hint:Show(); return
        end
        if lastContent.hint then lastContent.hint:Hide() end

        local aW = lastContent:GetWidth()
        local btnW = math.floor((aW - AC_GAP) / AC_COLS) - 1
        for i, e in ipairs(lastUsed) do
            local col = (i-1) % AC_COLS
            local row = math.floor((i-1) / AC_COLS)
            local btn = GetOrMakeLastBtn(i)
            btn:SetSize(btnW, AC_BTN_H)
            btn:SetPoint("TOPLEFT", col*(btnW+AC_GAP), -(row*(AC_BTN_H+AC_GAP)))
            btn.bg:SetAllPoints(); btn.bg:SetColorTexture(0.12, 0.12, 0.14, 0.7)
            btn.lbl:SetAllPoints(); btn.lbl:SetText(e.text); btn.lbl:Show()
            local ec = e
            btn:SetScript("OnClick", function()
                BCB.InsertAtCursor(ec.text); PushLastUsed(ec); f:Hide()
            end)
            btn:Show()
        end
    end

    -- ── EMOTICONS TAB ────────────────────────────────────────────────────────
    -- Uses ScrollFrameTemplate (same as Config) -- always has scrollbar visible.
    -- ScrollFrame pulls in by SB_INSET on the right; scrollbar sits in that space.
    local asciiScroll = CreateFrame("ScrollFrame", nil, f, "ScrollFrameTemplate")
    asciiScroll:SetPoint("TOPLEFT",     f, "TOPLEFT",     PAD,              CONTENT_Y)
    asciiScroll:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -(PAD + SB_INSET), BORDER)
    asciiScroll:Hide()

    -- Content child: built once on first OnShow (GetWidth() is 0 before layout pass)
    local asciiChild = CreateFrame("Frame", nil, asciiScroll)
    asciiScroll:SetScrollChild(asciiChild)
    local asciiBuilt = false

    local origAsciiShow = asciiScroll:GetScript("OnShow")
    asciiScroll:SetScript("OnShow", function(self)
        if origAsciiShow then origAsciiShow(self) end
        if asciiBuilt then return end
        asciiBuilt = true

        local cW = self:GetWidth()
        asciiChild:SetWidth(cW)
        local AC_BTN_W = math.floor((cW - AC_GAP) / AC_COLS) - 1

        for i, emote in ipairs(EMOTICONS) do
            local col = (i-1) % AC_COLS
            local row = math.floor((i-1) / AC_COLS)
            local btn = CreateFrame("Button", nil, asciiChild)
            btn:SetSize(AC_BTN_W, AC_BTN_H)
            btn:SetPoint("TOPLEFT", col*(AC_BTN_W+AC_GAP), -(row*(AC_BTN_H+AC_GAP)))
            local bg = btn:CreateTexture(nil, "BACKGROUND")
            bg:SetAllPoints(); bg:SetColorTexture(0.12, 0.12, 0.14, 0.7)
            local hl = btn:CreateTexture(nil, "HIGHLIGHT")
            hl:SetAllPoints(); hl:SetColorTexture(0.3, 0.5, 0.9, 0.3)
            local lbl = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            lbl:SetPoint("CENTER"); lbl:SetText(emote); lbl:SetJustifyH("CENTER")
            local e = emote
            btn:SetScript("OnClick", function()
                BCB.InsertAtCursor(e); PushLastUsed({text=e}); f:Hide()
            end)
        end
        asciiChild:SetHeight(math.ceil(#EMOTICONS/AC_COLS)*(AC_BTN_H+AC_GAP)+PAD)
    end)

    -- TAB SWITCHING
    local activeTab = "last"
    local function ShowTab(which)
        activeTab = which
        lastContent:SetShown(which == "last")
        asciiScroll:SetShown(which == "ascii")
        tabLast:SetActive(which == "last")
        tabAscii:SetActive(which == "ascii")
        if which == "last" and rebuildLastUsed then rebuildLastUsed() end
    end
    tabLast:SetScript( "OnClick", function() ShowTab("last")  end)
    tabAscii:SetScript("OnClick", function() ShowTab("ascii") end)
    f:SetScript("OnShow", function() ShowTab(activeTab) end)
    f.ShowTab = ShowTab

    ShowTab("last")
end  -- BuildPickerPanel

--------------------------------------------------------------------------------
-- ANCHOR + RESIZE PICKER
-- Sets panel width = BCB.frame width. Opens above/below based on screen position.
-- Called every open so it tracks frame resizes or repositions.
--------------------------------------------------------------------------------
local function AnchorPicker()
    if not pickerFrame then return end
    local fw = BCB.frame:GetWidth()
    pickerFrame:SetWidth(fw)

    -- Two equal tabs
    if pickerFrame.tabLast then
        local tw = math.floor((fw - BORDER * 2) / 2)
        pickerFrame.tabLast:SetWidth(tw)
        pickerFrame.tabAscii:SetWidth(tw)
    end

    pickerFrame:ClearAllPoints()
    local _, cy = BCB.frame:GetCenter()
    local screenMid = UIParent:GetHeight() / 2
    if cy and cy > screenMid then
        -- Input box in top half of screen -- open picker below it
        pickerFrame:SetPoint("TOPRIGHT", BCB.frame, "BOTTOMRIGHT", 0, -4)
    else
        -- Input box in bottom half (or unknown) -- open picker above it
        pickerFrame:SetPoint("BOTTOMRIGHT", BCB.frame, "TOPRIGHT", 0, 4)
    end
end

--------------------------------------------------------------------------------
-- ICON BUTTON  -- smile.tga inside BCB.frame right edge
--------------------------------------------------------------------------------
local ICON_SZ  = 18
local ICON_PAD = 10

local EB_RIGHT_ICON    = -(ICON_SZ + ICON_PAD + 6)
local EB_RIGHT_NO_ICON = -15
local CC_RIGHT_ICON    = -(ICON_SZ + ICON_PAD + 8)
local CC_RIGHT_NO_ICON = -8

local function UpdateAnchors()
    local show = BigChatBoxDB and BigChatBoxDB.showEmojiPicker ~= false
    if BCB.editBox then
        BCB.editBox:ClearAllPoints()
        BCB.editBox:SetPoint("LEFT",  BCB.frame, "LEFT",  15, 0)
        BCB.editBox:SetPoint("RIGHT", BCB.frame, "RIGHT",
            show and EB_RIGHT_ICON or EB_RIGHT_NO_ICON, 0)
    end
    if BCB.charCounter and BigChatBoxDB then
        local pos = BigChatBoxDB.charCounterPos or "inside_right"
        if pos == "inside_right" then
            BCB.charCounter:ClearAllPoints()
            BCB.charCounter:SetPoint("RIGHT", BCB.frame, "RIGHT",
                show and CC_RIGHT_ICON or CC_RIGHT_NO_ICON, 0)
        end
    end
end

function BCB.SetupEmojiIcon()
    if BCB._emojiIconCreated then BCB.RepositionEmojiIcon(); return end
    BCB._emojiIconCreated = true

    local btn = CreateFrame("Button", "BCBEmojiIconBtn", BCB.frame)
    btn:SetSize(ICON_SZ, ICON_SZ)
    btn:SetPoint("RIGHT", BCB.frame, "RIGHT", -ICON_PAD, 0)
    btn:SetFrameLevel(BCB.frame:GetFrameLevel() + 15)
    BCB.emojiIconBtn = btn

    local iconTex = btn:CreateTexture(nil, "ARTWORK")
    iconTex:SetAllPoints()
    iconTex:SetTexture("Interface\\AddOns\\BigChatBox\\assets\\smile.tga")
    iconTex:SetAlpha(0.7)
    btn.iconTex = iconTex

    local hl = btn:CreateTexture(nil, "HIGHLIGHT")
    hl:SetAllPoints(); hl:SetColorTexture(1,1,1,0.15)

    btn:SetScript("OnEnter", function()
        btn.iconTex:SetAlpha(1.0)
        GameTooltip:SetOwner(btn, "ANCHOR_TOPLEFT")
        GameTooltip:SetText(L["EMOJI_PICKER_TITLE"]   or "Emoticon Picker", 1,1,1)
        GameTooltip:AddLine(L["EMOJI_PICKER_TOOLTIP"] or "Click to open picker", 0.7,0.7,0.7)
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function()
        btn.iconTex:SetAlpha(0.7); GameTooltip:Hide()
    end)
    btn:SetScript("OnClick", function()
        BuildPickerPanel()
        if pickerFrame:IsShown() then
            pickerFrame:Hide()
        else
            AnchorPicker()
            pickerFrame:Show()
            pickerFrame:Raise()
        end
    end)

    BCB.RepositionEmojiIcon()
end

function BCB.RepositionEmojiIcon()
    local show = BigChatBoxDB and BigChatBoxDB.showEmojiPicker ~= false
    if BCB.emojiIconBtn then BCB.emojiIconBtn:SetShown(show) end
    UpdateAnchors()
    if not show and pickerFrame and pickerFrame:IsShown() then pickerFrame:Hide() end
end
