-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest4"
local Dialog = require "Quests/Dialog"

local name		  = 'Dynamo Badge'
local description = 'Will earn Dynamo Badge'
local level = 32
local guitare = false
N = 2
local DynamoBadge = Quest:new()

function DynamoBadge:new()
	o = Quest.new(DynamoBadge, name, description, level, dialogs)
	o.pokemonId = 1
	o.N = 2

	return o
end

function DynamoBadge:isDoable()
	if self:hasMap() and not  hasItem("Dynamo Badge") then
		return true
	end
	return false
end

function DynamoBadge:isDone()
	if ( hasItem("Dynamo Badge") and getMapName() == "Mauville City Gym" ) or  getMapName() == "Mauville City Stop House 3" then
		return true
	else
		return false
	end
end

function DynamoBadge:MauvilleCity()
	if not hasItem("TM114") and not game.hasPokemonWithMove("Rock Smash")  then
		moveToMap("Mauville City House 2")
	elseif not hasItem("TM13") and not game.hasPokemonWithMove("Ice Beam")  then
		moveToMap("Mauville City Game Corner")
	elseif not game.hasPokemonWithMove("Ice Beam") then
			if self.pokemonId < getTeamSize() then
				useItemOnPokemon("TM13", self.pokemonId)
				log("Pokemon: " .. self.pokemonId .. " Try Learning:TM13 - Ice Beam")
				self.pokemonId = self.pokemonId + 1
			else
				fatal("No pokemon in this team can learn Ice Beam")
			end
	elseif not game.hasPokemonWithMove("Rock Smash") then
			if self.pokemonId < getTeamSize() then
				useItemOnPokemon("TM114", self.pokemonId)
				log("Pokemon: " .. self.pokemonId .. " Try Learning:TM114 - Rock Smash")
				self.pokemonId = self.pokemonId + 1
			else
				fatal("No pokemon in this team can learn Rock Smash")
			end
	elseif self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Mauville City" then
		moveToMap("Pokecenter Mauville City")
	elseif isNpcOnCell(13,14) then
		talkToNpcOnCell(13,14)
	else
		
		moveToMap("Mauville City Stop House 3")
	end
	
	
end

function DynamoBadge:Route117()
	if self:needPokecenter() then
		moveToMap("Mauville City Stop House 2")
	elseif not self:isTrainingOver() then
		moveToGrass()
	else moveToMap("Mauville City Stop House 2")
	end
	
end

function DynamoBadge:MauvilleCityGameCorner()
	if hasItem("TM13") then
		moveToMap("Mauville City")
	elseif not isShopOpen() then
		return 	talkToNpcOnCell(18,5)
	else
		return buyItem("TM13",1)
	end
end
	
function DynamoBadge:MauvilleCityHouse2()
	if not hasItem("TM114") then
		talkToNpc("Nerd Julian")
	else moveToMap("Mauville City")
	end
	
end

function DynamoBadge:PokecenterMauvilleCity()
	return self:pokecenter("Mauville City")
end

function DynamoBadge:MauvilleCityStopHouse2()
	if not self:isTrainingOver() and not self:needPokecenter() then 
		moveToMap("Route 117")
	else moveToMap("Mauville City")
	end
end

function DynamoBadge:MauvilleCityGym()
	if not hasItem("Dynamo Badge") then
		if not isNpcOnCell(7,9) then 
			return talkToNpcOnCell(7,1) or talkToNpcOnCell(11,11)
			
		elseif isNpcOnCell(5,15) then 
			talkToNpcOnCell(1,17)
			log("2")
		elseif isNpcOnCell(3,13) and isNpcOnCell(7,13) and not isNpcOnCell(9,15) and isNpcOnCell(11,13) then
			talkToNpcOnCell(1,19)
			log("3")
		elseif isNpcOnCell(3,13) and isNpcOnCell(7,13) and isNpcOnCell(9,15) and isNpcOnCell(7,17) then
			talkToNpcOnCell(7,15)
			log("4")
		elseif isNpcOnCell(3,13) and isNpcOnCell(11,13) and isNpcOnCell(9,15) and isNpcOnCell(7,17) then
			talkToNpcOnCell(3,11)
			log("5")
		elseif isNpcOnCell(11,13) and isNpcOnCell(3,13) and not isNpcOnCell(9,15) and not isNpcOnCell(7,13)  then
			talkToNpcOnCell(3,11)
			log("6")
		elseif isNpcOnCell(9,15) and not isNpcOnCell(7,13) and not isNpcOnCell(11,13) and not isNpcOnCell(3,13) then
			talkToNpcOnCell(1,19)
			log("7")
		elseif isNpcOnCell(11,13) and not isNpcOnCell(3,13) and not isNpcOnCell(7,13) and not isNpcOnCell(9,15) then
			talkToNpcOnCell(7,15)
			log("8")
		elseif isNpcOnCell(7,13) and not isNpcOnCell(9,15) and not isNpcOnCell(11,13) then
			talkToNpcOnCell(11,11)
			log("9")
		elseif isNpcOnCell(7,9) and not isNpcOnCell(7,13) and not isNpcOnCell(3,13) and not isNpcOnCell(11,13) and not isNpcOnCell(9,15) then
			talkToNpcOnCell(11,11)
			log("a")
		else log("NOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO")
		end
	end
		
end



return DynamoBadge