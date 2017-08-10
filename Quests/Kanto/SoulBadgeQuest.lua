-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"


local name		  = 'Sould Badge'
local description = 'Get Hm surf then go back to vermilion city'
local level = 48

local dialogs = {
	questSurfAccept = Dialog:new({ 
		"There is something there I want you to take",
		"Did you get the HM broseph"
	})
}

local SoulBadgeQuest = Quest:new()

function SoulBadgeQuest:new()
	local o = Quest.new(SoulBadgeQuest, name, description, level, dialogs)
	o.zoneExp = 1
	o.pokemonId = 1
	return o
end

function SoulBadgeQuest:isDoable()	
	if self:hasMap() and not hasItem("Marsh Badge") and not hasItem("RainBow Badge") then
			return true
	
	end
	return false
end

function SoulBadgeQuest:isDone()
	if ( hasItem("RainBow Badge") and getMapName() == "Saffron City") or getMapName() == "Safari Entrance" or getMapName() == "Route 20" or getMapName() == "Vermilion City" or getMapName() == "Route 7" then
		return true
	else
		return false
	end
end

function SoulBadgeQuest:pokemart_()
	local pokeballCount = getItemQuantity("Pokeball")
	local money         = getMoney()
	if money >= 200 and pokeballCount < 50 then
		if not isShopOpen() then
			return talkToNpcOnCell(9,8)
		else
			local pokeballToBuy = 50 - pokeballCount
			local maximumBuyablePokeballs = money / 200
			if maximumBuyablePokeballs < pokeballToBuy then
				pokeballToBuy = maximumBuyablePokeballs
			end
				return buyItem("Pokeball", pokeballToBuy)
		end
	else
		return moveToMap("Fuchsia City")
	end
end

function SoulBadgeQuest:needPokemart_()
	if getItemQuantity("Pokeball") < 30 and getMoney() >= 200 then
		return true
	end
	return false
end

function SoulBadgeQuest:canEnterSafari()
	return getMoney() > 5000	
end

function SoulBadgeQuest:randomZoneExp()
	if self.zoneExp == 1 then
		if game.inRectangle(51,18,55,22) then--Zone 1
			return moveToGrass()
		else
			return moveToCell(53,20)
		end
	elseif self.zoneExp == 2 then
		if game.inRectangle(65,29,70,31) then--Zone 2
			return moveToGrass()
		else
			return moveToCell(68,30)
		end
	elseif self.zoneExp == 3 then
		if game.inRectangle(62,14,66,15) then--Zone 3
			return moveToGrass()
		else
			return moveToCell(64,14)
		end
	else
		if game.inRectangle(89,14,91,18) then--Zone 4
			return moveToGrass()
		else
			return moveToCell(90,16)
		end
	end
end

function SoulBadgeQuest:PokecenterFuchsia()
	if self:needPokecenter() or not game.isTeamFullyHealed() then
			return talkToNpcOnCell(9,15)
	elseif not hasPokemonInTeam("Ditto") and getTeamSize() == 6 and getMoney() >= 50000 then
			if isPCOpen() then
				depositPokemonToPC(2)
			else
				return usePC()
			end
	else
		return self:pokecenter("Fuchsia City")
	end
end

function SoulBadgeQuest:Route18()
		return moveToGrass()
end


function SoulBadgeQuest:SaffronCity()
	if hasItem("Bike Voucher") then
		return moveToMap("Route 5 Stop House")
	elseif hasItem("Bicycle") or hasItem("Yellow Bicycle") or hasItem("Blue Bicycle") or hasItem("Green Bicycle") then 
		return moveToMap("Route 7 Stop House")
	elseif not hasPokemonInTeam("Ditto") then
		return moveToMap("Route 8 Stop House")
	else
		return moveToMap("Route 6 Stop House")
	end
end

function SoulBadgeQuest:Route7StopHouse()
	return moveToMap("Route 7")
end

function SoulBadgeQuest:Route5StopHouse()
	if hasItem("Bike Voucher") then
		return moveToMap("Route 5")
	else  
		return moveToMap("Saffron City")
	end
end

function SoulBadgeQuest:Route5()
	if hasItem("Bike Voucher") then
		return moveToMap("Cerulean City")
	else  
		return moveToMap("Route 5 Stop House")
	end
end

function SoulBadgeQuest:CeruleanCity()
	if hasItem("Bike Voucher") then
		if getMoney() <= 60000 then
			return moveToMap("Route 24")
		else
			return moveToCell(15,38)
		end
	else  
		return moveToMap("Route 5")
	end
end

function SoulBadgeQuest:Route24()
	if getMoney() <= 60000 then
		return moveToMap("Route 25")
	else
		return moveToMap("Cerulean City")
	end
end

function SoulBadgeQuest:Route25()
	if hasItem("Nugget") and getMoney() <= 60000 then
		return moveToMap("Item Maniac House")
	elseif getMoney() >= 60000 then
		return moveToMap("Route 24")
	else
		fatal("You don't have enough money to buy Bike")
	end
end

function SoulBadgeQuest:ItemManiacHouse() -- sell nugget
	if hasItem("Nugget") then
		return talkToNpcOnCell(6, 5)
	else
		return moveToMap("Route 25")
	end
end

function SoulBadgeQuest:CeruleanCityBikeShop()
	if hasItem("Bike Voucher") then
		if BIKE_COLOR_ID == 1 then
			pushDialogAnswer(1)
			pushDialogAnswer(1)
			return talkToNpcOnCell(11,7)
		elseif BIKE_COLOR_ID == 2 then
			pushDialogAnswer(1)
			pushDialogAnswer(2)
			return talkToNpcOnCell(11,7)
		elseif BIKE_COLOR_ID == 3 then
			pushDialogAnswer(1)
			pushDialogAnswer(3)
			return talkToNpcOnCell(11,7)
		elseif BIKE_COLOR_ID == 4 then
			pushDialogAnswer(1)
			pushDialogAnswer(4)
			return talkToNpcOnCell(11,7)
		end
	else  
		return moveToMap("Cerulean City")
	end
end


function SoulBadgeQuest:Route8StopHouse()
	if not hasPokemonInTeam("Ditto") then
		return moveToMap("Route 8")
	else
		return moveToMap("Saffron City")
	end
end

function SoulBadgeQuest:Route8()
	if not hasPokemonInTeam("Ditto") then
		return moveToGrass()
	else
		return moveToMap("Route 8 Stop House")
	end
end

function SoulBadgeQuest:Route6StopHouse()
	if hasItem("Bike Voucher") then
		return moveToMap("Saffron City")
	else 
		return moveToMap("Route 6")
	end
end



function SoulBadgeQuest:Route6()
	if hasItem("Bike Voucher") then
		return moveToMap("Route 6 Stop House")
	else 
		return moveToMap("Vermilion City")
	end
end
function SoulBadgeQuest:FuchsiaCity()
	if self:needPokemart_() and not hasItem("HM03 - Surf") then --It buy balls if not have badge, at blackoutleveling no
		return moveToMap("Safari Stop")
	elseif  self.registeredPokecenter ~= "Pokecenter Fuchsia" or not game.isTeamFullyHealed()  then
		return moveToMap("Pokecenter Fuchsia")
	elseif not self:isTrainingOver() then
		return moveToMap("Route 15 Stop House")
	elseif getMoney() <= 5000 and not hasItem("HM03 - Surf") then
		return moveToMap("Route 18")
	elseif not hasItem("HM03 - Surf") then
		if not dialogs.questSurfAccept.state then
			return moveToMap("Fuchsia City Stop House")
		else
			return moveToMap("Safari Stop")
		end
	elseif not hasItem("Soul Badge") and getMoney() >= 55000 then 
		return moveToMap("Fuchsia Gym")
	elseif hasItem("Soul Badge") and getMoney() >= 55000 then
		return moveToMap("Route 15 Stop House")
	else
		return moveToMap("Fuchsia City Stop House")
	end
end


function SoulBadgeQuest:SafariStop()
	if self:needPokemart_() then
		self:pokemart_()
	elseif  dialogs.questSurfAccept.state then
		if not hasItem("HM03 - Surf") and self:canEnterSafari() then
			return talkToNpcOnCell(7,4)
		else
			return moveToMap("Fuchsia City")
		end
	else
		return moveToMap("Fuchsia City")
	end
end

function SoulBadgeQuest:Route15StopHouse()
	if not self:isTrainingOver() then
		return moveToMap("Route 15")
	elseif getMoney() >= 55000 then
		return moveToMap("Route 15")
	else 
		return moveToMap("Fuchsia City")
	end
end

function SoulBadgeQuest:FuchsiaCityStopHouse()
	if not hasItem("HM03 - Surf") then
		if dialogs.questSurfAccept.state then
			return moveToMap("Fuchsia City")
		else
			return moveToMap("Route 19")
		end
	else
		return moveToMap("Route 19")
	end
end

function SoulBadgeQuest:Route17()
	return moveToMap("Route 16")
end
function SoulBadgeQuest:Route16()
	return  moveToCell(90,19) or moveToCell(64,13) 
end
function SoulBadgeQuest:Route16StopHouse()
	return moveToCell(20,6)
end

function SoulBadgeQuest:Route19()
	if not hasItem("HM03 - Surf") then
		if dialogs.questSurfAccept.state then
			return moveToMap("Fuchsia City Stop House")
		else
			return talkToNpcOnCell(33,19)
		end
	elseif hasItem("HM03 - Surf") and not game.hasPokemonWithMove("Surf") and getTeamSize() >= 3 then
		if not game.hasPokemonWithMove("Surf") then
			if self.pokemonId < getTeamSize() then					
				useItemOnPokemon("HM03 - Surf", self.pokemonId)
				log("Pokemon: " .. self.pokemonId .. " Try Learning: HM03 - Surf")
				self.pokemonId = self.pokemonId + 1
				return
			else
				return useItemOnPokemon("HM03 - Surf", 2)
			end
		end 
	else
		return moveToMap("Route 20")
	end
end

function SoulBadgeQuest:Route14()
	return moveToMap("Route 13")
end

function SoulBadgeQuest:Route13()
	return moveToMap("Route 12")
end

function SoulBadgeQuest:Route12()
	return moveToMap("Lavender Town")
end

function SoulBadgeQuest:LavenderTown()
	return moveToMap("Route 8")
end


function SoulBadgeQuest:Route15()
	if not self:isTrainingOver() then
		return moveToGrass()
	elseif getMoney() >= 55000 then
		return moveToMap("Route 14")
	else
		return moveToMap("Route 15 Stop House")
	end
end

function SoulBadgeQuest:FuchsiaGym()
	if not hasItem("Soul Badge") then
		if game.inRectangle(6,16,7,16) then -- Antistuck NearLinkExitCell (7,16) Pathfind Return move on this cell
			return moveToCell(6,15)
		else
			return talkToNpcOnCell(7,10)
		end
	else
		return moveToMap("Fuchsia City")
	end
end

return SoulBadgeQuest