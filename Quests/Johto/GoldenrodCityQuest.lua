local sys    = require "Libs/syslib"
--local pc     = require "Libs/pclib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest2"
local Dialog = require "Quests/Dialog"

local name		  = 'Goldenrod City'
local description = " Complete Guard's Quest"
local level = 35

local dialogs = {
	martElevatorFloorB1F = Dialog:new({ 
		"on the underground"
	}),
	martElevatorFloor1 = Dialog:new({ 
		"the first floor"
	}),
	martElevatorFloor2 = Dialog:new({ 
		"the second floor"
	}),
	martElevatorFloor3 = Dialog:new({ 
		"the third floor"
	}),
	martElevatorFloor4 = Dialog:new({ 
		"the fourth floor"
	}),
	martElevatorFloor5 = Dialog:new({ 
		"the fifth floor"
	}),
	martElevatorFloor6 = Dialog:new({ 
		"the sixth floor"
	}),
	directorQuestPart1 = Dialog:new({ 
		"there is nothing to see here"
	}),
	guardQuestPart1 = Dialog:new({ 
		"any information on his whereabouts"
	}),
	guardQuestPart2 = Dialog:new({ 
		"where did you find him",
		"he might be able to help"
	})
}

local GoldenrodCityQuest = Quest:new()

function GoldenrodCityQuest:new()
	local o = Quest.new(GoldenrodCityQuest, name, description, level, dialogs)
	o.need_oddish = false
	o.gavine_done = false
	o.checkCrate1 = false
	o.checkCrate2 = false
	o.checkCrate3 = false
	o.checkCrate4 = false
	o.checkCrate5 = false
	o.checkCrate6 = false
	o.checkCrate7 = false
	return o
end

function GoldenrodCityQuest:isDoable()
	if self:hasMap() then
		if getMapName() == "Goldenrod City" then 
			return isNpcOnCell(48,34)
		else
			return true
		end
	end
	return false
end

function GoldenrodCityQuest:isDone()
	if getMapName() == "Goldenrod City" and not isNpcOnCell(50,34)  then
		return true
	end
	return false
	
end

function GoldenrodCityQuest:pokemart_()
	local pokeballCount = getItemQuantity("Pokeball")
	local money         = getMoney()
	if money >= 200 and pokeballCount < 50 then
		if not isShopOpen() then
			return talkToNpcOnCell(21,6)
		else
			local pokeballToBuy = 50 - pokeballCount
			local maximumBuyablePokeballs = money / 200
			if maximumBuyablePokeballs < pokeballToBuy then
				pokeballToBuy = maximumBuyablePokeballs
			end
				return buyItem("Pokeball", pokeballToBuy)
		end
	else
		return moveToMap("Goldenrod Mart 1")
	end
end

function GoldenrodCityQuest:PokecenterGoldenrod()
			self:pokecenter("Goldenrod City")
end

function GoldenrodCityQuest:GoldenrodCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Goldenrod" then
		return moveToMap("Pokecenter Goldenrod")
	elseif self:needPokemart() then
		return moveToMap("Goldenrod Mart 1")
	elseif not hasPokemonInTeam("Bellsprout") then
		return moveToMap("Route 35 Stop House")
	elseif hasItem("Bike Voucher") then
		return moveToMap("Goldenrod City Bike Shop")
	elseif not self:isTrainingOver() then
		return moveToMap("Route 34")
	elseif not isNpcOnCell(48,34) then
		return talkToNpcOnCell(50,34)
	elseif hasItem("Basement Key") and not hasItem("SquirtBottle") and dialogs.guardQuestPart2.state then --get Oddish on PC and start leveling
		if not game.hasPokemonWithMove("Sleep Powder") then
			if hasPokemonInTeam("Oddish") then			
				return moveToMap("Route 34")
			else
				return moveToMap("Pokecenter Goldenrod")
			end
		else
			return moveToMap("Goldenrod Mart 1")
		end
	elseif isNpcOnCell(48,34) then
		if dialogs.guardQuestPart2.state then
			if hasItem("Basement Key") then
				
			else
				return moveToMap("Goldenrod City House 2")
			end
		elseif dialogs.guardQuestPart1.state then
			return moveToMap("Goldenrod Underground Entrance Top")
		else
			pushDialogAnswer(2)
			return talkToNpcOnCell(48,34)
		end
	else
	end
end

function GoldenrodCityQuest:Route35StopHouse()
	if not hasPokemonInTeam("Bellsprout") then
		return moveToMap("Route 35")
	else
		return moveToMap("Goldenrod City")
	end
end

function GoldenrodCityQuest:Route35()
	if not hasPokemonInTeam("Bellsprout") then
		if not game.hasPokemonWithMove("Cut") then
			if self.pokemonId < getTeamSize() then					
				useItemOnPokemon("HM01 - Cut", self.pokemonId)
				log("Pokemon: " .. self.pokemonId .. " Try Learning: HM03 - Surf")
				self.pokemonId = self.pokemonId + 1
				return
			else
				return useItemOnPokemon("HM01 - Cut", 1)
			end 
		else
			return moveToMap("Route 36")
		end 
	else
		return moveToMap("Route 35 Stop House")
	end
end

function GoldenrodCityQuest:Route36()
	if not hasPokemonInTeam("Bellsprout") then
		return moveToGrass()
	else 
		return moveToMap("Route 35")
	end
end

function GoldenrodCityQuest:GoldenrodCityBikeShop()
	if hasItem("Bike Voucher") then
		return talkToNpcOnCell(11,3)
	else
		return moveToMap("Goldenrod City")
	end
end

function GoldenrodCityQuest:GoldenrodUndergroundEntranceTop()
	dialogs.guardQuestPart1.state = false
	if dialogs.directorQuestPart1.state or self.gavin_done then
		return moveToMap("Goldenrod City")
	else
		return moveToMap("Goldenrod Underground Path")
	end
	
end

function GoldenrodCityQuest:GoldenrodUndergroundPath()
	if isNpcOnCell(7,2) then
		return talkToNpcOnCell(7,2) --Item: TM-46   Psywave
	elseif not isNpcOnCell(17,10) then
		if not self.gavin_done then
			return moveToMap("Goldenrod Underground Basement")
		else
			return moveToMap("Goldenrod Underground Entrance Top")
		end
	elseif dialogs.directorQuestPart1.state then
		return moveToMap("Goldenrod Underground Entrance Top")
	else
		return talkToNpcOnCell(17,10)
	end
end

function GoldenrodCityQuest:GoldenrodCityHouse2()
	if not hasItem("Basement Key") then
		return talkToNpcOnCell(9,5)
	else
		return moveToMap("Goldenrod City")
	end
end

function GoldenrodCityQuest:Route34()
	if self:needPokecenter() or not self.registeredPokecenter == "Pokecenter Goldenrod" then
		return moveToMap("Goldenrod City")
	elseif not self:isTrainingOver() then
		return moveToGrass()
	elseif hasItem("Basement Key") and not hasItem("SquirtBottle") and dialogs.guardQuestPart2.state then --get Oddish on PC and start leveling
		if not game.hasPokemonWithMove("Sleep Powder") then
			if hasPokemonInTeam("Oddish") or hasPokemonInTeam("Gloom") then
				if game.getTotalUsablePokemonCount() < getTeamSize() then
					return moveToMap("Goldenrod City") --oddish is low level so, it will die first every time
				else
					return moveToGrass()
				end
			else
				return moveToMap("Goldenrod City")
			end
		else
			return moveToMap("Goldenrod City")
		end
	else
		return moveToMap("Goldenrod City")
	end
end

function GoldenrodCityQuest:Route34StopHouse()
	if self:needPokecenter() or not self.registeredPokecenter == "Pokecenter Goldenrod" then
		return moveToMap("Route 34")
	else
		return moveToMap("Route 34")
	end
end

function GoldenrodCityQuest:GoldenrodMartElevator()
	if not hasItem("Fresh Water") then
		if not dialogs.martElevatorFloor6.state then		
			pushDialogAnswer(5)
			pushDialogAnswer(3)
			return talkToNpcOnCell(1,6)
		else
			dialogs.martElevatorFloor6.state = false
			return moveToCell(3,6)
		end
	elseif hasItem("Basement Key") and not hasItem("SquirtBottle") and game.hasPokemonWithMove("Sleep Powder") and dialogs.guardQuestPart2.state then
		if not dialogs.martElevatorFloorB1F.state then		
			pushDialogAnswer(1)
			return talkToNpcOnCell(1,6)
		else
			dialogs.martElevatorFloorB1F.state = false
			return moveToCell(3,6)
		end
	else
		if not dialogs.martElevatorFloor1.state then
			pushDialogAnswer(2)
			return talkToNpcOnCell(1,6)
		else
			dialogs.martElevatorFloor1.state = false
			return moveToCell(3,6)
		end
	end
end

function GoldenrodCityQuest:GoldenrodMart1()
	if self:needPokemart() then
		return moveToMap("Goldenrod Mart 2")
	elseif not hasItem("Fresh Water") then
		return moveToMap("Goldenrod Mart Elevator")
	elseif hasItem("Basement Key") and not hasItem("SquirtBottle") and game.hasPokemonWithMove("Sleep Powder") and dialogs.guardQuestPart2.state then
		return moveToMap("Goldenrod Mart Elevator")
	else
		return moveToMap("Goldenrod City")
	end
end

function GoldenrodCityQuest:GoldenrodMart2()
	if self:needPokemart() then
		self:pokemart_()
	else
		return moveToMap("Goldenrod Mart 1")
	end
end

function GoldenrodCityQuest:GoldenrodMart6()
	if not hasItem("Fresh Water") then
		if not isShopOpen() then
			return talkToNpcOnCell(11, 3)
		else
			if getMoney() > 1000 then
				return buyItem("Fresh Water", 5)
			else
				return buyItem("Fresh Water",(getMoney()/200))
			end
		end
	else
		return moveToMap("Goldenrod Mart Elevator")
	end
end

function GoldenrodCityQuest:GoldenrodMartB1F()
	if hasItem("Basement Key") and not hasItem("SquirtBottle") and dialogs.guardQuestPart2.state and game.hasPokemonWithMove("Sleep Powder") then
		if isNpcOnCell(13,8) then
			pushDialogAnswer(2)
			if  game.hasPokemonWithName("Bellsprout")  then
			pushDialogAnswer(game.hasPokemonWithName("Bellsprout"))
			else
			fatal("Error . - No Bellsprout in this team")
			end
			return talkToNpcOnCell(13,8)
		else
			return moveToMap("Underground Warehouse")
		end
	else
		return moveToMap("Goldenrod Mart Elevator")
	end
	
end

function GoldenrodCityQuest:UndergroundWarehouse()
	if not self.checkCrate1 then --Marill Crate
		if getPlayerX() == 23 and getPlayerY() == 12 then
			talkToNpcOnCell(23,13)
			self.checkCrate1 = true
			return
		else
			return moveToCell(23,12)
		end
	elseif not self.checkCrate2 then --Miltank Crate
		if getPlayerX() == 20 and getPlayerY() == 9 then
			talkToNpcOnCell(20,8)
			self.checkCrate2 = true
			return
		else
			return moveToCell(20,9)
		end
	elseif not self.checkCrate3 then --Abra Crate
		if getPlayerX() == 16 and getPlayerY() == 12 then
			talkToNpcOnCell(15,12)
			self.checkCrate3 = true
			return
		else
			return moveToCell(16,12)
		end
	elseif isNpcOnCell(15,17) then--Item: Revive
		return talkToNpcOnCell(15,17)
	elseif not self.checkCrate4 then --Meowth Crate
		if getPlayerX() == 19 and getPlayerY() == 17 then
			talkToNpcOnCell(19,16)
			self.checkCrate4 = true
			return
		else
			return moveToCell(19,17)
		end
	elseif not self.checkCrate5 then --Heracross Crate
		if getPlayerX() == 24 and getPlayerY() == 22 then
			talkToNpcOnCell(24,23)
			self.checkCrate5 = true
			return
		else
			return moveToCell(24,22)
		end
	elseif not self.checkCrate6 then --Snubbull Crate	
		if getPlayerX() == 13 and getPlayerY() == 24 then
			talkToNpcOnCell(12,24)
			self.checkCrate6 = true
			return
		else
			return moveToCell(13,24)
		end
	elseif not self.checkCrate7 then --Item: Great Balls
		if getPlayerX() == 5 and getPlayerY() == 8 then
			talkToNpcOnCell(5,7)
			self.checkCrate7 = true
			return
		else
			return moveToCell(5,8)
		end
	elseif isNpcOnCell(3,16) then --Item: Antidote
		return talkToNpcOnCell(3,16) 
	else
		self.checkCrate1 = false
		self.checkCrate2 = false
		self.checkCrate3 = false
		self.checkCrate4 = false
		self.checkCrate5 = false
		self.checkCrate6 = false
		self.checkCrate7 = false
		return moveToCell(7,18)
	end
end

function GoldenrodCityQuest:GoldenrodUndergroundBasement()
	-- BASEMENT LEVELRS PUZZLE
	if not isNpcOnCell(5,4) then
		dialogs.guardQuestPart2.state = false
		self.gavin_done = true
		if isNpcOnCell(9,18) then
			return talkToNpcOnCell(8,19)
		elseif isNpcOnCell(18,12) then
			return talkToNpcOnCell(17,13)
		else
			return moveToMap("Goldenrod Underground Path")
		end	
	elseif isNpcOnCell(18,12) and isNpcOnCell(22,16) and isNpcOnCell(18,18) and isNpcOnCell(13,16) and isNpcOnCell(9,12) and isNpcOnCell(9,18) and isNpcOnCell(4,16) and isNpcOnCell(4,10) then --Lever A
		return talkToNpcOnCell(26,13)
	elseif not isNpcOnCell(18,12) and isNpcOnCell(22,16) and isNpcOnCell(18,18) and isNpcOnCell(13,16) and isNpcOnCell(9,12) and not isNpcOnCell(9,18) and isNpcOnCell(4,16) and isNpcOnCell(4,10) then --Lever C
		return talkToNpcOnCell(17,13)
	elseif isNpcOnCell(18,12) and isNpcOnCell(22,16) and isNpcOnCell(18,18) and not isNpcOnCell(13,16) and isNpcOnCell(9,12) and not isNpcOnCell(9,18) and isNpcOnCell(4,16) and isNpcOnCell(4,10) then --Lever D
		return talkToNpcOnCell(17,17)
	elseif isNpcOnCell(18,12) and not isNpcOnCell(22,16) and isNpcOnCell(18,18) and not isNpcOnCell(13,16) and not isNpcOnCell(9,12) and not isNpcOnCell(9,18) and isNpcOnCell(4,16) and isNpcOnCell(4,10) then --Lever C
		return talkToNpcOnCell(17,13)
	elseif not isNpcOnCell(18,12) and not isNpcOnCell(22,16) and isNpcOnCell(18,18) and isNpcOnCell(13,16) and not isNpcOnCell(9,12) and not isNpcOnCell(9,18) and isNpcOnCell(4,16) and isNpcOnCell(4,10) then --Lever B
		return talkToNpcOnCell(26,17)
	elseif not isNpcOnCell(18,12) and not isNpcOnCell(22,16) and isNpcOnCell(18,18) and isNpcOnCell(13,16) and isNpcOnCell(9,12) and not isNpcOnCell(9,18) and not isNpcOnCell(4,16) and isNpcOnCell(4,10) then --Lever C
		return talkToNpcOnCell(17,13)
	elseif isNpcOnCell(18,12) and not isNpcOnCell(22,16) and isNpcOnCell(18,18) and not isNpcOnCell(13,16) and isNpcOnCell(9,12) and not isNpcOnCell(9,18) and not isNpcOnCell(4,16) and isNpcOnCell(4,10) then --Lever C
		return talkToNpcOnCell(8,19)
	elseif isNpcOnCell(18,12) and not isNpcOnCell(22,16) and isNpcOnCell(18,18) and not isNpcOnCell(13,16) and isNpcOnCell(9,12) and isNpcOnCell(9,18) and not isNpcOnCell(4,16) and not isNpcOnCell(4,10) then	--Lever C
		if game.inRectangle(19,0,40,20) then
			return talkToNpcOnCell(26,13) --Leveler A
		else
			if isNpcOnCell(8,8) then --TM62 - Taunt
				return talkToNpcOnCell(8,8)
			elseif isNpcOnCell(5,4) then --Galvin Director
				return talkToNpcOnCell(5,4)
			else
				relog(10,"Relogging to slove the quest")
			end
		end
	elseif not isNpcOnCell(18,12) and not isNpcOnCell(22,16) and isNpcOnCell(18,18) and not isNpcOnCell(13,16) and isNpcOnCell(9,12) and not isNpcOnCell(9,18) and not isNpcOnCell(4,16) and not isNpcOnCell(4,10) then	--Lever C
			if isNpcOnCell(5,4) then --Galvin Director
				return talkToNpcOnCell(5,4)
			else
				relog(10,"Relogging to slove the quest")
			end
	else
	relog(10,"Relogging to slove the quest")
	end
end

function GoldenrodCityQuest:MapName()
	
end

function GoldenrodCityQuest:MapName()
	
end

function GoldenrodCityQuest:MapName()
	
end

return GoldenrodCityQuest