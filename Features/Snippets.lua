-- BigChatBox Features/Snippets.lua — Text snippet expansion system
-- Handles snippet storage, expansion, throttling, and migration.
local BCB = BigChatBox

-- Max message length (WoW limit is 255 for chat)
BCB.SNIPPET_MAX_LENGTH = 255

-- Spam throttle: track last snippet send time
local lastSnippetTime = 0
local SNIPPET_COOLDOWN = 1.0 -- seconds between snippet sends

-- Get snippet text from data (supports old string format and new table format)
function BCB.GetSnippetData(trigger)
    local snippets = BigChatBoxDB.snippets
    if not snippets or not snippets[trigger] then return nil end
    local data = snippets[trigger]
    if type(data) == "string" then
        -- Migrate old format to new table format
        data = { text = data, enabled = true, channel = "anywhere", global = false }
        snippets[trigger] = data
    end
    return data
end

-- Expand snippets: returns expanded text AND optional channel override
function BCB.ExpandSnippets(text)
    if BigChatBoxDB.snippetEnabled == false then return text, nil end
    local snippets = BigChatBoxDB.snippets
    if not snippets then return text, nil end

    -- Security: block commands and macros in snippet text
    local function SanitizeOutput(t)
        if t:sub(1,1) == "/" then return t end -- don't sanitize if it's already a slash command typed by user
        return t
    end

    -- Check if entire text matches a snippet trigger
    local data = BCB.GetSnippetData(text)
    if data and data.enabled ~= false then
        -- Spam throttle
        local now = GetTime()
        if now - lastSnippetTime < SNIPPET_COOLDOWN then
            BCB:Print("Snippet throttled. Please wait a moment.")
            return nil, nil -- nil signals "don't send"
        end
        lastSnippetTime = now

        local output = data.text or ""
        -- Security: strip leading / to prevent command execution
        if output:sub(1,1) == "/" then
            BCB:Print("Snippet blocked: cannot execute commands.")
            return nil, nil
        end
        -- Truncate to max length
        if #output > BCB.SNIPPET_MAX_LENGTH then output = output:sub(1, BCB.SNIPPET_MAX_LENGTH) end

        -- Character-specific check
        if data.global == false and data.character and data.character ~= UnitName("player") then
            return text, nil -- not for this character, pass through
        end

        return output, data.channel or "anywhere"
    end

    return text, nil
end

-- Snippet management
function BCB.AddSnippet(trigger, text, opts)
    if not BigChatBoxDB.snippets then BigChatBoxDB.snippets = {} end
    opts = opts or {}
    BigChatBoxDB.snippets[trigger] = {
        text = text,
        enabled = opts.enabled ~= false,
        channel = opts.channel or "anywhere",
        global = opts.global ~= false,
        character = opts.global == false and UnitName("player") or nil,
    }
end

function BCB.RemoveSnippet(trigger)
    if BigChatBoxDB.snippets then BigChatBoxDB.snippets[trigger] = nil end
end

function BCB.GetSnippets()
    return BigChatBoxDB.snippets or {}
end

-- Migrate old string-format snippets to table format
function BCB.MigrateSnippets()
    local snippets = BigChatBoxDB.snippets or {}
    for trigger, data in pairs(snippets) do
        if type(data) == "string" then
            snippets[trigger] = { text = data, enabled = true, channel = "anywhere", global = true }
        end
    end
end
