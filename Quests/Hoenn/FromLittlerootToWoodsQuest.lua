-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest4"
local Dialog = require "Quests/Dialog"

local name        = 'From Littleroot To Woods Quest'
local description = 'Pick Mudkip as start, and stop at Petalburg Woods'
local level       = 9
local FromLittlerootToWoodsQuest = Quest:new()

local dialogs = {
	profCheck = Dialog:new({ 
		"i gave her a task"
	}),
	jirachiCheck = Dialog:new({
 		"JIRACHI"
	}),
	npc1 = Dialog:new({
		"are some things money"
	}),
	npc2 = Dialog:new({
		"faced with a decision and you let someone"
	}),
	mayCheck = Dialog:new({ 
		"I heard much",
	})
}

function FromLittlerootToWoodsQuest:new()
	return Quest.new(FromLittlerootToWoodsQuest, name, description, level, dialogs)
end


function FromLittlerootToWoodsQuest:isDoable()
	if not hasItem("Stone Badge")   and self:hasMap() then
		return true
	end
	return false
end

function FromLittlerootToWoodsQuest:isDone()
	return getMapName() == "Petalburg Woods"  or getMapName() == "Rustboro City"
end


function FromLittlerootToWoodsQuest:Route102()
	if  self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Oldale Town" then
		moveToMap("Oldale Town")
	elseif not game.hasPokemonWithMove("Surf") then
			return game.tryTeachMove("Surf","HM03 - Surf")
	elseif hasItem("TM28") and not game.hasPokemonWithMove("Dig") then
		return useItemOnPokemon("TM28",1)
	elseif not self:isTrainingOver()  then
		moveToGrass()
	else moveToMap("Petalburg City")
	end
end

function FromLittlerootToWoodsQuest:PetalburgCity()
	if isNpcOnCell(38,22) then
			talkToNpcOnCell (38,22)
	elseif isNpcVisible("Norman") then
			talkToNpc ("Norman")
	elseif self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Petalburg City" then
		return moveToMap("Pokecenter Petalburg City")
	elseif not self:isTrainingOver() then 
		return moveToMap("Route 104")
	else if isNpcVisible("Norman") then
			talkToNpc ("Norman")
		else moveToMap("Route 104")
		end
	end
end

function FromLittlerootToWoodsQuest:PokecenterPetalburgCity()
	return self:pokecenter("Petalburg City")
end

function FromLittlerootToWoodsQuest:Route104()
	if not self:isTrainingOver() and game.inRectangle(1,70,78,142) then
		moveToGrass()
	elseif game.inRectangle(1,70,78,142) then 
		moveToCell(36,79)
	elseif isNpcOnCell(31,45) and not dialogs.npc1.state then
			talkToNpcOnCell (31,45)
	elseif isNpcOnCell(60,42) and not dialogs.npc2.state then
			talkToNpcOnCell (60,42)
	elseif game.inRectangle(7,0,74,59) then 
		moveToCell(40,0)
	else moveToCell(36,79)
	end
end	


function FromLittlerootToWoodsQuest:LittlerootTownTruck()
	return moveToMap("Littleroot Town")
end

function FromLittlerootToWoodsQuest:LittlerootTown()
	if getTeamSize() == 0 and not dialogs.profCheck.state then
		return moveToMap("Prof. Birch House")
	elseif getTeamSize() == 0 and dialogs.profCheck.state then
		return moveToMap("Lab Littleroot Town")
	else moveToMap("Route 101")
	end
end

function FromLittlerootToWoodsQuest:PlayerHouseLittlerootTown()
	if not dialogs.jirachiCheck.state then 
		return moveToMap("Player Bedroom Littleroot Town")
	else return moveToMap("Littleroot Town")
	end
end

function FromLittlerootToWoodsQuest:ProfBirchHouse()
	if isNpcVisible("Professor Birch") then 
		return talkToNpc("Professor Birch")
	else moveToMap("Littleroot Town")
		 dialogs.profCheck.state = true
			
	end
end
	
function FromLittlerootToWoodsQuest:LabLittlerootTown()
	if getTeamSize() == 0 then 
			talkToNpcOnCell(10,4)
	end
	if (getTeamSize() == 1 or  getTeamSize() == 2)  then
	if isNpcVisible("#261") then 
		talkToNpc ("#261")
	else moveToMap ("Littleroot Town")
end
end
end


function FromLittlerootToWoodsQuest:PlayerBedroomLittlerootTown()
	if dialogs.jirachiCheck.state then
		return moveToMap("Player House Littleroot Town")	
	elseif isNpcVisible("#385") then 
		return talkToNpc("#385")
	else dialogs.jirachiCheck.state = true
	end
		
end


function FromLittlerootToWoodsQuest:Route101()
	return moveToMap("Oldale Town")
end

function FromLittlerootToWoodsQuest:OldaleTown()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Oldale Town" then
		return moveToMap("Pokecenter Oldale Town")
	elseif dialogs.mayCheck.state then 
		return moveToMap("Route 102")
	else moveToMap("Route 103")
	end
end

function FromLittlerootToWoodsQuest:Route103()
	if not game.inRectangle(29,11,29,11) and not dialogs.mayCheck.state then 
		moveToCell(29,11)
	elseif isNpcOnCell (30,11) then
		talkToNpcOnCell(30,11)
	else moveToMap("Oldale Town")
		dialogs.mayCheck.state = true
		return
	end
end


function FromLittlerootToWoodsQuest:PokecenterOldaleTown()
	return self:pokecenter("Oldale Town")
end


return FromLittlerootToWoodsQuest
