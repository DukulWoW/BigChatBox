-- BigChatBox Utils/Encoding.lua — Compact style string encoder/decoder
-- Self-contained base64 + binary serialization for clean export strings.
-- No external dependencies. Produces short alphanumeric strings safe for
-- chat, forums, Discord, etc.
--
-- Export pipeline:  style table → compact binary → base64 → "!BCB1:<encoded>"
-- Import pipeline:  detect prefix → base64 decode → deserialize → style table
-- Legacy "BCB:" prefix strings are still handled by the old parser in ConfigMain.

local BCB = BigChatBox

--------------------------------------------------------------------------------
-- BASE64 ENCODER / DECODER
--------------------------------------------------------------------------------
local b64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local b64lookup = {}
for i = 1, 64 do b64lookup[b64chars:sub(i, i)] = i - 1 end

local function Base64Encode(data)
    local out = {}
    local len = #data
    for i = 1, len, 3 do
        local a = data:byte(i)
        local b = i + 1 <= len and data:byte(i + 1) or 0
        local c = i + 2 <= len and data:byte(i + 2) or 0
        local n = a * 65536 + b * 256 + c
        out[#out + 1] = b64chars:sub(math.floor(n / 262144) % 64 + 1, math.floor(n / 262144) % 64 + 1)
        out[#out + 1] = b64chars:sub(math.floor(n / 4096) % 64 + 1, math.floor(n / 4096) % 64 + 1)
        out[#out + 1] = (i + 1 <= len) and b64chars:sub(math.floor(n / 64) % 64 + 1, math.floor(n / 64) % 64 + 1) or "="
        out[#out + 1] = (i + 2 <= len) and b64chars:sub(n % 64 + 1, n % 64 + 1) or "="
    end
    return table.concat(out)
end

local function Base64Decode(data)
    data = data:gsub("[^A-Za-z0-9+/=]", "")  -- strip whitespace/junk
    local out = {}
    for i = 1, #data, 4 do
        local a = b64lookup[data:sub(i, i)] or 0
        local b = b64lookup[data:sub(i + 1, i + 1)] or 0
        local c = b64lookup[data:sub(i + 2, i + 2)] or 0
        local d = b64lookup[data:sub(i + 3, i + 3)] or 0
        local n = a * 262144 + b * 4096 + c * 64 + d
        out[#out + 1] = string.char(math.floor(n / 65536) % 256)
        if data:sub(i + 2, i + 2) ~= "=" then out[#out + 1] = string.char(math.floor(n / 256) % 256) end
        if data:sub(i + 3, i + 3) ~= "=" then out[#out + 1] = string.char(n % 256) end
    end
    return table.concat(out)
end

--------------------------------------------------------------------------------
-- COMPACT BINARY SERIALIZATION
-- Format: sequence of (keyID, value) pairs. Each key is mapped to a single
-- byte ID. Values are typed: byte for small ints, scaled uint16 for floats,
-- length-prefixed strings, booleans, and RGB triples.
--------------------------------------------------------------------------------

-- Ordered key list — the index IS the key ID (1-based). Adding keys at the
-- end is safe; removing or reordering breaks backward compat.
local KEY_ORDER = {
    "bgAlpha",          -- 1
    "bgColor",          -- 2  (RGB)
    "bgTexture",        -- 3  (string)
    "bgTextureName",    -- 4  (string)
    "bgScale",          -- 5
    "bgChannelTint",    -- 6  (bool)
    "bgTintIntensity",  -- 7
    "borderAlpha",      -- 8
    "borderColor",      -- 9  (RGB)
    "borderTexture",    -- 10 (string)
    "borderTextureName",-- 11 (string)
    "borderThickness",  -- 12
    "font",             -- 13 (string)
    "fontName",         -- 14 (string)
    "channelFont",      -- 15 (string)
    "channelFontName",  -- 16 (string)
    "fontSize",         -- 17
    "channelFontSize",  -- 18
    "scale",            -- 19
    "fontOutline",      -- 20 (string)
    "boxDropShadow",    -- 21 (bool)
    "textAlign",        -- 22 (string)
    "colorTypedText",   -- 23 (bool)
    "width",            -- 24
    "height",           -- 25
    "dynamicHeight",    -- 26 (bool)
    "dynamicWidth",     -- 27 (bool)
}

-- Reverse lookup: key name → ID
local KEY_IDS = {}
for i, k in ipairs(KEY_ORDER) do KEY_IDS[k] = i end

-- Type tags (stored as one byte before value)
local T_BYTE    = 1   -- unsigned 0-255
local T_UINT16  = 2   -- unsigned 0-65535
local T_FLOAT   = 3   -- scaled: value * 10000, stored as uint16
local T_STRING  = 4   -- length (uint16) + raw bytes
local T_BOOL    = 5   -- 0 or 1
local T_RGB     = 6   -- three floats (r, g, b each as uint16 * 10000)

-- Known types per key (avoids storing type tag per value — saves bytes)
local KEY_TYPES = {
    bgAlpha = "float", bgScale = "num", bgChannelTint = "bool", bgTintIntensity = "num",
    borderAlpha = "float", borderThickness = "num",
    bgColor = "rgb", borderColor = "rgb",
    bgTexture = "str", bgTextureName = "str", borderTexture = "str", borderTextureName = "str",
    font = "str", fontName = "str", channelFont = "str", channelFontName = "str",
    fontOutline = "str", textAlign = "str",
    fontSize = "num", channelFontSize = "num", width = "num", height = "num",
    scale = "float", boxDropShadow = "bool", colorTypedText = "bool",
    dynamicHeight = "bool", dynamicWidth = "bool",
}

-- Helper: write uint16 big-endian
local function WriteU16(val)
    val = math.max(0, math.min(65535, math.floor(val + 0.5)))
    return string.char(math.floor(val / 256), val % 256)
end

-- Helper: read uint16 big-endian from string at position
local function ReadU16(data, pos)
    local hi = data:byte(pos) or 0
    local lo = data:byte(pos + 1) or 0
    return hi * 256 + lo, pos + 2
end

local function Serialize(styleTable)
    local parts = {}
    -- Version byte (for future format changes)
    parts[#parts + 1] = string.char(1)

    for _, key in ipairs(KEY_ORDER) do
        local val = styleTable[key]
        if val ~= nil then
            local ktype = KEY_TYPES[key]
            parts[#parts + 1] = string.char(KEY_IDS[key])
            if ktype == "rgb" and type(val) == "table" then
                parts[#parts + 1] = WriteU16(math.floor((val.r or 1) * 10000))
                parts[#parts + 1] = WriteU16(math.floor((val.g or 1) * 10000))
                parts[#parts + 1] = WriteU16(math.floor((val.b or 1) * 10000))
            elseif ktype == "float" then
                local n = tonumber(val) or 1
                parts[#parts + 1] = WriteU16(math.floor(n * 10000))
            elseif ktype == "num" then
                local n = math.floor(tonumber(val) or 0)
                if n >= 0 and n <= 255 then
                    parts[#parts + 1] = string.char(0)  -- flag: single byte
                    parts[#parts + 1] = string.char(n)
                else
                    parts[#parts + 1] = string.char(1)  -- flag: uint16
                    parts[#parts + 1] = WriteU16(n)
                end
            elseif ktype == "bool" then
                parts[#parts + 1] = string.char(val and 1 or 0)
            elseif ktype == "str" then
                local s = tostring(val)
                parts[#parts + 1] = WriteU16(#s)
                parts[#parts + 1] = s
            end
        end
    end
    return table.concat(parts)
end

local function Deserialize(data)
    if not data or #data < 2 then return nil end
    local pos = 1
    local version = data:byte(pos); pos = pos + 1
    if version ~= 1 then return nil end  -- unknown version

    local result = {}
    while pos <= #data do
        local keyID = data:byte(pos); pos = pos + 1
        if not keyID or keyID < 1 or keyID > #KEY_ORDER then break end
        local key = KEY_ORDER[keyID]
        local ktype = KEY_TYPES[key]

        if ktype == "rgb" then
            local r, g, b
            r, pos = ReadU16(data, pos); g, pos = ReadU16(data, pos); b, pos = ReadU16(data, pos)
            result[key] = { r = r / 10000, g = g / 10000, b = b / 10000 }
        elseif ktype == "float" then
            local v; v, pos = ReadU16(data, pos)
            result[key] = v / 10000
        elseif ktype == "num" then
            local flag = data:byte(pos); pos = pos + 1
            if flag == 0 then
                result[key] = data:byte(pos); pos = pos + 1
            else
                local v; v, pos = ReadU16(data, pos)
                result[key] = v
            end
        elseif ktype == "bool" then
            result[key] = data:byte(pos) == 1; pos = pos + 1
        elseif ktype == "str" then
            local slen; slen, pos = ReadU16(data, pos)
            result[key] = data:sub(pos, pos + slen - 1); pos = pos + slen
        else
            break  -- unknown type, stop parsing
        end
    end
    return result
end

--------------------------------------------------------------------------------
-- PUBLIC API
--------------------------------------------------------------------------------

--- Encode a style table into a compact shareable string.
--- @param styleTable table  Keys from BigChatBoxDB to encode
--- @return string  Encoded string prefixed with "!BCB1:"
function BCB.EncodeStyleString(styleTable)
    local binary = Serialize(styleTable)
    local encoded = Base64Encode(binary)
    return "!BCB1:" .. encoded
end

--- Decode a compact style string back into a table.
--- @param str string  The encoded string (with "!BCB1:" prefix)
--- @return table|nil  Decoded style table, or nil on failure
function BCB.DecodeStyleString(str)
    if not str or type(str) ~= "string" then return nil end
    str = str:match("^%s*(.-)%s*$")  -- trim whitespace
    if str:sub(1, 6) ~= "!BCB1:" then return nil end
    local encoded = str:sub(7)
    local binary = Base64Decode(encoded)
    if not binary or #binary < 2 then return nil end
    return Deserialize(binary)
end

--- Check if a string is a new-format encoded style string.
function BCB.IsEncodedStyleString(str)
    if not str or type(str) ~= "string" then return false end
    return str:match("^%s*!BCB1:") ~= nil
end

--- Check if a string is a legacy-format style string.
function BCB.IsLegacyStyleString(str)
    if not str or type(str) ~= "string" then return false end
    return str:match("^%s*BCB:") ~= nil
end

--------------------------------------------------------------------------------
-- SNIPPET ENCODE / DECODE
-- Format: tab-delimited fields per snippet, records separated by newline.
-- Fields: trigger \t text \t enabled(0/1) \t channel \t global(0/1)
-- Tabs and newlines in values are escaped as \t and \n respectively.
-- Single snippet prefix: "!BCBS1:"   All snippets prefix: "!BCBSA1:"
--------------------------------------------------------------------------------
local function EscapeSnippetField(s)
    return (s or ""):gsub("\\", "\\\\"):gsub("\t", "\\t"):gsub("\n", "\\n")
end
local function UnescapeSnippetField(s)
    return (s or ""):gsub("\\n", "\n"):gsub("\\t", "\t"):gsub("\\\\", "\\")
end

--- Encode one or more snippets into a compact string.
--- @param snippets table  { [trigger]=data, ... }  (standard BigChatBoxDB.snippets subset)
--- @param prefix string   "!BCBS1:" or "!BCBSA1:"
local function EncodeSnippets(snippets, prefix)
    local records = {}
    for trigger, data in pairs(snippets) do
        if type(data) == "table" then
            local fields = {
                EscapeSnippetField(trigger),
                EscapeSnippetField(data.text or ""),
                (data.enabled ~= false) and "1" or "0",
                EscapeSnippetField(data.channel or "anywhere"),
                (data.global ~= false) and "1" or "0",
            }
            records[#records + 1] = table.concat(fields, "\t")
        end
    end
    if #records == 0 then return nil end
    table.sort(records)  -- deterministic order
    return prefix .. Base64Encode(table.concat(records, "\n"))
end

--- Decode a snippet string back into a { [trigger]=data } table.
--- Returns nil on failure. Supports both new !BCBS1:/!BCBSA1: and legacy BCBS:/BCBSA: formats.
local function DecodeSnippets(str)
    str = str:match("^%s*(.-)%s*$")
    local body
    if str:sub(1, 7) == "!BCBS1:" then
        body = Base64Decode(str:sub(8))
    elseif str:sub(1, 8) == "!BCBSA1:" then
        body = Base64Decode(str:sub(9))
    else
        return nil
    end
    if not body or body == "" then return nil end
    local result = {}
    for line in (body .. "\n"):gmatch("([^\n]*)\n") do
        if line ~= "" then
            local fields = {}
            for f in (line .. "\t"):gmatch("([^\t]*)\t") do fields[#fields + 1] = f end
            local trigger  = UnescapeSnippetField(fields[1])
            local text     = UnescapeSnippetField(fields[2])
            local enabled  = fields[3] ~= "0"
            local channel  = UnescapeSnippetField(fields[4] or "anywhere")
            local global   = (fields[5] or "1") ~= "0"
            if trigger and trigger ~= "" and text then
                result[trigger] = { text = text, enabled = enabled, channel = channel, global = global }
            end
        end
    end
    return result
end

function BCB.EncodeSnippet(trigger, data)
    return EncodeSnippets({ [trigger] = data }, "!BCBS1:")
end

function BCB.EncodeAllSnippets(snippets)
    return EncodeSnippets(snippets, "!BCBSA1:")
end

function BCB.DecodeSnippetString(str)
    str = str:match("^%s*(.-)%s*$")
    -- New format
    if str:sub(1, 7) == "!BCBS1:" or str:sub(1, 8) == "!BCBSA1:" then
        return DecodeSnippets(str)
    end
    -- Legacy single: "BCBS:trigger:text" (colons in text escaped as \c)
    if str:sub(1, 5) == "BCBS:" then
        local trigger, text = str:sub(6):match("^([^:]+):(.+)$")
        if trigger and text then
            text = text:gsub("\\c", ":")
            return { [trigger] = { text = text, enabled = true, channel = "anywhere", global = true } }
        end
        return nil
    end
    -- Legacy all: "BCBSA:t1:text1|t2:text2|..."
    if str:sub(1, 6) == "BCBSA:" then
        local result = {}
        for entry in str:sub(7):gmatch("[^|]+") do
            local trigger, text = entry:match("^([^:]+):(.+)$")
            if trigger and text then
                text = text:gsub("\\c", ":")
                result[trigger] = { text = text, enabled = true, channel = "anywhere", global = true }
            end
        end
        return next(result) and result or nil
    end
    return nil
end

function BCB.IsEncodedSnippetString(str)
    if not str or type(str) ~= "string" then return false end
    str = str:match("^%s*(.-)%s*$")
    return str:sub(1,7) == "!BCBS1:" or str:sub(1,8) == "!BCBSA1:" or str:sub(1,5) == "BCBS:" or str:sub(1,6) == "BCBSA:"
end
