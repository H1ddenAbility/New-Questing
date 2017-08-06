-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest4"
local Dialog = require "Quests/Dialog"

local name		  = 'Beat Deoxys'
local description = 'Will earn the 8th Badge and beat Deoxys on the moon'
local level = 90

local dialogs = {
	goSky = Dialog:new({ 
		"He is currently at Sky Pillar"
	}),
	firstChamp = Dialog:new({ 
		"He is somewhere in this Gym..."
	})
}

local beatDeoxys = Quest:new()

function beatDeoxys:new()
	return Quest.new(beatDeoxys, name, description, level, dialogs)
end

function beatDeoxys:isDoable()
	if self:hasMap()  and not  hasItem("Rain Badge") then
		return true
	end
	return false
end

function beatDeoxys:isDone()
	if hasItem("Rain Badge") and getMapName() == "Sootopolis City Gym B1F" then
		return true
	else
		return false
	end
end

function beatDeoxys:SootopolisCity()
	if self.registeredPokecenter ~= "Pokecenter Sootopolis City" then
		moveToMap("Pokecenter Sootopolis City")
	elseif isNpcOnCell(50,17) then
		talkToNpcOnCell(50,17)
	elseif not self:isTrainingOver() then
		moveToCell(50,91)
	else 
		moveToMap("Sootopolis City Gym 1F")
	end
end

function beatDeoxys:PokecenterSootopolisCity()
	return self:pokecenter("Sootopolis City")
end

function beatDeoxys:SootopolisCityUnderwater()
	moveToMap("Route 126 Underwater")
end

function beatDeoxys:Route126Underwater()
	moveToCell(15,71)
end

function beatDeoxys:Route126()
	moveToRectangle(17,78,33,85)
end

function beatDeoxys:SootopolisCityGym1F()
	if game.inRectangle(22,38,22,38)  then
		moveToCell(22,47)
	elseif game.inRectangle(21,38,23,47) then
		moveToCell(22,38)
	elseif game.inRectangle(22,38,22,38)  then
		moveToCell(22,47)
	elseif game.inRectangle(19,27,25,34) then
		moveToCell(22,29)
	elseif game.inRectangle(17,5,25,23) and not dialogs.firstChamp.state then
		talkToNpcOnCell(22,6)
	elseif game.inRectangle(17,4,27,23) and dialogs.firstChamp.state then
		moveToCell(22,17)
	end
end

function beatDeoxys:SootopolisCityGymB1F()
	if getPokemonHealthPercent(1) < 70 then
		return useItemOnPokemon("Hyper Potion", 1)
	end
	if game.inRectangle(10,34,15,42) then
		moveToCell(13,34)
	elseif game.inRectangle(13,21,22,28) then
		moveToCell(13,21)
	elseif game.inRectangle(10,5,16,14) then
		talkToNpcOnCell(13,6)
	end
end

return beatDeoxys
