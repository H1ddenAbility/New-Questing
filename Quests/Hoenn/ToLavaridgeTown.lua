-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest4"
local Dialog = require "Quests/Dialog"

local name		  = 'To Lavaridge Town'
local description = 'Will go to the Mt. Pyre and defeat Max'
local level = 48

local dialogs = {
	jacksonMete = Dialog:new({ 
		"First you pester me in Kanto"
	}),
	fckbug = Dialog:new({ 
		"Sure.. Just try to mess with us, we will make you regret!"
	})
}

local ToLavaridgeTown = Quest:new()

function ToLavaridgeTown:new()
	return Quest.new(ToLavaridgeTown, name, description, level, dialogs)
end

function ToLavaridgeTown:isDoable()
	if self:hasMap()  and not hasItem("Heat Badge")  then
		return true
	end
	return false
end

function ToLavaridgeTown:isDone()
	if getMapName() == "Lavaridge Town" then
		return true
	else
		return false
	end
end

function ToLavaridgeTown:MauvilleCityGym()
	return moveToMap("Mauville City")
end

function ToLavaridgeTown:MauvilleCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Mauville City" then
		moveToMap("Pokecenter Mauville City")
	else moveToMap("Mauville City Stop House 3")
	end
end

function ToLavaridgeTown:MauvilleCityStopHouse3()
	moveToMap("Route 111 South")
	
end

function ToLavaridgeTown:Route111South()
	if isNpcOnCell(23,51) then
		talkToNpcOnCell(23,51)
	else moveToMap("Route 112")
	end
	
end

function ToLavaridgeTown:Route112()
	if isNpcOnCell(29,34) and not  game.inRectangle(11,0,48,18) then
		moveToMap("Fiery Path")
	elseif game.inRectangle(11,0,48,18) then 
		moveToMap("Route 111 North")
	elseif game.inRectangle(0,53,15,63) then 
		moveToMap("Lavaridge Town")
	else moveToMap("Cable Car Station 1")
	end
end

function ToLavaridgeTown:CableCarStation1()
	talkToNpcOnCell(10,6)
end

function ToLavaridgeTown:CableCarStation2()
	moveToMap("Mt. Chimney")
end

function ToLavaridgeTown:FieryPath()
	return moveToCell(38,8)
end



function ToLavaridgeTown:Route111North()
	return moveToMap("Route 113")
end

function ToLavaridgeTown:Route113()
	if not self:isTrainingOver() and not self:needPokecenter() and self.registeredPokecenter == "Pokecenter Fallarbor Town"  then
		moveToGrass()
	else moveToMap("Fallarbor Town")
	end
end

function ToLavaridgeTown:FallarborTown()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Fallarbor Town" then
		moveToMap("Pokecenter Fallarbor Town")
	elseif not self:isTrainingOver() then
		moveToMap("Route 113")
	else moveToMap("Route 114")
	end
end

function ToLavaridgeTown:Route114()
	moveToMap("Meteor falls 1F 1R")
end

function ToLavaridgeTown:Meteorfalls1F1R()
	if isNpcOnCell(31,23) then
		talkToNpcOnCell(31,23)
	elseif not isNpcOnCell(31,23) and not dialogs.jacksonMete.state then
		dialogs.jacksonMete.state = true	
	elseif dialogs.jacksonMete.state then 
		log("ddd")
		moveToMap("Route 115")
	end	
end		



function ToLavaridgeTown:Route115()
	moveToMap("Rustboro City")
end

function ToLavaridgeTown:RustboroCity()
	moveToMap("Route 116")
end

function ToLavaridgeTown:Route116()
	moveToMap("Rusturf Tunnel")	
end

function ToLavaridgeTown:RusturfTunnel()
	if isNpcOnCell(25,9) then
		talkToNpcOnCell(25,9)
	else log("dd")
		moveToMap("Verdanturf Town")
	end
end

function ToLavaridgeTown:MauvilleCityStopHouse2()
	 moveToMap("Mauville City")
	end


function ToLavaridgeTown:VerdanturfTown()
	moveToMap("Route 117")
end

function ToLavaridgeTown:Route117()
		moveToMap("Mauville City Stop House 2")
end




function ToLavaridgeTown:PokecenterMauvilleCity()
	return self:pokecenter("Mauville City")
end

function ToLavaridgeTown:PokecenterFallarborTown()
	return self:pokecenter("Fallarbor Town")
end

function ToLavaridgeTown:MtChimney()
	if not dialogs.fckbug.state then
		if isNpcOnCell(44,25) then
			talkToNpcOnCell(44,25)
		else dialogs.fckbug.state = true
		end
	elseif isNpcOnCell(26,9) then
		talkToNpcOnCell(26,9)
	else moveToMap("Jagged Pass")
	end
end

function ToLavaridgeTown:JaggedPass()
	moveToMap("Route 112")
end

return ToLavaridgeTown