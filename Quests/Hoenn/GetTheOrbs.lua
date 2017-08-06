-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest4"
local Dialog = require "Quests/Dialog"

local name		  = 'Get the Orbs'
local description = 'Will get the Blue and Red Orbs'
local level = 55

local dialogs = {
	jack = Dialog:new({ 
		"Many lives were lost"
	})
}

local GetTheOrbs = Quest:new()

function GetTheOrbs:new()
	return Quest.new(GetTheOrbs, name, description, level, dialogs)
end

function GetTheOrbs:isDoable()
	if self:hasMap() and not hasItem("Blue Orb") then
		return true
	end
	return false
end

function GetTheOrbs:isDone()
	if  getMapName() == "Route 124" then
		return true
	else
		return false
	end
end

function GetTheOrbs:PokecenterFortreeCity()
	return self:pokecenter("Fortree City")
end

function GetTheOrbs:FortreeCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Fortree City" then
		moveToMap("Pokecenter Fortree City")
	elseif not self:isTrainingOver() then 
		moveToMap("Route 120")
	elseif not hasItem("Feather Badge") then 
		moveToMap("Fortree Gym")
	else moveToMap("Route 120")
	end
end

function GetTheOrbs:Route120()
	if  self:needPokecenter() then 
		moveToMap("Fortree City")
	elseif not self:isTrainingOver() then 
		moveToGrass()
	else moveToMap("Route 121")
	end
end

function GetTheOrbs:FortreeGym()
	if not hasItem("Feather Badge") then
		talkToNpcOnCell(19,7)
	else moveToMap("Fortree City")
	end
end

function GetTheOrbs:Route121()
	moveToMap("Lilycove City")
end

function GetTheOrbs:PokecenterLilycoveCity()
	return self:pokecenter("Lilycove City")
end

function GetTheOrbs:LilycoveCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Lilycove City" then
		moveToMap("Pokecenter Lilycove City")
	else
		moveToMap("Route 124")
	end
end

return GetTheOrbs