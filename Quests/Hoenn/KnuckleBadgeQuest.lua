-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest4"
local Dialog = require "Quests/Dialog"

local name        = 'Knuckle Badge'
local description = 'Will meet Steven, earn 2nd badge and get back to Devon corp '

local level       = 28
local clock = os.clock





local KnuckleBadgeQuest  = Quest:new()

local dialogs = {
	Steven = Dialog:new({ 
		"Steven",
	}),
	
}

function KnuckleBadgeQuest:new()
	return Quest.new(KnuckleBadgeQuest , name, description, level, dialogs)
end


function KnuckleBadgeQuest:isDoable()
	if hasItem("Stone Badge") and self:hasMap() and not hasItem("Devon Goods") and not hasItem("Dynamo Badge") then
	return true
	end
	return false
end

function KnuckleBadgeQuest:isDone()
		return hasItem("Knuckle Badge") and  hasItem("Devon Goods")
end 




function KnuckleBadgeQuest:PetalburgWoods()
	if not hasItem("Knuckle Badge") then
	moveToCell(24,60)
	else moveToCell(22,0)
	end
end

function KnuckleBadgeQuest:Route104()
	if game.inRectangle(7,0,41,67) then 
		if hasItem("Knuckle Badge") then 
		moveToMap("Rustboro City")
		else moveToMap("Petalburg Woods")
		end
	elseif not hasItem("Knuckle Badge") then
	moveToMap("Route 104 Sailor House") 
	elseif isNpcOnCell(60,42) and hasItem("Knuckle Badge") then 
		moveToCell(36,79)
		
end
end
function KnuckleBadgeQuest:Route104SailorHouse()
	if isNpcOnCell(8,7) then 
		talkToNpcOnCell(8,7)
	elseif isNpcOnCell(8,6) then 
		talkToNpcOnCell(8,6)
	elseif isNpcOnCell(8,5) then 
		talkToNpcOnCell(8,5)
	elseif isNpcOnCell(9,5) then 
		talkToNpcOnCell(9,5)
	elseif isNpcOnCell(10,5) then 
		talkToNpcOnCell(10,5)
	elseif isNpcOnCell(11,5) then 
		talkToNpcOnCell(11,5)
	elseif isNpcOnCell(11,6) then 
		talkToNpcOnCell(11,6)
	elseif isNpcOnCell(11,7) then 
		talkToNpcOnCell(11,7)
	elseif isNpcOnCell(11,6) then 
		talkToNpcOnCell(11,6)
	elseif isNpcOnCell(11,7) then 
		talkToNpcOnCell(11,7)
	elseif isNpcOnCell(11,8) then 
		talkToNpcOnCell(11,8)
	elseif isNpcOnCell(10,8) then 
		talkToNpcOnCell(10,8)
	elseif isNpcOnCell(9,8) then 
		talkToNpcOnCell(9,8)
	elseif isNpcOnCell(8,8) then 
		talkToNpcOnCell(8,8)
	end
end

function KnuckleBadgeQuest:PokecenterDewfordTown()
	return self:pokecenter("Dewford Town")
end


function KnuckleBadgeQuest:DewfordTown()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Dewford Town" then
		return moveToMap("Pokecenter Dewford Town")
	elseif hasItem("SLetter") then 
		moveToMap("Route 106")
	elseif not self:isTrainingOver() then
		moveToMap("Route 106")
	elseif not hasItem("Knuckle Badge") then
		if isNpcOnCell(22,23)then 
			talkToNpcOnCell(22,23)
		else moveToMap("Dewford Town Gym")
		end
	else talkToNpcOnCell(37,9)

end
end

function KnuckleBadgeQuest:GraniteCave1F()
	if (game.inRectangle(35,5,41,7) or game.inRectangle(10,5,39,6) or game.inRectangle(5,6,11,12) or game.inRectangle(7,13,7,13)) and hasItem("SLetter") then 
		moveToCell(7,13)
	elseif (game.inRectangle(35,5,41,7) or game.inRectangle(10,5,39,6) or game.inRectangle(5,6,11,12) or game.inRectangle(7,13,7,13)) and not hasItem("SLetter") then 
		moveToCell(38,6)
	elseif self:needPokecenter() then
		moveToMap("Route 106")
	elseif hasItem("SLetter") then 
		moveToCell(17,13)
	elseif not self:isTrainingOver() then 
		moveToRectangle(22,8,29,9)
	else moveToMap("Route 106")
	end
end

function KnuckleBadgeQuest:GraniteCaveB1F()
	if game.inRectangle(27,14,32,17) and hasItem("SLetter") then 
		moveToCell(28,15)
	elseif game.inRectangle(27,14,32,17) and not hasItem("SLetter") then 
		moveToCell(31,15)
	elseif hasItem("SLetter") then 
		moveToCell(30,24)
	else moveToCell(5,23)
	end
end

function KnuckleBadgeQuest:GraniteCave1F2()
	if isNpcVisible("Steven") then 
		talkToNpc("Steven")
	else moveToMap("Granite Cave 1F")
	end
end

function KnuckleBadgeQuest:GraniteCaveB2F()
	if hasItem("SLetter") then 
		moveToCell(30,18)
	else moveToCell(29,26)
	end
end

function KnuckleBadgeQuest:DewfordTownGym()
	if not hasItem("Knuckle Badge") then 
		talkToNpcOnCell(16,12)
	else moveToMap("Dewford Town")
	end
end

function KnuckleBadgeQuest:Route106()
	if self:needPokecenter() then
		moveToMap("Dewford Town")
	elseif hasItem("SLetter") or not self:isTrainingOver()then 
		moveToMap("Granite Cave 1F")
	else moveToMap("Dewford Town")
	end
end

function KnuckleBadgeQuest:PokecenterRustboroCity()
	return self:pokecenter("Rustboro City")
end

function KnuckleBadgeQuest:RustboroCityGym()
	moveToMap("Rustbor City")
end	


function KnuckleBadgeQuest:DevonCorporation1F()
	if not dialogs.Steven.state then
		moveToMap("Devon Corporation 2F")
	else moveToMap("Rustboro City")
end
end

function KnuckleBadgeQuest:DevonCorporation2F()
	if not dialogs.Steven.state then
		moveToMap("Devon Corporation 3F")
	else moveToMap("Devon Corporation 1F")
end
end

function KnuckleBadgeQuest:RustboroCity()
	moveToMap("Devon Corporation 1F")
end


function KnuckleBadgeQuest:DevonCorporation3F()
	if not dialogs.Steven.state then
		talkToNpc("Mr. Stone")
	else moveToMap("Devon Corporation 2F")
end
end

return KnuckleBadgeQuest 
