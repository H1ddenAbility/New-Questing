-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPaPa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest2"
local Dialog = require "Quests/Dialog"

local name		  = 'Rising Badge Quest'
local description = 'Will exp to lv 80 and earn the 8th badge'
local level = 90

local dialogs = {
	xxx = Dialog:new({ 
		" "
	})
}

local RisingBadgeQuest = Quest:new()

function RisingBadgeQuest:new()
	return Quest.new(RisingBadgeQuest, name, description, level, dialogs)
end

function RisingBadgeQuest:isDoable()
	if self:hasMap() and not hasItem("Rising Badge")  then
		return true
	end
	return false
end

function RisingBadgeQuest:isDone()
	if hasItem("Rising Badge") and getMapName() == "Blackthorn City Gym" then
		return true
	else
		return false
	end
end



function RisingBadgeQuest:MahoganyTown()
	if self:needPokecenter() or not game.isTeamFullyHealed() or not self.registeredPokecenter == "Pokecenter Mahogany Town" then
		moveToMap("Pokecenter Mahogany")
	else moveToMap("Route 44")
	end
end

function RisingBadgeQuest:Route44()
	moveToMap("Ice Path 1F")
end

function RisingBadgeQuest:IcePath1F()
	if game.inRectangle(11,15,49,61) or game.inRectangle(47,13,58,19) then
		moveToCell(57,15)
	else moveToMap("Blackthorn City")
	end
end

function RisingBadgeQuest:IcePathB1F()
	if game.inRectangle (24,41,41,49) or game.inRectangle (14,45,24,43) then
		moveToCell(18,45)
	else
	moveToCell(21,25)
	end
end

function RisingBadgeQuest:IcePathB2F()
	if game.inRectangle (49,9,58,30) then
		moveToCell(50,27)
	else
		moveToCell(23,22)
	end
end

function RisingBadgeQuest:IcePathB3F()
	moveToCell(32,17)
end

function RisingBadgeQuest:BlackthornCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or not self.registeredPokecenter == "Pokecenter Blackthorn City" then
		moveToMap("Pokecenter Blackthorn" )
	elseif not self:isTrainingOver() then 
		moveToMap("Dragons Den Entrance")
	else moveToMap("Blackthorn City Gym")
	end
end

function RisingBadgeQuest:DragonsDenEntrance()
	if self:needPokecenter() then
		moveToMap("Blackthorn City")
	elseif not self:isTrainingOver() then
		moveToMap("Dragons Den")
	else moveToMap("Blackthorn City")
	end
end

function RisingBadgeQuest:DragonsDen()
	if self:needPokecenter() then 
		moveToMap("Dragons Den Entrance")
	elseif not self:isTrainingOver()then
		moveToRectangle(33,29,49,29)
	else moveToMap("Dragons Den Entrance")
	end
end

function RisingBadgeQuest:PokecenterBlackthorn()
	self:pokecenter("Blackthorn City")
end


function RisingBadgeQuest:BlackthornCityGym()
	talkToNpcOnCell(29,12)
end

return RisingBadgeQuest