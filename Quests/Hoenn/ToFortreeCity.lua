-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest4"
local Dialog = require "Quests/Dialog"

local name		  = 'To Fortree City'
local description = 'Will save the Weather Institute and get the Devon Scope'
local level = 40

local dialogs = {
	xxx = Dialog:new({ 
		" "
	})
}

local ToFortreeCity = Quest:new()

function ToFortreeCity:new()
	o = Quest.new(ToFortreeCity, name, description, level, dialogs)
	o.pokemonId = 1
	return o
end



function ToFortreeCity:isDoable()
	if self:hasMap() and not hasItem("Devon Scope") and hasItem("Balance Badge") then
		return true
	end
	return false
end

function ToFortreeCity:isDone()
	if hasItem("Devon Scope") and getMapName() == "Route 120" then
		return true
	else
		return false
	end
end

function ToFortreeCity:PokecenterPetalburgCity()
	return self:pokecenter("Petalburg City")
end

function ToFortreeCity:PetalburgCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Petalburg City" then
		moveToMap("Pokecenter Petalburg City")
	else moveToMap("Route 102")
	end
end


function ToFortreeCity:PetalburgCityGym()
	if isNpcOnCell (73,104) then
		talkToNpcOnCell(73,104)
	elseif game.inRectangle(68,101,79,109) and not hasItem("Balance Badge")  then 
		log("zz")
		moveToCell(77,100)
	elseif game.inRectangle(36,82,47,90) and hasItem("Balance Badge") then
		moveToCell(38,90)
	elseif game.inRectangle(35,55,47,63) and hasItem("Balance Badge") then
		moveToCell(44,63)		
	elseif game.inRectangle(35,28,46,36) and hasItem("Balance Badge") then
		moveToCell(37,36)
	elseif game.inRectangle(18,4,29,11) and hasItem("Balance Badge")  then 
		moveToCell(27,11)
	end
end

function ToFortreeCity:Route102()
	if not game.hasPokemonWithMove("Surf") then
		if self.pokemonId < getTeamSize() then
			useItemOnPokemon("HM03 - Surf", self.pokemonId)
			log("Pokemon: " .. self.pokemonId .. " Try Learning:Surf")
			self.pokemonId = self.pokemonId + 1
		else
			fatal("No pokemon in this team can learn Surf")
		end
	else 
	moveToMap("Oldale Town")
	end
end

function ToFortreeCity:OldaleTown()
	return moveToMap("Route 103")
end

function ToFortreeCity:Route103()
	 moveToMap("Route 110")
end

function ToFortreeCity:Route110()
	return moveToMap("Mauville City Stop House 1")
end

function ToFortreeCity:MauvilleCityStopHouse1()
	return moveToMap("Mauville City")
end

function ToFortreeCity:MauvilleCity()
	return moveToMap("Mauville City Stop House 4")
end


function ToFortreeCity:MauvilleCityStopHouse4()
	return moveToMap("Route 118")
end

function ToFortreeCity:Route118()
	return moveToMap("Route 119B")
end

function ToFortreeCity:Route119B()
	return moveToMap("Route 119A")
end

function ToFortreeCity:Route119A()
	return moveToMap("Fortree City")

end

function ToFortreeCity:WeatherInstitute1F()
	if not game.isTeamFullyHealed() then
		talkToNpcOnCell(18,24)
	elseif not self:isTrainingOver()  then
		moveToMap("Route 119A")
	elseif  isNpcOnCell(32,9) then
		talkToNpcOnCell(32,9)
	elseif isNpcOnCell(24,13) then
		moveToMap("Weather Institute 2F")
	else moveToMap("Route 119A")
	end
end

function ToFortreeCity:WeatherInstitute2F()
	if isNpcOnCell(16,19) then
		talkToNpcOnCell(16,19)
	else moveToMap("Weather Institute 1F")
	end
end


function ToFortreeCity:Route120()
	if isNpcOnCell(45,13) then 
		talkToNpcOnCell(45,13)
	elseif not isNpcOnCell(45,13) and not hasItem("Feather Badge") then
		moveToMap("Fortree City")
	end
end

function ToFortreeCity:FortreeCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Fortree City" then
		moveToMap("Pokecenter Fortree City")
	elseif not hasItem("Devon Scope") then
		moveToMap("Route 120")
	end
end

function ToFortreeCity:PokecenterFortreeCity()
	return self:pokecenter("Fortree City")
end

function ToFortreeCity:FortreeGym()
	if not hasItem("Feather Badge") then
		talkToNpcOnCell(19,7)
	else moveToMap("Fortree City")
	end
end

function ToFortreeCity:Route1a03()
	return moveToMap("Route110")
end

function ToFortreeCity:Route103a()
	return moveToMap("Route110")
end

function ToFortreeCity:Route10a3()
	return moveToMap("Route110")
end
function ToFortreeCity:Route1a03()
	return moveToMap("Route110")
end


return ToFortreeCity