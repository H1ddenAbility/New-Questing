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
	if self:hasMap() and not hasItem("Blue Orb") and not  hasItem("Rain Badge") then
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

function beatDeoxys:Route128()
	if not dialogs.goSky.state then 
		moveToMap("Route 127")
	else moveToMap("Route 129")
	end
end

function beatDeoxys:MossdeepCity()
		moveToMap("Route 127")
end

function beatDeoxys:Route127()
	if not dialogs.goSky.state then
		moveToMap("Route 126")
	else moveToMap("Route 128")
	end
end

function beatDeoxys:Route126()
	if not dialogs.goSky.state then 
		if hasMove(1, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(1)
			moveToCell(15,71)
		elseif hasMove(2, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(2)
			moveToCell(15,71)
		elseif hasMove(3, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(3)
			moveToCell(15,71)
		elseif hasMove(4, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(4)
			moveToCell(15,71)
			elseif hasMove(5, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(5)
			moveToCell(15,71)
		elseif hasMove(6, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(6)
			moveToCell(15,71)
		end
	else moveToMap("Route 127")
	end
end

function beatDeoxys:Route126Underwater()
	if isNpcOnCell(58,97) then 
		talkToNpcOnCell(58,97)
	elseif not dialogs.goSky.state then 
		moveToMap("Sootopolis City Underwater")
	else if hasMove(1, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(1)
			moveToCell(15,71)
		elseif hasMove(2, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(2)
			moveToCell(15,71)
		elseif hasMove(3, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(3)
			moveToCell(15,71)
		elseif hasMove(4, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(4)
			moveToCell(15,71)
			elseif hasMove(5, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(5)
			moveToCell(15,71)
		elseif hasMove(6, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(6)
			moveToCell(15,71)
		end
	end
end

function beatDeoxys:SootopolisCityUnderwater()
	if dialogs.goSky.state then 
		moveToMap("Route 126 Underwater")
	else if hasMove(1, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(1)
			moveToCell(17,11)
		elseif hasMove(2, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(2)
			moveToCell(17,11)
		elseif hasMove(3, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(3)
			moveToCell(17,11)
		elseif hasMove(4, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(4)
			moveToCell(17,11)
			elseif hasMove(5, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(5)
			moveToCell(17,11)
		elseif hasMove(6, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(6)
			moveToCell(17,11)
		end
	end
end

function beatDeoxys:SootopolisCity()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Sootopolis City" then
		moveToMap("Pokecenter Sootopolis City")
	elseif isNpcOnCell(48,68) and not dialogs.goSky.state then 
		talkToNpcOnCell(50,17)
	elseif dialogs.goSky.state then
		if hasMove(1, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(1)
			moveToCell(50,91)
		elseif hasMove(2, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(2)
			moveToCell(50,91)
		elseif hasMove(3, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(3)
			moveToCell(50,91)
		elseif hasMove(4, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(4)
			moveToCell(50,91)
			elseif hasMove(5, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(5)
			moveToCell(50,91)
		elseif hasMove(6, "Dive") then
			pushDialogAnswer(1)
			pushDialogAnswer(6)
			moveToCell(50,91)
		end
	elseif not isNpcOnCell(48,68) and not hasItem("Rain Badge") then
		moveToMap("Sootopolis City Gym 1F")
	else log("dd")
	end
end

function beatDeoxys:Route129()
	moveToMap("Route 130")
end

function beatDeoxys:Route130()
	moveToMap("Route 131")
end

function beatDeoxys:Route131()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Pacifidlog Town" then
		moveToMap("Pacifidlog Town")
	else moveToMap("Sky Pillar Entrance")
	end
end

function beatDeoxys:PacifidlogTown()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Pacifidlog Town" then
		moveToMap("Pokecenter Pacifidlog Town")
	else moveToMap("Route 131")
	end
end

function beatDeoxys:SkyPillarEntrance()
	if not game.inRectangle(25,7,36,26) then
		if self:needPokecenter() then 
			moveToMap("Route 131")
		else moveToMap("Sky Pillar Entrance Cave 1F")
		end
	else 
		 if isNpcOnCell(27,7) then	
			talkToNpcOnCell(27,7)
		 elseif self:needPokecenter() then
			moveToMap("Sky Pillar Entrance Cave 1F")
			else
			moveToMap("Sky Pillar 1F")
		 end
	end
		
end

function beatDeoxys:SkyPillar1F()
	if  not self:isTrainingOver() and not self:needPokecenter() then
		moveToRectangle(3,6,11,12)
	elseif self:needPokecenter() then	
		moveToMap("Sky Pillar Entrance")
	else moveToCell(13,5)
	end
end

function beatDeoxys:SkyPillarEntranceCave1F()
	if self:needPokecenter() then 
		moveToCell(7,17)
	else moveToCell(17,6)
	end
end

function beatDeoxys:PacifidlogTown()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Pacifidlog Town" then
		moveToMap("Pokecenter Pacifidlog Town")
	else moveToMap("Route 131")
	end
end


function beatDeoxys:PokecenterPacifidlogTown()
	return self:pokecenter("Pacifidlog Town")
end


function beatDeoxys:PokecenterSootopolisCity()
	return self:pokecenter("Sootopolis City")
end


function beatDeoxys:SkyPillar2F()
	moveToCell(7,5)
end

function beatDeoxys:SkyPillar3F()
	moveToCell(3,6)
end

function beatDeoxys:SkyPillar4F()
	moveToCell(8,12)
end

function beatDeoxys:SkyPillar5F()
	moveToCell(13,12)
end

function beatDeoxys:SkyPillar6F()
	talkToNpcOnCell(25,19)
end

function beatDeoxys:Moon()
	if game.inRectangle(25,48,8,33) then
		moveToCell(7,40)
	elseif game.inRectangle(8,31,26,11) then
		moveToCell(15,10)
	elseif game.inRectangle(39,11,52,41) and deoxysBattu then
		log("dd")
		moveToCell(53,19)
	elseif game.inRectangle(39,11,52,41) and not deoxysBattu then
		moveToCell(53,40)
	elseif isNpcOnCell(30,28) then 
		talkToNpcOnCell(30,28)
	else deoxysBattu = true 
		moveToMap("Moon 2F")
		
	end
end

function beatDeoxys:Moon1F()
	if game.inRectangle(4,24,9,45) or game.inRectangle(3,31,11,33)  then
		moveToCell(8,24)
	elseif game.inRectangle(16,4,47,14) then
		moveToCell(47,15)
	elseif game.inRectangle(57,43,61,47) then
		moveToCell(59,45)
	elseif game.inRectangle(5,3,8,3) then
		moveToCell(6,8)
	elseif game.inRectangle(57,23,61,25) then
		moveToCell(59,23)
	end
end

function beatDeoxys:MoonB1F()
	if game.inRectangle(55,15,60,23) then
		dialogs.goSky.state = false
		talkToNpcOnCell(60,23)
	elseif not deoxysBattu then
		log("dd")
		moveToCell(32,19)
	else moveToCell(5,32)
	end
end

function beatDeoxys:Moon2F()
	if not deoxysBattu then
		if game.inRectangle(6,3,6,3) then 
			moveToCell(5,3)
		elseif game.inRectangle(5,3,5,3) then 
			moveToCell(5,4)
		elseif game.inRectangle(5,4,5,4) then 
			moveToCell(5,5)
		else moveToMap("Moon")
		end
	else moveToCell(6,4)
	end
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
	if game.inRectangle(10,34,15,42) then
		moveToCell(13,34)
	elseif game.inRectangle(13,21,22,28) then
		moveToCell(13,21)
	elseif game.inRectangle(10,5,16,14) then
		talkToNpcOnCell(13,6)
	end
end

return beatDeoxys
