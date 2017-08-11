-- Copyright � 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'Elite 4 - Kanto'
local description = 'Training for e4'
local level = 96

local dialogs = {
	leagueKantoNotDone = Dialog:new({ 
		"you are not ready to go to johto yet"
	}),
	e4Done = Dialog:new({ 
		"i see you are Champion of Kanto, you may continue",
	}),
	readyE4 = Dialog:new({ 
		"already the champ, don't need to go",
	})
}

local ExpForElite4Kanto = Quest:new()

function ExpForElite4Kanto:new()
	local o = Quest.new(ExpForElite4Kanto, name, description, level, dialogs)
	o.qnt_revive = 15
	o.qnt_hyperpot = 22
	o.registeredPokecenter_ = ""
	o.zoneExp = 1
	o.timeSeed = 0
	o.minuteZones = 5
	return o
end

function ExpForElite4Kanto:isDoable()
	if self:hasMap()  and not hasItem("Zephyr Badge") then
		return true
	end
	return false
end

function ExpForElite4Kanto:isDone()
	if getMapName() == "Route 26" or getMapName() == "Route 2" or getMapName() == "Elite Four Lorelei Room" then --Fix Blackout
		return true
	end
	return false
end

function ExpForElite4Kanto:buyReviveItems() --return false if all items are on the bag 
	if getItemQuantity("Revive") < self.qnt_revive or getItemQuantity("Hyper Potion") < self.qnt_hyperpot then
		if not isShopOpen() then
			return talkToNpcOnCell(16,22)
		else
			if getItemQuantity("Revive") < self.qnt_revive then
				return buyItem("Revive", (self.qnt_revive - getItemQuantity("Revive")))
			end
			if getItemQuantity("Hyper Potion") < self.qnt_hyperpot then
				return buyItem("Hyper Potion", (self.qnt_hyperpot - getItemQuantity("Hyper Potion")))
			end
		end
	else
		return false
	end

end

function ExpForElite4Kanto:canBuyReviveItems()
	local bag_revive = getItemQuantity("Revive")
	local bag_hyperpot = getItemQuantity("Hyper Potion")
	local cost_revive = (self.qnt_revive - bag_revive) * 1500
	local cost_hyperpot = (self.qnt_hyperpot - bag_hyperpot) * 1200
	return getMoney() > (cost_hyperpot + cost_revive)
end



function ExpForElite4Kanto:useZoneExp()
		if self.zoneExp == 1 then
			return moveToRectangle(46,15,47,21)
		elseif self.zoneExp == 2 then
			return moveToRectangle(33,16,37,18) 
		elseif self.zoneExp == 3 then
			return moveToRectangle(40,21,47,22) 
		elseif self.zoneExp == 4 then
			return moveToRectangle(28,19,32,21) 
		elseif self.zoneExp == 5 then
			return moveToRectangle(25,26,42,26) 
		elseif self.zoneExp == 6 then
			return moveToRectangle(23,27,36,28) 
		elseif self.zoneExp == 7 then
			return moveToRectangle(21,34,31,35) 
		elseif self.zoneExp == 8 then
			if getMapName() == "Victory Road Kanto 3F" then
				return moveToCell(29,17)
			else
				return moveToRectangle(16,9,29,9)
			end
		elseif self.zoneExp == 9 then
			if getMapName() == "Victory Road Kanto 3F" then
				return moveToCell(29,17)
			else
				return moveToRectangle(19,14,24,15)
			end
		elseif self.zoneExp == 10 then
			if getMapName() == "Victory Road Kanto 3F" then
				return moveToCell(29,17)
			else
				return moveToRectangle(12,17,16,19)
			end	
		elseif self.zoneExp == 11 then
			if getMapName() == "Victory Road Kanto 3F" then
				return moveToCell(29,17)
			else
				return moveToRectangle(13,27,28,29)
			end	
		elseif self.zoneExp == 12 then
			if getMapName() == "Victory Road Kanto 3F" then
				return moveToCell(29,17)
			else
				return moveToRectangle(18,24,29,25)
			end	
		elseif self.zoneExp == 13 then
			if getMapName() == "Victory Road Kanto 3F" then
				return moveToCell(29,17)
			else
				return moveToRectangle(21,19,27,22)
			end	
		elseif self.zoneExp == 14 then
			if getMapName() == "Victory Road Kanto 3F" then
				return moveToCell(29,17)
			else
				return moveToRectangle(28,19,44,21)
			end	
		elseif self.zoneExp == 15 then
			if getMapName() == "Victory Road Kanto 3F" then
				return moveToCell(29,17)
			else
				return moveToRectangle(40,23,58,23)
			end	
		else
		    return moveToRectangle(46,15,47,21)
		end
end

function ExpForElite4Kanto:buyReviveItems() --return false if all items are on the bag (32x Revives 32x HyperPotions)
	if getItemQuantity("Revive") < self.qnt_revive or getItemQuantity("Hyper Potion") < self.qnt_hyperpot then
		if not isShopOpen() then
			return talkToNpcOnCell(16,22)
		else
			if getItemQuantity("Revive") < self.qnt_revive then
				return buyItem("Revive", (self.qnt_revive - getItemQuantity("Revive")))
			end
			if getItemQuantity("Hyper Potion") < self.qnt_hyperpot then
				return buyItem("Hyper Potion", (self.qnt_hyperpot - getItemQuantity("Hyper Potion")))
			end
		end
	else
		return false
	end
end

function ExpForElite4Kanto:canBuyReviveItems()
	local bag_revive = getItemQuantity("Revive")
	local bag_hyperpot = getItemQuantity("Hyper Potion")
	local cost_revive = (self.qnt_revive - bag_revive) * 1500
	local cost_hyperpot = (self.qnt_hyperpot - bag_hyperpot) * 1200
	return getMoney() > (cost_hyperpot + cost_revive)
end

function ExpForElite4Kanto:Route22()
	if isNpcOnCell(10,8) then
		talkToNpcOnCell(10,8)
	elseif not isNpcOnCell(10,8) then
		return moveToCell(9,8)
	elseif getMoney() >= 55000 and not hasItem("Bicycle") then
		return moveToMap("Viridian City")
	elseif dialogs.leagueKantoNotDone.state and not hasItem("HM03 - Surf") then
		return moveToMap("Pokemon League Reception Gate")
	elseif hasItem("HM03 - Surf") and getTeamSize() <=5 then 
		return moveToMap("Viridian City") 
	elseif hasItem("HM03 - Surf") and game.minTeamLevel() <= 47 and game.maxTeamLevel() <= 96 then
		return moveToMap("Viridian City") 
	elseif hasItem("HM03 - Surf") and dialogs.leagueKantoNotDone.state then
		return moveToMap("Pokemon League Reception Gate")
	elseif not game.hasPokemonWithMove("Surf") and dialogs.e4Done.state then
		return moveToMap("Viridian City") 
	else 
		return moveToMap("Pokemon League Reception Gate")
	end
end

function ExpForElite4Kanto:ViridianCity()
	if getTeamSize() == 5 and dialogs.e4Done.state then
		return moveToMap("Route 1 Stop House")
	elseif dialogs.e4Done.state and not game.hasPokemonWithMove("Surf") then
		return moveToMap("Pokecenter Viridian")
	elseif self:needPokecenter()  then 
		return moveToMap("Pokecenter Viridian") 
	elseif hasItem("HM03 - Surf") and dialogs.e4Done.state then
		return moveToMap("Route 22")
	elseif getMoney() >= 55000 and not hasItem("Bicycle") and ( hasPokemonInTeam("Sentret") or hasPokemonInTeam("Furret") ) then
		return moveToMap("Route 2")
	elseif getMoney() >= 55000 and not hasItem("Bicycle") and getTeamSize() == 5 then
		return moveToMap("Route 1 Stop House")
	elseif getMoney() >= 55000 and not hasItem("Bicycle") and getTeamSize() == 6 and ( not hasPokemonInTeam("Sentret") or not hasPokemonInTeam("Furret") ) then
		return moveToMap("Pokecenter Viridian")
	elseif   dialogs.leagueKantoNotDone.state and not hasItem("HM03 - Surf")  then
		return moveToMap("Route 22") 
	elseif hasItem("HM03 - Surf") and getTeamSize() <=5 and game.maxTeamLevel() <= 96 then
		return moveToMap("Pokecenter Viridian")
	elseif hasItem("HM03 - Surf") and getTeamSize() ==6 and game.minTeamLevel() <= 47 and game.maxTeamLevel() <= 96 then
		return moveToMap("Pokecenter Viridian")
	else 
		return moveToMap("Route 22") 
	end
	
end

function ExpForElite4Kanto:Route1StopHouse()
	if getTeamSize() == 6 then
		return moveToMap("Viridian City")
	else
		return moveToMap("Route 1")
	end
end

function ExpForElite4Kanto:Route1()
	if getTeamSize() == 6 then 
		return moveToMap("Route 1 Stop House")
	elseif isNight() and getTeamSize() == 5  then 
		return relog(180,"It is night time, you need to wait morning to catch a sentret")
	else 
		return moveToRectangle(23,11,26,13) 
	end
end

function ExpForElite4Kanto:PokecenterViridian()
	if getMoney() >= 55000 and not hasItem("Bicycle") and getTeamSize() == 6 then
		if   ( getPokemonName(1) ~= "Sentret"   or  getPokemonName(1) ~= "Furret" ) and getTeamSize() == 6 then
			if isPCOpen() then
				if isCurrentPCBoxRefreshed() then
					if getTeamSize() == 6 then
						return depositPokemonToPC(1)
					end
				end
			else usePC() 
			end
		else 
			return moveToMap("Viridian City")
		end
	elseif hasItem("Bicycle") and getTeamSize() <= 5 then 
		if isPCOpen() then
			if isCurrentPCBoxRefreshed() then
				if getCurrentPCBoxSize() ~= 0 then
					for pokemon=1, getCurrentPCBoxSize() do
						if getPokemonLevelFromPC(getCurrentPCBoxId(), pokemon) > 47 then
						return withdrawPokemonFromPC(getCurrentPCBoxId(),pokemon) 	
						end
					end
					return openPCBox(getCurrentPCBoxId()+1)
				end
			else
				return
			end
		else
			return usePC()
		end
	elseif 	hasItem("Bicycle") and getTeamSize() == 6 and game.minTeamLevel() <= 47 and not dialogs.e4Done.state then
	
		if isPCOpen() then
			if isCurrentPCBoxRefreshed() then
				if getCurrentPCBoxSize() ~= 0 then
					for pokemon=1, getCurrentPCBoxSize() do
						if getPokemonLevelFromPC(getCurrentPCBoxId(), pokemon) > 47 then
						return swapPokemonFromPC(getCurrentPCBoxId(),pokemon,1) 	
						end
					end
					return openPCBox(getCurrentPCBoxId()+1)
				end
			else
				return
			end
		else
			return usePC()
		end
	elseif dialogs.e4Done.state and not game.hasPokemonWithMove("Surf") then
		if isPCOpen() then
			if isCurrentPCBoxRefreshed() then
				if getCurrentPCBoxSize() ~= 0 then
					for pokemon=1, getCurrentPCBoxSize() do
						if getPokemonNameFromPC(getCurrentPCBoxId(),pokemon) == "Sentret" then
							return swapPokemonFromPC(getCurrentPCBoxId(),pokemon,1) 
						elseif getPokemonNameFromPC(getCurrentPCBoxId(),pokemon) == "Furret" then
							return swapPokemonFromPC(getCurrentPCBoxId(),pokemon,1) 
					
						end
					end
					return openPCBox(getCurrentPCBoxId()+1)
				end
			else
				return
			end
		else
			return usePC()
		end
	else 
		return moveToMap("Viridian City")
	end
end

function ExpForElite4Kanto:PokemonLeagueReceptionGate()
	if isNpcOnCell(22,3) then
		return talkToNpcOnCell(22,3)
	elseif isNpcOnCell(22,23) and getTeamSize() == 6 then
		if dialogs.leagueKantoNotDone.state then
			return moveToMap("Victory Road Kanto 1F")
		else
			return talkToNpcOnCell(22,23)
		end
	elseif not isNpcOnCell(22,23) and hasItem("HM03 - Surf") and not game.hasPokemonWithMove("Surf")  then
		dialogs.e4Done.state = true
		return moveToMap("Route 22")
		
	elseif not isNpcOnCell(22,23) and hasItem("HM03 - Surf") and game.hasPokemonWithMove("Surf") then
		return moveToMap("Route 26") 
	else
		return moveToMap("Route 22")
	end
end

function ExpForElite4Kanto:VictoryRoadKanto1F()
	if   getTeamSize() <= 5 then 
		return moveToRectangle(36,36,42,41)
	elseif getTeamSize() == 6 then
		return moveToMap("Victory Road Kanto 2F")
	end
end

function ExpForElite4Kanto:VictoryRoadKanto2F()
	if self.registeredPokecenter_ ~= "Indigo Plateau Center" then 
		return moveToMap("Victory Road Kanto 3F")
	else 
		return self:useZoneExp()
	end
end

function ExpForElite4Kanto:VictoryRoadKanto3F()
	if isNpcOnCell(46,14) then --Moltres
		return talkToNpcOnCell(46,14)
	elseif  self.registeredPokecenter_ ~= "Indigo Plateau Center" then
			return moveToMap("Indigo Plateau")
	elseif  getTeamSize() <= 5 then
		return moveToRectangle(45,15,47,21)
	elseif  ( hasPokemonInTeam("Zubat") or hasPokemonInTeam("Golbat") ) and getTeamSize() ==6 then
			return self:useZoneExp()
	else
			return moveToMap("Indigo Plateau")
	end
	
end

function ExpForElite4Kanto:IndigoPlateau()
		if self:needPokecenter() or self.registeredPokecenter_ ~= "Indigo Plateau Center" then
			return moveToMap("Indigo Plateau Center")
		elseif ( hasPokemonInTeam("Zubat") or hasPokemonInTeam("Golbat") ) and getTeamSize() ==6 then
			self.zoneExp = math.random(1,15)
			return moveToMap("Victory Road Kanto 3F") 
		elseif getTeamSize() ==1 then
			return moveToMap("Victory Road Kanto 3F") 
		else
			return moveToMap("Indigo Plateau Center")
		end
end

function ExpForElite4Kanto:IndigoPlateauCenter()
	
		if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter_ ~= "Indigo Plateau Center" then
			self.registeredPokecenter_ = getMapName()
			return talkToNpcOnCell(4,22)
		elseif getTeamSize() >= 1 and game.minTeamLevel() <= 39 then
			if isPCOpen() then
				depositPokemonToPC(2)
			else
				return usePC()
			end
		elseif getTeamSize() ==1 then
			return moveToMap("Indigo Plateau") 
		elseif ( hasPokemonInTeam("Zubat") or hasPokemonInTeam("Golbat") ) and getTeamSize() ==6 then
			return moveToMap("Indigo Plateau") 
		elseif self:buyReviveItems() ~= false then
			return 
		elseif dialogs.readyE4.state then
			return talkToNpcOnCell(13,23)
		else
			return moveToCell(10,3) --Start E4
		end
end

function ExpForElite4Kanto:MapName()
	
end

return ExpForElite4Kanto