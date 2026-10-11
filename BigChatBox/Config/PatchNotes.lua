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
    version = "7.0.0",
    name    = "I intend to live forever",
    entries = {
        NEW .. "WoW Forever support. BigChatBox now loads on the Forever client with its own TOC",
        NEW .. "The setup wizard, the built-in styles and the two help windows now also work on TBC Anniversary, Mists of Pandaria Classic and Classic Era",
        CHANGE .. "Patch notes now show only the notes for the current version",
        CHANGE .. "Restart Setup keeps your snippets, saved styles and chat history; only settings are reset",
        CHANGE .. "Chat messages from BigChatBox use its blue name tag, and the lockdown messages are translated",
        CHANGE .. "A message with several lines (multiline box or a multi-line snippet): a line starting with / stops the send, so commands are never posted as text. Lines over 255 characters are split instead of cut off, and more than 10 messages asks first",
        CHANGE .. "The whisper name suggestions keep the realm for players on other realms, so the whisper reaches the right person",
        CHANGE .. "History tab: Wipe Entire History now says it also clears Recent Whispers, and no longer reloads the UI",
        CHANGE .. "BigChatBox is now licensed under the GPLv3; the logo and icon are All Rights Reserved",
        FIXED .. "Picking a key that is already in use now binds the action you were setting, not always the multiline box. The setup wizard asks first too",
        FIXED .. "/bcb reset and Shift+Alt+click now keep the box at the default position after a reload",
        FIXED .. "Renaming or creating a snippet can no longer overwrite another snippet with the same name; the name turns red instead",
        FIXED .. "Dragging the history length slider no longer deletes history; the new length applies from the next message",
        FIXED .. "A language chosen in BigChatBox now wins over the game client's language, and English can be chosen on any client",
        FIXED .. "After a reload the box no longer opens as a whisper or channel with nobody to send to",
        FIXED .. "Hovering a link in the box shows the exact item (item level, upgrades, random suffix)",
        FIXED .. "Width and height sliders no longer size the box twice when the scale is not 100%",
        FIXED .. "Chinese, Japanese or Korean fonts no longer stick after switching back to another language",
        FIXED .. "Snippet share strings keep a backslash followed by n or t",
        FIXED .. "The snippet Import button says Import, and the Reset All help text says what it resets",
        FIXED .. "Sending many messages no longer slows down over a session once the History tab has been opened",
        FIXED .. "Settings, snippets and whisper history are ready right after login, even when a whisper arrives in the first second",
        FIXED .. "Clicking a player name in chat during combat, a keystone or an arena no longer opens BigChatBox next to Blizzard's box",
        FIXED .. "Font previews in the two font menus no longer show each other's fonts",
        FIXED .. "Changing channel from the main box's menu now also updates the multiline box",
        FIXED .. "Blizzard's chat box no longer flashes on screen every time BigChatBox sends a message",
        { forever = true, FIXED .. "Pressing Enter now opens BigChatBox instead of Blizzard's chat box" },
        { forever = true, FIXED .. "BigChatBox's windows (settings, help, patch notes, setup) line up inside the Forever window frame" },
        { classic = true, FIXED .. "The settings sliders show their track and the +/- buttons again" },
        { classic = true, FIXED .. "The multiline section is hidden in the Features tab, since the multiline box is not on Classic yet" },
        { classic = true, FIXED .. "Key bindings are no longer saved again at every login, and never during combat" },
        { classic = true, CHANGE .. "The version no longer shows rc1" },
        { classic = true, CHANGE .. "BigChatBox no longer pauses in combat on Classic: that pause is only needed for Retail's and Forever's chat restrictions" },
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
    local sf = CreateFrame("ScrollFrame", nil, f, "ScrollFrameTemplate")
    sf:SetPoint("TOPLEFT",    20, -68)
    sf:SetPoint("BOTTOMRIGHT", BCB.IsClassic and -28 or -24, withCheckbox and 56 or 16)
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
