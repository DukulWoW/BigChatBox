-- BigChatBox Config/PatchNotes.lua
-- Patch notes for the CURRENT version only (same model as BigNoteBox's WhatsNewData).
--   BCB.ShowPatchNotesPopup()  - first-login popup, once per version
--   BCB.ShowPatchNotesViewer() - the same notes, opened from the version button
--
-- HOW TO UPDATE FOR A NEW RELEASE:
--   1. Set `version` to the new version (must match Init.lua and every TOC).
--   2. Set `name` to the release name (shown under the version on the General tab).
--   3. Replace `entries` with the notes for this version. Older notes are not kept
--      here; the full history lives in CHANGELOG / the release pages.
--   4. A line for some clients only is a table instead of a string:
--        { forever = true, "..." }   -- WoW Forever only
--        { retail  = true, "..." }   -- Retail only
--        { classic = true, "..." }   -- TBC, MoP and Classic Era only
--   Plain ASCII only. Prefix lines with the coloured New/Change/Fixed/Removed tags.
--
-- VERSIONING: follow BigNoteBox's X.Y.Z rules (kept in BNB's project files).
-- TODO(Dukul): copy those rules here. The popup shows again whenever `version` changes.

local BCB = BigChatBox
local L = BCB.L or {}

local NEW    = "|cff66bb6aNew:|r "
local CHANGE = "|cff66bb6aChange:|r "
local FIXED  = "|cff66bb6aFixed:|r "

--------------------------------------------------------------------------------
-- PATCH NOTES DATA
--------------------------------------------------------------------------------

BCB.PATCH_NOTES = {
    version = "7.0.1",
    name    = "I intend to live forever",
    entries = {
        CHANGE .. "Protected commands such as /cast, /target and /focus now move to Blizzard's chat box instead of failing: press Enter again to run them",
        FIXED .. "/join and /leave typed in BigChatBox no longer give an \"action blocked\" error on Retail and WoW Forever: they move to Blizzard's chat box, press Enter again to run them",
        FIXED .. "Accepting the \"allow scripts\" popup after a /run, /script or /dump from BigChatBox no longer fails: until scripts are allowed, these commands move to Blizzard's chat box",
        FIXED .. "A chat lockdown without combat now says \"Paused during a chat lockdown\" instead of \"combat\", and is announced again the next time it starts",
        FIXED .. "A command typed while a lockdown began is no longer posted to chat as plain text",
        { classic = true, FIXED .. "The language choice in the setup wizard and Settings > Advanced is now shown on Classic too" },
    },
}

-- Lines for this client only (tables carry a client tag).
local function ClientEntries()
    local out = {}
    for _, entry in ipairs(BCB.PATCH_NOTES.entries or {}) do
        if type(entry) == "table" then
            local show
            if entry.forever then show = BCB.IsForever
            elseif entry.retail then show = not BCB.IsForever and not BCB.IsClassic
            elseif entry.classic then show = BCB.IsClassic
            else show = true end
            if show and entry[1] then out[#out + 1] = entry[1] end
        else
            out[#out + 1] = entry
        end
    end
    return out
end
BCB.GetPatchNoteEntries = ClientEntries

--------------------------------------------------------------------------------
-- WINDOW: shared builder for the popup (with "don't show again") and the viewer
--------------------------------------------------------------------------------

local function BuildWindow(name, title, withCheckbox)
    local data = BCB.PATCH_NOTES
    local f = CreateFrame("Frame", name, UIParent, "ButtonFrameTemplate")
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
    BCB.SeatChrome(f)  -- Forever border offset (Utils.lua)
    f:SetTitle(title)
    tinsert(UISpecialFrames, name)

    -- Version label + release name below the title bar
    local verFS = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    verFS:SetPoint("TOPLEFT", 20, -38)
    verFS:SetText("|cffff9900v" .. data.version .. "|r")

    local nameFS = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    nameFS:SetPoint("LEFT", verFS, "RIGHT", 8, 1)
    nameFS:SetText(data.name or "")
    nameFS:SetTextColor(0.85, 0.85, 0.85)

    -- Scrollable notes list
    local sf = BCB.CreateScrollFrame(nil, f)
    sf:SetPoint("TOPLEFT",    20, -68)
    sf:SetPoint("BOTTOMRIGHT", -24, withCheckbox and 56 or 16)
    local ct = CreateFrame("Frame", nil, sf)
    ct:SetWidth(sf:GetWidth() - 10)
    sf:SetScrollChild(ct)

    local y = 0
    for _, note in ipairs(ClientEntries()) do
        local nFS = ct:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        nFS:SetPoint("TOPLEFT", 4, y)
        nFS:SetWidth(ct:GetWidth() - 8)
        nFS:SetJustifyH("LEFT")
        nFS:SetSpacing(3)
        nFS:SetTextColor(0.9, 0.9, 0.9)
        nFS:SetText(note)
        y = y - nFS:GetStringHeight() - 9
    end
    ct:SetHeight(math.abs(y) + 10)

    if withCheckbox then
        -- "Don't show again" checkbox - checked by default
        local cb = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate")
        cb:SetPoint("BOTTOMLEFT", 14, 24)
        cb:SetChecked(true)
        local cbLabel = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        cbLabel:SetPoint("LEFT", cb, "RIGHT", 2, 0)
        cbLabel:SetText(L["PATCHNOTES_DONT_SHOW"])
        cbLabel:SetTextColor(0.65, 0.65, 0.65)

        local btn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        btn:SetSize(100, 26)
        btn:SetPoint("BOTTOMRIGHT", -16, 24)
        btn:SetText(L["PATCHNOTES_GOT_IT"])

        local function DoClose()
            if cb:GetChecked() then BigChatBoxDB.seenPatchVersion = data.version end
            f:Hide()
        end
        btn:SetScript("OnClick", DoClose)
        if f.CloseButton then f.CloseButton:SetScript("OnClick", DoClose) end
    end

    return f
end

-- First-login popup. Triggered from Core/Initialize.lua when seenPatchVersion ~= version.
function BCB.ShowPatchNotesPopup()
    if not BCB.PATCH_NOTES or not BCB.PATCH_NOTES.version then return end
    if not BCB.patchPopupFrame then
        BCB.patchPopupFrame = BuildWindow("BCBPatchNotesPopup", L["PATCHNOTES_WINDOW_TITLE"], true)
    end
    BCB.patchPopupFrame:Show()
    BCB.patchPopupFrame:Raise()
end

-- Viewer, opened from the version button in GeneralTab. Toggles.
function BCB.ShowPatchNotesViewer()
    if not BCB.PATCH_NOTES or not BCB.PATCH_NOTES.version then return end
    if not BCB.patchViewerFrame then
        BCB.patchViewerFrame = BuildWindow("BCBPatchNotesViewer", L["PATCHNOTES_VIEWER_TITLE"], false)
        BCB.patchViewerFrame:Show()
    elseif BCB.patchViewerFrame:IsShown() then
        BCB.patchViewerFrame:Hide()
        return
    else
        BCB.patchViewerFrame:Show()
    end
    BCB.patchViewerFrame:Raise()
end
