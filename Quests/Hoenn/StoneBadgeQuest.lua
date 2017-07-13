-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest4"
local Dialog = require "Quests/Dialog"

local name        = 'StoneBadgeQuestQuest'
local description = 'Will get the 1st badge'

local level       = 11
local clock = os.clock





local StoneBadgeQuest = Quest:new()

local dialogs = {
	magmaCheck = Dialog:new({ 
		"you deal with him"
	}),
	
}

function StoneBadgeQuest:new()
	return Quest.new(StoneBadgeQuest, name, description, level, dialogs)
end


function StoneBadgeQuest:isDoable()
	if not hasItem("Stone Badge")   and self:hasMap() then
		return true
	end
	return false
end

function StoneBadgeQuest:isDone()
	 if (hasItem("Stone Badge") and getMapName() == "Rustboro City Gym") or getMapName() == "Pokecenter Petalburg City" then 
			return true 
		else 
			return false
	end
end


function StoneBadgeQuest:PetalburgWoods()
	if isNpcOnCell(38,30) then 
		talkToNpcOnCell(38,30)
	elseif isNpcOnCell(36,30) then 
		if not dialogs.magmaCheck.state then
			talkToNpcOnCell(36,30)
		else
			return relog(5,"relog")
		end
	elseif isNpcOnCell(37,29) then
		talkToNpcOnCell(37,29)
	else moveToCell(22,0)
	end
end

function StoneBadgeQuest:RustboroCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Rustboro City" then
		moveToMap("Pokecenter Rustboro City")
	elseif not self:isTrainingOver() then 
		return moveToMap("Route 104")
	elseif self:isTrainingOver() and not hasItem("Stone Badge") then
		moveToMap("Rustboro City Gym")
	end
end

function StoneBadgeQuest:Route104()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Rustboro City" then
		moveToCell(40,0)
	elseif not self:isTrainingOver() then
		moveToGrass()
	else moveToCell(40,0)
	end
end	

function StoneBadgeQuest:PokecenterRustboroCity()
	return self:pokecenter("Rustboro City")
end

function StoneBadgeQuest:RustboroCityGym()
	if self:needPokecenter() or self.registeredPokecenter ~= "Pokecenter Rustboro City" then
		return moveToMap("Rustboro City")
	elseif not hasItem("Stone Badge") then 
		talkToNpcOnCell(10,3)
	end
end	

return StoneBadgeQuest
