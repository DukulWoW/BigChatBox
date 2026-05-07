-- BigChatBox Editbox/ChannelDisplay.lua — Channel indicator, dropdown, cycling
-- Shows current chat type above/beside the editbox with color + dropdown menus.
-- v5.5.0: Left-click and right-click menus use WowStyle1DropdownTemplate with fallback.

local BCB = BigChatBox
local defaults = BCB.defaults

-- Forward declare — set after creation
local UpdateChannelDisplay

--------------------------------------------------------------------------------
-- CREATE CHANNEL DISPLAY
--------------------------------------------------------------------------------
function BCB.CreateChannelDisplay(parent)
    local channelButton = CreateFrame("Button", nil, parent)
    channelButton:SetSize(150, 20)
    channelButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")

    local channelText = channelButton:CreateFontString(nil, "OVERLAY")
    channelText:SetPoint("CENTER")
    channelText:SetTextColor(1, 1, 1)
    channelText:SetJustifyH("CENTER")

    local fontPath = BigChatBoxDB.channelFont     or defaults.channelFont
    local fontSize = BigChatBoxDB.channelFontSize or defaults.channelFontSize
    channelText:SetFont(fontPath, fontSize, "")

    channelButton.text = channelText
    BCB.channelButton = channelButton
    BCB.channelText   = channelText

    -- Reposition based on settings (top/bottom/left/right)
    local function RepositionChannelText()
        channelButton:ClearAllPoints()
        local side = BigChatBoxDB.channelTextSide or "top"
        if side == "bottom" then
            channelButton:SetPoint("TOP", parent, "BOTTOM", 0, -2)
            channelText:SetJustifyH("CENTER")
        elseif side == "left" then
            channelButton:SetPoint("RIGHT", parent, "LEFT", -2, 0)
            channelText:SetJustifyH("RIGHT")
        elseif side == "right" then
            channelButton:SetPoint("LEFT", parent, "RIGHT", 2, 0)
            channelText:SetJustifyH("LEFT")
        else -- top (default)
            channelButton:SetPoint("BOTTOM", parent, "TOP", 0, 2)
            channelText:SetJustifyH("CENTER")
        end
        if side == "left" or side == "right" then
            local textW = channelText:GetStringWidth() or 80
            channelButton:SetSize(textW + 10, 20)
        else
            channelButton:SetSize(150, 20)
        end
    end
    RepositionChannelText()
    BCB.RepositionChannelText = RepositionChannelText

    -- Show/hide channel name entirely (independent of auto-hide)
    local function UpdateChannelVisibility()
        local show = BigChatBoxDB.showChannelName ~= false  -- default true
        if show then
            channelButton:Show()
        else
            channelButton:Hide()
        end
    end
    BCB.UpdateChannelVisibility = UpdateChannelVisibility
    UpdateChannelVisibility()

    -- Auto-hide (fades when not hovering; only applies when channel name is shown)
    local function UpdateAutoHide()
        if not (BigChatBoxDB.showChannelName ~= false) then return end
        if BigChatBoxDB.autoHideChannelText then
            channelText:SetAlpha(0)
        else
            channelText:SetAlpha(1)
        end
    end
    BCB.UpdateAutoHide = UpdateAutoHide
    UpdateAutoHide()

    -- Hover detection for auto-hide
    parent:HookScript("OnShow", function()
        -- If channel name is fully hidden, ensure button stays hidden and bail out
        if BigChatBoxDB.showChannelName == false then
            channelButton:Hide()
            return
        end
        if BigChatBoxDB.autoHideChannelText then
            channelText:SetAlpha(0)
            parent:SetScript("OnUpdate", function()
                if BigChatBoxDB.showChannelName == false then channelButton:Hide(); return end
                if not BigChatBoxDB.autoHideChannelText then channelText:SetAlpha(1); return end
                if parent:IsMouseOver(30, -30, -30, 30) or channelButton:IsMouseOver() then
                    channelText:SetAlpha(1)
                else
                    channelText:SetAlpha(0)
                end
            end)
        end
    end)

    -- Dropdown state
    local isDropdownOpen = false
    BCB.isDropdownOpen = function() return isDropdownOpen end
    BCB.setDropdownOpen = function(state) isDropdownOpen = state end

    -- Check if modern dropdown template is available
    local useModern = C_XMLUtil and C_XMLUtil.GetTemplateInfo
        and C_XMLUtil.GetTemplateInfo("WowStyle1DropdownTemplate")

    -- Shared helper: close menu and refocus editbox
    local function CloseAndRefocus()
        isDropdownOpen = false
        if BCB.frame and BCB.editBox then
            BCB.frame:Show()
            C_Timer.After(0.01, function() if BCB.editBox then BCB.editBox:SetFocus() end end)
        end
    end

    ----------------------------------------------------------------------------
    -- MODERN LEFT-CLICK MENU (WowStyle1DropdownTemplate)
    ----------------------------------------------------------------------------
    local function ShowModernChannelMenu(anchor)
        if not BCB._channelDropdown then
            BCB._channelDropdown = CreateFrame("DropdownButton", "BCBChannelDropdown", parent, "WowStyle1DropdownTemplate")
            BCB._channelDropdown:SetPoint("CENTER", channelButton, "CENTER")
            BCB._channelDropdown:SetSize(1, 1); BCB._channelDropdown:SetAlpha(0)
        end
        BCB._channelDropdown:SetupMenu(function(_, rootDescription)
            rootDescription:CreateTitle("Chat Channels")
            local function AddChan(label, chatType, disabled)
                local btn = rootDescription:CreateButton(label, function()
                    BCB.SwitchToChannel(chatType); CloseAndRefocus()
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

            -- Custom channels
            local channels = {GetChannelList()}
            if #channels > 0 then
                rootDescription:CreateDivider()
                for i = 1, #channels, 3 do
                    local id, name = channels[i], channels[i + 1]
                    if id and name then
                        rootDescription:CreateButton("[" .. id .. "] " .. name, function()
                            if BCB.editBox then
                                BCB.editBox:SetAttribute("chatType", "CHANNEL")
                                BCB.editBox:SetAttribute("channelTarget", id)
                                BigChatBoxDB.lastChatType = "CHANNEL"
                                UpdateChannelDisplay()
                            end
                            CloseAndRefocus()
                        end)
                    end
                end
            end

            -- Recent whispers
            local wh = BigChatBoxDB.whisperHistory or {}
            if #wh > 0 then
                rootDescription:CreateDivider()
                rootDescription:CreateTitle("Recent Whispers")
                for _, playerName in ipairs(wh) do
                    rootDescription:CreateButton(playerName, function()
                        if BCB.editBox then
                            BCB.editBox:SetAttribute("chatType", "WHISPER")
                            BCB.editBox:SetAttribute("tellTarget", playerName)
                            BigChatBoxDB.lastChatType = "WHISPER"
                            UpdateChannelDisplay()
                        end
                        CloseAndRefocus()
                    end)
                end
            end
        end)
        BCB._channelDropdown:OpenMenu()
    end

    ----------------------------------------------------------------------------
    -- MODERN RIGHT-CLICK MENU (WowStyle1DropdownTemplate)
    ----------------------------------------------------------------------------
    local function ShowModernConfigMenu()
        if not BCB._configDropdown then
            BCB._configDropdown = CreateFrame("DropdownButton", "BCBConfigDropdown", parent, "WowStyle1DropdownTemplate")
            BCB._configDropdown:SetPoint("CENTER", channelButton, "CENTER")
            BCB._configDropdown:SetSize(1, 1); BCB._configDropdown:SetAlpha(0)
        end
        BCB._configDropdown:SetupMenu(function(_, rootDescription)
            rootDescription:CreateTitle("Options")
            rootDescription:CreateButton("Open Config", function()
                if BCB.OpenConfigWindow then BCB.OpenConfigWindow()
                elseif Settings and Settings.OpenToCategory and BCB.settingsCategory then
                    Settings.OpenToCategory(BCB.settingsCategory:GetID())
                end
                isDropdownOpen = false
            end)
            rootDescription:CreateButton("Toggle Anchor Editor", function()
                if BCB.ToggleVisualEditor then BCB.ToggleVisualEditor() end
                isDropdownOpen = false
            end)
            rootDescription:CreateButton("Clear Chat History", function()
                StaticPopup_Show("BCB_CLEAR_HISTORY"); isDropdownOpen = false
            end)
            rootDescription:CreateButton("Clear Whisper History", function()
                StaticPopup_Show("BCB_CLEAR_WHISPERS"); isDropdownOpen = false
            end)
            rootDescription:CreateDivider()
            rootDescription:CreateButton("Close Menu", function() isDropdownOpen = false end)
        end)
        BCB._configDropdown:OpenMenu()
    end

    ----------------------------------------------------------------------------
    -- LEGACY LEFT-CLICK MENU (UIDropDownMenuTemplate fallback)
    ----------------------------------------------------------------------------
    local function ShowLegacyChannelMenu(anchor)
        local menuFrame = CreateFrame("Frame", "BCBChannelDropdown", parent, "UIDropDownMenuTemplate")
        local function AddMenuItem(text, func, disabled)
            local info = UIDropDownMenu_CreateInfo()
            info.text = text
            info.func = function() func(); CloseDropDownMenus(); CloseAndRefocus() end
            info.notCheckable = true; info.disabled = disabled
            UIDropDownMenu_AddButton(info)
        end
        UIDropDownMenu_Initialize(menuFrame, function()
            UIDropDownMenu_AddButton({text = "Chat Channels", isTitle = true, notCheckable = true})
            AddMenuItem("Say",      function() BCB.SwitchToChannel("SAY") end)
            AddMenuItem("Yell",     function() BCB.SwitchToChannel("YELL") end)
            AddMenuItem("Party",    function() BCB.SwitchToChannel("PARTY") end,         not IsInGroup(LE_PARTY_CATEGORY_HOME))
            AddMenuItem("Raid",     function() BCB.SwitchToChannel("RAID") end,          not IsInRaid(LE_PARTY_CATEGORY_HOME))
            AddMenuItem("Instance", function() BCB.SwitchToChannel("INSTANCE_CHAT") end, not IsInGroup(LE_PARTY_CATEGORY_INSTANCE))
            AddMenuItem("Guild",    function() BCB.SwitchToChannel("GUILD") end,         not IsInGuild())
            AddMenuItem("Officer",  function() BCB.SwitchToChannel("OFFICER") end,       not IsInGuild())
            local channels = {GetChannelList()}
            if #channels > 0 then
                UIDropDownMenu_AddButton({text = " ", isTitle = true, notCheckable = true})
                for i = 1, #channels, 3 do
                    local id, name = channels[i], channels[i + 1]
                    if id and name then
                        AddMenuItem("[" .. id .. "] " .. name, function()
                            if BCB.editBox then
                                BCB.editBox:SetAttribute("chatType", "CHANNEL")
                                BCB.editBox:SetAttribute("channelTarget", id)
                                BigChatBoxDB.lastChatType = "CHANNEL"
                                UpdateChannelDisplay()
                            end
                        end)
                    end
                end
            end
            if #BigChatBoxDB.whisperHistory > 0 then
                UIDropDownMenu_AddButton({text = " ", isTitle = true, notCheckable = true})
                UIDropDownMenu_AddButton({text = "Recent Whispers", isTitle = true, notCheckable = true})
                for _, playerName in ipairs(BigChatBoxDB.whisperHistory) do
                    AddMenuItem(playerName, function()
                        if BCB.editBox then
                            BCB.editBox:SetAttribute("chatType", "WHISPER")
                            BCB.editBox:SetAttribute("tellTarget", playerName)
                            BigChatBoxDB.lastChatType = "WHISPER"
                            UpdateChannelDisplay()
                        end
                    end)
                end
            end
        end)
        ToggleDropDownMenu(1, nil, menuFrame, anchor, 0, 0)
    end

    ----------------------------------------------------------------------------
    -- LEGACY RIGHT-CLICK MENU (UIDropDownMenuTemplate fallback)
    ----------------------------------------------------------------------------
    local function ShowLegacyConfigMenu(anchor)
        local menuFrame = CreateFrame("Frame", "BCBConfigDropdown", parent, "UIDropDownMenuTemplate")
        local function AddMenuItem(text, func)
            local info = UIDropDownMenu_CreateInfo()
            info.text = text
            info.func = function() func(); CloseDropDownMenus(); isDropdownOpen = false end
            info.notCheckable = true
            UIDropDownMenu_AddButton(info)
        end
        UIDropDownMenu_Initialize(menuFrame, function()
            UIDropDownMenu_AddButton({text = "Options", isTitle = true, notCheckable = true})
            AddMenuItem("Open Config", function()
                if BCB.OpenConfigWindow then BCB.OpenConfigWindow()
                elseif Settings and Settings.OpenToCategory and BCB.settingsCategory then
                    Settings.OpenToCategory(BCB.settingsCategory:GetID())
                end
            end)
            AddMenuItem("Toggle Anchor Editor", function()
                if BCB.ToggleVisualEditor then BCB.ToggleVisualEditor() end
            end)
            AddMenuItem("Clear Chat History",    function() StaticPopup_Show("BCB_CLEAR_HISTORY") end)
            AddMenuItem("Clear Whisper History", function() StaticPopup_Show("BCB_CLEAR_WHISPERS") end)
            UIDropDownMenu_AddButton({text = " ", isTitle = true, notCheckable = true})
            AddMenuItem("Close Menu", function() end)
        end)
        ToggleDropDownMenu(1, nil, menuFrame, anchor, 0, 0)
    end

    ----------------------------------------------------------------------------
    -- ONCLICK: route to modern or legacy based on availability
    ----------------------------------------------------------------------------
    channelButton:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            isDropdownOpen = true
            if useModern then ShowModernChannelMenu(self)
            else ShowLegacyChannelMenu(self) end
        elseif button == "RightButton" then
            isDropdownOpen = true
            if useModern then ShowModernConfigMenu()
            else ShowLegacyConfigMenu(self) end
        end
    end)

    -- Hover effect
    channelButton:SetScript("OnEnter", function(self) self.text:SetTextColor(1, 1, 0.5) end)
    channelButton:SetScript("OnLeave", function(self)
        local chatType = BCB.editBox and BCB.editBox:GetAttribute("chatType") or "SAY"
        local typeInfo = ChatTypeInfo[chatType]
        if typeInfo then self.text:SetTextColor(typeInfo.r, typeInfo.g, typeInfo.b)
        else self.text:SetTextColor(1, 1, 1) end
    end)

    return channelButton
end

--------------------------------------------------------------------------------
-- UPDATE CHANNEL DISPLAY
-- Updates the channel text, colors, and border tint.
--------------------------------------------------------------------------------
function BCB.UpdateChannelDisplay()
    if not BCB.channelText or not BCB.editBox or not BCB.frame then return end

    local chatType   = BCB.editBox:GetAttribute("chatType") or "SAY"
    local chatTarget = BCB.editBox:GetAttribute("tellTarget")
    local displayText = ""
    local r, g, b = 1, 1, 1

    local typeInfo = ChatTypeInfo[chatType]
    if typeInfo then r, g, b = typeInfo.r, typeInfo.g, typeInfo.b end

    if chatType == "WHISPER" and chatTarget then
        displayText = "To: " .. Ambiguate(chatTarget, "short")
    elseif chatType == "BN_WHISPER" and chatTarget then
        displayText = "To: " .. chatTarget
    elseif chatType == "CHANNEL" then
        local channelNum = BCB.editBox:GetAttribute("channelTarget")
        if channelNum then
            local _, chanName = GetChannelName(channelNum)
            displayText = chanName and chanName ~= "" and ("[" .. channelNum .. "] " .. chanName) or ("[" .. channelNum .. "]")
        else
            displayText = "Channel"
        end
    else
        displayText = _G["CHAT_MSG_" .. chatType] or chatType
    end

    BCB.channelText:SetText(displayText)
    BCB.channelText:SetTextColor(r, g, b)

    -- Border color = channel color × user border color
    local borderAlpha = BigChatBoxDB.borderAlpha or defaults.borderAlpha
    local borderColor = BigChatBoxDB.borderColor or defaults.borderColor
    BCB.frame:SetBackdropBorderColor(r * borderColor.r, g * borderColor.g, b * borderColor.b, borderAlpha)

    -- Background tint
    if BigChatBoxDB.bgChannelTint then
        local bgAlpha = BigChatBoxDB.bgAlpha or defaults.bgAlpha
        local bgColor = BigChatBoxDB.bgColor or defaults.bgColor
        local intensity = (BigChatBoxDB.bgTintIntensity or 50) / 100
        BCB.frame:SetBackdropColor(
            bgColor.r * (1 - intensity) + r * intensity,
            bgColor.g * (1 - intensity) + g * intensity,
            bgColor.b * (1 - intensity) + b * intensity,
            bgAlpha)
    end

    if BCB.SyncChatTypeToBlizzard then BCB.SyncChatTypeToBlizzard() end

    -- Re-apply show/hide state every time the display updates (handles
    -- the checkbox being toggled while the frame is open)
    if BCB.UpdateChannelVisibility then BCB.UpdateChannelVisibility() end
end

-- Local reference for use within this file's closures
UpdateChannelDisplay = BCB.UpdateChannelDisplay

--------------------------------------------------------------------------------
-- SWITCH CHANNEL
--------------------------------------------------------------------------------
function BCB.SwitchToChannel(chatType)
    if BCB.editBox then
        BCB.editBox:SetAttribute("chatType", chatType)
        BigChatBoxDB.lastChatType = chatType
        BCB.UpdateChannelDisplay()
    end
end
