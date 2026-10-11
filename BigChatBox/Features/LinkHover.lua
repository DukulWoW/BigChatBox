-- BigChatBox Features/LinkHover.lua — Inline link hover tooltips
-- Shows item/spell/achievement tooltips when hovering links in the editbox.
local BCB = BigChatBox

function BCB.SetupLinkHover()
    if not BCB.editBox then return end
    local editBox = BCB.editBox

    editBox:SetHyperlinksEnabled(true)

    -- SetHyperlink shows the exact linked item (bonus IDs, random suffixes), unlike
    -- SetItemByID. Protected, so a link the tooltip cannot show does not raise an
    -- error on every hover (BUG-09, FOR-07).
    editBox:SetScript("OnHyperlinkEnter", function(self, link)
        if BigChatBoxDB.enableLinkHover == false then return end
        GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
        if pcall(GameTooltip.SetHyperlink, GameTooltip, link) then GameTooltip:Show() else GameTooltip:Hide() end
    end)

    editBox:SetScript("OnHyperlinkLeave", function() GameTooltip:Hide() end)

    editBox:SetScript("OnHyperlinkClick", function(self, link, text, button)
        SetItemRef(link, text, button, self)
    end)
end
