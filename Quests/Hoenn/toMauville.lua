-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa]

local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest4"
local Dialog = require "Quests/Dialog"

local name        = 'To Mauville City'
local description = 'Beat Museum,May and go to Mauville '

local level       = 35
local toMauville = Quest:new()


local dialogs = {
	devonVic = Dialog:new({ 
		"I need to do some research on this"
		
	}),
	ingenieur = Dialog:new({ 
		"Oh, you need to see Devon",
		"Restaurants for cats?" --ARE THEY OUT OF THEIR MINDS ? 

	}),
	goingO = Dialog:new({ 
		"What is going on?"

	}),
	npc10 = Dialog:new({
		"give my best next time too"
	})
}

function toMauville:new()
	return Quest.new(toMauville , name, description, level, dialogs)
end


function toMauville:isDoable()
	if hasItem("Stone Badge") and self:hasMap() and not  hasItem("Dynamo Badge") then
		return true
	end
	return false
end

function toMauville:isDone()
		if (hasItem("Knuckle Badge") and  getMapName() == "Mauville City") then 
		return true
	end
	return false
end 

	
function toMauville:DevonCorporation3F()
	return moveToMap("Devon Corporation 2F")
end

function toMauville:DevonCorporation2F()
	return moveToMap("Devon Corporation 1F")
end

function toMauville:DevonCorporation1F()
	return moveToMap("Rustboro City")
end

function toMauville:RustboroCity()
	moveToMap("Route 104")
end


function toMauville:Route104()
	if game.inRectangle(7,0,67,51) then 
		moveToMap("Petalburg Woods")
	else moveToMap("Route 104 Sailor House")
		
end
end

function toMauville:DewfordTown()
	pushDialogAnswer(2)
	talkToNpcOnCell(37,9)
end

function toMauville:Route109()
	if self.registeredPokecenter ~= "Pokecenter Slateport" then
		moveToMap("Slateport City")
	elseif not self:isTrainingOver() then
		moveToRectangle(26,2,38,2)
	else 
		moveToMap("Slateport City")
	end
	
end

function toMauville:Route104SailorHouse()
	if isNpcOnCell(8,7) then 
		talkToNpcOnCell(8,7)
	elseif isNpcOnCell(8,6) then 
		talkToNpcOnCell(8,6)
	elseif isNpcOnCell(8,5) then 
		talkToNpcOnCell(8,5)
	elseif isNpcOnCell(9,5) then 
		talkToNpcOnCell(9,5)
	elseif isNpcOnCell(10,5) then 
		talkToNpcOnCell(10,5)
	elseif isNpcOnCell(11,5) then 
		talkToNpcOnCell(11,5)
	elseif isNpcOnCell(11,6) then 
		talkToNpcOnCell(11,6)
	elseif isNpcOnCell(11,7) then 
		talkToNpcOnCell(11,7)
	elseif isNpcOnCell(11,6) then 
		talkToNpcOnCell(11,6)
	elseif isNpcOnCell(11,7) then 
		talkToNpcOnCell(11,7)
	elseif isNpcOnCell(11,8) then 
		talkToNpcOnCell(11,8)
	elseif isNpcOnCell(10,8) then 
		talkToNpcOnCell(10,8)
	elseif isNpcOnCell(9,8) then 
		talkToNpcOnCell(9,8)
	elseif isNpcOnCell(8,8) then 
		talkToNpcOnCell(8,8)
	
		
	end
end

function toMauville:SlateportCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Slateport" then
		 moveToCell(32,25)
	elseif not hasItem("Devon Goods")  then 
		moveToMap("Route 110")
	elseif not dialogs.ingenieur.state and not dialogs.devonVic.state then 
		moveToCell(39,54)
	elseif dialogs.ingenieur.state then 
		moveToCell(55,38)
	else moveToMap("Route 110")
	end
	
end

function toMauville:SlateportShipyard1F()
	if not dialogs.ingenieur.state then 
		talkToNpcOnCell(5,6)
	else moveToMap("Slateport City")
	end
	
end

function toMauville:PokecenterSlateport()
	return self:pokecenter("Slateport City")
end

function toMauville:SlateportMuseum1F()
	if not dialogs.devonVic.state then 
		moveToMap("Slateport Museum 2F")
	else moveToMap("Slateport City")	
	end
end

 function toMauville:SlateportMuseum2F()
    if isNpcOnCell(11,14) and game.inRectangle(9,12,12,15) then 
        talkToNpcOnCell (11,14)
        log("lol")
    elseif isNpcOnCell(11,14) and not game.inRectangle(9,12,12,15) then 
        talkToNpcOnCell(10,16)
    elseif isNpcVisible("Devon") and not dialogs.goingO.state then 
        talkToNpc("Devon")
        log("lel")
    elseif dialogs.devonVic.state then 
        moveToMap("Slateport Museum 1F")
        dialogs.ingenieur.state = false
    else dialogs.devonVic.state = true
        dialogs.ingenieur.state = false
    end
end 

function toMauville:Route110()
	if isNpcOnCell(43,78) then 
		talkToNpcOnCell(43,78)
	elseif isNpcOnCell(24,60) and not dialogs.npc10.state then
			talkToNpcOnCell (24,60)
	else moveToMap("Mauville City Stop House 1")
	end
end

function toMauville:MauvilleCityStopHouse1()
	return moveToMap("Mauville City")
end

function toMauville:PetalburgWoods()
	return moveToCell(24,60)
	
	end
	
return toMauville