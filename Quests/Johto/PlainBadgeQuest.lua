-- Copyright � 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest2"
local Dialog = require "Quests/Dialog"

local name		  = 'Plain Badge Quest'
local description = ' Plain Badge'
local level = 35

local PlainBadgeQuest = Quest:new()

function PlainBadgeQuest:new()
	return Quest.new(PlainBadgeQuest, name, description, level)
end

function PlainBadgeQuest:isDoable()
	if self:hasMap() and not hasItem("Plain Badge") then
		return true
	end
	return false
end

function PlainBadgeQuest:isDone()
	if hasItem("Plain Badge") and getMapName() == "Goldenrod City Gym" then
		return true
	else
		return false
	end
end

function PlainBadgeQuest:PokecenterGoldenrod()
	self:pokecenter("Goldenrod City")
end

function PlainBadgeQuest:GoldenrodCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or not self.registeredPokecenter == "Pokecenter Goldenrod" then
		return moveToMap("Pokecenter Goldenrod")	
	elseif not self:isTrainingOver() then
		return moveToMap("Route 34")
	elseif not hasItem("Plain Badge") then
		return moveToMap("Goldenrod City Gym")
	else
		return moveToMap("Route 35 Stop House")
	end	
end

function PlainBadgeQuest:Route34()
    if not self:isTrainingOver() then
		return moveToGrass()
	else
		return moveToMap("Goldenrod City")
	end
end

function PlainBadgeQuest:GoldenrodCityGym()
	return talkToNpcOnCell(10,3)
end

return PlainBadgeQuest