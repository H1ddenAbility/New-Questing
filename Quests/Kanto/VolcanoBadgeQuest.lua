-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'Volcano Badge'
local description = 'Revive Fossil + Cinnabar Key + Exp on Seafoam B4F'
local level = 3

local VolcanoBadgeQuest = Quest:new()

function VolcanoBadgeQuest:new()
	return Quest.new(VolcanoBadgeQuest, name, description, level)
end

function VolcanoBadgeQuest:isDoable()
	if self:hasMap()  then
		return true
	end
	return false
end

function VolcanoBadgeQuest:isDone()
	if getMapName() == "Cinnabar Lab" or getMapName() == "Cinnabar mansion 1" or getMapName() == "Route 21" then
		return true
	end
	return false
end


function VolcanoBadgeQuest:randomZoneExp()
	if self.zoneExp == 1 then
			return moveToRectangle(7,38,37,38)
		
	elseif self.zoneExp == 2 then
			return moveToRectangle(24,34,51,34)
		
	elseif self.zoneExp == 3 then
			return moveToRectangle(68,34,72,39)
		
	elseif	self.zoneExp == 4 then
			return moveToRectangle(37,19,49,24)
	elseif	self.zoneExp == 5 then
			return moveToRectangle(9,21,19,25)	
	else	
			return moveToRectangle(23,29,42,32)
	end
end




function VolcanoBadgeQuest:VulcanicTown()
		
	if not self.registeredPokecenter == "Pokecenter Vulcanic Town"
		
	then
		return moveToMap("Pokecenter Vulcanic Town")
	elseif getItemQuantity("Pokeball") < 50 and getMoney() >= 200 then
		return moveToMap("Pokemart Vulcanic Town")
	else
		return moveToMap("Kalijodo Path")
	end
end

function VolcanoBadgeQuest:VulcanicTownHouse1()
 return moveToMap("Vulcanic Town")
 end

function VolcanoBadgeQuest:PokecenterVulcanicTown()
	if not game.isTeamFullyHealed() then 
	return talkToNpcOnCell(8,14)
	else
	return moveToMap("Vulcanic Town")
	end
end

function VolcanoBadgeQuest:PokemartVulcanicTown()
if getMoney() >= 200 and  getItemQuantity("pokeball") <= 49 then
		if not isShopOpen() then
			return talkToNpcOnCell(3,4) 
		else
			return buyItem("Pokeball", 30)
		end
	else
		return moveToMap("Vulcanic Town")
	end
end



function VolcanoBadgeQuest:KalijodoPath()
	self.zoneExp = math.random(1,5)
		return moveToMap("Kalijodo Lake")
end
	

function VolcanoBadgeQuest:KalijodoLake()
	return self:randomZoneExp()
end


return VolcanoBadgeQuest
