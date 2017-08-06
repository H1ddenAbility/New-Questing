-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPaPa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest2"
local Dialog = require "Quests/Dialog"

local name		  = 'Fog Badge Quest'
local description = 'You will exp to the lv 35 and earn the 5th Badge'
local level = 45

local dialogs = {
	letter = Dialog:new({ 
		"Please hurry up"
	}),
	suicune = Dialog:new({ 
		"Nothing"
	})
}

local FogBadgeQuest = Quest:new()

function FogBadgeQuest:new()
	return Quest.new(FogBadgeQuest, name, description, level, dialogs)
end

function FogBadgeQuest:isDoable()
	if self:hasMap() and hasItem("Plain Badge") and not hasItem("Fog Badge") then
		return true
	end
	return false
end

function FogBadgeQuest:isDone()
	if hasItem("Fog Badge") and getMapName() == "Ecruteak Gym" then
		return true
	else
		return false
	end
end

function FogBadgeQuest:GoldenrodCityGym()
	moveToMap("Goldenrod City")
end

function FogBadgeQuest:GoldenrodCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Goldenrod" then
		return moveToMap("Pokecenter Goldenrod")
	elseif not hasItem("SquirtBottle") then 
		moveToMap("Goldenrod City Flower Shop")
	elseif dialogs.letter.state then 
		if isNpcOnCell(81,56) then 
			talkToNpcOnCell(81,56)
		elseif isNpcOnCell(81,57) then 
			talkToNpcOnCell(81,57)
		elseif isNpcOnCell(81,58) then 
			talkToNpcOnCell(81,58)
		else moveToMap("Route 35 Stop House")
			dialogs.letter.state = false --BUG
			return
		end
	else moveToMap("Route 35 Stop House")
	end
end

function FogBadgeQuest:PokecenterGoldenrod()
	self:pokecenter("Goldenrod City")
end

function FogBadgeQuest:GoldenrodCityFlowerShop()
	if not hasItem("SquirtBottle") then 
		talkToNpcOnCell(0,9)
	else moveToMap("Goldenrod City")
	end
end

function FogBadgeQuest:Route35StopHouse()
	if dialogs.letter.state then 
		moveToMap("Goldenrod City")
	else moveToMap("Route 35")
	end
end

function FogBadgeQuest:Route35()
	if isNpcOnCell(11,8) and not dialogs.letter.state then
		talkToNpcOnCell(11,8)
	elseif dialogs.letter.state then 
		moveToMap("Route 35 Stop House")
	elseif isNpcOnCell(11,8) then 
		talkToNpcOnCell(11,8)
	else moveToMap("National Park Stop House 1")
	end
end

function FogBadgeQuest:NationalParkStopHouse1()
	moveToMap("National Park")
end

function FogBadgeQuest:NationalParkStop()
	moveToMap("Route 36")
end

function FogBadgeQuest:NationalPark()
	if isNpcOnCell(29,16) then
		return talkToNpcOnCell(29,16)
	else
		return moveToMap("National Park Stop")
	end
end

function FogBadgeQuest:Route36()
	if isNpcOnCell(47,25) then 
		talkToNpcOnCell(47,25)
	else moveToMap("Route 37")
	end
end

function FogBadgeQuest:Route37()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Ecruteak" then
		moveToMap("Ecruteak City")
	elseif not self:isTrainingOver() then 
		moveToGrass()
	end
end

function FogBadgeQuest:EcruteakCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Ecruteak" then
		return moveToMap("Pokecenter Ecruteak")
	elseif not self:isTrainingOver() then
		moveToMap("Route 37")
	elseif isNpcOnCell(22,40) then 
		moveToMap("Burned Tower Top Floor")
	else moveToMap("Ecruteak Gym")
	end
end

function FogBadgeQuest:BurnedTowerTopFloor()
	if isNpcOnCell(17,13) then 
		talkToNpcOnCell(17,13)
	elseif not dialogs.suicune.state then 
		moveToCell(18,11)
	elseif game.inRectangle(18,10,18,10) then
		moveToCell(17,10)
	else moveToMap("Ecruteak City")
	end
end

function FogBadgeQuest:BurnedTowerFloor2()
	if isNpcOnCell(15,12) then 
		talkToNpcOnCell(15,12)
	elseif not isNpcOnCell(15,12) and not dialogs.suicune.state then  
		dialogs.suicune.state = true 
		return moveToCell(18,10)
		
	end
end

function FogBadgeQuest:EcruteakGym()
	talkToNpcOnCell(6,4)
end

function FogBadgeQuest:PokecenterEcruteak()
	self:pokecenter("Ecruteak City")
end


return FogBadgeQuest
