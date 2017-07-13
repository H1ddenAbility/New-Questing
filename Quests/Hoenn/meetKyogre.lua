-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest4"
local Dialog = require "Quests/Dialog"

local name		  = 'Meet Kyogre'
local description = 'Clear the underwater hideout'
local level = 60
local dive = nil 

local dialogs = {
	xxx = Dialog:new({ 
		" "
	})
}

local meetKyogre = Quest:new()

function meetKyogre:new()
	o = Quest.new(meetKyogre, name, description, level, dialogs)
	o.pokemonId = 1

	return o
end

function meetKyogre:isDoable()
	if self:hasMap() and  hasItem("Blue Orb") and hasItem("Mind Badge")then
		return true
	end
	return false
end

function meetKyogre:isDone()
	if not hasItem("Blue Orb") and getMapName() == "Route 128" then
		return true
	else
		return false
	end
end

function meetKyogre:MossdeepCity()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Mossdeep City" then
		moveToMap("Pokecenter Mossdeep City")
	elseif isNpcOnCell(83,22) then 
		talkToNpcOnCell(83,22)
	elseif not hasItem("HM06 - Dive") then 
		moveToMap("Mossdeep City Space Center 1F")
	elseif not game.hasPokemonWithMove("Dive") then
			if self.pokemonId <= getTeamSize() then
				useItemOnPokemon("HM06 - Dive", self.pokemonId)
				log("Pokemon: " .. self.pokemonId .. " Dive")
				self.pokemonId = self.pokemonId + 1
			else
				fatal("dd")
			end
	elseif not self:isTrainingOver() then
		moveToRectangle(4,8,12,19)
	else moveToMap("Route 127")
end
end

function meetKyogre:MossdeepCitySpaceCenter1F()
	if not hasItem("HM06 - Dive") then
		talkToNpcOnCell(12,6)
	else moveToMap("Mossdeep City")
	end
end

function meetKyogre:PokecenterMossdeepCity()
	return self:pokecenter("Mossdeep City")
end

function meetKyogre:Route127()
	if hasMove(1, "Dive") then
		pushDialogAnswer(1)
		pushDialogAnswer(1)
		moveToCell(37,25)
	elseif hasMove(2, "Dive") then
		pushDialogAnswer(1)
		pushDialogAnswer(2)
		moveToCell(37,25)
	elseif hasMove(3, "Dive") then
		pushDialogAnswer(1)
		pushDialogAnswer(3)
		moveToCell(37,25)
	elseif hasMove(4, "Dive") then
		pushDialogAnswer(1)
		pushDialogAnswer(4)
		moveToCell(37,25)
	elseif hasMove(5, "Dive") then
		pushDialogAnswer(1)
		pushDialogAnswer(5)
		moveToCell(37,25)
	elseif hasMove(6, "Dive") then
		pushDialogAnswer(1)
		pushDialogAnswer(6)
		moveToCell(37,25)
	end
end


function meetKyogre:Route127Underwater()
	moveToMap("Route 128 Underwater")
end

function meetKyogre:Route128Underwater()
	moveToMap("Secret Underwater Cavern")
end

function meetKyogre:SecretUnderwaterCavern()
	if hasMove(1, "Dive") then
		pushDialogAnswer(1)
		pushDialogAnswer(1)
		moveToCell(8,6)
	elseif hasMove(2, "Dive") then
		pushDialogAnswer(1)
		pushDialogAnswer(2)
		moveToCell(8,6)
	elseif hasMove(3, "Dive") then
		pushDialogAnswer(1)
		pushDialogAnswer(3)
		moveToCell(8,6)
	elseif hasMove(4, "Dive") then
		pushDialogAnswer(1)
		pushDialogAnswer(4)
		moveToCell(8,6)
	elseif hasMove(5, "Dive") then
		pushDialogAnswer(1)
		pushDialogAnswer(5)
		moveToCell(8,6)
	elseif hasMove(6, "Dive") then
		pushDialogAnswer(1)
		pushDialogAnswer(6)
		moveToCell(8,6)
	end
end

function meetKyogre:SeafloorCavernEntrance()
	moveToMap("Seafloor Cavern R1")
end

function meetKyogre:SeafloorCavernR1()
	moveToMap("Seafloor Cavern R2")
end

function meetKyogre:SeafloorCavernR2()
	moveToMap("Seafloor Cavern R3")
end

function meetKyogre:SeafloorCavernR3()
	moveToMap("Seafloor Cavern R4")
end

function meetKyogre:SeafloorCavernR4()
	moveToMap("Seafloor Cavern R6")
end

function meetKyogre:SeafloorCavernR6()
	if game.inRectangle(4,19,4,19) then
		moveToCell(5,19)
	elseif game.inRectangle(5,19,5,19) then
		moveToCell(6,19)
	elseif game.inRectangle(6,19,6,19) then
		moveToCell(7,19)
	elseif game.inRectangle(7,19,7,19) then
		moveToCell(7,18)
	elseif game.inRectangle(7,18,7,18) then
		moveToCell(8,18)
	elseif game.inRectangle(8,18,8,18) then
		moveToCell(9,18)
	elseif game.inRectangle(9,18,9,18) then 
		moveToCell(10,18)
	elseif game.inRectangle(11,18,14,18) then
		moveToCell(15,18)
	elseif game.inRectangle(19,12,19,12) then
		moveToCell(20,12)
	elseif game.inRectangle(19,8,19,8) then
		moveToCell(19,7)
	elseif game.inRectangle(11,8,11,8) then
		moveToCell(11,7)
	elseif game.inRectangle(3,3,8,7) then
		moveToMap("Seafloor Cavern R7")
	end
end

function meetKyogre:SeafloorCavernR7()
	moveToMap("Seafloor Cavern R8")
end

function meetKyogre:SeafloorCavernR8()
	moveToMap("Seafloor Cavern R9")
end

function meetKyogre:SeafloorCavernR9()
	talkToNpcOnCell(16,37)
end

function meetKyogre:MapName()
	
end

function meetKyogre:MapName()
	
end

function meetKyogre:MapName()
	
end

function meetKyogre:MapName()
	
end

function meetKyogre:MapName()
	
end

function meetKyogre:MapName()
	
end

function meetKyogre:MapName()
	
end

return meetKyogre
