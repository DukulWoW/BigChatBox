-- BigChatBox Config/GeneralTab.lua — General tab (logo, about, feature overview)

local BCB = BigChatBox
local L = BCB.L or {}
local Config = BCB.Config
local PAD = Config.PAD

function Config.BuildGeneralTab(container)
    -- Preview at top (does not scroll)
    local pv = Config.CreatePreview(container, 160)
    pv:SetPoint("TOPLEFT", 10, -4); pv:SetPoint("TOPRIGHT", -10, -4)
    container.previewWidget = pv

    local sf, ct = Config.CreateSmartScrollFrame(container, -172)
    local y = 0

    -- Logo + title + version
    local logo = ct:CreateTexture(nil, "ARTWORK"); logo:SetSize(96, 96); logo:SetPoint("TOP", 0, y)
    logo:SetTexture("Interface\\AddOns\\BigChatBox\\assets\\logo-256"); y = y - 100
    local tit = ct:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge"); tit:SetPoint("TOP", 0, y); tit:SetText("|cff5599ffBigChatBox|r"); y = y - 16
    local by = ct:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall"); by:SetPoint("TOP", 0, y); by:SetText(L["AUTHOR"]); by:SetTextColor(1,1,1); y = y - 14
    local verBtn = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); verBtn:SetSize(80, 22); verBtn:SetPoint("TOP", 0, y)
    verBtn:SetText("v" .. BCB.ADDON_VERSION)
    verBtn:SetScript("OnClick", function() if BCB.ShowPatchNotesViewer then BCB.ShowPatchNotesViewer() end end)
    verBtn:SetScript("OnEnter", function(btn) GameTooltip:SetOwner(btn, "ANCHOR_TOP"); GameTooltip:AddLine(L["BTN_VIEW_PATCH_NOTES"], 1, 1, 1); GameTooltip:Show() end)
    verBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    y = y - 26
    local updateName = ct:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall"); updateName:SetPoint("TOP", 0, y); updateName:SetText(BCB.UPDATE_NAME or ""); updateName:SetTextColor(1, 0.6, 0); y = y - 20

    -- 2x4 feature grid
    -- Content width is WINDOW_WIDTH - 50 = 550. PAD=20 each side, gap=20 between cols.
    -- cellW = (550 - PAD*2 - 20) / 2 = (550 - 60) / 2 = 245
    local cellW = (Config.WINDOW_WIDTH - 50 - PAD * 2 - 20) / 2
    local function Cell(px, py, hdr, desc)
        local h = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightMedium"); h:SetPoint("TOPLEFT", px, py); h:SetText(hdr); h:SetWidth(cellW); h:SetJustifyH("LEFT")
        local t = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); t:SetPoint("TOPLEFT", px, py - 18); t:SetText(desc); t:SetWidth(cellW); t:SetJustifyH("LEFT"); t:SetSpacing(2); t:SetTextColor(0.8,0.8,0.8)
        return t:GetStringHeight() + 22
    end
    local col2 = PAD + cellW + 20
    local h1, h2

    h1 = Cell(PAD,  y, L["CELL_SNIPPETS_HDR"],      "Text shortcuts that expand on send.\nManage in the Snippets tab.")
    h2 = Cell(col2, y, L["CELL_ANCHOR_HDR"],  "Click and drag to reposition.\nArrow keys for pixel precision.")
    y = y - math.max(h1, h2) - 8

    h1 = Cell(PAD,  y, L["CELL_AUTOCOMPLETE_HDR"],   "Smart Tab for commands, whispers,\nand snippet triggers (!guild).")
    h2 = Cell(col2, y, L["CELL_HISTORY_HDR"],   "Full history with timestamps.\nScroll with mouse wheel.")
    y = y - math.max(h1, h2) - 8

    h1 = Cell(PAD,  y, L["CELL_CUSTOMIZATION_HDR"],  "Designer tab for backgrounds, borders,\nfonts, colors. Save & share styles.")
    h2 = Cell(col2, y, L["CELL_SECURE_HDR"], "Auto-pauses in M+, arenas, and\nrated BGs to protect your chat.")
    y = y - math.max(h1, h2) - 8

    h1 = Cell(PAD,  y, L["CELL_SHARING_HDR"],        "Export styles and snippets as short\nstrings to share with friends.")
    h2 = Cell(col2, y, L["CELL_LONGMSG_HDR"],  "Messages over 255 chars split\nautomatically. Silent, notice, or confirm.")
    y = y - math.max(h1, h2) - 16

    -- Help buttons — centered at the bottom
    -- Total width: 130 + 6 + 140 + 6 + 130 = 412. Center x = (550 - 412) / 2 = 69
    local btnX = (Config.WINDOW_WIDTH - 50 - 412) / 2
    local hb  = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); hb:SetSize(130, 24);  hb:SetPoint("TOPLEFT",  btnX,           y); hb:SetText(L["BTN_HELP_AND_TIPS"])
    local scb = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); scb:SetSize(140, 24); scb:SetPoint("TOPLEFT", btnX + 136,     y); scb:SetText(L["BTN_COMBAT_LOCKOUT_INFO"])
    local shb = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); shb:SetSize(130, 24); shb:SetPoint("TOPLEFT", btnX + 136+146, y); shb:SetText(L["BTN_SHIFT_CLICK_INFO"])
    hb:SetScript("OnClick",  function() BCB.ShowHelpWindow() end)
    scb:SetScript("OnClick", function() if BCB.ShowSecureContentHelp then BCB.ShowSecureContentHelp() end end)
    shb:SetScript("OnClick", function() if BCB.ShowShiftClickHelp    then BCB.ShowShiftClickHelp()    end end)
    y = y - 34

    -- Solidarity line
    local ASSET = "Interface\\AddOns\\BigChatBox\\assets\\"
    local sol = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    sol:SetPoint("TOP", 0, y)
    sol:SetJustifyH("CENTER")
    sol:SetTextColor(0.85, 0.85, 0.85)
    sol:SetText(
        "LGBTQIA+ " .. "|T" .. ASSET .. "flag-pride:14:20|t" ..
        " Pride  \226\128\148  Trans " .. "|T" .. ASSET .. "flag-trans:14:20|t" ..
        " Rights  \226\128\148  Slava " .. "|T" .. ASSET .. "flag-ua:14:20|t" ..
        " Ukraini  \226\128\148  Free " .. "|T" .. ASSET .. "flag-ps:14:20|t" ..
        " Palestine"
    )
    y = y - 20

    ct:SetHeight(math.abs(y) + 20); sf:UpdateScrollbar()
end
