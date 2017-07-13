-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest2"
local Dialog = require "Quests/Dialog"

local name		  = 'Ilex Forest'
local description = ' Farfetch Quest'
local level = 28

local dialogs = {
	farfetchQuestAccept = Dialog:new({ 
		"have you found it yet"
	})
}

local IlexForestQuest = Quest:new()

function IlexForestQuest:new()
	local o = Quest.new(IlexForestQuest, name, description, level, dialogs)
	return o
end

function IlexForestQuest:isDoable()
	if self:hasMap() and not hasItem("Plain Badge") then
		return true
	end
	return false
end

function IlexForestQuest:isDone()
	if getMapName() == "Goldenrod City" or getMapName() == "Pokecenter Azalea" or getMapName() == "Pokecenter Goldenrod"  or getMapName() == "Azalea Town" then
		return true
	end
	return false
end

function IlexForestQuest:IlexForestStopHouse()
	if self:needPokecenter() then
		return moveToMap("Azalea Town")
	else
		return moveToMap("Ilex Forest")
	end
end

function IlexForestQuest:IlexForest()
	if self:needPokecenter() then
		return moveToMap("Ilex Forest Stop House")
	elseif isNpcOnCell(12,58) then
		if not dialogs.farfetchQuestAccept.state then
			return talkToNpcOnCell(12,58)
		else
			if isNpcOnCell(47,42) then
				return talkToNpcOnCell(47,42)
			else
				return talkToNpcOnCell(12,58)
			end
		end
	else
		if game.tryTeachMove("Cut","HM01 - Cut") == true then
			return moveToMap("Route 34 Stop House")
		end
	end
end

function IlexForestQuest:Route34StopHouse()
	return moveToMap("Route 34")
end

function IlexForestQuest:Route34()
	return moveToMap("Goldenrod City")
end

return IlexForestQuest