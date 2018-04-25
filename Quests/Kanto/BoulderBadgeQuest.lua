-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name        = 'Boulder Badge'
local description = 'from route 2 to route 3'

local BoulderBadgeQuest = Quest:new()
function BoulderBadgeQuest:new()
	return Quest.new(BoulderBadgeQuest, name, description, 13)
end

function BoulderBadgeQuest:isDoable()
	if not hasItem("HM01 - Cut") and self:hasMap()
	then
		return true
	end
	return false
end

function BoulderBadgeQuest:isDone()
	return getMapName() == "Pokecenter Route 3" or getMapName() == "Viridian City" or getMapName() == "Pokecenter Viridian"
end



function BoulderBadgeQuest:Route2()
	if game.inRectangle(0, 90, 24, 130) then
		if  not game.isTeamFullyHealed() then
			return moveToMap("Viridian City")
		else
			return moveToMap("Route 2 Stop")
		end
	elseif game.inRectangle(0, 0, 28, 42) then
		self:route2Up()
	else
		error("BoulderBadgeQuest:Route2(): This position should not be possible")
	end
end

function BoulderBadgeQuest:Route2Stop()
	return moveToMap("Viridian Forest")
end

function BoulderBadgeQuest:ViridianForest()
	if not game.hasPokemonWithMove("Dragon Rage") and not hasItem("TM23") then
		return moveToMap("Viridian Maze")
	else
		moveToMap("Route 2 Stop2")
	end
end

function BoulderBadgeQuest:ViridianMaze()
	if not game.hasPokemonWithMove("Dragon Rage") and not hasItem("TM23") then
		log("Getting tm23-DragonRage for charmander")
		return talkToNpcOnCell(199,32)
	elseif hasItem("TM23") and not game.hasPokemonWithMove("Dragon Rage") then 
		return useItemOnPokemon("TM23", 1)
	elseif isNpcOnCell(186,52) then
		return talkToNpcOnCell(186,52)
	else 
		return moveToMap("Viridian Forest")
	end
end

function BoulderBadgeQuest:Route2Stop2()
	return moveToMap("Route 2")
end

function BoulderBadgeQuest:route2Up()
	if self.registeredPokecenter ~= "Pokecenter Pewter" then
		return moveToMap("Pewter City")
	elseif not self:isTrainingOver()  then
		return moveToGrass()
	else
		return moveToMap("Pewter City")
	end
end

function BoulderBadgeQuest:PewterCity()
	if isNpcOnCell(23,22) then
		talkToNpcOnCell(23,22)
	elseif self.registeredPokecenter ~= "Pokecenter Pewter" or not game.isTeamFullyHealed() then
		return moveToMap("Pokecenter Pewter")
	elseif self:needPokemart() then
		return moveToMap("Pewter Pokemart")
	elseif not self:isTrainingOver() then
		log("Training until "..self.level .."Lv")
		return moveToMap("Route 2")
	elseif self:isTrainingOver() and not hasItem("Boulder Badge") then
		return moveToMap("Pewter Gym")
	else
		return moveToCell(65,32)
	end
end

function BoulderBadgeQuest:PewterGym()
	self.level = 13
	if hasItem("Boulder Badge") or  not game.isTeamFullyHealed() then
		return moveToMap("Pewter City")
	else
		return talkToNpcOnCell(7,5)
	end
end

function BoulderBadgeQuest:Route3()
	return moveToMap("Pokecenter Route 3")
end

function BoulderBadgeQuest:PokecenterPewter()
	if   getPokemonName(1) ~= "Charmander" and getPokemonName(1) ~= "Charmeleon"  and not hasItem("Boulder Badge")  then
		if isPCOpen() then
			if isCurrentPCBoxRefreshed() then
				return depositPokemonToPC(1)
			else
				return
			end
		else
			return usePC()
		end
	elseif  getTeamSize() >=2 and not hasItem("HM03 - Surf") then
		if isPCOpen() then
			if isCurrentPCBoxRefreshed() then
				return depositPokemonToPC(2)
			else
				return
			end
		else
			return usePC()
		end
				
	else
		self:pokecenter("Pewter City")
	end
end


function BoulderBadgeQuest:PewterPokemart()
	self:pokemart("Pewter City")
end

return BoulderBadgeQuest
