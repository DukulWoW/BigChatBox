-- BigChatBox Features/Autocomplete.lua — Smart Tab completion system
-- Provides autocomplete for slash commands, whisper targets, and snippet triggers.
-- Whisper autocomplete shows class icon, colored class name, level, and source.
local BCB = BigChatBox

local SLASH_COMMANDS = {
    "/say","/yell","/guild","/party","/raid","/instance",
    "/whisper","/reply","/emote","/afk","/dnd",
    "/dance","/wave","/bow","/cheer","/clap","/cry",
    "/flex","/goodbye","/hello","/kiss","/kneel","/laugh",
    "/no","/nod","/point","/roar","/rude","/salute",
    "/shy","/sigh","/sit","/sleep","/stand","/surprised",
    "/thank","/train","/violin","/yes",
    "/readycheck","/pull","/countdown",
    "/invite","/kick","/promote","/lead",
    "/target","/focus","/assist",
    "/cast","/use","/cancelaura",
    "/run","/script","/dump",
    "/bcb","/reload","/console",
    "/who","/join","/leave",
    "/trade","/lookingforgroup",
}

local MAX_ROWS = 8
local ROW_H = 22

-- Class icon texcoords from the class icon atlas (4x4 grid, 256x256)
local CLASS_ICON_ATLAS = "Interface\\GLUES\\CHARACTERCREATE\\UI-CharacterCreate-Classes"
local CLASS_ICON_COORDS = {
    WARRIOR     = {0,    0.25, 0,    0.25},
    MAGE        = {0.25, 0.5,  0,    0.25},
    ROGUE       = {0.5,  0.75, 0,    0.25},
    DRUID       = {0.75, 1,    0,    0.25},
    HUNTER      = {0,    0.25, 0.25, 0.5},
    SHAMAN      = {0.25, 0.5,  0.25, 0.5},
    PRIEST      = {0.5,  0.75, 0.25, 0.5},
    WARLOCK     = {0.75, 1,    0.25, 0.5},
    PALADIN     = {0,    0.25, 0.5,  0.75},
    DEATHKNIGHT = {0.25, 0.5,  0.5,  0.75},
    MONK        = {0.5,  0.75, 0.5,  0.75},
    DEMONHUNTER = {0.75, 1,    0.5,  0.75},
    EVOKER      = {0,    0.25, 0.75, 1},
}

-- Build inline class icon texture string
local function ClassIconString(classFile)
    local c = CLASS_ICON_COORDS[classFile]
    if not c then return "" end
    return string.format("|T%s:14:14:0:0:256:256:%d:%d:%d:%d|t",
        CLASS_ICON_ATLAS,
        math.floor(c[1]*256), math.floor(c[2]*256),
        math.floor(c[3]*256), math.floor(c[4]*256))
end

-- Build colored class name string
local function ColoredClassName(classFile)
    if not classFile then return "" end
    local colors = RAID_CLASS_COLORS and RAID_CLASS_COLORS[classFile]
    if not colors then return classFile end
    local hex = string.format("%02x%02x%02x", math.floor(colors.r*255), math.floor(colors.g*255), math.floor(colors.b*255))
    -- Capitalize first letter, lowercase rest
    local display = classFile:sub(1,1) .. classFile:sub(2):lower()
    -- Special cases
    if classFile == "DEATHKNIGHT" then display = "Death Knight"
    elseif classFile == "DEMONHUNTER" then display = "Demon Hunter"
    elseif classFile == "INSTANCE_CHAT" then display = "Instance" end
    return "|cff" .. hex .. display .. "|r"
end

function BCB.CreateAutocompleteSystem()
    local popup = CreateFrame("Frame", "BCBAutocomplete", UIParent, "BackdropTemplate")
    popup:SetBackdrop({bgFile="Interface\\Buttons\\White8x8", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", edgeSize=10, insets={left=2,right=2,top=2,bottom=2}})
    popup:SetBackdropColor(0.05, 0.05, 0.08, 0.95); popup:SetBackdropBorderColor(0.4, 0.4, 0.5, 1)
    popup:SetFrameStrata("FULLSCREEN_DIALOG"); popup:SetFrameLevel(200)
    popup:SetClampedToScreen(true); popup:Hide(); popup:EnableMouse(true)
    popup.rows = {}; popup.selectedIndex = 0; popup.matches = {}; popup.previews = {}
    BCB.autocompleteFrame = popup

    for i = 1, MAX_ROWS do
        local row = CreateFrame("Button", nil, popup)
        row:SetHeight(ROW_H); row:SetPoint("TOPLEFT", 4, -4 - (i-1)*ROW_H); row:SetPoint("RIGHT", -4, 0)
        local hl = row:CreateTexture(nil, "HIGHLIGHT"); hl:SetAllPoints(); hl:SetColorTexture(0.3,0.5,0.8,0.3)
        local sel = row:CreateTexture(nil, "BACKGROUND"); sel:SetAllPoints(); sel:SetColorTexture(0.2,0.4,0.7,0.5); sel:Hide()
        row.selTex = sel
        local fs = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); fs:SetPoint("LEFT",8,0); fs:SetJustifyH("LEFT")
        row.text = fs
        local pv = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"); pv:SetPoint("RIGHT",-8,0); pv:SetJustifyH("RIGHT"); pv:SetTextColor(0.5,0.5,0.5); pv:SetWidth(220); pv:SetWordWrap(false)
        row.preview = pv
        row:SetScript("OnClick", function() if popup.onSelect then popup.onSelect(i) end end)
        row:SetScript("OnEnter", function() popup.selectedIndex = i; popup:UpdateSelection() end)
        popup.rows[i] = row
    end

    function popup:UpdateSelection()
        for i, row in ipairs(self.rows) do
            row.selTex[i == self.selectedIndex and "Show" or "Hide"](row.selTex)
        end
    end

    function popup:ShowMatches(matches, anchorFrame, previews)
        self.matches = matches; self.previews = previews or {}; self.selectedIndex = 1
        local count = math.min(#matches, MAX_ROWS)
        if count == 0 then self:Hide(); return end
        for i = 1, MAX_ROWS do
            if i <= count then
                self.rows[i].text:SetText(matches[i]); self.rows[i].preview:SetText(self.previews[i] or ""); self.rows[i]:Show()
            else self.rows[i]:Hide() end
        end
        self:SetHeight(count * ROW_H + 8); self:SetWidth(math.max(anchorFrame:GetWidth(), 280))
        self:ClearAllPoints()
        if (BigChatBoxDB.autocompletePosition or "bottom") == "top" then
            self:SetPoint("BOTTOMLEFT", anchorFrame, "TOPLEFT", 0, 2)
        else
            self:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -2)
        end
        self:Show(); self:UpdateSelection()
    end

    -- Guild roster cache (refreshed on editbox open + GUILD_ROSTER_UPDATE)
    local guildCache = {}  -- [nameKey] = { class, level }
    local guildCacheStale = true

    local function RefreshGuildCache()
        if not IsInGuild() then guildCache = {}; return end
        local newCache = {}
        local numMembers = GetNumGuildMembers()
        for i = 1, numMembers do
            local name, _, _, level, _, _, _, _, online, _, classFile = GetGuildRosterInfo(i)
            if name and online then
                local short = Ambiguate(name, "short")
                newCache[short:lower()] = { class = classFile, level = level }
            end
        end
        guildCache = newCache
        guildCacheStale = false
    end

    -- Register for guild roster updates
    local guildFrame = CreateFrame("Frame")
    guildFrame:RegisterEvent("GUILD_ROSTER_UPDATE")
    guildFrame:SetScript("OnEvent", function() guildCacheStale = true end)

    -- Refresh guild cache when editbox opens
    local origShow = BCB.frame and BCB.frame.Show
    if BCB.frame then
        BCB.frame:HookScript("OnShow", function()
            if guildCacheStale then RefreshGuildCache() end
        end)
    end
    -- Also set up a deferred hook if frame isn't created yet
    BCB._refreshGuildCacheOnShow = function()
        if guildCacheStale then RefreshGuildCache() end
    end

    -- Build player names with metadata for whisper autocomplete
    local function GetPlayerNamesEnriched()
        local names, seen, nameInfo = {}, {}, {}

        local function Add(n, info)
            if not n or n == "" then return end
            local key = n:lower()
            if seen[key] then
                -- Merge: accumulate source flags and prefer more detailed info
                local existing = nameInfo[key]
                if info.class and not existing.class then existing.class = info.class end
                if info.level and (not existing.level or existing.level == 0) then existing.level = info.level end
                if info.specName and not existing.specName then existing.specName = info.specName; existing.specIcon = info.specIcon end
                if info.bnetID and not existing.bnetID then existing.bnetID = info.bnetID end
                if info.bnetTag and not existing.bnetTag then existing.bnetTag = info.bnetTag end
                -- Accumulate source flags
                if info.isBnet then existing.isBnet = true end
                if info.isGuild then existing.isGuild = true end
                if info.isFriend then existing.isFriend = true end
                if info.isGroup then existing.isGroup = true end
                return
            end
            seen[key] = true
            names[#names+1] = n
            nameInfo[key] = info
        end

        -- WoW friends (character-level friends, online only)
        for i = 1, (C_FriendList and C_FriendList.GetNumFriends() or 0) do
            local info = C_FriendList.GetFriendInfoByIndex(i)
            if info and info.name and info.connected then
                Add(info.name, {
                    class = info.className and info.className:upper():gsub(" ", "") or nil,
                    level = info.level,
                    isFriend = true,
                })
            end
        end

        -- BNet friends: use battleTag for matching/display, store bnetAccountID for send path.
        for i = 1, (BNGetNumFriends and BNGetNumFriends() or 0) do
            local bnetInfo = C_BattleNet and C_BattleNet.GetFriendAccountInfo(i)
            if bnetInfo then
                local gameInfo = bnetInfo.gameAccountInfo
                -- Add online WoW character name
                if gameInfo and gameInfo.characterName and gameInfo.isOnline and gameInfo.clientProgram == "WoW" then
                    local classFile = gameInfo.className and gameInfo.className:upper():gsub(" ", "") or nil
                    if classFile and not RAID_CLASS_COLORS[classFile] then
                        for k, _ in pairs(RAID_CLASS_COLORS) do
                            if k == classFile then break end
                        end
                    end
                    Add(gameInfo.characterName, {
                        class = classFile,
                        level = gameInfo.characterLevel,
                        isBnet = true,
                        bnetID = bnetInfo.bnetAccountID,
                    })
                end
                -- Add BattleTag name (part before #) as a searchable entry
                local btag = bnetInfo.battleTag
                if btag and btag ~= "" then
                    local btagName = btag:match("^(.-)#") or btag
                    if btagName ~= "" then
                        Add(btagName, {
                            isBnet = true,
                            bnetID = bnetInfo.bnetAccountID,
                            bnetTag = btag,
                        })
                    end
                end
            end
        end

        -- Guild members (online only)
        if guildCacheStale then RefreshGuildCache() end
        if IsInGuild() then
            for i = 1, GetNumGuildMembers() do
                local name, _, _, level, _, _, _, _, online, _, classFile = GetGuildRosterInfo(i)
                if name and online then
                    local short = Ambiguate(name, "short")
                    Add(short, {
                        class = classFile,
                        level = level,
                        isGuild = true,
                    })
                end
            end
        end

        -- Group members (party/raid) — includes spec via GetInspectSpecialization
        local numGroup = GetNumGroupMembers()
        if numGroup > 0 then
            local prefix = IsInRaid() and "raid" or "party"
            local count = IsInRaid() and numGroup or (numGroup - 1)
            for i = 1, count do
                local unit = prefix .. i
                if UnitExists(unit) then
                    local name = UnitName(unit)
                    local _, classFile = UnitClass(unit)
                    local level = UnitLevel(unit)
                    local specName, specIcon
                    if GetInspectSpecialization then
                        local specID = GetInspectSpecialization(unit)
                        if specID and specID > 0 and GetSpecializationInfoByID then
                            local _, sName, _, sIcon = GetSpecializationInfoByID(specID)
                            if sName then specName = sName; specIcon = sIcon end
                        end
                    end
                    if name then
                        Add(name, {
                            class = classFile,
                            level = level > 0 and level or nil,
                            specName = specName,
                            specIcon = specIcon,
                            isGroup = true,
                        })
                    end
                end
            end
        end

        -- Recent whispers (no metadata, just names)
        for _, n in ipairs(BigChatBoxDB.whisperHistory or {}) do
            Add(n, {})
        end

        table.sort(names, function(a,b) return a:lower() < b:lower() end)
        return names, nameInfo
    end

    -- Build enriched preview string for a whisper name
    -- Layout: classicon classname specicon specname (lvl) source-icons
    local BNET_ICON = "Interface\\AddOns\\BigChatBox\\assets\\bnet"
    local GUILD_ICON = "Interface\\AddOns\\BigChatBox\\assets\\guild"
    local function BuildEnrichedPreview(info)
        if not info then return "" end
        local parts = {}

        -- Show full BattleTag early if this is a battletag-only entry (no class info)
        if info.bnetTag and not info.class then
            parts[#parts+1] = "|cff82c5ff" .. info.bnetTag .. "|r"
        end

        -- Class icon + colored class name
        if info.class and RAID_CLASS_COLORS[info.class] then
            parts[#parts+1] = ClassIconString(info.class)
            parts[#parts+1] = ColoredClassName(info.class)
        end

        -- Spec icon + spec name (only available for group members)
        if info.specName then
            if info.specIcon then
                parts[#parts+1] = "|T" .. info.specIcon .. ":14:14|t"
            end
            parts[#parts+1] = "|cffdddddd" .. info.specName .. "|r"
        end

        -- Level in brackets
        if info.level and info.level > 0 then
            parts[#parts+1] = "|cffaaaaaa(" .. info.level .. ")|r"
        end

        -- Source icons on the right — multiple can show
        if info.isBnet then
            parts[#parts+1] = "|T" .. BNET_ICON .. ":14:14|t"
        end
        if info.isGuild then
            parts[#parts+1] = "|T" .. GUILD_ICON .. ":14:14|t"
        end

        return table.concat(parts, " ")
    end

    -- Helper to get snippet text from data (supports old string format and new table format)
    local function GetSnippetText(data)
        if type(data) == "table" then return data.text or "" end
        return data or ""
    end
    local function IsSnippetEnabled(data)
        if type(data) == "table" then return data.enabled ~= false end
        return true
    end

    function BCB.UpdateAutocomplete(text)
        if not text or text == "" then popup:Hide(); return end
        local db = BigChatBoxDB

        -- Snippet autocomplete: starts with !
        if text:sub(1,1) == "!" and not text:find(" ") and (db.snippetEnabled ~= false) and (db.acSnippetEnabled ~= false) then
            local partial = text:lower(); local matches, previews = {}, {}
            for trigger, data in pairs(db.snippets or {}) do
                local sText = GetSnippetText(data)
                if IsSnippetEnabled(data) and trigger:lower():sub(1, #partial) == partial and trigger:lower() ~= partial then
                    matches[#matches+1] = trigger
                    previews[#previews+1] = #sText > 40 and sText:sub(1,37).."..." or sText
                end
            end
            if #matches > 0 then
                local combined = {}; for i, m in ipairs(matches) do combined[i] = {m=m, p=previews[i]} end
                table.sort(combined, function(a,b) return a.m:lower() < b.m:lower() end)
                matches, previews = {}, {}; for _, c in ipairs(combined) do matches[#matches+1]=c.m; previews[#previews+1]=c.p end
                popup.mode="snippet"; popup:ShowMatches(matches, BCB.frame, previews); return
            end
        end

        -- Slash command autocomplete
        if text:sub(1,1) == "/" and not text:find(" ") and (db.acCommandEnabled ~= false) then
            local partial = text:lower(); local matches = {}
            for _, cmd in ipairs(SLASH_COMMANDS) do
                if cmd:lower():sub(1, #partial) == partial and cmd:lower() ~= partial then matches[#matches+1] = cmd end
            end
            if #matches > 0 then popup.mode="slash"; popup:ShowMatches(matches, BCB.frame); return end
        end

        -- Whisper name autocomplete (enriched)
        if db.acWhisperEnabled ~= false then
            local p1, p2 = text:match("^(/[wW]%s+)(.+)$")
            if not p1 then p1, p2 = text:match("^(/[wW]hisper%s+)(.+)$") end
            if p1 and p2 then
                local allNames, nameInfo = GetPlayerNamesEnriched()
                local matches, previews, matchInfo = {}, {}, {}
                local pLow = p2:lower()
                local showBnet = (db.acBnetEnabled ~= false)
                for _, name in ipairs(allNames) do
                    if name:lower():sub(1, #pLow) == pLow and name:lower() ~= pLow then
                        local nfo = nameInfo[name:lower()]
                        -- Skip pure-bnet entries if bnet autocomplete is toggled off
                        if not showBnet and nfo and nfo.isBnet and not nfo.isGuild and not nfo.isFriend and not nfo.isGroup then
                            -- skip
                        else
                            matches[#matches+1] = name
                            previews[#previews+1] = BuildEnrichedPreview(nfo)
                            matchInfo[#matchInfo+1] = nfo
                        end
                    end
                end
                if #matches > 0 then
                    popup.mode="name"; popup.namePrefix=p1; popup.matchInfo=matchInfo
                    popup:ShowMatches(matches, BCB.frame, previews); return
                end
            end
        end

        popup:Hide()
    end

    popup.onSelect = function(idx)
        local match = popup.matches[idx]
        if not match or not BCB.editBox then return end
        if popup.mode == "slash" then
            BCB.editBox:SetText(match .. " "); BCB.editBox:SetCursorPosition(#match + 1)
        elseif popup.mode == "name" then
            local info = popup.matchInfo and popup.matchInfo[idx]
            if info and info.bnetID then
                -- BNet friend: set up BN_WHISPER directly via editbox attributes
                BCB.editBox:SetText("")
                BCB.editBox:SetAttribute("chatType", "BN_WHISPER")
                BCB.editBox:SetAttribute("tellTarget", match)
                BigChatBoxDB.lastChatType = "BN_WHISPER"
                if BCB.UpdateChannelDisplay then BCB.UpdateChannelDisplay() end
            else
                -- Regular whisper: fill in /w Name
                local full = (popup.namePrefix or "/w ") .. match .. " "
                BCB.editBox:SetText(full); BCB.editBox:SetCursorPosition(#full)
            end
        elseif popup.mode == "snippet" then
            BCB.editBox:SetText(match); BCB.editBox:SetCursorPosition(#match)
        end
        popup:Hide(); BCB.editBox:SetFocus()
    end
end
