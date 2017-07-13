-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest2"
local Dialog = require "Quests/Dialog"

local name		  = 'Sprout Tower'
local description = ' Violet City'
local level = 14

local dialogs = {
	masterDone = Dialog:new({ 
		"you have already won",
		"passed my test"
	})
}

local SproutTowerQuest = Quest:new()

function SproutTowerQuest:new()
	return Quest.new(SproutTowerQuest, name, description, level, dialogs)
end

function SproutTowerQuest:isDoable()
	return self:hasMap()
end

function SproutTowerQuest:isDone()
	if getMapName() == "Violet City" or getMapName() == "Pokecenter Violet City" then
		return true
	end
	return false
end

function SproutTowerQuest:SproutTowerF1()
	if game.inRectangle(1,16,25,26) or game.inRectangle(6,7,20,15) then		
		if dialogs.masterDone.state then
			return moveToMap("Violet City")
		else
			if isNpcOnCell(1,16) then
				return talkToNpcOnCell(1,16) --Pokemon: Gastly (Blue Ball)
			else
				return moveToCell(8,8)
			end
			
		end		
	else
		if dialogs.masterDone.state then
			return moveToCell(24,3)
		else
			return moveToCell(2,11)
		end	
	end
end

function SproutTowerQuest:SproutTowerF2()
	if game.inRectangle(7,3,25,14) then
		if dialogs.masterDone.state then
			return moveToCell(9,9)
		else
			return moveToCell(23,4)
		end
	else
		if dialogs.masterDone.state then
			return moveToCell(3,12)
		else
				return moveToCell(13,23)
		end
	end
end

function SproutTowerQuest:SproutTowerF3()
	if not isNpcOnCell(13,4) then --Master NPC
		dialogs.masterDone.state = true
	end
	if dialogs.masterDone.state then
		return moveToCell(13,24)
	else
		if isNpcOnCell(16,4) then --Item: Escape Rope
			return talkToNpcOnCell(16,4)
		else
			return talkToNpcOnCell(13,4)
		end
	end
end

return SproutTowerQuest