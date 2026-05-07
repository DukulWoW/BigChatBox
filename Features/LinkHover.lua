-- BigChatBox Features/LinkHover.lua — Inline link hover tooltips
-- Shows item/spell/achievement tooltips when hovering links in the editbox.
local BCB = BigChatBox

function BCB.SetupLinkHover()
    if not BCB.editBox then return end
    local editBox = BCB.editBox

    editBox:SetHyperlinksEnabled(true)

    editBox:SetScript("OnHyperlinkEnter", function(self, link, text)
        if BigChatBoxDB.enableLinkHover == false then return end
        GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
        local linkType, linkID = link:match("^(%a+):(.+)")
        if linkType == "item" then
            local itemID = tonumber(linkID:match("^(%d+)"))
            if itemID then GameTooltip:SetItemByID(itemID) end
        elseif linkType == "spell" then
            local spellID = tonumber(linkID:match("^(%d+)"))
            if spellID then GameTooltip:SetSpellByID(spellID) end
        elseif linkType == "achievement" then
            GameTooltip:SetHyperlink(link)
        else
            GameTooltip:SetHyperlink(link)
        end
        GameTooltip:Show()
    end)

    editBox:SetScript("OnHyperlinkLeave", function() GameTooltip:Hide() end)

    editBox:SetScript("OnHyperlinkClick", function(self, link, text, button)
        SetItemRef(link, text, button, self)
    end)
end
