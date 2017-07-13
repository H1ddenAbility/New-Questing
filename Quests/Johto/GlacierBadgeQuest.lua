-- Copyright � 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPaPa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'Glacier Badge Quest'
local description = 'Will exp to the lv 65, clear the Rocket Hideout, and earn the 7th Badge'
local level = 49
local N = 1
local lance = false
local computerone = false
local admin = false
local pcJames = false
local pcJessie = false
local chappy = false

local GlacierBadgeQuest = Quest:new()
local dialogs = {
	fdp = Dialog:new({ 
		"Rats, no sign of any picture with Christina on this desk!"
		
		
	}),
	marchefdp = Dialog:new({ 
		"I don't have anything to do with this now...",
		"Yes, this was the computer!"
		
	})

}
function GlacierBadgeQuest:new()
	return Quest.new(GlacierBadgeQuest, name, description, level, dialogs)
end


function GlacierBadgeQuest:isDoable()
	if self:hasMap() and not hasItem("Glacier Badge") and hasItem("Mineral Badge") then
		return true
	end
	return false
end

function GlacierBadgeQuest:isDone()
	if hasItem("Glacier Badge") and getMapName() == "Mahogany Town Gym" then
		return true
	else
		return false
	end
end

function GlacierBadgeQuest:OlivineCityGym()
	moveToMap("Olivine City")
end

function GlacierBadgeQuest:OlivineCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Olivine City" then
		moveToMap("Olivine Pokecenter")
	else moveToMap("Route 39")
	end
end

function GlacierBadgeQuest:OlivinePokecenter()
	self:pokecenter("Olivine City")
end

function GlacierBadgeQuest:Route39()
	moveToMap("Route 38")
end

function GlacierBadgeQuest:Route38()
	moveToMap("Ecruteak Stop House 1")
end

function GlacierBadgeQuest:EcruteakStopHouse1()
	moveToMap("Ecruteak City")
end


function GlacierBadgeQuest:EcruteakCity()
	moveToMap("Ecruteak Stop House 2")
end


function GlacierBadgeQuest:EcruteakStopHouse2()
	moveToMap("Route 42")
end

function GlacierBadgeQuest:Route42()
	if game.inRectangle(4,20,18,14) then 
		moveToCell(17,13)
	elseif game.inRectangle(66,14,94,18) then
		moveToMap("Mahogany Town")
	end
end

function GlacierBadgeQuest:MtMortar1F()
	if game.inRectangle(21,45,34,36) then 
		moveToCell(34,35)
	elseif game.inRectangle(53,36,66,45) then 
		moveToCell(65,46)
	end
end

function GlacierBadgeQuest:MtMortarLowerCave()
	return moveToCell(47,57)
end

function GlacierBadgeQuest:MahoganyTown()
	if self:needPokecenter() or not game.isTeamFullyHealed() or not self.registeredPokecenter == "Pokecenter Mahogany Town" then
		moveToMap("Pokecenter Mahogany")
	elseif not isNpcOnCell(11,24) then
		moveToMap("Mahogany Town Gym")
	elseif not chappy then
		moveToMap("Route 43")
	elseif chappy then 
		moveToMap("Mahogany Town Shop")
	end
end

function GlacierBadgeQuest:Route43()
	if not chappy then 
		moveToMap("Lake of Rage")
	else moveToMap("Mahogany Town")
	end
end

function GlacierBadgeQuest:LakeofRage()
	if isNpcOnCell(50,28) then 
		talkToNpcOnCell(50,28)
	else moveToMap("Route 43")
		chappy = true
		return
	end
end

function GlacierBadgeQuest:MahoganyTownShop()
	moveToMap("Mahogany Town Rocket Hideout B1F")
end

function GlacierBadgeQuest:MahoganyTownRocketHideoutB1F()
	moveToCell(4,24)
end

function GlacierBadgeQuest:MahoganyTownRocketHideoutB2F()
	if game.inRectangle(3,30,48,23) and not lance then 
		if isNpcOnCell(24,22) then
			if not game.inRectangle(24,23,24,23) then
			moveToCell(24,23,24,23)
			else
			talkToNpcOnCell(24,22) 
			lance = true
			return
			end
		else 
			moveToCell(24,22)
		end
	elseif game.inRectangle(3,30,48,23) and not isNpcOnCell(24,22) then
		moveToCell(24,22)
	elseif game.inRectangle(3,30,48,23) then
		moveToCell(49,30)
	elseif game.inRectangle(14,22,26,9) then
		if isNpcOnCell(15,12) then
			talkToNpcOnCell(15,12)
		elseif isNpcOnCell(15,13) then
			talkToNpcOnCell(15,13) 
		elseif isNpcOnCell(15,14) then
			talkToNpcOnCell(15,14)
		else talkToNpcOnCell(24,22)
		end
	elseif game.inRectangle(3,3,48,5) or game.inRectangle(46,6,40,19) then 
		if not admin and not pcJessie then
			if not game.inRectangle(40,18,40,18) then
				moveToCell(40,18)
			else
			talkToNpcOnCell(40,17)
			pcJessie = true
			return
			end
		elseif admin then 
			moveToCell(49,5)
		else moveToCell(2,5)
		end
	elseif game.inRectangle(3,9,9,19) then
		if not admin and not pcJames then
			if not game.inRectangle(5,18,5,18) then
				return moveToCell(5,18)
			else
		    talkToNpcOnCell(5,17)
			pcJames = true	
			return
			end
		else moveToCell(2,10)
		end
	end
end


function GlacierBadgeQuest:MahoganyTownRocketHideoutB3F()
	if game.inRectangle(48,4,26,30) then
		if dialogs.fdp.state then
			dialogs.fdp.state = false
			N = N + 1
			return
		elseif dialogs.marchefdp.state then
			if not admin then
			moveToCell(49,5)
			else moveToCell(49,30)
			end
		elseif N == 1 then
				if not game.inRectangle(40,19,40,19) then
					moveToCell(40,19)
				else
				talkToNpcOnCell(40,18)
				return
				end
		elseif N == 2 then
				if not game.inRectangle(37,19,37,19) then
					moveToCell(37,19)
				else
				talkToNpcOnCell(37,18)
				
				return
				end
		elseif  N == 3 then
				if not game.inRectangle(34,19,34,19) then
					moveToCell(34,19)
				else
				talkToNpcOnCell(34,18)
				
				return
				end
		elseif  N == 4 then
				if not game.inRectangle(31,19,31,19) then
					moveToCell(31,19)
				else
				talkToNpcOnCell(31,18)
				
				return
				end
		elseif N == 5 then
				if not game.inRectangle(40,15,40,15) then
					moveToCell(40,15)
				else
				talkToNpcOnCell(40,14)
				
				return
				end
		elseif N == 6 then
				if not game.inRectangle(37,15,37,15) then
					moveToCell(37,15)
				else
				talkToNpcOnCell(37,14)
			
				return
				end
		elseif N == 7 then
				if not game.inRectangle(34,15,34,15) then
					moveToCell(34,15)
				else
				talkToNpcOnCell(34,14)
			
				return
				end
		elseif N == 8 then
				if not game.inRectangle(31,15,31,15) then
					moveToCell(31,15)
					else
				talkToNpcOnCell(31,14)
				
				return
				end
			
		elseif not admin then
			moveToCell(49,5)
		else moveToCell(49,30)
		end
	elseif game.inRectangle(3,4,23,19) then
		if isNpcOnCell(18,15) then 
			moveToCell(2,10)
		elseif isNpcOnCell(18,9) and  not admin then
			talkToNpcOnCell(18,9)
		elseif not admin then
			if not game.inRectangle(16,7,16,7)then
				moveToCell(16,7)
			else	
			talkToNpcOnCell(16,6)
			admin = true
			return
			end
		else moveToCell(2,5)
		end
	end
end



function GlacierBadgeQuest:PokecenterMahogany()
	if isNpcOnCell(9,22) then
		talkToNpcOnCell(9,22)
	else return self:pokecenter("Mahogany Town")
	end
end

function GlacierBadgeQuest:MahoganyTownGym()
	if game.inRectangle(15,66,21,50) then 
		moveToCell(17,49)
	elseif game.inRectangle(12,33,18,45) then  
		moveToCell(17,32)
	elseif game.inRectangle(13,28,20,12) then 
		talkToNpcOnCell(19,12)
	end
end

function GlacierBadgeQuest:MapName()
	
end

function GlacierBadgeQuest:MapName()
	
end

function GlacierBadgeQuest:MapName()
	
end

function GlacierBadgeQuest:MapName()
	
end


return GlacierBadgeQuest