-- BigChatBox Config/SnippetsTab.lua — Snippets tab (two-pane editor)

local BCB = BigChatBox
local L = BCB.L or {}
local Config = BCB.Config
local PAD = Config.PAD

function Config.BuildSnippetsTab(container)
    if BigChatBoxDB.snippetEnabled == false then
        local msg = container:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        msg:SetPoint("CENTER"); msg:SetText(L["SNIPPETS_DISABLED_MSG"]); msg:SetTextColor(0.5,0.5,0.5)
        return
    end
    local ct = CreateFrame("Frame", nil, container); ct:SetAllPoints()
    local y = -8
    local hdr = ct:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge"); hdr:SetPoint("TOPLEFT", PAD, y); hdr:SetText(L["SNIPPETS_HEADER"]); hdr:SetTextColor(1,0.82,0); y = y - 18
    local desc = ct:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); desc:SetPoint("TOPLEFT", PAD, y); desc:SetWidth(Config.WINDOW_WIDTH - 80); desc:SetJustifyH("LEFT")
    desc:SetText(L["SNIPPETS_DESC"]); desc:SetTextColor(0.7,0.7,0.7); y = y - 24

    local listW = math.floor((Config.WINDOW_WIDTH - 30) * 0.35)

    -- Left: snippet list
    local listBox = CreateFrame("Frame", nil, ct, "InsetFrameTemplate")
    listBox:SetPoint("TOPLEFT", 4, y); listBox:SetWidth(listW); listBox:SetPoint("BOTTOM", ct, "BOTTOM", 0, 36)
    local listBg = listBox:CreateTexture(nil, "BACKGROUND", nil, -1); listBg:SetPoint("TOPLEFT",3,-3); listBg:SetPoint("BOTTOMRIGHT",-3,3); listBg:SetColorTexture(0.03,0.03,0.03,0.9)
    local listSF = CreateFrame("ScrollFrame", nil, listBox, "ScrollFrameTemplate")
    listSF:SetPoint("TOPLEFT", 6, -4); listSF:SetPoint("BOTTOMRIGHT", -22, 4)
    local listSC = CreateFrame("Frame", nil, listSF); listSC:SetWidth(listW - 30); listSF:SetScrollChild(listSC)
    local scrollBar = listSF.ScrollBar

    -- Right: edit panel (no background, sits on window texture like Baganator)
    local ep = CreateFrame("Frame", nil, ct)
    ep:SetPoint("TOPLEFT", listBox, "TOPRIGHT", 8, 0); ep:SetPoint("RIGHT", ct, "RIGHT", -4, 0); ep:SetPoint("BOTTOM", ct, "BOTTOM", 0, 36)

    local editTitle = ep:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    editTitle:SetPoint("TOPLEFT", 4, 0); editTitle:SetText(L["SNIPPET_EDIT_HEADER"]); editTitle:SetTextColor(1,0.82,0)

    -- Snippet Active checkbox at top
    local enCheck = CreateFrame("CheckButton", nil, ep, "UICheckButtonTemplate"); enCheck:SetPoint("TOPLEFT", 4, -22)
    enCheck.text = enCheck:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); enCheck.text:SetPoint("LEFT", enCheck, "RIGHT", 2, 0); enCheck.text:SetText(L["SNIPPET_ACTIVE"])

    local trigLbl = ep:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); trigLbl:SetPoint("TOPLEFT", 4, -52); trigLbl:SetText(L["SNIPPET_TRIGGER_LBL"])
    local trigInput = CreateFrame("EditBox", nil, ep, "InputBoxTemplate"); trigInput:SetHeight(34)
    trigInput:SetPoint("TOPLEFT", 18, -68); trigInput:SetPoint("RIGHT", ep, "RIGHT", -8, 0); trigInput:SetAutoFocus(false); trigInput:SetMaxLetters(39)
    -- Hardcoded ! prefix label — anchored to trigInput so it sits at the same baseline
    local bangLbl = ep:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); bangLbl:SetPoint("LEFT", trigInput, "LEFT", -12, 1); bangLbl:SetText("!")
    bangLbl:SetTextColor(0.7, 0.9, 1)
    -- Strip ALL leading ! the user types (the ! is already shown as a label)
    trigInput:HookScript("OnTextChanged", function(self, ui)
        if ui then
            local t = self:GetText()
            if t then
                local stripped = t:match("^!+(.*)")
                if stripped then self:SetText(stripped); self:SetCursorPosition(#stripped) end
            end
        end
    end)

    local textLbl = ep:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); textLbl:SetPoint("TOPLEFT", 4, -108); textLbl:SetText(L["SNIPPET_TEXT_LBL"])
    local textBg = CreateFrame("Frame", nil, ep, "BackdropTemplate")
    textBg:SetPoint("TOPLEFT", 4, -124); textBg:SetPoint("RIGHT", ep, "RIGHT", -8, 0); textBg:SetHeight(140)
    textBg:SetBackdrop({bgFile="Interface\\Buttons\\White8x8", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", edgeSize=8, insets={left=2,right=2,top=2,bottom=2}})
    textBg:SetBackdropColor(0.05,0.05,0.05,0.8); textBg:SetBackdropBorderColor(0.3,0.3,0.3,1)
    local textInput = CreateFrame("EditBox", nil, textBg)
    textInput:SetPoint("TOPLEFT", 6, -6); textInput:SetPoint("BOTTOMRIGHT", textBg, "BOTTOMRIGHT", -6, 6)
    textInput:SetAutoFocus(false); textInput:SetMaxLetters(255); textInput:SetMultiLine(true); textInput:SetFontObject(ChatFontNormal)
    -- Character counter
    local charCount = ep:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    charCount:SetPoint("TOPRIGHT", textBg, "BOTTOMRIGHT", 0, -2); charCount:SetText("0/255"); charCount:SetTextColor(0.5,0.5,0.5)
    local function UpdateCharCount()
        local text = textInput:GetText() or ""
        local len = #text
        -- Count lines
        local numLines = 1
        for _ in text:gmatch("\n") do numLines = numLines + 1 end
        local lineStr = numLines > 1 and (numLines.." lines · ") or ""
        charCount:SetText(lineStr..len.."/255")
        if len >= 255 then charCount:SetTextColor(1,0.3,0.3) elseif len >= 200 then charCount:SetTextColor(1,0.8,0.3) else charCount:SetTextColor(0.5,0.5,0.5) end
    end
    -- Char count updated via textInput:SetScript("OnTextChanged") below

    -- Channel restriction - dynamic channels with colors
    local chanLbl = ep:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); chanLbl:SetPoint("TOPLEFT", 4, -282); chanLbl:SetText(L["SNIPPET_CHANNEL_LBL"])

    -- Build channel options dynamically with chat colors
    local chanColorMap = {
        Say="SAY", Yell="YELL", Guild="GUILD", Party="PARTY",
        Raid="RAID", Instance="INSTANCE_CHAT"
    }
    local function GetChannelOptions()
        local opts = {}
        -- Static channel options with colors
        local staticOpts = {"Anywhere","Say","Yell","Guild","Party","Raid","Instance"}
        for _, name in ipairs(staticOpts) do
            local chatKey = chanColorMap[name]
            if chatKey then
                local ti = ChatTypeInfo[chatKey]
                if ti then
                    local hex = format("%02x%02x%02x", ti.r*255, ti.g*255, ti.b*255)
                    opts[#opts+1] = "|cff"..hex..name.."|r"
                else
                    opts[#opts+1] = name
                end
            else
                opts[#opts+1] = name  -- "Anywhere" has no color
            end
        end
        -- Add joined channels with CHANNEL color
        local chanTi = ChatTypeInfo["CHANNEL1"] or ChatTypeInfo["CHANNEL"]
        for i = 1, 20 do
            local id, cname = GetChannelName(i)
            if id and id > 0 and cname and cname ~= "" then
                local label = "/"..id.." "..cname
                if chanTi then
                    local hex = format("%02x%02x%02x", chanTi.r*255, chanTi.g*255, chanTi.b*255)
                    opts[#opts+1] = "|cff"..hex..label.."|r"
                else
                    opts[#opts+1] = label
                end
            end
        end
        return opts
    end
    -- Strip color codes for mapping to internal keys
    local function StripColor(s) return s:gsub("|c%x%x%x%x%x%x%x%x",""):gsub("|r","") end
    -- Rebuild the colored label for a plain channel display name (e.g. "Guild" → "|cff..Guild|r")
    local function GetColoredLabel(plainName)
        local chatKey = chanColorMap[plainName]
        if chatKey then
            local ti = ChatTypeInfo[chatKey]
            if ti then return format("|cff%02x%02x%02x", ti.r*255, ti.g*255, ti.b*255)..plainName.."|r" end
        end
        -- Dynamic channel e.g. "/1 General"
        local chanTi = ChatTypeInfo["CHANNEL1"] or ChatTypeInfo["CHANNEL"]
        if chanTi and plainName:sub(1,1) == "/" then
            return format("|cff%02x%02x%02x", chanTi.r*255, chanTi.g*255, chanTi.b*255)..plainName.."|r"
        end
        return plainName  -- "Anywhere" or fallback
    end
    local chanMapL = {Anywhere="anywhere",Say="say",Yell="yell",Guild="guild",Party="party",Raid="raid",Instance="instance"}
    local chanRevL = {}; for k,v in pairs(chanMapL) do chanRevL[v]=k end
    -- Also map dynamic channels
    local function BuildChanMap()
        for i = 1, 20 do
            local id, name = GetChannelName(i)
            if id and id > 0 and name and name ~= "" then
                local key = "/"..id.." "..name
                chanMapL[key] = "channel_"..id
                chanRevL["channel_"..id] = key
            end
        end
    end
    BuildChanMap()

    local selectedChannel = "Anywhere"
    local isDirty = false
    local UpdateSaveBtn  -- forward declarations; all assigned after their dependencies are created
    local AutoSave
    local RefreshList
    local chanDrop = Config.CreateWowDropdown(ep, "", GetChannelOptions, "Anywhere", function(n) selectedChannel = StripColor(n); isDirty = true; UpdateSaveBtn(); AutoSave(); RefreshList() end)
    chanDrop:SetPoint("TOPLEFT", -8, -296); chanDrop:SetPoint("RIGHT", ep, "RIGHT", 0, 0)

    -- Global checkbox (more space below dropdown)
    local glCheck = CreateFrame("CheckButton", nil, ep, "UICheckButtonTemplate"); glCheck:SetPoint("TOPLEFT", 4, -342)
    glCheck.text = glCheck:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); glCheck.text:SetPoint("LEFT", glCheck, "RIGHT", 2, 0); glCheck.text:SetText(L["SNIPPET_GLOBAL"])

    -- Buttons at bottom of right panel
    local saveBtn = CreateFrame("Button", nil, ep, "UIPanelButtonTemplate"); saveBtn:SetSize(70, 24)
    saveBtn:SetPoint("BOTTOMLEFT", ep, "BOTTOMLEFT", 4, 4); saveBtn:SetText(L["BTN_SAVE_SNIPPET"]); saveBtn:Disable()
    local delBtn = CreateFrame("Button", nil, ep, "UIPanelButtonTemplate"); delBtn:SetSize(80, 24)
    delBtn:SetPoint("LEFT", saveBtn, "RIGHT", 4, 0); delBtn:SetText(L["BTN_DELETE_SNIPPET"]); delBtn:Disable()
    local shareBtn = CreateFrame("Button", nil, ep, "UIPanelButtonTemplate"); shareBtn:SetSize(80, 24)
    shareBtn:SetPoint("LEFT", delBtn, "RIGHT", 4, 0); shareBtn:SetText(L["BTN_SHARE_SNIPPET"]); shareBtn:Disable()
    local dupeBtn = CreateFrame("Button", nil, ep, "UIPanelButtonTemplate"); dupeBtn:SetSize(80, 24)
    dupeBtn:SetPoint("LEFT", shareBtn, "RIGHT", 4, 0); dupeBtn:SetText(L["BTN_DUPLICATE_SNIPPET"]); dupeBtn:Disable()

    UpdateSaveBtn = function()
        local trig = trigInput:GetText()
        local text = textInput:GetText()
        if isDirty and trig and trig ~= "" and text and text ~= "" then
            saveBtn:Enable()
        else
            saveBtn:Disable()
        end
    end

    local selectedTrigger = nil

    AutoSave = function()
        local rawTrig = trigInput:GetText(); local text = textInput:GetText()
        -- trigInput shows the part after !; stored key always has ! prefix
        local trigger = (rawTrig and rawTrig ~= "") and ("!" .. (rawTrig:sub(1,1) == "!" and rawTrig:sub(2) or rawTrig)) or nil
        if not trigger or trigger == "!" or not text or text == "" then return end
        if text:sub(1,1) == "/" then return end
        if not BigChatBoxDB.snippets then BigChatBoxDB.snippets = {} end
        local data = {}; local old = BigChatBoxDB.snippets[selectedTrigger or trigger]
        if type(old) == "table" then for k,v in pairs(old) do data[k]=v end end
        data.text = text; data.enabled = (enCheck:GetChecked() and true or false); data.global = (glCheck:GetChecked() and true or false)
        data.character = (not data.global) and UnitName("player") or nil
        data.channel = chanMapL[selectedChannel] or "anywhere"
        if selectedTrigger and selectedTrigger ~= trigger then BigChatBoxDB.snippets[selectedTrigger] = nil end
        BigChatBoxDB.snippets[trigger] = data; selectedTrigger = trigger
    end

    RefreshList = function()
        local kids = {listSC:GetChildren()}; for _, ch in ipairs(kids) do ch:Hide(); ch:ClearAllPoints() end
        local newSC = CreateFrame("Frame", nil, listSF); newSC:SetWidth(listW - 30); listSF:SetScrollChild(newSC); listSC = newSC
        local snippets = BigChatBoxDB.snippets or {}
        local sorted = {}; for t in pairs(snippets) do sorted[#sorted+1] = t end
        table.sort(sorted, function(a,b) return a:lower() < b:lower() end)
        local lY = 0
        for _, trigger in ipairs(sorted) do
            local data = snippets[trigger]
            local enabled = not (type(data) == "table" and not data.enabled)
            local row = CreateFrame("Button", nil, listSC); row:SetHeight(24); row:SetPoint("TOPLEFT", 0, -lY); row:SetPoint("RIGHT")
            local hl = row:CreateTexture(nil, "HIGHLIGHT"); hl:SetAllPoints(); hl:SetColorTexture(0.3,0.5,0.8,0.3)
            local sel = row:CreateTexture(nil, "BACKGROUND"); sel:SetAllPoints(); sel:SetColorTexture(0.2,0.4,0.7,0.4); sel:Hide()
            local fs = row:CreateFontString(nil, "ARTWORK", "GameFontHighlight"); fs:SetPoint("LEFT", 8, 0); fs:SetPoint("RIGHT", -4, 0); fs:SetJustifyH("LEFT")
            if not enabled then
                fs:SetText("|cff666666"..trigger.."|r")
            else
                -- Color by channel: anywhere/numbered = blue, named channels follow ChatTypeInfo
                local chanKey = type(data) == "table" and (data.channel or "anywhere") or "anywhere"
                local chatTypeKey = ({guild="GUILD",party="PARTY",raid="RAID",say="SAY",yell="YELL",instance="INSTANCE_CHAT"})[chanKey]
                local hex = "55ccff"  -- default blue for anywhere / numbered channels
                if chatTypeKey then
                    local ti = ChatTypeInfo[chatTypeKey]
                    if ti then hex = format("%02x%02x%02x", ti.r*255, ti.g*255, ti.b*255) end
                end
                fs:SetText("|cff"..hex..trigger.."|r")
            end
            if selectedTrigger == trigger then sel:Show() end
            local captT = trigger
            row:SetScript("OnClick", function()
                if selectedTrigger then AutoSave() end
                selectedTrigger = captT; local d = BigChatBoxDB.snippets[captT]
                -- Display trigger without leading ! (the ! label provides it)
                local displayTrig = captT:sub(1,1) == "!" and captT:sub(2) or captT
                trigInput:SetText(displayTrig); textInput:SetText(type(d)=="table" and (d.text or "") or (d or ""))
                local dEnabled = true; if type(d)=="table" and d.enabled == false then dEnabled = false end
                local dGlobal = true; if type(d)=="table" and d.global == false then dGlobal = false end
                BuildChanMap()
                selectedChannel = chanRevL[type(d)=="table" and (d.channel or "anywhere") or "anywhere"] or "Anywhere"
                chanDrop:SetSelected(GetColoredLabel(selectedChannel))
                enCheck:SetChecked(dEnabled)
                glCheck:SetChecked(dGlobal)
                delBtn:Enable(); shareBtn:Enable(); dupeBtn:Enable()
                isDirty = false; UpdateSaveBtn()
                UpdateCharCount(); RefreshList()
            end)
            lY = lY + 24
        end
        if #sorted == 0 then
            local e = listSC:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); e:SetPoint("TOPLEFT", 8, -8)
            e:SetText(L["SNIPPET_EMPTY_LIST"]); e:SetTextColor(0.5,0.5,0.5); lY = 60
        end
        listSC:SetHeight(math.max(lY, 1))
        C_Timer.After(0.05, function() if scrollBar then if lY <= listSF:GetHeight() then scrollBar:Hide() else scrollBar:Show() end end end)
    end

    saveBtn:SetScript("OnClick", function()
        AutoSave(); isDirty = false; UpdateSaveBtn(); RefreshList()
    end)

    -- Auto-save on changes (also updates char counter in real-time)
    local saveTimer = nil
    local function DebouncedSaveAndRefresh()
        if saveTimer then saveTimer:Cancel() end
        saveTimer = C_Timer.NewTimer(0.5, function() AutoSave(); RefreshList(); saveTimer = nil end)
    end
    trigInput:SetScript("OnTextChanged", function(s,ui)
        if ui then
            isDirty = true; UpdateSaveBtn()
            local t = trigInput:GetText()
            if t and t ~= "" then
                -- Auto-create snippet entry if it doesn't exist yet
                if not BigChatBoxDB.snippets then BigChatBoxDB.snippets = {} end
                if not selectedTrigger then
                    selectedTrigger = "!" .. (t:sub(1,1) == "!" and t:sub(2) or t)
                    AutoSave(); RefreshList()
                else
                    DebouncedSaveAndRefresh()
                end
            end
        end
    end)
    textInput:SetScript("OnTextChanged", function(s,ui)
        UpdateCharCount()
        if ui then
            isDirty = true; UpdateSaveBtn()
            -- Ensure selectedTrigger is set from the trigger field
            local t = trigInput:GetText()
            if t and t ~= "" and not selectedTrigger then
                selectedTrigger = "!" .. (t:sub(1,1) == "!" and t:sub(2) or t)
                -- If this snippet isn't saved yet, save and show immediately
                if not BigChatBoxDB.snippets or not BigChatBoxDB.snippets[selectedTrigger] then
                    AutoSave(); RefreshList()
                else
                    DebouncedSaveAndRefresh()
                end
            end
        end
    end)
    enCheck:SetScript("OnClick", function() AutoSave(); RefreshList() end)
    glCheck:SetScript("OnClick", function() AutoSave() end)

    delBtn:SetScript("OnClick", function()
        if selectedTrigger then StaticPopup_Show("BCB_DELETE_SNIPPET", selectedTrigger, nil, {trigger=selectedTrigger}) end
    end)
    shareBtn:SetScript("OnClick", function()
        if not selectedTrigger then return end; AutoSave()
        local data = BigChatBoxDB.snippets[selectedTrigger]
        if not data then return end
        local encoded = BCB.EncodeSnippet and BCB.EncodeSnippet(selectedTrigger, data)
        if encoded then
            StaticPopup_Show("BCB_SHARE_SNIPPET", nil, nil, {encoded = encoded})
        end
    end)
    dupeBtn:SetScript("OnClick", function()
        if not selectedTrigger or not BigChatBoxDB.snippets then return end; AutoSave()
        local base = selectedTrigger; local num = 1; while BigChatBoxDB.snippets[base..num] do num = num + 1 end
        local newT = base..num; local old = BigChatBoxDB.snippets[selectedTrigger]; local copy = {}
        if type(old)=="table" then for k,v in pairs(old) do copy[k]=v end else copy={text=old,enabled=true,channel="anywhere",global=true} end
        BigChatBoxDB.snippets[newT] = copy; selectedTrigger = newT
        local displayT = newT:sub(1,1) == "!" and newT:sub(2) or newT
        trigInput:SetText(displayT); RefreshList()
    end)

    -- Bottom bar
    local newBtn = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); newBtn:SetSize(110, 24)
    newBtn:SetPoint("BOTTOMLEFT", ct, "BOTTOMLEFT", PAD, 6); newBtn:SetText(L["BTN_NEW_SNIPPET"])
    newBtn:SetScript("OnClick", function()
        if selectedTrigger then AutoSave() end
        selectedTrigger = nil; trigInput:SetText(""); textInput:SetText(""); enCheck:SetChecked(true); glCheck:SetChecked(true)
        selectedChannel = "Anywhere"; trigInput:SetFocus(); isDirty = false; saveBtn:Disable(); delBtn:Disable(); shareBtn:Disable(); dupeBtn:Disable(); RefreshList()
    end)
    local expBtn = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); expBtn:SetSize(90, 24); expBtn:SetPoint("LEFT", newBtn, "RIGHT", 8, 0); expBtn:SetText(L["BTN_EXPORT_ALL"])
    if Config.FitButton then Config.FitButton(expBtn, 90) end
    expBtn:SetScript("OnClick", function()
        local snippets = BigChatBoxDB.snippets or {}
        if not next(snippets) then BCB:Print(L["SNIPPET_NOTHING_TO_EXPORT"]); return end
        local encoded = BCB.EncodeAllSnippets and BCB.EncodeAllSnippets(snippets)
        if encoded then
            StaticPopup_Show("BCB_SHARE_SNIPPET", nil, nil, {encoded = encoded})
        end
    end)
    local impBtn = CreateFrame("Button", nil, ct, "UIPanelButtonTemplate"); impBtn:SetSize(90, 24); impBtn:SetPoint("LEFT", expBtn, "RIGHT", 8, 0); impBtn:SetText(L["BTN_IMPORT_SNIPPET"])
    if Config.FitButton then Config.FitButton(impBtn, 90) end
    impBtn:SetScript("OnClick", function() StaticPopup_Show("BCB_IMPORT_SNIPPETS") end)
    RefreshList()
end
