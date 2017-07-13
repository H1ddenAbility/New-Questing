-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest2"
local Dialog = require "Quests/Dialog"

local name		  = 'Azalea Town'
local description = ' Hive Badge'
local level = 26

local HiveBadgeQuest = Quest:new()

function HiveBadgeQuest:new()
	return Quest.new(HiveBadgeQuest, name, description, level)
end

function HiveBadgeQuest:isDoable()
	if self:hasMap() and not hasItem("Plain Badge") then
		return true
	end
	return false
end

function HiveBadgeQuest:isDone()
	return getMapName() == "Ilex Forest"
end

function HiveBadgeQuest:PokecenterAzalea()
	self:pokecenter("Azalea Town")
end

function HiveBadgeQuest:AzaleaPokemart()
	self:pokemart("Azalea Town")	
end

function HiveBadgeQuest:AzaleaTown()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Azalea" then
		return moveToMap("Pokecenter Azalea")
	elseif self:needPokemart() then
		return moveToMap("Azalea Pokemart")	
	elseif not self:isTrainingOver() then
		return moveToMap("Route 33")
	elseif isNpcOnCell(19,28) then	
		return moveToMap("Slowpoke Well")
	elseif not hasItem("Hive Badge") then
		return moveToMap("Azalea Town Gym")
	elseif isNpcOnCell(5,12) then
		return talkToNpcOnCell(5,12)
	else
		return moveToMap("Ilex Forest Stop House")
	end	
end

function HiveBadgeQuest:Route33()
	if self:needPokecenter() or self:needPokemart() or self.registeredPokecenter ~= "Pokecenter Azalea" then
		return moveToMap("Azalea Town")
	elseif not self:isTrainingOver() then
		return moveToGrass()
	else
		return moveToMap("Azalea Town")
	end
end

function HiveBadgeQuest:IlexForestStopHouse()
	return moveToMap("Ilex Forest")
end

function HiveBadgeQuest:SlowpokeWell()
	if isNpcOnCell(12,26) then
		return talkToNpcOnCell(12,26)
	else
		return moveToMap("Azalea Town")
	end
end

function HiveBadgeQuest:AzaleaTownGym()
	if not hasItem("Hive Badge") then
		return talkToNpcOnCell(15,3)
	else
		return moveToMap("Azalea Town")
	end
end

return HiveBadgeQuest