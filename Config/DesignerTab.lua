-- BigChatBox Config/DesignerTab.lua — Designer tab (size, bg, border, fonts, text)

local BCB = BigChatBox
local L = BCB.L or {}
local Config = BCB.Config
local PAD = Config.PAD

function Config.BuildDesignerTab(container)
    -- Sticky preview
    -- Preview at top (does not scroll)
    local pv = Config.CreatePreview(container, 160)
    pv:SetPoint("TOPLEFT", 10, -4); pv:SetPoint("TOPRIGHT", -10, -4)
    container.previewWidget = pv

    local sf, ct = Config.CreateSmartScrollFrame(container, -172)
    local y = -8
    local function upd() if BCB.UpdateBackdrop then BCB.UpdateBackdrop() end; if pv.Refresh then pv:Refresh() end; if pv.RefreshChannelColor then pv:RefreshChannelColor() end end
    local function updF() if BCB.UpdateFontSize then BCB.UpdateFontSize() end; if BCB.UpdateChannelFontSize then BCB.UpdateChannelFontSize() end; if pv.Refresh then pv:Refresh() end end

    -- Styles
    local styH = ct:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); styH:SetPoint("TOPLEFT", PAD, y); styH:SetText(L["STYLES"]); styH:SetTextColor(1,0.82,0); y = y - 22

    -- Build a lookup of built-in preset names → decoded data (nil = factory default)
    local builtinLookup = {}
    local builtinOrder = {}
    for _, entry in ipairs(BCB.BUILTIN_STYLES or {}) do
        local data = nil
        if entry.str then
            if entry.str:sub(1, 6) == "!BCB1:" then
                data = BCB.DecodeStyleString and BCB.DecodeStyleString(entry.str)
            else
                data = BCB.ParseStyleString and BCB.ParseStyleString(entry.str)
            end
        end
        builtinLookup[entry.name] = data  -- nil for "Default" (no str)
        builtinOrder[#builtinOrder + 1] = entry.name
    end

    local sDrop = Config.CreateWowDropdown(ct, L["ACTIVE_STYLE"],
        function()
            local s = {}
            for _, name in ipairs(builtinOrder) do s[#s + 1] = name end
            if BigChatBoxDB.styles then
                local user = {}
                for n in pairs(BigChatBoxDB.styles) do
                    if not builtinLookup[n] and n ~= "Default" then user[#user + 1] = n end
                end
                table.sort(user, function(a, b) return a:lower() < b:lower() end)
                if #user > 0 then
                    s[#s + 1] = "---"
                    for _, n in ipairs(user) do s[#s + 1] = n end
                end
            end
            return s
        end,
        BigChatBoxDB.activeStyle or "Default",
        function(name)
            if name == "---" then return end
            if builtinLookup[name] ~= nil or name == "Default" then
                if BCB.ApplyStyleData then BCB.ApplyStyleData(builtinLookup[name], name) end
            elseif BigChatBoxDB.styles and BigChatBoxDB.styles[name] then
                if BCB.ApplyStyleData then
                    BCB.ApplyStyleData(BigChatBoxDB.styles[name], name)
                else
                    for k, v in pairs(BigChatBoxDB.styles[name]) do BigChatBoxDB[k] = v end
                    BigChatBoxDB.activeStyle = name
                    if BCB.frame then BCB.frame:SetSize(BigChatBoxDB.width or 400, BigChatBoxDB.height or 50) end
                    if BCB.UpdateBackdrop then BCB.UpdateBackdrop() end
                    if BCB.UpdateFontSize then BCB.UpdateFontSize() end
                    if BCB.UpdateChannelFontSize then BCB.UpdateChannelFontSize() end
                end
            end
            if pv.Refresh then pv:Refresh() end
        end)
    sDrop:SetPoint("TOPLEFT", 0, y); sDrop:SetPoint("RIGHT"); y = y - 52
    -- Expose style dropdown so BCB.RefreshConfigAfterStyleApply can update it (now on designer container)
    container.styleDropdown = sDrop
    -- Style action buttons (all in a row)
    local svB = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); svB:SetSize(110, 26); svB:SetPoint("TOPLEFT", PAD, y); svB:SetText(L["BTN_SAVE_STYLE"]); svB:SetScript("OnClick", function() StaticPopup_Show("BCB_SAVE_STYLE") end)
    local dlB = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); dlB:SetSize(110, 26); dlB:SetPoint("LEFT", svB, "RIGHT", 6, 0); dlB:SetText(L["BTN_DELETE_STYLE"]); dlB:SetScript("OnClick", function() StaticPopup_Show("BCB_DELETE_STYLE") end)
    local exB = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); exB:SetSize(110, 26); exB:SetPoint("LEFT", dlB, "RIGHT", 6, 0); exB:SetText(L["BTN_EXPORT_STYLE"]); exB:SetScript("OnClick", function() StaticPopup_Show("BCB_EXPORT_STYLE") end)
    local imB = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); imB:SetSize(110, 26); imB:SetPoint("LEFT", exB, "RIGHT", 6, 0); imB:SetText(L["BTN_IMPORT_STYLE"]); imB:SetScript("OnClick", function() StaticPopup_Show("BCB_IMPORT_STYLE") end)
    y = y - 48  -- extra gap before Size section

    -- Size
    local sH = ct:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); sH:SetPoint("TOPLEFT", PAD, y); sH:SetText(L["SECTION_SIZE"]); sH:SetTextColor(1,0.82,0); y = y - 24
    local wS = Config.CreateSlider(ct, L["LABEL_WIDTH"], 200, 1200, BigChatBoxDB.width or 400, 400, function(v) BigChatBoxDB.width = v; if BCB.frame then BCB.frame:SetWidth(v*(BigChatBoxDB.scale or 1)) end; upd() end)
    wS:SetPoint("TOPLEFT", 0, y); wS:SetPoint("RIGHT"); y = y - 38
    local hS = Config.CreateSlider(ct, L["LABEL_HEIGHT"], 30, 150, BigChatBoxDB.height or 50, 50, function(v) BigChatBoxDB.height = v; if BCB.frame then BCB.frame:SetHeight(v*(BigChatBoxDB.scale or 1)) end; upd() end)
    hS:SetPoint("TOPLEFT", 0, y); hS:SetPoint("RIGHT"); y = y - 38
    local scS = Config.CreateSlider(ct, L["LABEL_SCALE"], 50, 200, math.floor((BigChatBoxDB.scale or 1)*100), 100, function(v) BigChatBoxDB.scale = v/100; if BCB.frame then BCB.frame:SetScale(v/100) end; upd() end, function(v) return math.floor(v).."%" end)
    scS:SetPoint("TOPLEFT", 0, y); scS:SetPoint("RIGHT"); y = y - 38
    -- Dynamic sizing checkboxes (side by side)
    local dhCb = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); dhCb:SetPoint("TOPLEFT", PAD, y)
    dhCb.text = dhCb:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); dhCb.text:SetPoint("LEFT", dhCb, "RIGHT", 2, 0); dhCb.text:SetText(L["CB_DYNAMIC_HEIGHT"])
    dhCb:SetChecked(BigChatBoxDB.dynamicHeight or false)
    dhCb:SetScript("OnClick", function(self) BigChatBoxDB.dynamicHeight = self:GetChecked(); if BCB.UpdateDynamicHeight then BCB.UpdateDynamicHeight() end; upd() end)
    local dwCb = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); dwCb:SetPoint("LEFT", dhCb.text, "RIGHT", 16, 0)
    dwCb.text = dwCb:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); dwCb.text:SetPoint("LEFT", dwCb, "RIGHT", 2, 0); dwCb.text:SetText(L["CB_DYNAMIC_WIDTH"])
    dwCb:SetChecked(BigChatBoxDB.dynamicWidth or false)
    dwCb:SetScript("OnClick", function(self) BigChatBoxDB.dynamicWidth = self:GetChecked(); if BCB.UpdateDynamicWidth then BCB.UpdateDynamicWidth() end; upd() end)
    y = y - 36

    -- Background
    local bgH = ct:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); bgH:SetPoint("TOPLEFT", PAD, y); bgH:SetText(L["SECTION_BACKGROUND"]); bgH:SetTextColor(1,0.82,0); y = y - 22
    local bgD = Config.CreateWowDropdown(ct, L["LABEL_BG_TEXTURE"],
        function() local l = {"Default", "None"}; local lsm = Config.GetLSM(); if lsm then for _,v in ipairs(lsm:List("statusbar")) do l[#l+1] = v end end; return l end,
        BigChatBoxDB.bgTextureName or "Default",
        function(n) BigChatBoxDB.bgTextureName = n; if n=="None" then BigChatBoxDB.bgTexture="" else BigChatBoxDB.bgTexture = n=="Default" and BCB.defaults.bgTexture or (Config.GetMP("statusbar",n) or BCB.defaults.bgTexture) end; upd() end, "texture")
    bgD:SetPoint("TOPLEFT", 0, y); bgD:SetPoint("RIGHT"); y = y - 52
    local bgA = Config.CreateSlider(ct, L["LABEL_BG_OPACITY"], 0, 100, math.floor((BigChatBoxDB.bgAlpha or 0.95)*100), 95, function(v) BigChatBoxDB.bgAlpha = v/100; upd() end, function(v) return math.floor(v).."%" end)
    bgA:SetPoint("TOPLEFT", 0, y); bgA:SetPoint("RIGHT"); y = y - 38
    local bgB = Config.CreateSlider(ct, L["LABEL_BG_BRIGHTNESS"], 0, 100, math.floor(((BigChatBoxDB.bgColor and BigChatBoxDB.bgColor.r) or 1)*100), 100, function(v) local b=v/100; BigChatBoxDB.bgColor={r=b,g=b,b=b}; upd() end, function(v) return math.floor(v).."%" end)
    bgB:SetPoint("TOPLEFT", 0, y); bgB:SetPoint("RIGHT"); y = y - 38
    local bgSc = Config.CreateSlider(ct, L["LABEL_BG_SCALE"], 50, 150, BigChatBoxDB.bgScale or 100, 100, function(v) BigChatBoxDB.bgScale = v; upd() end, function(v) return math.floor(v).."%" end)
    bgSc:SetPoint("TOPLEFT", 0, y); bgSc:SetPoint("RIGHT"); y = y - 30
    -- Channel color tint toggle + intensity
    local tintCb = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); tintCb:SetPoint("TOPLEFT", PAD, y)
    tintCb.text = tintCb:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); tintCb.text:SetPoint("LEFT", tintCb, "RIGHT", 4, 0); tintCb.text:SetText(L["CB_TINT_BG"])
    tintCb:SetChecked(BigChatBoxDB.bgChannelTint or false)
    local tintSlider
    tintCb:SetScript("OnClick", function(self)
        BigChatBoxDB.bgChannelTint = self:GetChecked()
        if tintSlider then tintSlider:SetAlpha(self:GetChecked() and 1 or 0.4); tintSlider:EnableMouse(self:GetChecked()) end
        upd(); if BCB.UpdateChannelDisplay then BCB.UpdateChannelDisplay() end
    end)
    y = y - 30
    tintSlider = Config.CreateSlider(ct, L["LABEL_TINT_INTENSITY"], 5, 100, BigChatBoxDB.bgTintIntensity or 50, 50, function(v) BigChatBoxDB.bgTintIntensity = v; upd(); if BCB.UpdateChannelDisplay then BCB.UpdateChannelDisplay() end end, function(v) return math.floor(v).."%" end)
    tintSlider:SetPoint("TOPLEFT", 0, y); tintSlider:SetPoint("RIGHT")
    tintSlider:SetAlpha(BigChatBoxDB.bgChannelTint and 1 or 0.4); tintSlider:EnableMouse(BigChatBoxDB.bgChannelTint and true or false)
    y = y - 44

    -- Border
    local bdH = ct:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); bdH:SetPoint("TOPLEFT", PAD, y); bdH:SetText(L["SECTION_BORDER"]); bdH:SetTextColor(1,0.82,0); y = y - 22
    local bdD = Config.CreateWowDropdown(ct, L["LABEL_BORDER_TEXTURE"],
        function() local l = {"Default"}; local lsm = Config.GetLSM(); if lsm then for _,v in ipairs(lsm:List("border")) do l[#l+1] = v end end; return l end,
        BigChatBoxDB.borderTextureName or "Default",
        function(n) BigChatBoxDB.borderTextureName = n; if n=="None" then BigChatBoxDB.borderTexture="" else BigChatBoxDB.borderTexture = n=="Default" and BCB.defaults.borderTexture or (Config.GetMP("border",n) or BCB.defaults.borderTexture) end; upd() end)
    bdD:SetPoint("TOPLEFT", 0, y); bdD:SetPoint("RIGHT"); y = y - 52
    local bdA = Config.CreateSlider(ct, L["LABEL_BORDER_OPACITY"], 0, 100, math.floor((BigChatBoxDB.borderAlpha or 1.0)*100), 100, function(v) BigChatBoxDB.borderAlpha = v/100; if BCB.UpdateChannelDisplay then BCB.UpdateChannelDisplay() end; upd() end, function(v) return math.floor(v).."%" end)
    bdA:SetPoint("TOPLEFT", 0, y); bdA:SetPoint("RIGHT"); y = y - 38
    local bdB = Config.CreateSlider(ct, L["LABEL_BORDER_BRIGHTNESS"], 0, 100, math.floor(((BigChatBoxDB.borderColor and BigChatBoxDB.borderColor.r) or 1)*100), 100, function(v) local b=v/100; BigChatBoxDB.borderColor={r=b,g=b,b=b}; if BCB.UpdateChannelDisplay then BCB.UpdateChannelDisplay() end; upd() end, function(v) return math.floor(v).."%" end)
    bdB:SetPoint("TOPLEFT", 0, y); bdB:SetPoint("RIGHT"); y = y - 38
    local bdT = Config.CreateSlider(ct, L["LABEL_BORDER_THICKNESS"], 1, 200, math.floor(((BigChatBoxDB.borderThickness or 16) / 16) * 100), 100, function(v) BigChatBoxDB.borderThickness = math.max(1, math.floor(16 * v / 100 + 0.5)); upd() end, function(v) return math.floor(v).."%" end)
    bdT:SetPoint("TOPLEFT", 0, y); bdT:SetPoint("RIGHT"); y = y - 44

    -- Fonts
    local fH = ct:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); fH:SetPoint("TOPLEFT", PAD, y); fH:SetText(L["SECTION_FONTS"]); fH:SetTextColor(1,0.82,0); y = y - 22
    local cF = Config.CreateWowDropdown(ct, L["LABEL_CHANNEL_FONT"], function() return Config.GetML("font") end, BigChatBoxDB.channelFontName or "Default",
        function(n) BigChatBoxDB.channelFontName = n; BigChatBoxDB.channelFont = n=="Default" and BCB.defaults.channelFont or (Config.GetMP("font",n) or BCB.defaults.channelFont); updF() end, "font")
    cF:SetPoint("TOPLEFT", 0, y); cF:SetPoint("RIGHT"); y = y - 52
    local iF = Config.CreateWowDropdown(ct, L["LABEL_INPUT_FONT"], function() return Config.GetML("font") end, BigChatBoxDB.fontName or "Default",
        function(n) BigChatBoxDB.fontName = n; BigChatBoxDB.font = n=="Default" and BCB.defaults.font or (Config.GetMP("font",n) or BCB.defaults.font); updF() end, "font")
    iF:SetPoint("TOPLEFT", 0, y); iF:SetPoint("RIGHT"); y = y - 52
    local cFS = Config.CreateSlider(ct, L["LABEL_CHANNEL_FONT_SIZE"], 8, 28, BigChatBoxDB.channelFontSize or 16, 16, function(v) BigChatBoxDB.channelFontSize = v; updF() end)
    cFS:SetPoint("TOPLEFT", 0, y); cFS:SetPoint("RIGHT"); y = y - 38
    local iFS = Config.CreateSlider(ct, L["LABEL_INPUT_FONT_SIZE"], 8, 24, BigChatBoxDB.fontSize or 14, 14, function(v) BigChatBoxDB.fontSize = v; updF() end)
    iFS:SetPoint("TOPLEFT", 0, y); iFS:SetPoint("RIGHT"); y = y - 48

    -- Text Options
    local toH = ct:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); toH:SetPoint("TOPLEFT", PAD, y); toH:SetText(L["SECTION_TEXT_OPTIONS"]); toH:SetTextColor(1,0.82,0); y = y - 26

    local function MkChk(yy, label, dbKey)
        local cb = CreateFrame("CheckButton", nil, ct, "UICheckButtonTemplate"); cb:SetPoint("TOPLEFT", PAD, yy)
        cb.text = cb:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); cb.text:SetPoint("LEFT", cb, "RIGHT", 4, 0); cb.text:SetText(label)
        cb:SetChecked(BigChatBoxDB[dbKey] or false); cb:SetScript("OnClick", function(self) BigChatBoxDB[dbKey] = self:GetChecked(); upd()
            if pv and pv.RefreshChannelColor then pv:RefreshChannelColor() end end)
        return cb
    end
    local colorCb = MkChk(y, L["CB_MATCH_TEXT_COLOR"], "colorTypedText"); container._colorTypedTextCb = colorCb; y = y - 32

    -- Text alignment
    local alD = Config.CreateWowDropdown(ct, L["LABEL_TEXT_ALIGNMENT"],
        function() return {"Left", "Center", "Right"} end,
        (BigChatBoxDB.textAlign or "LEFT"):sub(1,1):upper() .. (BigChatBoxDB.textAlign or "LEFT"):sub(2):lower(),
        function(n) BigChatBoxDB.textAlign = n:upper(); updF()
            if BCB.editBox then BCB.editBox:SetJustifyH(n:upper()) end
        end)
    alD:SetPoint("TOPLEFT", 0, y); alD:SetPoint("RIGHT"); y = y - 52

    -- Font Outline dropdown (replaces old outline/shadow checkboxes)
    local outlineOptions = {"None", "Outline", "Thick Outline", "Monochrome Outline", "Drop Shadow", "Strong Drop Shadow", "Strongest Drop Shadow"}
    -- Migrate old boolean settings to new string key
    if BigChatBoxDB.fontOutline == nil then
        if BigChatBoxDB.showOutline then BigChatBoxDB.fontOutline = "Outline"
        elseif BigChatBoxDB.showShadow then BigChatBoxDB.fontOutline = "Drop Shadow"
        else BigChatBoxDB.fontOutline = "None" end
    end
    local olD = Config.CreateWowDropdown(ct, L["LABEL_FONT_OUTLINE"], function() return outlineOptions end, BigChatBoxDB.fontOutline or "None",
        function(n) BigChatBoxDB.fontOutline = n; updF(); if pv and pv.RefreshChannelColor then pv:RefreshChannelColor() end end)
    olD:SetPoint("TOPLEFT", 0, y); olD:SetPoint("RIGHT"); y = y - 52

    ct:SetHeight(math.abs(y) + 20); sf:UpdateScrollbar()

    -- Expose a refresh function so style apply can sync all widgets to current DB values
    container.RefreshDesignerWidgets = function()
        local db = BigChatBoxDB
        sDrop:SetSelected(db.activeStyle or "Default")
        wS:SetValue(db.width or 400)
        hS:SetValue(db.height or 50)
        scS:SetValue(math.floor((db.scale or 1) * 100))
        dhCb:SetChecked(db.dynamicHeight or false)
        dwCb:SetChecked(db.dynamicWidth or false)
        bgD:SetSelected(db.bgTextureName or "Default")
        bgA:SetValue(math.floor((db.bgAlpha or 0.95) * 100))
        bgB:SetValue(math.floor(((db.bgColor and db.bgColor.r) or 1) * 100))
        bgSc:SetValue(db.bgScale or 100)
        tintCb:SetChecked(db.bgChannelTint or false)
        tintSlider:SetValue(db.bgTintIntensity or 50)
        tintSlider:SetAlpha((db.bgChannelTint and 1 or 0.4)); tintSlider:EnableMouse(db.bgChannelTint and true or false)
        bdD:SetSelected(db.borderTextureName or "Default")
        bdA:SetValue(math.floor((db.borderAlpha or 1) * 100))
        bdB:SetValue(math.floor(((db.borderColor and db.borderColor.r) or 1) * 100))
        bdT:SetValue(math.floor(((db.borderThickness or 16) / 16) * 100))
        cF:SetSelected(db.channelFontName or "Default")
        iF:SetSelected(db.fontName or "Default")
        cFS:SetValue(db.channelFontSize or 16)
        iFS:SetValue(db.fontSize or 14)
        -- colorTypedText checkbox (created via MkChk, we need a local ref)
        if container._colorTypedTextCb then container._colorTypedTextCb:SetChecked(db.colorTypedText or false) end
        alD:SetSelected((db.textAlign or "LEFT"):sub(1,1):upper() .. (db.textAlign or "LEFT"):sub(2):lower())
        olD:SetSelected(db.fontOutline or "None")
    end
end
