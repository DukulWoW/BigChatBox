-- BigChatBox Config/PatchNotes.lua
-- Patch notes data + two window builders:
--   BCB.ShowPatchNotesPopup()  — first-login popup for current version
--   BCB.ShowPatchNotesViewer() — full accordion viewer (all major releases)
--
-- HOW TO UPDATE FOR A NEW RELEASE:
--   1. Add a new entry at the TOP of BCB.PATCH_NOTES (index [1]).
--   2. Set version = "X.X.0", name = "Release Name", notes = { ... }
--   3. Bump ADDON_VERSION in Init.lua to match.
--   That's it. Both windows pull from this table automatically.

local BCB = BigChatBox
local L = BCB.L or {}

--------------------------------------------------------------------------------
-- PATCH NOTES DATA
-- ADD NEW RELEASES AT THE TOP. Newest entry must be index [1].
--------------------------------------------------------------------------------

BCB.PATCH_NOTES = {
    {
        version = "6.0.0",
        name    = "An oldie but a goddie!",
        notes   = {
            "|cff5599ffClassic support!|r — BigChatBox now works in |cff5599ffTBC Anniversary|r, |cff5599ffMists of Pandaria Classic|r, and |cff5599ffVanilla Classic Era|r.",
            "One addon, all versions. The same editbox, snippets, history, autocomplete, and config window you know from Midnight.",
            "Classic clients use a |cff5599ffcompatibility layer|r that handles API differences transparently — no separate addon to install.",
            "The config window sliders are built from scratch to look identical on Classic, using only universally available primitives.",
            "Language override is a retail-only feature (requires a Midnight TOC directive). Classic uses your client locale automatically.",
            "Multiline box is currently retail-only and will come to Classic in a future update.",
            "All previous features from v5.7.x carry over: multiline box, snippet save button, history search, mouse-wheel sliders.",
        },
    },
    {
        version = "5.7.3",
        name    = "Line Breaker!",
        notes   = {
            "|cff5599ffMultiline input box|r — compose multiple lines and send each as a separate chat message.",
            "Open with |cff5599ffShift+Enter|r (default). Enter adds a new line, Shift+Enter sends all lines.",
            "Channel label above the box, |cff5599ffchannel picker|r on left-click (same as main editbox).",
            "Resizable, draggable, styled to match your current BCB style automatically.",
            "Toggle and rebind in |cff5599ffFeatures tab|r > Multiline Input Box section.",
            "|cff5599ffUse Default style|r option in Features tab — multiline box can use the Default style independently of your active BCB style.",
            "|cff5599ffSnippets now support multiple lines|r — each line is sent as a separate message. Great for guild ads.",
            "|cff5599ffSave button|r added to the snippet editor. Snippet list colors match the snippet's channel.",
            "Snippet text field is taller, shows a |cff5599ffline counter|r when using multiple lines.",
            "Added: Can now search the chat history in the history tab (v5.7.4)",
            "Added: Can now use the mouse scrollwheel to increase and descrease the values by one on all sliders in config (v5.7.4)",
            "Added: The history length counter will turn red if you go above 500 now. I would keep it below that myself (v5.7.5)",
            "Fixed: |cff5599ffRestart Setup|r now performs a full factory reset (previously only cleared the wizard flag).",
            "Fixed: snippet trigger field no longer accepts |cff5599ff!!double bangs|r.",
            "Fixed: changing |cff5599ffPost in|r channel now saves and restores correctly across reloads.",
            "Fixed: Moving the text cursor up and down in the |cff5599ffmultiline input box|r didn't work as intended. (v5.7.3)",
            "Fixed: Can now use mouse pointer to change the location of the text cursor in the |cff5599ffmultiline input box|r. (v5.7.3)",
            "Fixed: The left-click menu of the |cff5599ffmultiline input box|r channel name will now correctly render above the input box, not below it. (v5.7.6)",
        },
    },
    {
        version = "5.6.0",
        name    = "Welcome! Willkommen! Bienvenue! Yokoso! Huanying!",
        notes   = {
            "|cff5599ffFull localization|r in 9 languages: German, French, Spanish, Portuguese (BR), Italian, Japanese, Korean, Simplified Chinese, and Traditional Chinese.",
            "New |cff5599ffpatch notes system|r — see what changed on login, and revisit from the General tab version button.",
            "|cff5599ffVersion button|r in the General tab replaces plain version text. Click it to open full patch notes.",
            "Patch notes accordion lists all major releases with expandable per-version notes.",
        },
    },
    {
        version = "5.5.0",
        name    = "Welcome Aboard!",
        notes   = {
            "|cff5599ffFirst-run setup wizard|r with live style preview walks new users through configuration.",
            "6 |cff5599ffbuilt-in style presets|r: Default, Clean, The Tracker, ElvUI, LS, Platy.",
            "Compact |cff5599ffstyle import/export|r in !BCB1: format — share styles as short strings.",
            "|cff5599ffAutocomplete|r for BNet friends, guild members, and group members with spec icons.",
            "|cff5599ffChannel color tint|r for the background — the box tints to match your active channel.",
            "|cff5599ffCharacter counter|r with 6 placement options (inside, outside corners).",
            "|cff5599ffMessage splitting|r for long messages: Silent, Notice, and Confirm modes.",
        },
    },
    {
        version = "5.3.0",
        name    = "Secure & Sound",
        notes   = {
            "Full |cff5599ffMidnight (12.0) taint safety|r — BCB pauses cleanly during M+ keystones, arenas, and rated BGs.",
            "|cff5599ffDual-mode send path|r: Blizzard editbox in normal play, direct API during secure lockdown.",
            "|cff5599ffKeybind capture UI|r in the Advanced tab (HousingCodex-style).",
            "|cff5599ffCtrl+Enter|r switches to Blizzard's native chat for panels that bypass BCB link insertion.",
            "LibDBIcon |cff5599ffminimap button|r with AddonCompartmentFrame and LibDataBroker support.",
            "|cff5599ffFont Outline dropdown|r replacing old outline/shadow checkboxes — 7 options.",
        },
    },
    {
        version = "5.0.0",
        name    = "The Big Rewrite",
        notes   = {
            "Monolithic ~3400-line Core.lua |cff5599ffsplit into 29 focused files|r across a clean folder structure.",
            "|cff5599ffModular architecture|r: Core/, Editbox/, Features/, Config/, Minimap/, Utils/, Locales/.",
            "Smart scrollframes in all config tabs.",
            "|cff5599ffTwo-pane snippet editor|r with per-channel restrictions and share/export.",
            "|cff5599ffWhisper name autocomplete|r from friends, guild, group, and recent whispers.",
            "|cff5599ffLink hover tooltips|r when hovering links in the input box.",
            "|cff5599ffStyle save/load/export/import|r system.",
        },
    },
}

--------------------------------------------------------------------------------
-- WINDOW 1: FIRST-LOGIN POPUP
-- Shows only BCB.PATCH_NOTES[1] (current version).
-- Triggered from Core/Initialize.lua when seenPatchVersion ~= ADDON_VERSION.
--------------------------------------------------------------------------------

function BCB.ShowPatchNotesPopup()
    if BCB.patchPopupFrame and BCB.patchPopupFrame:IsShown() then return end

    local entry = BCB.PATCH_NOTES and BCB.PATCH_NOTES[1]
    if not entry then return end

    if not BCB.patchPopupFrame then
        local f = CreateFrame("Frame", "BCBPatchNotesPopup", UIParent, "ButtonFrameTemplate")
        f:SetSize(500, 420)
        f:SetPoint("CENTER", 0, 60)
        f:SetToplevel(true)
        f:EnableMouse(true)
        f:SetMovable(true)
        f:SetClampedToScreen(true)
        f:RegisterForDrag("LeftButton")
        f:SetScript("OnDragStart", function() f:StartMoving() end)
        f:SetScript("OnDragStop",  function() f:StopMovingOrSizing() end)
        f:SetFrameStrata("FULLSCREEN_DIALOG")
        ButtonFrameTemplate_HidePortrait(f)
        ButtonFrameTemplate_HideButtonBar(f)
        if f.Inset then f.Inset:Hide() end
        f:SetTitle(L["PATCHNOTES_WINDOW_TITLE"])
        tinsert(UISpecialFrames, "BCBPatchNotesPopup")

        -- Version label + update name below the title bar
        local verFS = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        verFS:SetPoint("TOPLEFT", 20, -38)
        verFS:SetText("|cffff9900v" .. entry.version .. "|r")

        local nameFS = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        nameFS:SetPoint("LEFT", verFS, "RIGHT", 8, 1)
        nameFS:SetText(entry.name)
        nameFS:SetTextColor(0.85, 0.85, 0.85)

        -- Scrollable notes list
        local sf = CreateFrame("ScrollFrame", nil, f, "ScrollFrameTemplate")
        sf:SetPoint("TOPLEFT",    20, -68)
        sf:SetPoint("BOTTOMRIGHT", BCB.IsClassic and -28 or -24, 56)
        local ct = CreateFrame("Frame", nil, sf)
        ct:SetWidth(sf:GetWidth() - 10)
        sf:SetScrollChild(ct)

        local y = 0
        for _, note in ipairs(entry.notes) do
            local nFS = ct:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            nFS:SetPoint("TOPLEFT", 4, y)
            nFS:SetWidth(ct:GetWidth() - 8)
            nFS:SetJustifyH("LEFT")
            nFS:SetSpacing(3)
            nFS:SetTextColor(0.9, 0.9, 0.9)
            nFS:SetText("|cff888888•|r  " .. note)
            y = y - nFS:GetStringHeight() - 9
        end
        ct:SetHeight(math.abs(y) + 10)

        -- "Don't show again" checkbox — checked by default
        local cb = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate")
        cb:SetPoint("BOTTOMLEFT", 14, 24)
        cb:SetChecked(true)
        local cbLabel = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        cbLabel:SetPoint("LEFT", cb, "RIGHT", 2, 0)
        cbLabel:SetText(L["PATCHNOTES_DONT_SHOW"])
        cbLabel:SetTextColor(0.65, 0.65, 0.65)
        f._dontShowCb = cb

        -- L["PATCHNOTES_GOT_IT"] button
        local btn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        btn:SetSize(100, 26)
        btn:SetPoint("BOTTOMRIGHT", -16, 24)
        btn:SetText(L["PATCHNOTES_GOT_IT"])

        local function DoClose()
            if f._dontShowCb:GetChecked() then
                BigChatBoxDB.seenPatchVersion = BCB.PATCH_NOTES[1].version
            end
            f:Hide()
        end
        btn:SetScript("OnClick", DoClose)

        -- Override the template X button to use the same close logic
        if f.CloseButton then
            f.CloseButton:SetScript("OnClick", DoClose)
        end

        BCB.patchPopupFrame = f
    end

    BCB.patchPopupFrame:Show()
    BCB.patchPopupFrame:Raise()
end

--------------------------------------------------------------------------------
-- WINDOW 2: FULL PATCH NOTES VIEWER
-- Opened from the version button in GeneralTab.
-- Current version notes shown expanded at top.
-- Older major releases listed as a collapsible accordion below.
--------------------------------------------------------------------------------

function BCB.ShowPatchNotesViewer()
    -- Toggle if already built
    if BCB.patchViewerFrame then
        if BCB.patchViewerFrame:IsShown() then
            BCB.patchViewerFrame:Hide()
        else
            BCB.patchViewerFrame:Show()
            BCB.patchViewerFrame:Raise()
        end
        return
    end

    local f = CreateFrame("Frame", "BCBPatchNotesViewer", UIParent, "ButtonFrameTemplate")
    f:SetSize(520, 560)
    f:SetPoint("CENTER", 0, 0)
    f:SetToplevel(true)
    f:EnableMouse(true)
    f:SetMovable(true)
    f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function() f:StartMoving() end)
    f:SetScript("OnDragStop",  function() f:StopMovingOrSizing() end)
    ButtonFrameTemplate_HidePortrait(f)
    ButtonFrameTemplate_HideButtonBar(f)
    if f.Inset then f.Inset:Hide() end
    f:SetTitle(L["PATCHNOTES_VIEWER_TITLE"])
    tinsert(UISpecialFrames, "BCBPatchNotesViewer")

    -- Single scrollable column
    local sf = CreateFrame("ScrollFrame", nil, f, "ScrollFrameTemplate")
    sf:SetPoint("TOPLEFT",    14, -42)
    sf:SetPoint("BOTTOMRIGHT", BCB.IsClassic and -28 or -24, 8)
    local ct = CreateFrame("Frame", nil, sf)
    ct:SetWidth(sf:GetWidth() - 10)
    sf:SetScrollChild(ct)

    local IW = ct:GetWidth()  -- inner text width
    local y  = -8             -- running y offset in ct (negative = downward)

    -- ── Current version — always expanded ──────────────────────────────────
    local current = BCB.PATCH_NOTES and BCB.PATCH_NOTES[1]
    if current then
        local curHdr = ct:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        curHdr:SetPoint("TOPLEFT", 0, y)
        curHdr:SetJustifyH("LEFT")
        curHdr:SetText("|cffff9900v" .. current.version .. "|r  " .. current.name)
        y = y - curHdr:GetStringHeight() - 8

        for _, note in ipairs(current.notes) do
            local nFS = ct:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            nFS:SetPoint("TOPLEFT", 8, y)
            nFS:SetWidth(IW - 8)
            nFS:SetJustifyH("LEFT")
            nFS:SetSpacing(2)
            nFS:SetTextColor(0.9, 0.9, 0.9)
            nFS:SetText("|cff888888•|r  " .. note)
            y = y - nFS:GetStringHeight() - 6
        end
        y = y - 10
    end

    -- ── Divider + "Previous Updates" ───────────────────────────────────────
    local numEntries = BCB.PATCH_NOTES and #BCB.PATCH_NOTES or 0
    if numEntries < 2 then
        ct:SetHeight(math.abs(y) + 20)
        BCB.patchViewerFrame = f
        f:Show()
        f:Raise()
        return
    end

    local divLine = ct:CreateTexture(nil, "ARTWORK")
    divLine:SetHeight(1)
    divLine:SetPoint("TOPLEFT",  0, y + 2)
    divLine:SetPoint("TOPRIGHT", 0, y + 2)
    divLine:SetColorTexture(0.3, 0.3, 0.3, 1)
    y = y - 8

    local prevHdr = ct:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    prevHdr:SetPoint("TOPLEFT", 0, y)
    prevHdr:SetJustifyH("LEFT")
    prevHdr:SetText("|cffaaaaaa— Previous Updates —|r")
    y = y - prevHdr:GetStringHeight() - 14

    -- ── Accordion ──────────────────────────────────────────────────────────
    -- Layout strategy: all header buttons and content frames are anchored
    -- to ct with absolute y positions. RefreshLayout() recalculates and
    -- repositions everything whenever a section is toggled.

    local scrollBar = sf.ScrollBar  -- referenced by RefreshLayout and OnClick handlers
    local HEADER_H = 26  -- px height of each header row

    -- Collect older major releases (x.x.0 only, skip index 1)
    local entries = {}
    for i = 2, numEntries do
        local ent = BCB.PATCH_NOTES[i]
        if ent.version:match("%.0$") then
            entries[#entries + 1] = ent
        end
    end

    -- Pre-measure content height for each entry using throwaway FontStrings.
    -- We do this on a hidden measurer frame so GetStringHeight() works correctly.
    local measurer = CreateFrame("Frame", nil, f)
    measurer:SetSize(IW - 20, 200)
    measurer:Hide()

    local function MeasureContentH(ent)
        local h = 0
        for _, note in ipairs(ent.notes) do
            local mFS = measurer:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            mFS:SetWidth(IW - 20)
            mFS:SetSpacing(2)
            mFS:SetText("|cff666666•|r  " .. note)
            h = h + mFS:GetStringHeight() + 5
        end
        return h + 8  -- bottom padding
    end

    -- Build section table
    local sections = {}
    for _, ent in ipairs(entries) do
        sections[#sections + 1] = {
            entry    = ent,
            contentH = MeasureContentH(ent),
            isOpen   = false,
        }
    end

    -- y_base: y position of the first accordion header
    local y_base = y

    -- RefreshLayout: repositions all headers + content frames, updates ct height
    local function RefreshLayout()
        local cy = y_base
        for _, sec in ipairs(sections) do
            sec.hdrBtn:ClearAllPoints()
            sec.hdrBtn:SetPoint("TOPLEFT", ct, "TOPLEFT", 0, cy)
            sec.hdrBtn:SetPoint("RIGHT",   ct, "RIGHT",   0, 0)
            cy = cy - HEADER_H

            if sec.isOpen then
                sec.content:ClearAllPoints()
                sec.content:SetPoint("TOPLEFT", ct, "TOPLEFT", 12, cy)
                sec.content:SetPoint("RIGHT",   ct, "RIGHT",   -4, 0)
                sec.content:Show()
                cy = cy - sec.contentH
            else
                sec.content:Hide()
            end
        end
        ct:SetHeight(math.abs(cy) + 20)
    end

    -- Create header buttons and content frames
    for idx, sec in ipairs(sections) do
        -- Header button
        local hdrBtn = CreateFrame("Button", nil, ct)
        hdrBtn:SetHeight(HEADER_H)

        -- Hover highlight texture
        local hlTex = hdrBtn:CreateTexture(nil, "BACKGROUND")
        hlTex:SetAllPoints()
        hlTex:SetColorTexture(1, 1, 1, 0.05)
        hlTex:Hide()
        hdrBtn:SetScript("OnEnter", function() hlTex:Show() end)
        hdrBtn:SetScript("OnLeave", function() hlTex:Hide() end)

        -- Arrow indicator
        local arrowFS = hdrBtn:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        arrowFS:SetPoint("LEFT", 2, 0)
        arrowFS:SetWidth(14)
        arrowFS:SetText("|cffaaaaaa>|r")
        hdrBtn._arrowFS = arrowFS

        -- Version + name label
        local labelFS = hdrBtn:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        labelFS:SetPoint("LEFT", arrowFS, "RIGHT", 4, 0)
        labelFS:SetJustifyH("LEFT")
        labelFS:SetText("|cffffd100v" .. sec.entry.version .. "|r  " .. sec.entry.name)

        -- Thin bottom separator line
        local sepTex = hdrBtn:CreateTexture(nil, "ARTWORK")
        sepTex:SetHeight(1)
        sepTex:SetPoint("BOTTOMLEFT")
        sepTex:SetPoint("BOTTOMRIGHT")
        sepTex:SetColorTexture(0.2, 0.2, 0.2, 1)

        sec.hdrBtn = hdrBtn

        -- Content frame (populated with bullet notes, hidden until opened)
        local content = CreateFrame("Frame", nil, ct)
        content:SetHeight(sec.contentH)
        content:Hide()

        local cy2 = 0
        for _, note in ipairs(sec.entry.notes) do
            local nFS = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
            nFS:SetPoint("TOPLEFT", 0, cy2)
            nFS:SetWidth(IW - 20)
            nFS:SetJustifyH("LEFT")
            nFS:SetSpacing(2)
            nFS:SetTextColor(0.8, 0.8, 0.8)
            nFS:SetText("|cff666666•|r  " .. note)
            cy2 = cy2 - nFS:GetStringHeight() - 5
        end

        sec.content = content

        -- Click: toggle this section, close all others (one open at a time)
        hdrBtn:SetScript("OnClick", function()
            local wasOpen = sec.isOpen
            for _, s in ipairs(sections) do
                s.isOpen = false
                s.hdrBtn._arrowFS:SetText("|cffaaaaaa>|r")
            end
            if not wasOpen then
                sec.isOpen = true
                arrowFS:SetText("|cffaaaaaa v|r")
            end
            RefreshLayout()
            -- Re-evaluate scrollbar after height change
            if scrollBar then
                C_Timer.After(0.05, function()
                    if ct:GetHeight() > sf:GetHeight() then scrollBar:Show() else scrollBar:Hide() end
                end)
            end
        end)
    end

    -- Initial render (all collapsed)
    RefreshLayout()

    -- Auto-hide scrollbar when content fits; mirror ConfigWidgets smart scroll pattern
    if scrollBar then
        C_Timer.After(0.15, function()
            local contentH = ct:GetHeight()
            local visibleH = sf:GetHeight()
            if contentH <= visibleH then
                scrollBar:Hide()
            else
                scrollBar:Show()
            end
        end)
    end

    BCB.patchViewerFrame = f
    f:Show()
    f:Raise()
end
