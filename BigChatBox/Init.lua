-- BigChatBox Init.lua — Bootstrap namespace
-- This file loads FIRST. Creates the addon namespace and version constants.

local ADDON_NAME, BCB_NS = ...

BigChatBox = BigChatBox or {}
local BCB = BigChatBox

BCB.ADDON_NAME = ADDON_NAME
BCB.ADDON_VERSION = "7.0.0"
BCB.NS = BCB_NS  -- private namespace for internal module communication

-- Version shorthand (legacy compat — some files reference BCB.version)
BCB.version = BCB.ADDON_VERSION

-- WoW Forever is the Mainline client on a sub-100000 interface (16001 for 1.60.1).
-- Detect it by interface range alone; never assume "interface >= 100000 means modern".
-- Not by project id: since build 70170 Forever has its own WOW_PROJECT_ID (18), so a
-- WOW_PROJECT_MAINLINE check is false there (FOR-02). Era is 11xxx, other Classic 2xxxx+.
-- Checked at runtime rather than by which TOC loaded, so it also holds when a player
-- loads the retail TOC as "out of date" on Forever (same check as BNB.IsForever).
do
    local interface = select(4, GetBuildInfo()) or 0
    BCB.IsForever = interface >= 16000 and interface < 20000
end
