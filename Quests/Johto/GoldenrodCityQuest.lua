-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
--local pc     = require "Libs/pclib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest2"
local Dialog = require "Quests/Dialog"

local name		  = 'Goldenrod City'
local description = " Complete Guard's Quest"
local level = 35



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
			return true
	end
	return false
end

function GoldenrodCityQuest:isDone()
	if getMapName() == "Goldenrod City Gym" and not hasItem("Plain Badge") then
		return true
	end
	return false
	
end



function GoldenrodCityQuest:PokecenterGoldenrod()
		self:pokecenter("Goldenrod City")
end

function GoldenrodCityQuest:GoldenrodCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Goldenrod" then
		return moveToMap("Pokecenter Goldenrod")
	elseif hasItem("Bike Voucher") then
		return moveToMap("Goldenrod City Bike Shop")
	elseif not self:isTrainingOver() then
		return moveToMap("Route 34")
	else 
		return moveToMap("Goldenrod City Gym")
	end
end

function GoldenrodCityQuest:GoldenrodCityBikeShop()
	if hasItem("Bike Voucher") then
		return talkToNpcOnCell(11,3)
	else
		return moveToMap("Goldenrod City")
	end
end



function GoldenrodCityQuest:Route34()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Goldenrod" then
		return moveToMap("Goldenrod City")
	elseif not self:isTrainingOver() then
		return moveToGrass()
	else
		return moveToMap("Goldenrod City")
	end
end

function GoldenrodCityQuest:Route34StopHouse()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Goldenrod" then
		return moveToMap("Route 34")
	else
		return moveToMap("Route 34")
	end
end





function GoldenrodCityQuest:MapName()
	
end

function GoldenrodCityQuest:MapName()
	
end

function GoldenrodCityQuest:MapName()
	
end

return GoldenrodCityQuest
