-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest2"
local Dialog = require "Quests/Dialog"

local name		  = 'Violet City'
local description = ' Badge Quest'
local level = 16

local ZephyrBadgeQuest = Quest:new()

function ZephyrBadgeQuest:new()
	return Quest.new(ZephyrBadgeQuest, name, description, level)
end

function ZephyrBadgeQuest:isDoable()
	if self:hasMap() and not hasItem("Hive Badge") then
		return true
	end
	return false
end

function ZephyrBadgeQuest:isDone()
	if getMapName() == "Sprout Tower F1" or getMapName() == "Azalea Town" then
		return true
	end
	return false
end

function ZephyrBadgeQuest:PokecenterVioletCity()
	if isNpcOnCell(11,21) then--Guide BOB
		return talkToNpcOnCell(11,21)
	else
		self:pokecenter("Violet City")
	end
end

function ZephyrBadgeQuest:PokecenterRoute32()
	self:pokecenter("Route 32")
end

function ZephyrBadgeQuest:VioletCityPokemart()
	self:pokemart("Violet City")	
end

function ZephyrBadgeQuest:VioletCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Violet City" then
		return moveToMap("Pokecenter Violet City")
	elseif self:needPokemart() then
		return moveToMap("Violet City Pokemart")	
	elseif not self:isTrainingOver()  then
		return moveToMap("Route 32")
	elseif isNpcOnCell(27,44) then	
		return moveToMap("Sprout Tower F1")
	elseif not hasItem("Zephyr Badge") then
		return moveToMap("Violet City Gym Entrance")
	else
		return moveToMap("Route 32")
	end
end

function ZephyrBadgeQuest:Route32()
	if  not self.registeredPokecenter == "Pokecenter Violet City" then
		return moveToMap("Violet City")
	elseif not self:isTrainingOver()  then
		return moveToGrass()
	elseif hasItem("Zephyr Badge") then
		if isNpcOnCell(26,23) then
			return talkToNpcOnCell(26,23)
		else
			if not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Route 32" then
				return moveToMap("Pokecenter Route 32")
			else
				return moveToMap("Union Cave 1F")
			end
		end
	else
		return moveToMap("Violet City")
	end
end

function ZephyrBadgeQuest:VioletCityGymEntrance()
	if not hasItem("Zephyr Badge") then
		return moveToMap("Violet City Gym")
	else
		return moveToMap("Violet City")
	end
end

function ZephyrBadgeQuest:VioletCityGym()
	if not hasItem("Zephyr Badge") then
		return talkToNpcOnCell(7,4)
	else
		return moveToMap("Violet City Gym Entrance")
	end
end

function ZephyrBadgeQuest:UnionCave1F()
	return moveToCell(42,84)
end

function ZephyrBadgeQuest:Route33()
	return moveToMap("Azalea Town")
end

function ZephyrBadgeQuest:MapName()
	
end

return ZephyrBadgeQuest