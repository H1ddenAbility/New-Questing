-- Copyright © 2016 Rympex <Rympex@noemail>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name        = 'Thunder Badge Quest'
local description = 'From Route 5 to Route 6'
local level       = 2



local dialogs = {
	psychicWadePart2 = Dialog:new({
		"You see, that was Lance, the Pokemon League Champion.",
		"hurry up and tell him that"
	}),
	surgeVision = Dialog:new({
		"Take the cruise, become stronger, and after that, come at me and let's have a zapping match!"
	});
	switchWrong = Dialog:new({
		"wrong switch",
		"have been reset"
	}),
	switchTrigger = Dialog:new({
		"have triggered the first switch"
	})
}

local ThunderBadgeQuest = Quest:new()

function ThunderBadgeQuest:new()
	o = Quest.new(ThunderBadgeQuest, name, description, level, dialogs)
	o.puzzle = {}
	o.firstSwitchFound     = false
	o.firstSwitchActivated = false
	o.firstSwitchX = 0
	o.firstSwitchY = 0
	o.currentSwitchX = SWITCHES_START_X
	o.currentSwitchY = SWITCHES_START_Y
	return o
end

function ThunderBadgeQuest:isDoable()
	if  self:hasMap() then
		return true
	end
	return false
end

function ThunderBadgeQuest:isDone()
	if getMapName() == "Pokecenter Vulcanic Town" or getMapName() == "SSAnne 1F" or getMapName() == "Route 11" then
		return true
	else
		return false
	end
end

function ThunderBadgeQuest:Route5() 
	return moveToMap("Underground House 1")
end

function ThunderBadgeQuest:UndergroundHouse1()
	return moveToMap("Underground2")
end

function ThunderBadgeQuest:Underground2()
	return moveToMap("Underground House 2")
end

function ThunderBadgeQuest:UndergroundHouse2()
	
	return moveToMap("Route 6")
end

function ThunderBadgeQuest:Route6()
		return moveToMap("Vermilion City")
end

function ThunderBadgeQuest:EasterPlateau()
		return moveToMap("Vermilion City")
end

function ThunderBadgeQuest:PokecenterEasterPlateau()
		return moveToMap("Easter Plateau")
end


function ThunderBadgeQuest:PokecenterVermilion()
	self:pokecenter("Vermilion City")
end

function ThunderBadgeQuest:VermilionCity()
	if isNpcOnCell(38, 63) then
		self.dialogs.surgeVision.state = false -- security check, sometimes a NPC takes time to appear
	else
		self.dialogs.surgeVision.state = true
	end

	if  self.registeredPokecenter ~= "Pokecenter Vermilion" then
		return moveToMap("Pokecenter Vermilion")
	elseif not hasItem("Bike Voucher") and not hasItem("Bicycle") then
			return moveToMap("VermilionHouse2Bottom")
	elseif not dialogs.surgeVision.state then
		return talkToNpcOnCell(38, 63) -- Surge
	elseif not hasItem("HM01 - Cut") then -- Need do SSanne Quest
		return moveToCell(40, 67) -- Enter on SSAnne
	elseif not hasItem("Thunder Badge") then
		if game.tryTeachMove("Cut","HM01 - Cut") == true then
			return moveToMap("Route 11")
		end
	else
		return moveToMap("Route 11")
	end
end

function ThunderBadgeQuest:VermilionHouse2Bottom()
	if not hasItem("Bike Voucher") then
		return talkToNpcOnCell(8,6)
	else 
		return moveToMap("Vermilion City")
	end
end

function ThunderBadgeQuest:puzzleBinPosition(binId)
	local xCount = 5
	local yCount = 3
	local xPosition = 2
	local yPosition = 17
	local spaceBetweenBins = 2
	
	local line   = math.floor(binId / xCount + 1)
	local column = math.floor((binId - 1) % xCount + 1)
	
	local x = xPosition + (column - 1) * spaceBetweenBins
	local y = yPosition - (line   - 1) * spaceBetweenBins
	
	return x, y
end

function ThunderBadgeQuest:solvePuzzle()
	if not self.puzzle.bin then
		self.puzzle.bin = 1
	end
	if self.dialogs.switchWrong.state then
		self.dialogs.switchWrong.state = false
		self.dialogs.switchTrigger.state = false
		self.puzzle.bin = self.puzzle.bin + 1
	elseif self.dialogs.switchTrigger.state and not self.puzzle.firstBin then
		self.puzzle.firstBin = self.puzzle.bin
		self.puzzle.bin = 1 -- we know the first bin, let start again
	end
	
	if not self.dialogs.switchTrigger.state and self.puzzle.firstBin then
		local x, y = self:puzzleBinPosition(self.puzzle.firstBin)
		return talkToNpcOnCell(x, y)
	else
		local x, y = self:puzzleBinPosition(self.puzzle.bin)
		return talkToNpcOnCell(x, y)
	end
end

function ThunderBadgeQuest:VulcanIslandshore()
	return moveToMap("Vulcan Path")
end

function ThunderBadgeQuest:VulcanPath()
	if isNpcOnCell(22,37) then
	return talkToNpcOnCell(22,37)
	else return moveToMap("Vulcan Forest")
	end
end

function ThunderBadgeQuest:VulcanForest()
	return moveToMap("Vulcanic Town")
end

function ThunderBadgeQuest:VulcanicTown()
	return moveToMap("Pokecenter Vulcanic Town")
end
return ThunderBadgeQuest
