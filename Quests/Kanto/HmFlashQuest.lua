-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name        = 'Quest: HM05 - Flash '
local description = 'Go to fuchsia'

local HmFlashQuest = Quest:new()

function HmFlashQuest:new()
	return Quest.new(HmFlashQuest, name, description, 1)
end

function HmFlashQuest:isDoable()
	if self:hasMap() and not hasItem("Rainbow Badge") then
		return true
	end
	return false
end

function HmFlashQuest:isDone()
	if getMapName() == "Route 7" then
		return true
	else
		return false
	end
end

function HmFlashQuest:Route11()
	if isNpcOnCell(10, 13) then -- NPC Block Diglet's Entrance
		return talkToNpcOnCell(10, 13) 
	else
		return moveToMap("Vermilion City")
	end
end

function HmFlashQuest:DiglettsCaveEntrance2()
		return moveToMap("Route 11")
end

function HmFlashQuest:DiglettsCaveEntrance1()
		return moveToMap("Digletts Cave")
end

function HmFlashQuest:DiglettsCave()
	
		return moveToMap("Digletts Cave Entrance 2")
end

function HmFlashQuest:PokecenterVermilion() -- BlackOut FIX
	return moveToMap("Vermilion City")
end

function HmFlashQuest:VermilionCity()
		return moveToMap("Route 6")
end

function HmFlashQuest:Route6()
		return moveToMap("Route 6 Stop House")
end

function HmFlashQuest:Route6StopHouse()
return moveToMap("Saffron City")
end

function HmFlashQuest:SaffronCity()
	if hasItem("Bike Voucher") then
		moveToMap("Route 5 Stop House")
	else
		return moveToMap("Route 7 Stop House")
	end
end

function HmFlashQuest:Route5StopHouse()
	if hasItem("Bike Voucher") then
		moveToMap("Route 5")
	else
		return moveToMap("Saffron City")
	end
end

function HmFlashQuest:Route5()
	if hasItem("Bike Voucher") then
		moveToMap("Cerulean City")
	else
		return moveToMap("Route 5 Stop House")
	end
end

function HmFlashQuest:CeruleanCity()
	if hasItem("Bike Voucher") then
		moveToMap("Cerulean City Bike Shop")
	else
		return moveToMap("Route 5")
	end
end

function HmFlashQuest:CeruleanCityBikeShop()
	if hasItem("Bike Voucher") then
		talkToNpcOnCell(11,7)
	else
		return moveToMap("Cerulean City")
	end
end

function HmFlashQuest:Route7StopHouse()
	return moveToMap("Route 7")
end

function HmFlashQuest:PokecenterCerulean()
	return moveToMap("Cerulean City")
end


return HmFlashQuest




