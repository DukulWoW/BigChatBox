-- BigChatBox MinimapButton.lua - LibDBIcon minimap button + addon compartment
local BCB = BigChatBox
local ICON_PATH = "Interface\\AddOns\\BigChatBox\\assets\\icon"

--------------------------------------------------------------------------------
-- Quick Settings Menu (shared between minimap right-click and channel right-click)
-- v5.5.0: Uses WowStyle1DropdownTemplate with legacy fallback.
--------------------------------------------------------------------------------
local useModernMinimap = C_XMLUtil and C_XMLUtil.GetTemplateInfo
    and C_XMLUtil.GetTemplateInfo("WowStyle1DropdownTemplate")

local function ShowQuickMenu(anchorFrame)
    if useModernMinimap then
        -- Modern WowStyle1DropdownTemplate
        if not BCB._minimapDropdown then
            BCB._minimapDropdown = CreateFrame("DropdownButton", "BCBMinimapMenu", UIParent, "WowStyle1DropdownTemplate")
            BCB._minimapDropdown:SetSize(1, 1); BCB._minimapDropdown:SetAlpha(0)
        end
        -- Reposition to anchor each time (minimap icon, compartment, or cursor)
        BCB._minimapDropdown:ClearAllPoints()
        if type(anchorFrame) == "table" and anchorFrame.GetObjectType then
            BCB._minimapDropdown:SetPoint("TOP", anchorFrame, "BOTTOM", 0, 0)
        else
            -- "cursor" string or unknown anchor — position at cursor
            local x, y = GetCursorPosition()
            local scale = UIParent:GetEffectiveScale()
            BCB._minimapDropdown:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x / scale, y / scale)
        end
        BCB._minimapDropdown:SetupMenu(function(_, rootDescription)
            rootDescription:CreateTitle("|cff5599ffBigChatBox|r")
            rootDescription:CreateButton("Open Config", function()
                if BCB.OpenConfigWindow then BCB.OpenConfigWindow() end
            end)
            rootDescription:CreateButton("Anchor Editor", function()
                if BCB.ToggleVisualEditor then BCB.ToggleVisualEditor() end
            end)
            rootDescription:CreateDivider()
            rootDescription:CreateTitle("Quick Toggles")
            rootDescription:CreateCheckbox("Keep Input Open",
                function() return BigChatBoxDB.keepOpen or false end,
                function() BigChatBoxDB.keepOpen = not BigChatBoxDB.keepOpen end)
            rootDescription:CreateCheckbox("Color Text by Channel",
                function() return BigChatBoxDB.colorTypedText or false end,
                function() BigChatBoxDB.colorTypedText = not BigChatBoxDB.colorTypedText
                    if BCB.UpdateBackdrop then BCB.UpdateBackdrop() end end)
            rootDescription:CreateCheckbox("Auto-Hide Channel Label",
                function() return BigChatBoxDB.autoHideChannelText or false end,
                function() BigChatBoxDB.autoHideChannelText = not BigChatBoxDB.autoHideChannelText
                    if BCB.UpdateAutoHide then BCB.UpdateAutoHide() end end)
            rootDescription:CreateDivider()
            rootDescription:CreateButton("Close Menu", function() end)
        end)
        BCB._minimapDropdown:OpenMenu()
    else
        -- Legacy UIDropDownMenuTemplate fallback
        local menuFrame = CreateFrame("Frame", "BCBMinimapMenu", UIParent, "UIDropDownMenuTemplate")
        local function AddItem(text, func, disabled)
            local info = UIDropDownMenu_CreateInfo()
            info.text = text; info.func = function() func(); CloseDropDownMenus() end
            info.notCheckable = true; info.disabled = disabled
            UIDropDownMenu_AddButton(info)
        end
        local function AddToggle(text, dbKey, onChange)
            local info = UIDropDownMenu_CreateInfo()
            info.text = text; info.isNotRadio = true; info.keepShownOnClick = true
            info.checked = BigChatBoxDB[dbKey] or false
            info.func = function(self)
                BigChatBoxDB[dbKey] = not BigChatBoxDB[dbKey]
                if onChange then onChange(BigChatBoxDB[dbKey]) end
            end
            UIDropDownMenu_AddButton(info)
        end
        UIDropDownMenu_Initialize(menuFrame, function()
            UIDropDownMenu_AddButton({text = "|cff5599ffBigChatBox|r", isTitle = true, notCheckable = true})
            AddItem("Open Config", function()
                if BCB.OpenConfigWindow then BCB.OpenConfigWindow() end
            end)
            AddItem("Anchor Editor", function()
                if BCB.ToggleVisualEditor then BCB.ToggleVisualEditor() end
            end)
            UIDropDownMenu_AddButton({text = " ", isTitle = true, notCheckable = true})
            UIDropDownMenu_AddButton({text = "Quick Toggles", isTitle = true, notCheckable = true})
            AddToggle("Keep Input Open", "keepOpen")
            AddToggle("Color Text by Channel", "colorTypedText", function()
                if BCB.UpdateBackdrop then BCB.UpdateBackdrop() end
            end)
            AddToggle("Auto-Hide Channel Label", "autoHideChannelText", function(val)
                if BCB.UpdateAutoHide then BCB.UpdateAutoHide() end
            end)
            UIDropDownMenu_AddButton({text = " ", isTitle = true, notCheckable = true})
            AddItem("Close Menu", function() end)
        end)
        ToggleDropDownMenu(1, nil, menuFrame, anchorFrame, 0, 0)
    end
end
BCB.ShowQuickMenu = ShowQuickMenu

--------------------------------------------------------------------------------
-- LibDataBroker + LibDBIcon minimap button
--------------------------------------------------------------------------------
local LDB = LibStub and LibStub("LibDataBroker-1.1", true)
local DBIcon = LibStub and LibStub("LibDBIcon-1.0", true)

local ldbObject
if LDB then
    ldbObject = LDB:NewDataObject("BigChatBox", {
        type = "launcher",
        icon = ICON_PATH,
        label = "BigChatBox",
        OnClick = function(self, button)
            if button == "RightButton" then
                ShowQuickMenu(self)
            else
                if BCB.OpenConfigWindow then BCB.OpenConfigWindow() end
            end
        end,
        OnTooltipShow = function(tooltip)
            tooltip:AddLine("BigChatBox", 0.33, 0.6, 1)
            tooltip:AddLine("|cffffd100Left-click|r Open config", 1, 1, 1)
            tooltip:AddLine("|cffffd100Right-click|r Quick settings", 1, 1, 1)
            tooltip:AddLine("|cffffd100Drag|r to reposition", 0.7, 0.7, 0.7)
        end,
    })
    BCB.ldbObject = ldbObject
end

--------------------------------------------------------------------------------
-- Addon Compartment (Blizzard's built-in addon button, 10.x+)
--------------------------------------------------------------------------------
function BCB.OnAddonCompartmentClick(addonName, buttonName)
    if buttonName == "RightButton" then
        ShowQuickMenu("cursor")
    else
        if BCB.OpenConfigWindow then BCB.OpenConfigWindow() end
    end
end

function BCB.OnAddonCompartmentEnter(addonName, menuButtonFrame)
    GameTooltip:SetOwner(menuButtonFrame, "ANCHOR_LEFT")
    GameTooltip:AddLine("BigChatBox", 0.33, 0.6, 1)
    GameTooltip:AddLine("|cffffd100Left-click|r Open config", 1, 1, 1)
    GameTooltip:AddLine("|cffffd100Right-click|r Quick settings", 1, 1, 1)
    GameTooltip:Show()
end

function BCB.OnAddonCompartmentLeave()
    GameTooltip:Hide()
end

--------------------------------------------------------------------------------
-- Init (called from Core.lua Initialize)
--------------------------------------------------------------------------------
function BCB.InitMinimapButton()
    -- LibDBIcon needs a saved variables table for position/hidden state
    if not BigChatBoxDB.minimapIcon then
        BigChatBoxDB.minimapIcon = {
            hide = false,
            -- Migrate old angle to LibDBIcon's minimapPos if present
            minimapPos = BigChatBoxDB.minimapAngle or 220,
        }
    end

    -- Migrate: if user had minimap button hidden via old toggle, respect it
    if BigChatBoxDB.showMinimapButton == false then
        BigChatBoxDB.minimapIcon.hide = true
    end

    if DBIcon and ldbObject then
        DBIcon:Register("BigChatBox", ldbObject, BigChatBoxDB.minimapIcon)
    end
end

function BCB.SetMinimapButtonShown(show)
    if not DBIcon then return end
    if show then
        BigChatBoxDB.minimapIcon.hide = false
        DBIcon:Show("BigChatBox")
    else
        BigChatBoxDB.minimapIcon.hide = true
        DBIcon:Hide("BigChatBox")
    end
    -- Keep old key in sync for the config checkbox
    BigChatBoxDB.showMinimapButton = show
end
