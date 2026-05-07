-- BigChatBox Init.lua — Bootstrap namespace
-- This file loads FIRST. Creates the addon namespace and version constants.

local ADDON_NAME, BCB_NS = ...

BigChatBox = BigChatBox or {}
local BCB = BigChatBox

BCB.ADDON_NAME = ADDON_NAME
BCB.ADDON_VERSION = "6.0.5"
BCB.UPDATE_NAME = '"An oldie but a goddie!"'
BCB.NS = BCB_NS  -- private namespace for internal module communication

-- Version shorthand (legacy compat — some files reference BCB.version)
BCB.version = BCB.ADDON_VERSION
