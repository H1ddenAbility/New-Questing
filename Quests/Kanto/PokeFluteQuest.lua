-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'Poke Flute'
local description = 'Lavender Town (Pokemon Tower)'
local level = 3

local dialogs = {
	checkFujiHouse = Dialog:new({ 
		"i should check out"
	}),
	checkFujiNote = Dialog:new({
		"go into that tower to check",
		"already read this note"
	})
}

local PokeFluteQuest = Quest:new()

function PokeFluteQuest:new()
	return Quest.new(PokeFluteQuest, name, description, level, dialogs)
end

function PokeFluteQuest:isDoable()
	if self:hasMap() and not hasItem("Soul Badge") then
		return true
	end
	return false
end

function PokeFluteQuest:isDone()
	if (hasItem("Poke Flute") and getMapName() == "Route 12") or getMapName() == "Pokecenter Celadon" then --FIX Blackout 
		return true
	else
		return false
	end
end

function PokeFluteQuest:PokecenterLavender()
	self:pokecenter("Lavender Town")
end

function PokeFluteQuest:LavenderTown()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Lavender" then
		return moveToMap("Pokecenter Lavender")
	elseif dialogs.checkFujiHouse.state and not dialogs.checkFujiNote.state then
		return moveToMap("Lavender Town Volunteer House")
	elseif not hasItem("Poke Flute") then
		return moveToMap("Pokemon Tower 1F")
	else
		return moveToMap("Route 12")
	end
end


function PokeFluteQuest:LavenderTownVolunteerHouse()
	if not dialogs.checkFujiNote.state then
		return talkToNpcOnCell(10,10)
	else
		return moveToMap("Lavender Town")
	end
end

function PokeFluteQuest:PokemonTower1F()
	return moveToMap("Pokemon Tower 2F")
end

function PokeFluteQuest:PokemonTower2F()
	if not hasPokemonInTeam("Gastly") and getTeamSize() <= 5 then
		return moveToRectangle(7,8,15,9)
	elseif hasPokemonInTeam("Gastly") and not game.hasPokemonWithMove("Thunderbolt") and hasItem("TM24") then
		return useItemOnPokemon("TM24", 1)
	else
		return moveToMap("Pokemon Tower 3F")
	end
end

function PokeFluteQuest:PokemonTower3F()
	if hasItem("Poke Flute") then
		return moveToMap("Pokemon Tower 2F")
	else
		return moveToMap("Pokemon Tower 4F")
	end
end

function PokeFluteQuest:PokemonTower4F()
	if hasItem("Poke Flute") then
		return moveToMap("Pokemon Tower 3F")
	else
		return moveToMap("Pokemon Tower 5F")
	end
end

function PokeFluteQuest:PokemonTower5F()
	if hasItem("Poke Flute") then
		return moveToMap("Pokemon Tower 4F")
	else
		return moveToMap("Pokemon Tower 6F")
	end
end

function PokeFluteQuest:PokemonTower6F()
	if hasItem("Poke Flute") then
		return moveToMap("Pokemon Tower 5F")
	else
		if isNpcOnCell(9,19) then
			return talkToNpcOnCell(9,19)
		else
			return moveToMap("Pokemon Tower 7F")
		end
	end
end

function PokeFluteQuest:PokemonTower7F()
	if hasItem("Poke Flute") then
		if hasItem("Escape Rope") then
		return useItem("Escape Rope")
		else
		log("You dont have Escape Rope, go back to pokecenter manually")
		fatal()
		end
	else
		return talkToNpcOnCell(9,5) -- Fuji NPC - Give PokeFlute
	end
end

return PokeFluteQuest