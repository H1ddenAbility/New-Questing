-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest4"
local Dialog = require "Quests/Dialog"

local name		  = 'To Mossdeep City'
local description = 'Clear the Aqua Hideout of Lilycove and earn the 7th badge'
local level = 75

local dialogs = {
	shelly = Dialog:new({ 
		" ffff"
	}),
	finaqua = Dialog:new({ 
		"Route 128"
	}),
	combat = Dialog:new({ 
		"My name is Liza",
		"He is inside this Gym"
	})
}

local ToMossdeepCity = Quest:new()

function ToMossdeepCity:new()
	return Quest.new(ToMossdeepCity, name, description, level, dialogs)
end

function ToMossdeepCity:isDoable()
	if self:hasMap() and not hasItem("Red orb")  then
		return true
	end
	return false
end

function ToMossdeepCity:isDone()
	if hasItem("Mind Badge") and getMapName() == "Sootopolis City" then
		return true
	else
		return false
	end
end
function ToMossdeepCity:MagmaHideout4F()
	moveToMap("Magma Hideout 3F3R")
end

function ToMossdeepCity:MagmaHideout3F3R()
	moveToMap("Magma Hideout 2F3R")
end

function ToMossdeepCity:MagmaHideout2F3R()
	moveToMap("Magma Hideout 1F")
end

function ToMossdeepCity:MagmaHideout1F()
	moveToMap("Jagged Pass")
end

function ToMossdeepCity:JaggedPass()
	moveToMap("Route 112")
end

function ToMossdeepCity:Route112()
	moveToMap("Route 111 South")
end

function ToMossdeepCity:Route111South()
	moveToMap("Mauville City Stop House 3")
end


function ToMossdeepCity:MauvilleCityStopHouse3()
	moveToMap("Mauville City")
end

function ToMossdeepCity:MauvilleCity()
	moveToMap("Mauville City Stop House 4")
end


function ToMossdeepCity:MauvilleCityStopHouse4()
	moveToMap("Route 118")
end

function ToMossdeepCity:Route118()
	moveToMap("Route 119B")
end


function ToMossdeepCity:Route119B()
	moveToMap("Route 119A")
end

function ToMossdeepCity:Route119A()
	moveToMap("Fortree City")
end

function ToMossdeepCity:FortreeCity()
	moveToMap("Route 120")
end

function ToMossdeepCity:Route120()
	moveToMap("Route 121")
end

function ToMossdeepCity:Route121()
	moveToMap("Lilycove City")
end

function ToMossdeepCity:LilycoveCity()
	if isNpcOnCell(3,23) then
		talkToNpcOnCell(3,23)
	elseif self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Lilycove City" then
		moveToMap("Pokecenter Lilycove City")
	else moveToMap("Route 124")
	end
end


function ToMossdeepCity:PokecenterLilycoveCity()
	return self:pokecenter("Lilycove City")
end

function ToMossdeepCity:TeamAquaHideoutEntrance()
	moveToMap("Team Aqua Hideout 1F")
end


function ToMossdeepCity:TeamAquaHideout1F()
	if game.inRectangle(38,25,42,45) or game.inRectangle(37,26,60,31) or game.inRectangle(55,4,60,31) then
		moveToCell(58,5)
	elseif game.inRectangle(7,20,26,31) and isNpcOnCell(17,20) then
		talkToNpcOnCell(17,20)
	else moveToCell(11,22)
	end
end

function ToMossdeepCity:TeamAquaHideoutB1F()
	if game.inRectangle(2,26,40,30) and isNpcOnCell(38,18) then
		moveToCell(3,29)
	elseif game.inRectangle(2,26,40,30) and not isNpcOnCell(38,18) then
		dialogs.shelly.state = true
		moveToCell(3,29)
	elseif game.inRectangle(35,3,38,9) then
		moveToCell(35,8)
	elseif game.inRectangle(33,13,40,22) and isNpcOnCell(38,18) then
		talkToNpcOnCell(38,18)
	elseif game.inRectangle(33,13,40,22) and not isNpcOnCell(38,18) then
		dialogs.shelly.state = true
		moveToCell(35,20)
	end
	end



function ToMossdeepCity:TeamAquaHideoutWarpHallway()
	if game.inRectangle(12,32,36,32) then 
		moveToCell(19,32)
	elseif game.inRectangle(12,32,36,32) and not dialogs.shelly.state then
		moveToCell(19,32)
	elseif game.inRectangle(12,32,36,32) and dialogs.shelly.state then
		moveToCell(24,32)
	elseif game.inRectangle(12,17,36,17) and not dialogs.shelly.state then
		moveToCell(19,17)
	elseif game.inRectangle(12,17,36,17) and dialogs.shelly.state then
		moveToCell(24,17)
	elseif game.inRectangle(12,24,36,24) and not dialogs.shelly.state then
		moveToCell(14,24)
	elseif game.inRectangle(12,24,36,24) and dialogs.shelly.state then
		moveToCell(19,24)
	elseif game.inRectangle(23,39,40,47) and not dialogs.shelly.state then 
		moveToCell(24,41)
	elseif game.inRectangle(23,39,40,47) and dialogs.shelly.state then 
		moveToCell(39,42)
	elseif game.inRectangle(12,5,24,11) then
		moveToCell(19,5)
	end
	
end

function ToMossdeepCity:TeamAquaHideoutB2F()
	if game.inRectangle(7,3,14,11) and not dialogs.shelly.state then 
		moveToCell(12,4)
	elseif game.inRectangle(7,3,14,11) and  dialogs.shelly.state then 
		moveToCell(9,10)
	elseif game.inRectangle(21,3,40,19) then
		moveToCell(23,17)
	elseif game.inRectangle(29,24,40,35) and not isNpcOnCell(31,30) then
		talkToNpcOnCell(28,30)
	else talkToNpcOnCell(31,30)
	end
end

function ToMossdeepCity:Route124()
	if self.registeredPokecenter ~= "Pokecenter Mossdeep City" then
		moveToMap("Mossdeep City")
	elseif not self:isTrainingOver() then
		moveToRectangle(54,42,70,45)
	elseif hasItem("HM06 - Dive") then
		moveToMap("Route 126")
	else
		moveToMap("Mossdeep City")
	end
end

function ToMossdeepCity:Route126()
	if not game.hasPokemonWithMove("Dive") then
		return useItemOnPokemon("HM06 - Dive",1)
	elseif game.hasPokemonWithMove("Dive") then
		moveToCell(15,71)
	else
		fatal("Pokemon 1 can't learn dive")
	end
end
		
function ToMossdeepCity:Route126Underwater()
	if isNpcOnCell(58,97) then
		return talkToNpcOnCell(58,97)
	else 
		return moveToMap("Sootopolis City Underwater")
	end 
end
		
function ToMossdeepCity:SootopolisCityUnderwater()	
	moveToCell(17,11)
end	
	
function ToMossdeepCity:MossdeepCity()
	if isNpcOnCell(36,22) then
		talkToNpcOnCell(36,22)
	elseif self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Mossdeep City" then
		moveToMap("Pokecenter Mossdeep City")
	elseif not self:isTrainingOver() then
		moveToMap("Route 124")
	elseif not hasItem("Mind Badge") then
		moveToMap("Mossdeep Gym")
	elseif hasItem("Mind Badge") and not hasItem("HM06 - Dive") then
		if isNpcOnCell(83,22) then
			return talkToNpcOnCell(83,22)
		else 
			return moveToMap("Mossdeep City Space Center 1F")
		end
	else 
		return moveToMap("Route 124")
	end
end

function ToMossdeepCity:MossdeepCitySpaceCenter1F()
	if not hasItem("HM06 - Dive") then
		return talkToNpcOnCell(12,6)
	else
		return moveToMap("Mossdeep City")
	end
end

function ToMossdeepCity:MossdeepGym()
	if game.inRectangle(4,52,18,67) and not hasItem("Mind Badge") then
		moveToCell(5,52)
	elseif game.inRectangle(51,48,58,65) then
		moveToCell(54,65)
	elseif game.inRectangle(6,3,18,11) and not dialogs.combat.state then 
		talkToNpcOnCell(18,6)
	elseif game.inRectangle(6,3,18,11) and dialogs.combat.state then 
		moveToCell(7,3)
	elseif game.inRectangle(4,27,16,34) then
		moveToCell(10,34)
	elseif game.inRectangle(47,6,56,12) and not hasItem("Mind Badge") then
		talkToNpcOnCell(52,8)
	elseif game.inRectangle(47,6,56,12) then 
		moveToCell(56,6)
	elseif game.inRectangle(29,59,35,68) then 
		moveToCell(29,60)
	elseif game.inRectangle(4,52,18,67) or game.inRectangle(2,60,20,67) then
		moveToMap("Mossdeep City")
	end
end

function ToMossdeepCity:PokecenterMossdeepCity()
	return self:pokecenter("Mossdeep City")
end





return ToMossdeepCity