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
local level       = 32



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
	ditto = Dialog:new({
		"This isn't a Ditto"
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
	if  self:hasMap() and not hasItem("Bike Voucher") and not ( hasItem("Bicycle") or hasItem("Yellow Bicycle") or hasItem("Blue Bicycle") or hasItem("Green Bicycle") )  then
		return true
	end
	return false
end

function ThunderBadgeQuest:isDone()
	if  getMapName() == "Lavender Town" or getMapName() == "SSAnne 1F" or ( getMapName() == "Route 6" and hasItem("Bike Voucher") ) or ( getMapName() == "Saffron City" and hasItem("Rain Badge") ) then
		return true
	else
		return false
	end
end

function ThunderBadgeQuest:Route5()
	if hasItem("HM05 - Flash") then 
		return moveToMap("Cerulean City")
	else
		return moveToMap("Underground House 1")
	end
end

function ThunderBadgeQuest:CeruleanCity()
	if hasItem("HM05 - Flash") then 
		return moveToMap("Link")
	elseif hasItem("Rain Badge") and not hasItem("Boulder Badge") then 
		return moveToMap("Route 4")
	end
end

function ThunderBadgeQuest:Route9()
	return moveToMap("Route 10")
end

function ThunderBadgeQuest:Route10()
	if game.inRectangle(0, 43, 32, 71) then
		return moveToMap("Lavender Town")
	else
		return moveToMap("Link")
	end
end

function ThunderBadgeQuest:RockTunnel1()
	if game.inRectangle(32, 5, 48, 20) then
		return moveToCell(35,16)
	elseif game.inRectangle(3, 4, 32, 19) then
		return moveToCell(8,15)
	elseif game.inRectangle(4, 25, 28, 32) then
		return moveToCell(21,32)
	end
end

function ThunderBadgeQuest:RockTunnel2()
	if game.inRectangle(4, 11, 29, 29) then
		return moveToCell(8,26)
	else
		return moveToCell(7,5)
	end
end

function ThunderBadgeQuest:Route4()
	return moveToMap("Mt. Moon Exit")
end
	
function ThunderBadgeQuest:MtMoonExit()
	return moveToMap("Mt. Moon B1F")
end
	
function ThunderBadgeQuest:MtMoonB1F()
	if game.inRectangle(29, 16, 46, 23) then
		return moveToMap("Mt. Moon B2F")
	elseif game.inRectangle(53, 13, 79, 38) then
		return moveToMap("Mt. Moon 1F")
	end
end	
	
function ThunderBadgeQuest:MtMoon1F()	
	return moveToMap("Route 3")
end

function ThunderBadgeQuest:Route3()	
	return moveToMap("Pewter City")
end

function ThunderBadgeQuest:PewterCity()	
	return moveToMap("Pewter Gym")
end

function ThunderBadgeQuest:PewterGym()	
	if not hasItem("Boulder Badge") then
		return talkToNpcOnCell(7,5)
	else 
		return  useItem("Escape Rope")
	end
end

function ThunderBadgeQuest:MtMoonB2F()
	return moveToCell(38,40)
end		
	
function ThunderBadgeQuest:CeruleanGym() -- get Cascade Badge
	if  hasItem("Cascade Badge") then
		return moveToMap("Cerulean City")
	else
		return talkToNpcOnCell(10, 6)
	end
end

function ThunderBadgeQuest:UndergroundHouse1()
	if hasItem("HM05 - Flash") then
		return moveToMap("Route 5")
	else
		return moveToMap("Underground2")
	end
end

function ThunderBadgeQuest:Underground2()
	if hasItem("HM05 - Flash") then
		return moveToMap("Underground House 1")
	else
		return moveToMap("Underground House 2")
	end
end

function ThunderBadgeQuest:UndergroundHouse2()
	if hasItem("HM05 - Flash") then
		return moveToMap("Underground2")
	else
		return moveToMap("Route 6")
	end
end

function ThunderBadgeQuest:Route6()
	if hasItem("HM05 - Flash") and not hasItem("Rainbow Badge") then
		return moveToMap("Underground House 2")
	else
		return moveToMap("Vermilion City")
	end
end



function ThunderBadgeQuest:EasterPlateau()
		return moveToMap("Vermilion City")
end

function ThunderBadgeQuest:PokecenterEasterPlateau()
		return moveToMap("Easter Plateau")
end


function ThunderBadgeQuest:DiglettsCaveEntrance2()
		return moveToMap("Digletts Cave")
end

function ThunderBadgeQuest:DiglettsCave()
		return moveToMap("Digletts Cave Entrance 1")
end

function ThunderBadgeQuest:DiglettsCaveEntrance1()
		return moveToMap("Route 2")
end

function ThunderBadgeQuest:Route2()
		return moveToMap("Route 2 Stop3")
end

function ThunderBadgeQuest:Route2Stop3()
	if not hasItem("HM05 - Flash") then
		talkToNpcOnCell(6,5)
	else 
		return useItem("Escape Rope")
	end
end

function ThunderBadgeQuest:PokecenterVermilion()
	if  getTeamSize() >=2 and not hasItem("HM03 - Surf") then
				if isPCOpen() then
					if isCurrentPCBoxRefreshed() then
							return depositPokemonToPC(2)
					else
						return
					end
				else
					return usePC()
				end
				
	else
		self:pokecenter("Vermilion City")
	end
end

function ThunderBadgeQuest:VermilionCity()
	if isNpcOnCell(38, 63) then
		self.dialogs.surgeVision.state = false -- security check, sometimes a NPC takes time to appear
	else
		self.dialogs.surgeVision.state = true
	end

	if  self.registeredPokecenter ~= "Pokecenter Vermilion" or ( not game.isTeamFullyHealed() and not  hasPokemonInTeam("Ditto")  ) or ( getTeamSize() >= 2 and not hasItem("HM03 - Surf") ) then
		return moveToMap("Pokecenter Vermilion")
	elseif hasItem("Rain Badge") and not hasItem("Thunder Badge") then
		return moveToMap("Vermilion Gym")
	elseif hasItem("Rain Badge") and getItemQuantity("Escape Rope") <= 15  then
		return moveToMap("Vermilion Pokemart")
	elseif  getItemQuantity("Pokeball") <= 19 and getMoney() >= 7000  then
		return moveToMap("Vermilion Pokemart")
	elseif hasItem("Rain Badge") and not hasItem("Boulder Badge") then 
		return moveToMap("Route 6")
	elseif hasItem("Rain Badge") and hasItem("Boulder Badge") then 
		pushDialogAnswer(1)
		talkToNpc("Sailor Jon")
	elseif hasItem("Bike Voucher") then
		return moveToMap("Route 6")
	elseif hasItem("HM03 - Surf") and hasPokemonInTeam("Ditto")  and not hasItem("Bike Voucher") then
		return moveToCell(32,21)
	elseif not dialogs.surgeVision.state then
		return talkToNpcOnCell(38, 63) -- Surge
	elseif not hasItem("HM01 - Cut") then -- Need do SSanne Quest
		return moveToCell(40, 67) -- Enter on SSAnne
	elseif not game.hasPokemonWithMove("Cut") then
		return useItemOnPokemon("HM01 - Cut", 1)
	elseif not hasItem("Old Rod") then
		return moveToMap("Fisherman House - Vermilion")
	elseif not self:isTrainingOver() then
		return moveToMap("Route 11")
	elseif not hasItem("Thunder Badge") then
		return moveToMap("Vermilion Gym")
	elseif hasItem("HM05 - Flash") then 
		return moveToMap("Route 6")
	else
		return moveToMap("Route 11")
	end
end


function ThunderBadgeQuest:Route11()
	if  not hasItem("Thunder Badge") and not self:isTrainingOver() then
		return moveToGrass()
	elseif isNpcOnCell(10,13) and hasItem("Thunder Badge") then
		talkToNpcOnCell(10,13)
	elseif not isNpcOnCell(10,13) then
		moveToMap("Digletts Cave Entrance 2")
	else
		moveToMap("Vermilion City")
	end
end
	
function ThunderBadgeQuest:VermilionPokemart()
	if  getItemQuantity("Pokeball") <= 20 and getMoney() >= 7000 then
			if not isShopOpen() then 
				return talkToNpcOnCell(3,5)
			else
				return buyItem("Pokeball", 30)
			end
	else 
		moveToMap("Vermilion City")
	end
end

function ThunderBadgeQuest:FishermanHouseVermilion()
	if not hasItem("Old Rod") then
		talkToNpcOnCell(0,6)
	else
		return moveToMap("Vermilion City")
	end
end

function ThunderBadgeQuest:VermilionHouse2Bottom()
	if not hasItem("Bike Voucher") then
		if dialogs.ditto.state then
			pushDialogAnswer(getTeamSize())
			talkToNpc("Samuel")
		else
			pushDialogAnswer(1)
			talkToNpc("Samuel")
		end
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

function ThunderBadgeQuest:VermilionGym()
	self.level = 31
	if self:needPokecenter() or not game.isTeamFullyHealed() or not self.registeredPokecenter == "Pokecenter Vermilion" then
 		return moveToMap("Vermilion City")
	elseif not self:isTrainingOver() and not hasItem("Thunder Badge") then
		return moveToMap("Vermilion City")-- Go to Route 6 and Leveling
	else
		if hasItem("Thunder Badge") then
			return moveToMap("Vermilion City")
		else
			if not isNpcOnCell(6, 10) then
				return talkToNpcOnCell(6,4)
			else
				return self:solvePuzzle()
			end
		end
	end
end

return ThunderBadgeQuest
