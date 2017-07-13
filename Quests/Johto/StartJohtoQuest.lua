-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest2"
local Dialog = require "Quests/Dialog"

local name		  = 'New Bark Town'
local description = ' Get first Pokemon (Totodile) + Buy Bike Ticket' --Totodile can Learn Surf and Cut, is perfect for questing
local level = 8

local StartJohtoQuest = Quest:new()

function StartJohtoQuest:new()
	local o = Quest.new(StartJohtoQuest, name, description, level)
	o.BUY_BIKE = true
	return o
end

function StartJohtoQuest:isDoable()
	if self:hasMap() and not hasItem("Zephyr Badge") then
		return true
	end
	return false
end

function StartJohtoQuest:isDone()
	return getMapName() == "Violet City"
end

function StartJohtoQuest:NewBarkTown()
	if getTeamSize() == 0 then
		return moveToMap("Professor Elms Lab")
	else
		return moveToMap("Route 29")
	end
end

function StartJohtoQuest:NewBarkTownPlayerHouseBedroom()
	return moveToMap("New Bark Town Player House")
end

function StartJohtoQuest:NewBarkTownPlayerHouse()
	return moveToMap("New Bark Town")
end

function StartJohtoQuest:ProfessorElmsLab()
	if getTeamSize() == 0 then
		return talkToNpcOnCell(10,6) --Totodile can Learn Surf and Cut, is perfect for questing
	else
		return moveToMap("New Bark Town")
	end
end

function StartJohtoQuest:Route29()
		return moveToMap("Cherrygrove City")
end

function StartJohtoQuest:CherrygroveCity()
	if isNpcOnCell(52,7) then
		return talkToNpcOnCell(52,7) --Get 5 Pokeballs + 5 Potions + 10000 Money
	elseif self:needPokecenter() or not game.isTeamFullyHealed() or not self.registeredPokecenter == "Pokecenter Cherrygrove City" then
		return moveToMap("Pokecenter Cherrygrove City")
	elseif self:needPokemart() then
		return moveToMap("Mart Cherrygrove City")
	elseif game.tryTeachMove("Surf","HM03 - Surf") == true then
		return moveToCell(36,0) --Route 30
	end
end

function StartJohtoQuest:PokecenterCherrygroveCity()
	self:pokecenter("Cherrygrove City")
end

function StartJohtoQuest:MartCherrygroveCity()
	self:pokemart_()
end

function StartJohtoQuest:pokemart_()
	local pokeballCount = getItemQuantity("Pokeball")
	local money         = getMoney()
	if money >= 200 and pokeballCount < 50 then
		if not isShopOpen() then
			return talkToNpcOnCell(3,4)
		else
			local pokeballToBuy = 50 - pokeballCount
			local maximumBuyablePokeballs = money / 200
			if maximumBuyablePokeballs < pokeballToBuy then
				pokeballToBuy = maximumBuyablePokeballs
			end
				return buyItem("Pokeball", pokeballToBuy)
		end
	else
		return moveToMap("Cherrygrove City")
	end
end

function StartJohtoQuest:Route30()
	if  not self.registeredPokecenter == "Pokecenter Cherrygrove City"  then
		return moveToCell(8,96) --Cherrygrove City
	elseif getTeamSize() <= 1 or not self:isTrainingOver() then --Get some pokemons for fill the team
		return moveToGrass()
	elseif self.BUY_BIKE and getMoney() > 75000 and not hasItem("Bicycle") and not hasItem("Bike Voucher") then
		return moveToMap("Route 30 House 2")
	else
		return moveToMap("Route 31")
	end
end

function StartJohtoQuest:Route30House2()
	if self.BUY_BIKE and getMoney() > 75000 and not hasItem("Bicycle") and not hasItem("Bike Voucher") then
		return talkToNpcOnCell(2,6)
	else
		return moveToMap("Route 30")
	end
end

function StartJohtoQuest:Route31()
		return moveToMap("Violet City Stop House")
end

function StartJohtoQuest:VioletCityStopHouse()
	return moveToMap("Violet City")
end

return StartJohtoQuest