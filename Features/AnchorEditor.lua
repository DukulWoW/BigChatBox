-- BigChatBox Features/AnchorEditor.lua — Visual drag editor for positioning
-- Provides arrow nudging, symmetric resize, drag-to-move, grid overlay,
-- and an always-visible precision panel for exact positioning.
local BCB = BigChatBox
local defaults = BCB.defaults

local ToggleVisualEditor

-- Grid state
local gridLines = {}
local gridSizes = { 0, 20, 40, 80, 100 }  -- 0 = off
local gridLabels = { "Off", "20px", "40px", "80px", "100px" }
local gridDBLabels = { "Off", "20", "40", "80", "100" }
local gridIndex = 1  -- starts at Off

local function CreateVisualEditor()
    if BCB.visualEditor then return end

    local editor = CreateFrame("Button", "BCBAnchorEditor", UIParent)
    editor:SetFrameStrata("TOOLTIP"); editor:SetToplevel(true); editor:SetClampedToScreen(true)
    editor:SetClampRectInsets(-4, 4, 4, -4); editor:SetFlattensRenderLayers(true)
    editor:SetMovable(true); editor:RegisterForDrag("LeftButton"); editor:RegisterForClicks("LeftButtonUp", "RightButtonUp"); editor:Hide()

    local bg = editor:CreateTexture(nil, "BACKGROUND"); bg:SetColorTexture(0.1, 0.1, 0.1, 0.9); bg:SetAllPoints()

    -- Title text centered in the anchor bar
    local titleText = editor:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titleText:SetPoint("CENTER", editor, "CENTER", 0, 0)
    titleText:SetText("BigChatBox"); titleText:SetTextColor(1, 0.82, 0, 0.8)

    ----------------------------------------------------------------------------
    -- PRECISION PANEL — toggleable info/input window
    ----------------------------------------------------------------------------
    local precisionFrame = CreateFrame("Frame", "BCBPrecisionInput", UIParent, "BackdropTemplate")
    precisionFrame:SetSize(240, 200); precisionFrame:SetFrameStrata("FULLSCREEN_DIALOG"); precisionFrame:SetToplevel(true)
    precisionFrame:SetBackdrop({ bgFile = "Interface\\Buttons\\White8x8", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 12, insets = { left = 3, right = 3, top = 3, bottom = 3 } })
    precisionFrame:SetBackdropColor(0.08, 0.08, 0.08, 0.95); precisionFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
    precisionFrame:EnableMouse(true); precisionFrame:Hide()

    -- Close X button
    local closeX = CreateFrame("Button", nil, precisionFrame, "UIPanelCloseButton")
    closeX:SetPoint("TOPRIGHT", precisionFrame, "TOPRIGHT", 2, 2)
    closeX:SetScript("OnClick", function() precisionFrame:Hide() end)

    local pfTitle = precisionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    pfTitle:SetPoint("TOP", 0, -8); pfTitle:SetText("Position & Size"); pfTitle:SetTextColor(1, 0.82, 0)

    local function MakeInputRow(parent, label, yOff)
        local lbl = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        lbl:SetPoint("TOPLEFT", 12, yOff); lbl:SetText(label); lbl:SetWidth(50); lbl:SetJustifyH("RIGHT")
        local eb = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
        eb:SetSize(100, 20); eb:SetPoint("LEFT", lbl, "RIGHT", 8, 0)
        eb:SetAutoFocus(false); eb:SetNumeric(false); eb:SetMaxLetters(6)
        eb:SetFont("Fonts\\FRIZQT__.TTF", 12, "")
        return eb
    end

    precisionFrame.xInput = MakeInputRow(precisionFrame, "X:", -30)
    precisionFrame.yInput = MakeInputRow(precisionFrame, "Y:", -56)
    precisionFrame.wInput = MakeInputRow(precisionFrame, "Width:", -82)
    precisionFrame.hInput = MakeInputRow(precisionFrame, "Height:", -108)

    -- Grid dropdown
    local gridLabel = precisionFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    gridLabel:SetPoint("TOPLEFT", 12, -134); gridLabel:SetText("Grid:"); gridLabel:SetWidth(50); gridLabel:SetJustifyH("RIGHT")

    local gridBtn = CreateFrame("Button", nil, precisionFrame, "BackdropTemplate")
    gridBtn:SetSize(100, 20); gridBtn:SetPoint("LEFT", gridLabel, "RIGHT", 8, 0)
    gridBtn:SetBackdrop({ bgFile = "Interface\\Buttons\\White8x8", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 8, insets = { left = 2, right = 2, top = 2, bottom = 2 } })
    gridBtn:SetBackdropColor(0.15, 0.15, 0.15, 1); gridBtn:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
    local gridBtnText = gridBtn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    gridBtnText:SetPoint("CENTER"); gridBtnText:SetText("Off")
    gridBtn:SetScript("OnClick", function()
        gridIndex = gridIndex + 1
        if gridIndex > #gridSizes then gridIndex = 1 end
        gridBtnText:SetText(gridLabels[gridIndex])
        DrawGrid(gridSizes[gridIndex])
    end)
    precisionFrame.gridBtnText = gridBtnText

    -- Apply + Reset buttons
    local applyBtn = CreateFrame("Button", nil, precisionFrame, "UIPanelButtonTemplate")
    applyBtn:SetSize(100, 24); applyBtn:SetPoint("BOTTOMLEFT", 12, 10); applyBtn:SetText("Apply")
    applyBtn:SetScript("OnClick", function()
        local x = tonumber(precisionFrame.xInput:GetText())
        local y = tonumber(precisionFrame.yInput:GetText())
        local w = tonumber(precisionFrame.wInput:GetText())
        local h = tonumber(precisionFrame.hInput:GetText())
        if w then w = math.max(100, math.min(1200, w)) end
        if h then h = math.max(30, math.min(200, h)) end
        if w then editor:SetWidth(w); BCB.frame:SetWidth(w); BigChatBoxDB.width = w end
        if h then editor:SetHeight(h); BCB.frame:SetHeight(h); BigChatBoxDB.height = h end
        if x and y then
            editor:ClearAllPoints(); editor:SetPoint("CENTER", UIParent, "CENTER", x, y)
            BCB.frame:ClearAllPoints(); BCB.frame:SetPoint("CENTER", UIParent, "CENTER", x, y)
            BigChatBoxDB.point = "CENTER"; BigChatBoxDB.x = x; BigChatBoxDB.y = y
            BigChatBoxDB.xOffset = x; BigChatBoxDB.yOffset = y
        end
    end)

    local resetBtn = CreateFrame("Button", nil, precisionFrame, "UIPanelButtonTemplate")
    resetBtn:SetSize(100, 24); resetBtn:SetPoint("BOTTOMRIGHT", -12, 10); resetBtn:SetText("Reset")
    resetBtn:SetScript("OnClick", function()
        local dx, dy = defaults.position.x, defaults.position.y
        local dw, dh = defaults.size.width, defaults.size.height
        editor:ClearAllPoints(); editor:SetPoint("CENTER", UIParent, "CENTER", dx, dy)
        editor:SetSize(dw, dh)
        BCB.frame:ClearAllPoints(); BCB.frame:SetPoint("CENTER", UIParent, "CENTER", dx, dy)
        BCB.frame:SetSize(dw, dh)
        BigChatBoxDB.point = "CENTER"; BigChatBoxDB.x = dx; BigChatBoxDB.y = dy
        BigChatBoxDB.xOffset = dx; BigChatBoxDB.yOffset = dy
        BigChatBoxDB.width = dw; BigChatBoxDB.height = dh
    end)

    -- Enter key in any input triggers Apply
    for _, eb in ipairs({ precisionFrame.xInput, precisionFrame.yInput, precisionFrame.wInput, precisionFrame.hInput }) do
        eb:SetScript("OnEnterPressed", function() applyBtn:Click() end)
        eb:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    end

    editor.precisionFrame = precisionFrame

    -- Forward reference for DrawGrid (used by grid button above)
    local DrawGridFn

    ----------------------------------------------------------------------------
    -- Position the precision panel relative to the anchor (boundary-aware)
    ----------------------------------------------------------------------------
    local function RepositionPrecisionPanel()
        if not precisionFrame:IsShown() then return end
        precisionFrame:ClearAllPoints()
        local _, editorBottom = editor:GetCenter()
        if editorBottom then
            editorBottom = editorBottom - editor:GetHeight() / 2
        end
        if editorBottom and editorBottom < UIParent:GetHeight() * 0.35 then
            precisionFrame:SetPoint("BOTTOM", editor, "TOP", 0, 8)
        else
            precisionFrame:SetPoint("TOP", editor, "BOTTOM", 0, -8)
        end
    end

    ----------------------------------------------------------------------------
    -- UPDATE: precision inputs (always runs via OnUpdate)
    ----------------------------------------------------------------------------
    local function UpdateInfoLabels()
        local cx, cy = editor:GetCenter()
        local scx, scy = UIParent:GetCenter()
        if cx and scx then
            local x = math.floor(cx - scx + 0.5)
            local y = math.floor(cy - scy + 0.5)
            local w = math.floor(editor:GetWidth())
            local h = math.floor(editor:GetHeight())
            if precisionFrame:IsShown() then
                if not precisionFrame.xInput:HasFocus() then precisionFrame.xInput:SetText(tostring(x)) end
                if not precisionFrame.yInput:HasFocus() then precisionFrame.yInput:SetText(tostring(y)) end
                if not precisionFrame.wInput:HasFocus() then precisionFrame.wInput:SetText(tostring(w)) end
                if not precisionFrame.hInput:HasFocus() then precisionFrame.hInput:SetText(tostring(h)) end
            end
        end
        RepositionPrecisionPanel()
    end

    ----------------------------------------------------------------------------
    -- GRID OVERLAY — always centered on screen center, not on the anchor
    ----------------------------------------------------------------------------
    local gridFrame = CreateFrame("Frame", nil, UIParent)
    gridFrame:SetAllPoints(UIParent); gridFrame:SetFrameStrata("TOOLTIP")
    gridFrame:SetFrameLevel(editor:GetFrameLevel() - 1); gridFrame:Hide()
    editor.gridFrame = gridFrame

    -- Use screen center for grid lines (fixed, doesn't move with anchor)
    function DrawGrid(size)
        for _, line in ipairs(gridLines) do line:Hide() end
        wipe(gridLines)
        if size == 0 then gridFrame:Hide(); return end
        gridFrame:Show()

        local sw, sh = UIParent:GetWidth(), UIParent:GetHeight()
        local centerX, centerY = math.floor(sw / 2), math.floor(sh / 2)

        -- Vertical lines radiating from screen center
        for x = centerX % size, sw, size do
            local line = gridFrame:CreateLine(nil, "BACKGROUND")
            if math.abs(x - centerX) < 1 then
                line:SetThickness(2); line:SetColorTexture(0.3, 0.6, 1.0, 0.5)
            else
                line:SetThickness(1); line:SetColorTexture(0.3, 0.3, 0.3, 0.3)
            end
            line:SetStartPoint("BOTTOMLEFT", gridFrame, x, 0)
            line:SetEndPoint("TOPLEFT", gridFrame, x, 0)
            gridLines[#gridLines + 1] = line
        end

        -- Horizontal lines radiating from screen center
        for y = centerY % size, sh, size do
            local line = gridFrame:CreateLine(nil, "BACKGROUND")
            if math.abs(y - centerY) < 1 then
                line:SetThickness(2); line:SetColorTexture(0.3, 0.6, 1.0, 0.5)
            else
                line:SetThickness(1); line:SetColorTexture(0.3, 0.3, 0.3, 0.3)
            end
            line:SetStartPoint("BOTTOMLEFT", gridFrame, 0, y)
            line:SetEndPoint("BOTTOMRIGHT", gridFrame, 0, y)
            gridLines[#gridLines + 1] = line
        end
    end

    ----------------------------------------------------------------------------
    -- ARROW NUDGE BUTTONS (1px move per click)
    ----------------------------------------------------------------------------
    local arrows = {
        Up    = { p1 = {"TOPLEFT","TOPLEFT",14,0},       p2 = {"BOTTOMRIGHT","TOPRIGHT",-14,-14},    ox=0,  oy=1 },
        Down  = { p1 = {"BOTTOMLEFT","BOTTOMLEFT",14,0}, p2 = {"TOPRIGHT","BOTTOMRIGHT",-14,14},     ox=0,  oy=-1 },
        Left  = { p1 = {"TOPLEFT","TOPLEFT",0,-14},      p2 = {"BOTTOMRIGHT","BOTTOMLEFT",14,14},    ox=-1, oy=0 },
        Right = { p1 = {"TOPRIGHT","TOPRIGHT",0,-14},     p2 = {"BOTTOMLEFT","BOTTOMRIGHT",-14,14},   ox=1,  oy=0 },
    }
    for dir, data in pairs(arrows) do
        local btn = CreateFrame("Button", "$parentArrow"..dir, editor, "UIPanelSquareButton")
        btn:GetHighlightTexture():SetColorTexture(0.4,0.4,0.4,0.8)
        btn:GetNormalTexture():SetColorTexture(0.2,0.2,0.2,0.8)
        btn:GetPushedTexture():SetColorTexture(0.1,0.1,0.1,0.8)
        btn:SetFlattensRenderLayers(true)
        btn:SetPoint(data.p1[1], editor, data.p1[2], data.p1[3], data.p1[4])
        btn:SetPoint(data.p2[1], editor, data.p2[2], data.p2[3], data.p2[4])
        btn:SetSize(0,0); btn.offset_x = data.ox; btn.offset_y = data.oy
        SquareButton_SetIcon(btn, dir:upper())
        btn:SetScript("OnClick", function(self)
            local cx, cy = editor:GetCenter(); local scx, scy = UIParent:GetCenter()
            local x = math.floor(cx - scx + 0.5) + self.offset_x
            local y = math.floor(cy - scy + 0.5) + self.offset_y
            editor:ClearAllPoints(); editor:SetPoint("CENTER", UIParent, "CENTER", x, y)
            BCB.frame:ClearAllPoints(); BCB.frame:SetPoint("CENTER", UIParent, "CENTER", x, y)
            BigChatBoxDB.point="CENTER"; BigChatBoxDB.x=x; BigChatBoxDB.y=y; BigChatBoxDB.xOffset=x; BigChatBoxDB.yOffset=y
            UpdateInfoLabels()
        end)
    end

    ----------------------------------------------------------------------------
    -- RESIZE HANDLES (drag to resize, Shift+drag for symmetric)
    ----------------------------------------------------------------------------
    local function SetupSymmetricHandle(handle, isCorner, dirInfo)
        handle:SetScript("OnMouseDown", function(_, button)
            if button ~= "LeftButton" then return end
            if IsShiftKeyDown() then
                handle._sym = true
                handle._sW, handle._sH = editor:GetWidth(), editor:GetHeight()
                handle._sCX, handle._sCY = editor:GetCenter()
                local s = UIParent:GetEffectiveScale()
                handle._sMX, handle._sMY = GetCursorPosition(); handle._sMX = handle._sMX/s; handle._sMY = handle._sMY/s
                handle:SetScript("OnUpdate", function()
                    local mx, my = GetCursorPosition(); local s = UIParent:GetEffectiveScale(); mx=mx/s; my=my/s
                    local dx, dy = mx - handle._sMX, my - handle._sMY
                    local newW, newH = handle._sW, handle._sH
                    if dirInfo.horiz then
                        newW = math.max(handle._sW + dx * (dirInfo.horiz == "RIGHT" and 2 or -2), 100)
                    end
                    if dirInfo.vert then
                        newH = math.max(handle._sH + dy * (dirInfo.vert == "TOP" and 2 or -2), 30)
                    end
                    editor:SetSize(newW, newH)
                    editor:ClearAllPoints()
                    editor:SetPoint("CENTER", UIParent, "CENTER", handle._sCX - UIParent:GetWidth()/2, handle._sCY - UIParent:GetHeight()/2)
                    BCB.frame:SetSize(newW, newH)
                    UpdateInfoLabels()
                end)
            else
                handle._sym = false
                editor:StartSizing(dirInfo.sizing)
            end
        end)
        handle:SetScript("OnMouseUp", function()
            if handle._sym then handle:SetScript("OnUpdate", nil); handle._sym = false
            else editor:StopMovingOrSizing() end
            local w, h = editor:GetWidth(), editor:GetHeight()
            local cx, cy = editor:GetCenter(); local scx, scy = UIParent:GetCenter()
            editor:ClearAllPoints()
            editor:SetPoint("CENTER", UIParent, "CENTER", math.floor(cx-scx+0.5), math.floor(cy-scy+0.5))
            BCB.frame:SetSize(w, h)
            BigChatBoxDB.width = math.floor(w); BigChatBoxDB.height = math.floor(h)
            UpdateInfoLabels()
        end)
    end

    -- Corner resize handles
    for _, corner in ipairs({"TOPLEFT","TOPRIGHT","BOTTOMLEFT","BOTTOMRIGHT"}) do
        local handle = CreateFrame("Button", nil, editor); handle:SetSize(12,12)
        handle:SetPoint(corner, editor, corner, corner:find("LEFT") and -6 or 6, corner:find("TOP") and 6 or -6)
        local htex = handle:CreateTexture(nil,"ARTWORK"); htex:SetAllPoints(); htex:SetColorTexture(1,0.82,0,0.8)
        handle:SetScript("OnEnter", function() htex:SetColorTexture(1,1,0,1) end)
        handle:SetScript("OnLeave", function() htex:SetColorTexture(1,0.82,0,0.8) end)
        SetupSymmetricHandle(handle, true, {
            sizing = corner,
            horiz = corner:find("RIGHT") and "RIGHT" or "LEFT",
            vert = corner:find("TOP") and "TOP" or "BOTTOM",
        })
    end

    -- Edge resize handles
    local edges = {
        {point="TOP",    sizing="TOP",    w=40, h=8, ox=0,  oy=4,  vert="TOP"},
        {point="BOTTOM", sizing="BOTTOM", w=40, h=8, ox=0,  oy=-4, vert="BOTTOM"},
        {point="LEFT",   sizing="LEFT",   w=8, h=40, ox=-4, oy=0,  horiz="LEFT"},
        {point="RIGHT",  sizing="RIGHT",  w=8, h=40, ox=4,  oy=0,  horiz="RIGHT"},
    }
    for _, edge in ipairs(edges) do
        local handle = CreateFrame("Button", nil, editor); handle:SetSize(edge.w, edge.h)
        handle:SetPoint(edge.point, editor, edge.point, edge.ox, edge.oy)
        local htex = handle:CreateTexture(nil,"ARTWORK"); htex:SetAllPoints(); htex:SetColorTexture(1,0.82,0,0.6)
        handle:SetScript("OnEnter", function() htex:SetColorTexture(1,1,0,1) end)
        handle:SetScript("OnLeave", function() htex:SetColorTexture(1,0.82,0,0.6) end)
        SetupSymmetricHandle(handle, false, {sizing=edge.sizing, horiz=edge.horiz, vert=edge.vert})
    end

    -- Drag handlers
    editor:SetScript("OnDragStart", function(self) self:StartMoving() end)
    editor:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local cx, cy = self:GetCenter(); local scx, scy = UIParent:GetCenter()
        local x, y = math.floor(cx-scx+0.5), math.floor(cy-scy+0.5)
        self:ClearAllPoints(); self:SetPoint("CENTER", UIParent, "CENTER", x, y)
        BCB.frame:ClearAllPoints(); BCB.frame:SetPoint("CENTER", UIParent, "CENTER", x, y)
        BigChatBoxDB.point="CENTER"; BigChatBoxDB.x=x; BigChatBoxDB.y=y; BigChatBoxDB.xOffset=x; BigChatBoxDB.yOffset=y
        UpdateInfoLabels()
    end)

    -- OnUpdate: always sync precision panel values
    editor:SetScript("OnUpdate", function() UpdateInfoLabels() end)

    -- Click: Left-click title = toggle panel, Right-click close, Shift+Right reset
    editor:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            -- Toggle precision panel
            if precisionFrame:IsShown() then precisionFrame:Hide() else precisionFrame:Show(); RepositionPrecisionPanel() end
        elseif button == "RightButton" then
            if IsShiftKeyDown() then
                local dx, dy = defaults.position.x, defaults.position.y
                local dw, dh = defaults.size.width, defaults.size.height
                BCB.frame:ClearAllPoints()
                BCB.frame:SetPoint("CENTER", UIParent, "CENTER", dx, dy)
                BCB.frame:SetSize(dw, dh)
                self:ClearAllPoints()
                self:SetPoint("CENTER", UIParent, "CENTER", dx, dy)
                self:SetSize(dw, dh)
                BigChatBoxDB.point = "CENTER"; BigChatBoxDB.x = dx; BigChatBoxDB.y = dy
                BigChatBoxDB.xOffset = dx; BigChatBoxDB.yOffset = dy
                BigChatBoxDB.width = dw; BigChatBoxDB.height = dh
                UpdateInfoLabels()
                BCB:Print("Position and size reset to default")
            else ToggleVisualEditor() end
        end
    end)

    -- Tooltip
    editor:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP"); GameTooltip:AddLine("BigChatBox Anchor", 1, 0.82, 0)
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Drag to move, corners/edges to resize", 0.7,0.7,0.7)
        GameTooltip:AddLine("Shift+drag resizes symmetrically", 0.7,0.7,0.7)
        GameTooltip:AddLine("Left-click: toggle info panel", 0.7,0.7,0.7)
        GameTooltip:AddLine("Right-click to close, Shift+Right to reset", 0.7,0.7,0.7)
        GameTooltip:Show()
    end)
    editor:SetScript("OnLeave", function() GameTooltip:Hide() end)

    BCB.visualEditor = editor
end

ToggleVisualEditor = function()
    CreateVisualEditor()
    local e = BCB.visualEditor
    if e:IsShown() then
        e:Hide()
        if e.gridFrame then e.gridFrame:Hide() end
        if e.precisionFrame then e.precisionFrame:Hide() end
        -- Reset grid
        gridIndex = 1
        DrawGrid(0)
        if e.precisionFrame and e.precisionFrame.gridBtnText then
            e.precisionFrame.gridBtnText:SetText("Off")
        end
        return
    end
    if BCB.frame then
        local w, h = BCB.frame:GetSize()
        e:SetSize(w, h); e:SetResizable(true); e:SetResizeBounds(100, 30, 1200, 200)
        local p, rT, rP, x, y = BCB.frame:GetPoint()
        e:ClearAllPoints(); e:SetPoint(p, rT, rP, x, y)
    end
    e:Show()
    if e.precisionFrame then e.precisionFrame:Show() end
end

BCB.ToggleVisualEditor = ToggleVisualEditor
BCB.CreateVisualEditor = CreateVisualEditor
