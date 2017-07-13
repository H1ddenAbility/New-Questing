-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest4"
local Dialog = require "Quests/Dialog"

local name		  = 'To Balance Badge'
local description = 'Will earn the 4th and the 5th badge'
local level = 41
local joey = false 
local sarah = false
local stan = false

local dialogs = {
	dsf = Dialog:new({ 
		"good luck getting to",
		"Come back later"
	})

}

local ToBalanceBadge = Quest:new()

function ToBalanceBadge:new()
	return Quest.new(ToBalanceBadge, name, description, level, dialogs)
end

function ToBalanceBadge:isDoable()
	if self:hasMap() and not hasItem("Balance Badge") and hasItem("Dynamo Badge") then
		return true
	end
	return false
end

function ToBalanceBadge:isDone()
	if getMapName() == "Petalburg City" and hasItem("Balance Badge") then
		return true
	else
		return false
	end
end

function ToBalanceBadge:LavaridgeTownGym1F()
	if (game.inRectangle(21,35,32,40) or  game.inRectangle(21,25,23,40)) and not hasItem("Heat Badge") then
		moveToCell(21,26)
	elseif game.inRectangle(17,27,18,40) or game.inRectangle(4,38,18,40) then
		moveToCell(6,35)
	elseif game.inRectangle(7,26,13,40) then
		moveToCell(7,28)
	elseif game.inRectangle(7,4,30,13) and not game.inRectangle(19,4,25,12) then
		moveToCell(11,8)
	elseif game.inRectangle(19,4,25,12) and not game.inRectangle(25,5,25,5)    then
		moveToCell(25,5)
	elseif game.inRectangle(19,4,25,12)   then
		moveToCell(25,13)
	elseif game.inRectangle(26,25,32,25) or not hasItem("Heat Badge")  then 
		talkToNpcOnCell(29,26)
	else moveToMap("lavaridge Town")	
	
	end	
end

function ToBalanceBadge:LavaridgeTownGymB1F()
	if game.inRectangle(17,27,18,40) or game.inRectangle(4,38,18,40) or game.inRectangle(4,32,10,40) then
		moveToCell(6,35)
	elseif game.inRectangle(4,12,10,30) and not game.inRectangle(10,29,10,29) then
		moveToCell(10,29)
		log("cf")
	elseif game.inRectangle(4,12,10,30)   then
		log("dsssqs")
		moveToCell(4,13)
	elseif game.inRectangle(7,0,26,11) then	
		log("fff")
		moveToCell(16,5)
	elseif game.inRectangle(19,4,25,17) then
		moveToCell(25,33)
	end
end

function ToBalanceBadge:PokecenterLavaridgeTown()
	return self:pokecenter("Lavaridge Town")
end

function ToBalanceBadge:LavaridgeTown()
	if isNpcOnCell(15,25) then
		talkToNpcOnCell(15,25)
	elseif self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Lavaridge Town" then
		moveToMap("Pokecenter lavaridge Town")
	elseif not hasItem("Heat Badge") then
		moveToMap("Lavaridge Town Gym 1F")
	else moveToMap("Route 112")
	end
end

function ToBalanceBadge:Route112()
	if hasItem("Heat Badge") then 
		moveToMap("Route 111 South")
	else moveToMap("Lavadridge Town")
	end
end

function ToBalanceBadge:Route111Desert()
	if self:needPokecenter() or self:isTrainingOver() then
		moveToMap("Route 111 South")
	else moveToRectangle(22,26,52,52)
	end
end
	
function ToBalanceBadge:JaggedPass()
	 moveToMap("Route 112")
	end


function ToBalanceBadge:Route111South()
	if self:needPokecenter() or self:isTrainingOver() then
		moveToMap("Mauville City Stop House 3")
	else moveToMap("Route 111 Desert")
	end
end

function ToBalanceBadge:MauvilleCityStopHouse3()
	if self:needPokecenter() or self:isTrainingOver() then 
		moveToMap("Mauville City")
	else moveToMap("Route 111 South")
	end
end

function ToBalanceBadge:PokecenterMauvilleCity()
	return self:pokecenter("Mauville City")
end

function ToBalanceBadge:MauvilleCity()
	if self:needPokecenter() then
		moveToMap("Pokecenter Mauville City")
	elseif not self:isTrainingOver() then
		moveToMap("Mauville City Stop House 3")
	else moveToMap("Mauville City Stop House 2")
	end
end

function ToBalanceBadge:MauvilleCityStopHouse2()
	if not self:isTrainingOver() then
		moveToMap("Mauville City")
	else moveToMap("Route 117")
	end
end

function ToBalanceBadge:Route117()
	if not self:isTrainingOver() then
		moveToMap("Mauville City Stop House 2")
	else moveToMap("Verdanturf Town")
	end
end

function ToBalanceBadge:VerdanturfTown()
	if not self:isTrainingOver() then
		moveToMap("Route 117") 
	else moveToMap("Rusturf Tunnel")
	end
end

function ToBalanceBadge:RusturfTunnel()
	if not self:isTrainingOver() then 
		moveToMap("Verdanturf Town") 
	else moveToCell(11,19)
	end
end

function ToBalanceBadge:Route116()
	if not self:isTrainingOver() then
		moveToMap("Rusturf Tunnel")
	else moveToMap("Rustboro City")
	end
end

function ToBalanceBadge:RustboroCity()
	if not self:isTrainingOver() then 
		moveToMap("Route 116")
	else moveToCell(37,65)
	end
end

function ToBalanceBadge:Route104()
	if game.inRectangle(7,0,60,67) then 
		if not self:isTrainingOver() then
			moveToCell(40,0)
		else moveToMap("Petalburg Woods")
		end
	elseif not game.inRectangle(7,0,60,67) then
		if not self:isTrainingOver() then 
			moveToCell(36,79)
		else moveToMap("Petalburg City")
		end
	end
end

function ToBalanceBadge:PetalburgWoods()
	if not self:isTrainingOver() then 
		moveToCell(22,0)
	else moveToCell(24,60)
	end
end

function ToBalanceBadge:PetalburgCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Petalburg City" then
		moveToMap("Pokecenter Petalburg City")
	elseif not self:isTrainingOver() then 
		moveToMap("Route 104") 
	else moveToMap("Petalburg City Gym")
	end
end

function ToBalanceBadge:PokecenterPetalburgCity()
	return self:pokecenter("Petalburg City")
end

function ToBalanceBadge:PetalburgCityGym()
	if isNpcOnCell (73,104) then
		talkToNpcOnCell(73,104)
	elseif game.inRectangle(68,101,79,109) and not hasItem("Balance Badge")  then 
		log("zz")
		moveToCell(77,100)
	elseif  game.inRectangle(68,101,79,109) and hasItem("Balance Badge") then
		moveToCell(74,109)
	elseif game.inRectangle(36,82,47,90) and not joey and not game.inRectangle(42,86,42,86)  then 
		moveToCell(42,86)
	elseif game.inRectangle(36,82,47,90) and not joey and game.inRectangle(42,86,42,86)  then 
		talkToNpcOnCell(41,86)
		joey = true
	elseif game.inRectangle(36,82,47,90) and not hasItem("Balance Badge") then
		log("ff")
		moveToCell(38,81)
	elseif game.inRectangle(36,82,47,90) and hasItem("Balance Badge") then
		moveToCell(38,90)
	elseif game.inRectangle(35,55,46,63) and not sarah and not game.inRectangle(41,58,41,58)  then 
		moveToCell(41,58)
	elseif game.inRectangle(35,55,46,63) and not sarah and game.inRectangle(41,58,41,58)  then 
		talkToNpcOnCell(40,58)
		sarah = true
	elseif game.inRectangle(35,55,46,63) and not hasItem("Balance Badge") then
		log("df")
		moveToCell(44,54)
	elseif game.inRectangle(35,55,47,63) and hasItem("Balance Badge") then
		moveToCell(44,63)		
	elseif game.inRectangle(35,28,46,36) and not stan and not game.inRectangle(41,31,41,31)  then 
		moveToCell(41,31)
	elseif game.inRectangle(35,28,46,36) and not stan and game.inRectangle(41,31,41,31)  then 
		talkToNpcOnCell(40,31)
		stan= true
	elseif game.inRectangle(35,28,46,36) and not hasItem("Balance Badge") then
		log("df")
		moveToCell(37,27)
	elseif game.inRectangle(35,28,46,36) and hasItem("Balance Badge") then
		moveToCell(37,36)
	elseif game.inRectangle(18,4,29,11) and not hasItem("Balance Badge")  then 
		talkToNpcOnCell(23,4)
	elseif game.inRectangle(18,4,29,11) and hasItem("Balance Badge")  then 
		moveToCell(27,11)
	end
end

function ToBalanceBadge:dd()
	
end

function ToBalanceBadge:MapName()
	
end

return ToBalanceBadge