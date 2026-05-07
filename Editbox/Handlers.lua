-- BigChatBox Editbox/Handlers.lua — Editbox event scripts
-- OnTextChanged, OnKeyDown, OnEnterPressed, OnEscapePressed, focus management.

local BCB = BigChatBox

function BCB.SetupEditBoxHandlers()
    local editBox = BCB.editBox
    local historyIndex = 0

    -- TEXT CHANGED — parse commands, color text, update autocomplete
    editBox:SetScript("OnTextChanged", function(self, userInput)
        if userInput then
            historyIndex = 0
            if BigChatBoxDB.colorTypedText then
                local chatType = self:GetAttribute("chatType") or "SAY"
                local typeInfo = ChatTypeInfo[chatType]
                if typeInfo then self:SetTextColor(typeInfo.r, typeInfo.g, typeInfo.b)
                else self:SetTextColor(1, 1, 1) end
            else
                self:SetTextColor(1, 1, 1)
            end
            BCB.ParseChatCommand(self:GetText())
            if BCB.UpdateAutocomplete then BCB.UpdateAutocomplete(self:GetText()) end
        end
    end)

    -- KEY DOWN — Tab (autocomplete), Enter, Escape, Up/Down (history)
    editBox:SetScript("OnKeyDown", function(self, key)
        if key == "TAB" then
            local popup = BCB.autocompleteFrame
            if popup and popup:IsShown() and #popup.matches > 0 then
                if IsShiftKeyDown() then
                    popup.selectedIndex = popup.selectedIndex - 1
                    if popup.selectedIndex < 1 then popup.selectedIndex = math.min(#popup.matches, 8) end
                else
                    popup.selectedIndex = popup.selectedIndex + 1
                    if popup.selectedIndex > math.min(#popup.matches, 8) then popup.selectedIndex = 1 end
                end
                popup:UpdateSelection()
                if popup.onSelect then
                    local match = popup.matches[popup.selectedIndex]
                    if match and popup.mode == "slash" then
                        self:SetText(match); self:SetCursorPosition(#match)
                    elseif match and popup.mode == "name" then
                        local full = (popup.namePrefix or "/w ") .. match
                        self:SetText(full); self:SetCursorPosition(#full)
                    end
                end
            end
        elseif key == "ENTER" or key == "RETURN" then
            if IsControlKeyDown() then BCB_UseBlizzardChat(); return end
            local popup = BCB.autocompleteFrame
            if popup and popup:IsShown() and #popup.matches > 0 then
                if popup.onSelect then popup.onSelect(popup.selectedIndex) end
                return
            end
        elseif key == "ESCAPE" then
            local popup = BCB.autocompleteFrame
            if popup and popup:IsShown() then popup:Hide(); return end
        elseif key == "UP" then
            -- If autocomplete is open, navigate it upward instead of scrolling history
            local popup = BCB.autocompleteFrame
            if popup and popup:IsShown() and #popup.matches > 0 then
                popup.selectedIndex = popup.selectedIndex - 1
                if popup.selectedIndex < 1 then popup.selectedIndex = math.min(#popup.matches, 8) end
                popup:UpdateSelection()
                local match = popup.matches[popup.selectedIndex]
                if match then
                    if popup.mode == "slash" then
                        self:SetText(match); self:SetCursorPosition(#match)
                    elseif popup.mode == "name" then
                        local full = (popup.namePrefix or "/w ") .. match
                        self:SetText(full); self:SetCursorPosition(#full)
                    end
                end
                return
            end
            -- No autocomplete open — scroll history as normal
            if BigChatBoxDB.historyEnabled == false then return end
            local totalHistory = #BigChatBoxDB.history
            if totalHistory > 0 then
                historyIndex = math.min(historyIndex + 1, totalHistory)
                local history = BCB.GetFromHistory(historyIndex)
                if history then self:SetText(history); self:SetCursorPosition(#history) end
            end
        elseif key == "DOWN" then
            -- If autocomplete is open, navigate it downward instead of scrolling history
            local popup = BCB.autocompleteFrame
            if popup and popup:IsShown() and #popup.matches > 0 then
                popup.selectedIndex = popup.selectedIndex + 1
                if popup.selectedIndex > math.min(#popup.matches, 8) then popup.selectedIndex = 1 end
                popup:UpdateSelection()
                local match = popup.matches[popup.selectedIndex]
                if match then
                    if popup.mode == "slash" then
                        self:SetText(match); self:SetCursorPosition(#match)
                    elseif popup.mode == "name" then
                        local full = (popup.namePrefix or "/w ") .. match
                        self:SetText(full); self:SetCursorPosition(#full)
                    end
                end
                return
            end
            -- No autocomplete open — scroll history as normal
            if BigChatBoxDB.historyEnabled == false then return end
            if historyIndex > 0 then
                historyIndex = historyIndex - 1
                if historyIndex == 0 then
                    self:SetText("")
                else
                    local history = BCB.GetFromHistory(historyIndex)
                    if history then self:SetText(history); self:SetCursorPosition(#history) end
                end
            end
        end
    end)

    -- ENTER — send message
    editBox:SetScript("OnEnterPressed", function(self)
        local text = self:GetText()

        -- Always remember current channel
        local chatType = self:GetAttribute("chatType")
        BigChatBoxDB.lastChatType = chatType

        if text and text ~= "" then
            BCB.SendMessage(text, self)
        end

        historyIndex = 0
        self:SetText(""); self:SetCursorPosition(0); self:ClearFocus()
        BCB.frame:Hide()
    end)

    -- ESCAPE — cancel
    editBox:SetScript("OnEscapePressed", function(self)
        if BCB.autocompleteFrame and BCB.autocompleteFrame:IsShown() then
            BCB.autocompleteFrame:Hide(); return
        end
        -- Close emoji picker first if open; second ESC then closes the editbox
        if BCB.emojiPickerFrame and BCB.emojiPickerFrame:IsShown() then
            BCB.emojiPickerFrame:Hide(); return
        end
        historyIndex = 0
        self:SetText(""); self:SetCursorPosition(0)
        BCB.frame:Hide(); self:ClearFocus()
        if ChatFrame1EditBox and not BCB.IsSecureContentActive() then
            ChatFrame1EditBox:SetText("")
            ChatFrame1EditBox:Hide()
        end
    end)

    -- FOCUS GAINED
    editBox:SetScript("OnEditFocusGained", function(self)
        historyIndex = 0
        if not BCB.IsSecureContentActive() and ChatFrame1EditBox then
            ACTIVE_CHAT_EDIT_BOX = ChatFrame1EditBox
            BCB.SyncChatTypeToBlizzard()
        end
    end)

    -- FOCUS LOST
    editBox:SetScript("OnEditFocusLost", function(self)
        if not BCB.IsSecureContentActive() and not BCB.frame:IsShown() then
            if ChatFrame1EditBox and ACTIVE_CHAT_EDIT_BOX == ChatFrame1EditBox then
                ACTIVE_CHAT_EDIT_BOX = nil
            end
        end
        if BCB.isDropdownOpen and BCB.isDropdownOpen() then return end
        if BCB.autocompleteFrame and BCB.autocompleteFrame:IsShown() then return end
        if BigChatBoxDB.keepOpen then return end
        if BCB._suppressEditBoxHook then return end

        C_Timer.After(0.15, function()
            if BCB._suppressEditBoxHook then return end
            if (GetTime() - (BCB._lastLinkInsertTime or 0)) < 0.3 then return end
            if BCB.frame:IsShown() and not self:HasFocus() then
                historyIndex = 0
                self:SetText(""); self:SetCursorPosition(0)
                BCB.frame:Hide()
                if BCB.autocompleteFrame then BCB.autocompleteFrame:Hide() end
            end
        end)
    end)
end
