-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPaPa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest2"
local Dialog = require "Quests/Dialog"

local name		  = 'Storm Badge Quest'
local description = 'Will exp to lv 40 and earn the 5th badge'
local level = 40

local dialogs = {
	phare = Dialog:new({ 
		"Please return fast!"
	})
}

local StormBadgeQuest = Quest:new()

function StormBadgeQuest:new()
	o = Quest.new(StormBadgeQuest, name, description, level, dialogs)
	o.pokemonId = 1
	o.N = 2

	return o
end

function StormBadgeQuest:isDoable()
	if (self:hasMap() and not hasItem("Rain Badge") and hasItem("Fog Badge") )  or ( self:hasMap() and  hasItem("Rain Badge") and not hasItem("Storm Badge") ) then
		return true
	end
	return false
end

function StormBadgeQuest:isDone()
	if  getMapName() == "Ice Path 1F" or ( hasItem("Storm Badge") and getMapName() == "Cianwood City Gym"  ) then
		return true
	else
		return false
	end
end

function StormBadgeQuest:EcruteakGym()
	moveToMap("Ecruteak City")
end

function StormBadgeQuest:EcruteakCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Ecruteak" then
		moveToMap("Pokecenter Ecruteak")
	else moveToMap("Ecruteak Stop House 2")
	end
end

function StormBadgeQuest:PokecenterEcruteak()
	self:pokecenter("Ecruteak City")
end

function StormBadgeQuest:EcruteakStopHouse2()
	moveToMap("Route 42")
end

function StormBadgeQuest:OlivinePokecenter()
	self:pokecenter("Olivine City")
end

function StormBadgeQuest:Route42()
	if game.inRectangle(3,10,20,31) then
		return moveToCell(17,13)
	elseif game.inRectangle(66,10,95,31) then
		return	moveToCell(95,15)
	end
end



function StormBadgeQuest:MtMortar1F()
	return moveToCell(34,35) or moveToCell(65,46)
end

function StormBadgeQuest:MtMortarLowerCave()
	moveToCell(47,57)
end

function StormBadgeQuest:MahoganyTown()
	moveToMap("Route 44")
end

function StormBadgeQuest:Route44()
	moveToMap("Ice Path 1F")
end

function StormBadgeQuest:GlitterLighthouse1F()
	if dialogs.phare.state then 
		moveToCell(8,14)
	else moveToCell(9,5)
	end
end

function StormBadgeQuest:OlivineCity()
	if  self.registeredPokecenter ~= "Olivine Pokecenter" then
		moveToMap("Olivine Pokecenter")
	elseif isNpcOnCell(52,22) then
		talkToNpcOnCell(52,22)
	elseif not dialogs.phare.state then 
		moveToMap("Glitter Lighthouse 1F")
	else moveToMap("Route 40")
	end
end

function StormBadgeQuest:GlitterLighthouse2F()
	if dialogs.phare.state then 
		if game.inRectangle (10,4,15,7)then
		moveToCell(13,7)
		elseif game.inRectangle (3,4,9,13)then
		moveToCell(9,12)
		end
	else if game.inRectangle (10,4,15,7)then
		moveToCell(12,4)
		elseif game.inRectangle (3,4,9,13)then
		moveToCell(3,5)
		end
	end
end

function StormBadgeQuest:GlitterLighthouse3F()
	if dialogs.phare.state then 
		if game.inRectangle (9,3,13,12)then
		moveToCell(12,5)
		elseif game.inRectangle (1,6,6,3)then
		moveToCell(3,5)
		end
	else 
		if game.inRectangle (9,3,13,12)then
		moveToCell(9,12)
		elseif game.inRectangle (1,6,6,3)then
		 moveToCell(5,4)
		 end
	end
end

function StormBadgeQuest:GlitterLighthouse4F()
	if dialogs.phare.state then 
		moveToCell(5,4)
	else moveToCell(11,6)
	end
end

function StormBadgeQuest:GlitterLighthouse5F()
	if dialogs.phare.state then 
		moveToCell(11,11)
	else talkToNpcOnCell(11,9)
		 dialogs.phare.state = true
	end
end

function StormBadgeQuest:Route40()
	if not game.hasPokemonWithMove("Surf") then
		if self.pokemonId <= getTeamSize() then
			useItemOnPokemon("HM03 - Surf", self.pokemonId)
			log("Pokemon: " .. self.pokemonId .. " Try Learn Surf")
			self.pokemonId = self.pokemonId + 1
		else
			fatal("No pokemon in this team can learn Surf")
		end
	else moveToMap("Route 41")
	end
end

function StormBadgeQuest:Route41()
	moveToMap("Cianwood City")
end

function StormBadgeQuest:CianwoodCity()
	moveToMap("Cianwood City Gym")
end

function StormBadgeQuest:CianwoodCityGym()
	talkToNpcOnCell(32,15)
end








return StormBadgeQuest
