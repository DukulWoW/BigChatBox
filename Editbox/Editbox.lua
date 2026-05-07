-- BigChatBox Editbox/Editbox.lua — Main editbox frame creation & visual updates
-- Creates the BCB frame, editbox widget, placeholder text, and font/backdrop updaters.

local BCB = BigChatBox
local defaults = BCB.defaults

--------------------------------------------------------------------------------
-- CREATE THE MAIN FRAME
--------------------------------------------------------------------------------
function BCB.CreateBigChatBox()
    local frame = CreateFrame("Frame", "BigChatBoxFrame", UIParent, "BackdropTemplate")

    local db = BigChatBoxDB
    local width  = db.width  or defaults.size.width
    local height = db.height or defaults.size.height
    local alpha  = db.alpha  or defaults.alpha

    frame:SetSize(width, height)
    frame:SetAlpha(alpha)
    frame:SetFrameStrata("FULLSCREEN_DIALOG")
    frame:SetFrameLevel(100)

    -- Backdrop
    local bgTex     = db.bgTexture     or defaults.bgTexture
    local borderTex = db.borderTexture or defaults.borderTexture
    frame:SetBackdrop({
        bgFile   = bgTex,
        edgeFile = borderTex,
        tile = false, tileSize = 0, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    local bgAlpha     = db.bgAlpha     or defaults.bgAlpha
    local borderAlpha = db.borderAlpha or defaults.borderAlpha
    frame:SetBackdropColor(0, 0, 0, bgAlpha)
    frame:SetBackdropBorderColor(1, 1, 1, borderAlpha)

    -- Position
    frame:ClearAllPoints()
    if db.point then
        frame:SetPoint(db.point, UIParent, db.point, db.x or 0, db.y or 0)
    else
        local xOff = db.xOffset or defaults.position.x
        local yOff = db.yOffset or defaults.position.y
        frame:SetPoint(defaults.position.point, UIParent, defaults.position.point, xOff, yOff)
    end

    frame:SetMovable(true)
    frame:EnableMouse(false)
    frame:SetClampedToScreen(true)
    frame:Hide()

    BCB.frame = frame
    return frame
end

--------------------------------------------------------------------------------
-- CREATE THE EDITBOX WIDGET
--------------------------------------------------------------------------------
function BCB.CreateEditBox(parent)
    local editBox = CreateFrame("EditBox", "BigChatBoxEditBox", parent)
    editBox:SetMultiLine(false)
    editBox:SetAutoFocus(true)
    editBox:SetMaxLetters(0)

    local fontPath = BigChatBoxDB.font     or defaults.font
    local fontSize = BigChatBoxDB.fontSize or defaults.fontSize
    editBox:SetFont(fontPath, fontSize, "")

    editBox:SetPoint("LEFT",  parent, "LEFT",  15, 0)
    editBox:SetPoint("RIGHT", parent, "RIGHT", -15, 0)
    editBox:SetHeight(20)
    editBox:SetTextInsets(0, 0, 0, 0)
    editBox:SetCursorPosition(0)

    BCB.editBox = editBox

    -- Mouse wheel history scrolling on the parent frame
    local historyIndex = 0
    local savedText = ""
    parent:EnableMouseWheel(true)
    parent:SetScript("OnMouseWheel", function(_, delta)
        if BigChatBoxDB.enableMouseWheelHistory == false then return end
        local hist = BigChatBoxDB.history or {}
        if #hist == 0 then return end
        if delta > 0 then
            if historyIndex == 0 then savedText = editBox:GetText() end
            historyIndex = math.min(historyIndex + 1, #hist)
            local entry = hist[historyIndex]
            local txt = type(entry) == "table" and entry.text or tostring(entry)
            editBox:SetText(txt); editBox:SetCursorPosition(#txt)
        else
            historyIndex = math.max(historyIndex - 1, 0)
            if historyIndex == 0 then
                editBox:SetText(savedText); editBox:SetCursorPosition(#savedText)
            else
                local entry = hist[historyIndex]
                local txt = type(entry) == "table" and entry.text or tostring(entry)
                editBox:SetText(txt); editBox:SetCursorPosition(#txt)
            end
        end
    end)
    editBox:HookScript("OnTextChanged", function(_, userInput)
        if userInput then historyIndex = 0 end
    end)

    -- Placeholder text — grey hint shown on hover when editbox is empty
    local placeholder = parent:CreateFontString(nil, "OVERLAY")
    placeholder:SetPoint("LEFT", editBox, "LEFT", 2, 0)
    placeholder:SetFont(editBox:GetFont())
    placeholder:SetTextColor(0.5, 0.5, 0.5, 0.7)
    placeholder:SetText("Scroll history with mouse wheel and arrow keys...")
    placeholder:Hide()
    BCB.placeholder = placeholder

    local function UpdatePlaceholder()
        if not placeholder then return end
        local hasText = editBox:GetText() ~= ""
        local isHovered = parent.bcbMouseOver
        if not hasText and isHovered then placeholder:Show() else placeholder:Hide() end
    end

    parent:HookScript("OnEnter", function() parent.bcbMouseOver = true;  UpdatePlaceholder() end)
    parent:HookScript("OnLeave", function() parent.bcbMouseOver = false; UpdatePlaceholder() end)
    editBox:HookScript("OnEnter", function() parent.bcbMouseOver = true;  UpdatePlaceholder() end)
    editBox:HookScript("OnLeave", function() parent.bcbMouseOver = false; UpdatePlaceholder() end)
    -- NOTE: OnTextChanged hooks are registered in BCB.SetupEditBoxHooks() which
    -- must be called AFTER SetupEditBoxHandlers() sets the base OnTextChanged script.

    -- Character counter — overlay frame for outside positions, background for inside
    local counterFrame = CreateFrame("Frame", nil, parent)
    counterFrame:SetAllPoints(parent)
    counterFrame:SetFrameLevel(parent:GetFrameLevel() + 10)
    local charCounter = counterFrame:CreateFontString(nil, "OVERLAY")
    charCounter:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
    charCounter:SetAlpha(0.8)
    charCounter:Hide()
    BCB.charCounter = charCounter

    local CHAT_MSG_LIMIT = 255
    local function PositionCharCounter()
        charCounter:ClearAllPoints()
        local pos = BigChatBoxDB and BigChatBoxDB.charCounterPos or "inside_right"
        if pos == "outside_topleft" then
            counterFrame:SetFrameLevel(parent:GetFrameLevel() + 10)
            charCounter:SetPoint("BOTTOMLEFT", parent, "TOPLEFT", 4, 2)
        elseif pos == "outside_topright" then
            counterFrame:SetFrameLevel(parent:GetFrameLevel() + 10)
            charCounter:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT", -4, 2)
        elseif pos == "outside_bottomleft" then
            counterFrame:SetFrameLevel(parent:GetFrameLevel() + 10)
            charCounter:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 4, -2)
        elseif pos == "outside_bottomright" then
            counterFrame:SetFrameLevel(parent:GetFrameLevel() + 10)
            charCounter:SetPoint("TOPRIGHT", parent, "BOTTOMRIGHT", -4, -2)
        elseif pos == "outside_middleleft" then
            counterFrame:SetFrameLevel(parent:GetFrameLevel() + 10)
            charCounter:SetPoint("RIGHT", parent, "LEFT", -4, 0)
        elseif pos == "outside_middleright" then
            counterFrame:SetFrameLevel(parent:GetFrameLevel() + 10)
            charCounter:SetPoint("LEFT", parent, "RIGHT", 4, 0)
        else -- inside_right (default) — behind typed text
            counterFrame:SetFrameLevel(editBox:GetFrameLevel() - 1)
            charCounter:SetPoint("RIGHT", parent, "RIGHT", -8, 0)
        end
    end
    PositionCharCounter()
    BCB.RepositionCharCounter = PositionCharCounter

    local function UpdateCharCounter()
        if BigChatBoxDB and BigChatBoxDB.charCounterPos == "off" then
            charCounter:Hide()
            return
        end
        local text = editBox:GetText()
        local len = #text
        if len == 0 then
            charCounter:Hide()
            return
        end
        charCounter:SetText(len .. "/" .. CHAT_MSG_LIMIT)
        if len > CHAT_MSG_LIMIT then
            charCounter:SetTextColor(1, 0.3, 0.3)  -- red: over limit
        elseif len > CHAT_MSG_LIMIT - 30 then
            charCounter:SetTextColor(1, 0.82, 0)    -- yellow: approaching limit
        else
            charCounter:SetTextColor(0.6, 0.6, 0.6) -- grey: normal
        end
        charCounter:Show()
    end

    -- Register OnTextChanged hooks AFTER SetupEditBoxHandlers sets the base script.
    -- Called from Initialize.lua step 2b.
    function BCB.SetupEditBoxHooks()
        editBox:HookScript("OnTextChanged", function() UpdatePlaceholder() end)
        editBox:HookScript("OnTextChanged", function() UpdateCharCounter() end)
        editBox:HookScript("OnTextChanged", function()
            if BigChatBoxDB.dynamicWidth then BCB.UpdateDynamicWidth() end
        end)
    end

    -- Dynamic height: adjust frame height based on font size
    function BCB.UpdateDynamicHeight()
        if not BCB.frame or not BCB.editBox then return end
        if not BigChatBoxDB.dynamicHeight then
            BCB.frame:SetHeight(BigChatBoxDB.height or 50)
            return
        end
        local fontSize = BigChatBoxDB.fontSize or 14
        local newH = math.max(30, math.floor(fontSize * 2.8 + 8))
        BCB.frame:SetHeight(newH)
    end

    -- Hidden FontString used to measure rendered text width for dynamic width feature.
    -- EditBox does not expose GetStringWidth(); only FontString does.
    local measureFS = UIParent:CreateFontString(nil, "OVERLAY")
    measureFS:Hide()

    -- Dynamic width: grow frame width based on actual text render width, capped at 80% screen
    function BCB.UpdateDynamicWidth()
        if not BCB.frame or not BCB.editBox then return end
        if not BigChatBoxDB.dynamicWidth then
            BCB.frame:SetWidth(BigChatBoxDB.width or 400)
            return
        end
        local baseW = BigChatBoxDB.width or 400
        local text = editBox:GetText() or ""
        if text == "" then
            BCB.frame:SetWidth(baseW)
            return
        end
        -- Mirror the editbox font onto the measurement FontString, then measure
        local fontPath, fontSize, fontFlags = editBox:GetFont()
        if fontPath then measureFS:SetFont(fontPath, fontSize, fontFlags or "") end
        measureFS:SetText(text)
        local textWidth = measureFS:GetStringWidth() or 0
        local neededW = textWidth + 40  -- padding for cursor + insets
        local maxW = math.floor(UIParent:GetWidth() * 0.8)
        local newW = math.max(baseW, math.min(neededW, maxW))
        BCB.frame:SetWidth(newW)
    end

    BCB._updatePlaceholderFont = function()
        if placeholder and BCB.editBox then
            local f, s, fl = BCB.editBox:GetFont()
            if f then placeholder:SetFont(f, s, fl) end
        end
    end

    return editBox
end

--------------------------------------------------------------------------------
-- MOVEMENT / POSITION RESET
--------------------------------------------------------------------------------
function BCB.SetupMovement()
    local frame = BCB.frame

    frame:EnableMouse(true)
    frame:SetScript("OnHide", function()
        if BCB.editBox then
            BCB.editBox:SetText("")
            BCB.editBox:SetCursorPosition(0)
        end
        if not BCB.IsSecureContentActive() then
            if ChatFrame1EditBox then ChatFrame1EditBox:SetText("") end
            if ChatFrame1EditBox and ACTIVE_CHAT_EDIT_BOX == ChatFrame1EditBox then
                ACTIVE_CHAT_EDIT_BOX = nil
            end
        end
    end)

    frame:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" and IsShiftKeyDown() and IsAltKeyDown() then
            self:ClearAllPoints()
            self:SetPoint(defaults.position.point, UIParent, defaults.position.point,
                defaults.position.x, defaults.position.y)
            BigChatBoxDB.point   = nil
            BigChatBoxDB.x       = nil
            BigChatBoxDB.y       = nil
            BigChatBoxDB.xOffset = defaults.position.x
            BigChatBoxDB.yOffset = defaults.position.y
            print("|cff00ff00BigChatBox:|r Position reset to default")
        end
    end)
end

--------------------------------------------------------------------------------
-- UPDATE FUNCTIONS (called from Config and internally)
--------------------------------------------------------------------------------
function BCB.UpdateFontSize()
    if not BCB.editBox then return end
    local fontPath = BigChatBoxDB.font or defaults.font
    local fontSize = BigChatBoxDB.fontSize or defaults.fontSize
    -- If the stored font is the western default but the active locale is CJK,
    -- use the CJK font so Chinese/Japanese/Korean text renders correctly.
    -- This handles existing users who had font set before selecting a CJK locale.
    if (fontPath == defaults.font or fontPath == "Fonts\\FRIZQT__.TTF") then
        local cjkFont = BCB.GetUIFont and BCB.GetUIFont()
        if cjkFont and cjkFont ~= defaults.font then
            fontPath = cjkFont
        end
    end
    local outline  = BigChatBoxDB.fontOutline or "None"
    local flags = ""
    if     outline == "Outline"           then flags = "OUTLINE"
    elseif outline == "Thick Outline"     then flags = "THICKOUTLINE"
    elseif outline == "Monochrome Outline" then flags = "MONOCHROME,OUTLINE"
    end
    BCB.editBox:SetFont(fontPath, fontSize, flags)
    BCB.editBox:SetJustifyH(BigChatBoxDB.textAlign or "LEFT")
    -- Shadows
    if     outline == "Drop Shadow"          then BCB.editBox:SetShadowOffset(1, -1); BCB.editBox:SetShadowColor(0, 0, 0, 0.8)
    elseif outline == "Strong Drop Shadow"   then BCB.editBox:SetShadowOffset(2, -2); BCB.editBox:SetShadowColor(0, 0, 0, 1)
    elseif outline == "Strongest Drop Shadow" then BCB.editBox:SetShadowOffset(3, -3); BCB.editBox:SetShadowColor(0, 0, 0, 1)
    else BCB.editBox:SetShadowOffset(0, 0)
    end
    if BCB._updatePlaceholderFont then BCB._updatePlaceholderFont() end
    if BCB.UpdateDynamicHeight then BCB.UpdateDynamicHeight() end
end

function BCB.UpdateChannelFontSize()
    if BCB.channelText then
        local fontPath = BigChatBoxDB.channelFont     or defaults.channelFont
        local fontSize = BigChatBoxDB.channelFontSize or defaults.channelFontSize
        BCB.channelText:SetFont(fontPath, fontSize, "")
    end
end

function BCB.UpdateBackdrop()
    if not BCB.frame then return end
    local bgTex     = BigChatBoxDB.bgTexture     or defaults.bgTexture
    local borderTex = BigChatBoxDB.borderTexture or defaults.borderTexture
    local edgeSize  = BigChatBoxDB.borderThickness or 16

    -- Treat empty string as nil (no texture)
    if bgTex == "" then bgTex = nil end
    if borderTex == "" then borderTex = nil end
    if BigChatBoxDB.bgTextureName == "None" then bgTex = nil end
    if BigChatBoxDB.borderTextureName == "None" then borderTex = nil end

    -- Calculate insets based on bgScale setting
    local bgScale = (BigChatBoxDB.bgScale or 100) / 100
    local baseInset = 4
    local bgInset = baseInset + ((1 - bgScale) * 20)

    if not borderTex then
        BCB.frame:SetBackdrop({ bgFile = bgTex, tile = false, tileSize = 0, edgeSize = 0,
            insets = { left = bgInset, right = bgInset, top = bgInset, bottom = bgInset } })
    else
        BCB.frame:SetBackdrop({
            bgFile = bgTex, edgeFile = borderTex,
            tile = false, tileSize = 0, edgeSize = edgeSize,
            insets = { left = bgInset, right = bgInset, top = bgInset, bottom = bgInset },
        })
    end

    local bgAlpha = BigChatBoxDB.bgAlpha or defaults.bgAlpha
    local bgColor = BigChatBoxDB.bgColor or defaults.bgColor
    local bgR, bgG, bgB = bgColor.r, bgColor.g, bgColor.b

    -- Channel color tint on background
    if BigChatBoxDB.bgChannelTint then
        local chatType = BCB.editBox and BCB.editBox:GetAttribute("chatType") or "SAY"
        local typeInfo = ChatTypeInfo[chatType]
        if typeInfo then
            local intensity = (BigChatBoxDB.bgTintIntensity or 50) / 100
            bgR = bgR * (1 - intensity) + typeInfo.r * intensity
            bgG = bgG * (1 - intensity) + typeInfo.g * intensity
            bgB = bgB * (1 - intensity) + typeInfo.b * intensity
        end
    end
    BCB.frame:SetBackdropColor(bgR, bgG, bgB, bgAlpha)

    -- Drop shadow on input box
    if BigChatBoxDB.boxDropShadow then
        if not BCB.frame.dropShadow then
            BCB.frame.dropShadow = BCB.frame:CreateTexture(nil, "BACKGROUND", nil, -2)
            BCB.frame.dropShadow:SetPoint("TOPLEFT", -4, 4)
            BCB.frame.dropShadow:SetPoint("BOTTOMRIGHT", 4, -4)
            BCB.frame.dropShadow:SetColorTexture(0, 0, 0, 0.5)
        end
        BCB.frame.dropShadow:Show()
    elseif BCB.frame.dropShadow then
        BCB.frame.dropShadow:Hide()
    end

    -- Scale
    if BigChatBoxDB.scale then BCB.frame:SetScale(BigChatBoxDB.scale) end

    -- Reapply channel colors
    if BCB.UpdateChannelDisplay then BCB.UpdateChannelDisplay() end
end
