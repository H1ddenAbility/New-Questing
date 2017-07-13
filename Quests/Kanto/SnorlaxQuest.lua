-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'Route 12 to Fuchsia City'
local description = 'Snorlax Wakeup + All Items'
local level = 3

local SnorlaxQuest = Quest:new()

function SnorlaxQuest:new()
	return Quest.new(SnorlaxQuest, name, description, level)
end

function SnorlaxQuest:isDoable()
	if self:hasMap() and not hasItem("Soul Badge") then
		return true
	end
	return false
end

function SnorlaxQuest:isDone()
	if getMapName() == "Fuchsia City" or getMapName() == "Pokecenter Lavender" then --Fix Blackout
		return true
	end
	return false
end

function SnorlaxQuest:Route12()
	if isNpcOnCell(18,47) then --NPC: Snorlax
		return talkToNpcOnCell(18,47)
	else
		return moveToMap("Route 13")
	end
end

function SnorlaxQuest:Route13()
		return moveToCell(18,34) --Fixed: Can't Use moveToMap("Route 14") 1 cell of this link is on water
end

function SnorlaxQuest:Route14()
		return moveToMap("Route 15")
end

function SnorlaxQuest:Route15()
		return moveToMap("Route 15 Stop House")
end

function SnorlaxQuest:Route15StopHouse()
	return moveToMap("Fuchsia City")
end

return SnorlaxQuest