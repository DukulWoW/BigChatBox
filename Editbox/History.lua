-- BigChatBox Editbox/History.lua — Chat & whisper history management

local BCB = BigChatBox

--------------------------------------------------------------------------------
-- CHAT HISTORY
--------------------------------------------------------------------------------
function BCB.AddToHistory(text, chatType)
    if not text or text == "" then return end
    if BigChatBoxDB.historyEnabled == false then return end

    -- Skip /commands if setting is enabled
    if BigChatBoxDB.ignoreCommandsInHistory and text:match("^/") then return end

    -- Don't add duplicates of the last message
    local lastEntry = BigChatBoxDB.history[1]
    local lastText = type(lastEntry) == "table" and lastEntry.text or lastEntry
    if lastText == text then return end

    -- Locale-aware date+time stamp
    local locale = GetLocale()
    local dateFmt
    if locale == "enUS" or locale == "esMX" or locale == "ptBR" then
        dateFmt = date("%m/%d/%y - %H:%M")
    elseif locale == "koKR" or locale == "zhCN" or locale == "zhTW" or locale == "jaJP" then
        dateFmt = date("%y/%m/%d - %H:%M")
    else
        dateFmt = date("%d/%m/%y - %H:%M")
    end

    local entry = { text = text, time = dateFmt }
    if chatType and chatType ~= "" then entry.chatType = chatType end
    table.insert(BigChatBoxDB.history, 1, entry)

    local maxHistory = BigChatBoxDB.historyLength or 100
    while #BigChatBoxDB.history > maxHistory do
        table.remove(BigChatBoxDB.history)
    end

    -- Real-time refresh of the History tab if visible
    if BCB.RefreshConfigTab then BCB.RefreshConfigTab() end
end

function BCB.GetFromHistory(index)
    local entry = BigChatBoxDB.history[index]
    if type(entry) == "table" then return entry.text end
    return entry
end

--------------------------------------------------------------------------------
-- WHISPER HISTORY
--------------------------------------------------------------------------------
function BCB.AddToWhisperHistory(playerName)
    if not playerName or playerName == "" then return end

    -- Remove if already exists (move to front)
    for i = #BigChatBoxDB.whisperHistory, 1, -1 do
        if BigChatBoxDB.whisperHistory[i] == playerName then
            table.remove(BigChatBoxDB.whisperHistory, i)
        end
    end

    table.insert(BigChatBoxDB.whisperHistory, 1, playerName)

    while #BigChatBoxDB.whisperHistory > 5 do
        table.remove(BigChatBoxDB.whisperHistory)
    end
end

function BCB.ClearWhisperHistory()
    BigChatBoxDB.whisperHistory = {}
    print("|cff00ff00BigChatBox:|r Whisper history cleared.")
end
