-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest4"
local Dialog = require "Quests/Dialog"

local name		  = 'Dynamo Badge'
local description = 'Will earn Dynamo Badge'
local level = 48
local guitare = false
N = 2
local DynamoBadge = Quest:new()

local dialogs = {
	npc11 = Dialog:new({
		"got the entire footage right with my"
	}),
	npc12 = Dialog:new({
		"us your Pokemon again sometime",
	}),
	npc13 = Dialog:new({
		"Let's battle again sometime",
	}),
	npc14 = Dialog:new({
		"out your Pokemon had even more",
	}),
	npc15 = Dialog:new({
		"it is important to treat all you"
	}),
	npc16 = Dialog:new({
		"you be interested in doing volunteer work",
	}),
	npc17 = Dialog:new({
		"I still find Bug type Pokemon to be the",
	}),
	npc18 = Dialog:new({
		"really team up someday. Maybe we'll",
	}),
	npc19 = Dialog:new({
		"even think about touching Meg",
	}),
	npc20 = Dialog:new({
		"place looks beautiful though",
	}),
	npc21 = Dialog:new({
		"need to recharge my batteries",
	}),
	npc22 = Dialog:new({
		"Still looking, still no luck",
	}),
	npc23 = Dialog:new({
		"to trounce over Wattson",
	}),
	npc24 = Dialog:new({
		"you navigated your way through the puzzle",
	}),
	npc25 = Dialog:new({
		"find the sequential combination to this puzzle",
	})
}

function DynamoBadge:new()
	o = Quest.new(DynamoBadge, name, description, level, dialogs)
	o.pokemonId = 1
	o.N = 2

	return o
end


function DynamoBadge:isDoable()
	if self:hasMap() and not  hasItem("Dynamo Badge") then
		return true
	end
	return false
end

function DynamoBadge:isDone()
	if  hasItem("Dynamo Badge") and ( getMapName() == "Mauville City Gym"  or  getMapName() == "Mauville City Stop House 3" ) then
		return true
	else
		return false
	end
end

function DynamoBadge:MauvilleCity()
	if not hasItem("TM114") and not game.hasPokemonWithMove("Rock Smash")  then
		moveToMap("Mauville City House 2")
	elseif not hasItem("TM13") and not game.hasPokemonWithMove("Ice Beam")  then
		moveToMap("Mauville City Game Corner")
	elseif not game.hasPokemonWithMove("Ice Beam") then
			if self.pokemonId < getTeamSize() then
				useItemOnPokemon("TM13", self.pokemonId)
				log("Pokemon: " .. self.pokemonId .. " Try Learning:TM13 - Ice Beam")
				self.pokemonId = self.pokemonId + 1
			else
				fatal("No pokemon in this team can learn Ice Beam")
			end
	elseif  not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Mauville City" then
		moveToMap("Pokecenter Mauville City")
	elseif isNpcOnCell(13,14) then
		talkToNpcOnCell(13,14)
	elseif dialogs.npc25.state and not self:isTrainingOver() then
		return moveToMap("Mauville City Stop House 2")
	elseif dialogs.npc25.state and self:isTrainingOver() then
		moveToMap("Mauville City Gym")
	elseif 	 not dialogs.npc14.state then
		moveToMap("Mauville City Stop House 3")
	elseif 	 not dialogs.npc19.state then
		moveToMap("Mauville City Stop House 2")
	elseif 	 not dialogs.npc22.state then
		moveToMap("Mauville City Stop House 4")
	elseif not dialogs.npc25.state then
		moveToMap("Mauville City Gym")
	end
	
	
end

function DynamoBadge:MauvilleCityStopHouse4()
	if not dialogs.npc22.state then
		moveToMap("Route 118")
	else 
		moveToMap("Mauville City")
	end
end

function DynamoBadge:Route118()
	if not dialogs.npc22.state then
		if isNpcOnCell(10,13) and not dialogs.npc20.state then
			talkToNpcOnCell (10,13)
		elseif isNpcOnCell(16,21) and not dialogs.npc21.state then
			talkToNpcOnCell (16,21)
		elseif isNpcOnCell(28,14) and not dialogs.npc22.state then
			talkToNpcOnCell (28,14)
		end
	else 
		moveToMap("Mauville City Stop House 4")
	end
end


function DynamoBadge:MauvilleCityStopHouse2()
	if dialogs.npc25.state and not self:isTrainingOver() then
		moveToMap("Route 117")
	elseif dialogs.npc25.state and self:isTrainingOver() then
		moveToMap("Mauville City")
	elseif not dialogs.npc19.state then
		moveToMap("Route 117")
	else 
		moveToMap("Mauville City")
	end
end
 


function DynamoBadge:MauvilleCityStopHouse3()
	if not dialogs.npc14.state then
		moveToMap("Route 111 South")
	else 
		moveToMap("Mauville City")
	end
end

function DynamoBadge:Route111South()	
		if isNpcOnCell(33,91) and not dialogs.npc11.state then
			talkToNpcOnCell (33,91)
		elseif isNpcOnCell(33,90) and not dialogs.npc12.state then
			talkToNpcOnCell (33,90)
		elseif isNpcOnCell(23,70) and not dialogs.npc13.state then
			talkToNpcOnCell (23,70)
		elseif isNpcOnCell(31,64) and not dialogs.npc14.state then
			talkToNpcOnCell (31,64)
		else 
			moveToMap("Mauville City Stop House 3")
		end
end
	
function DynamoBadge:Route117()
	if dialogs.npc25.state and not self:isTrainingOver() then
		moveToGrass()
	elseif dialogs.npc25.state and self:isTrainingOver() then
		moveToMap("Mauville City Stop House 2")
	elseif not dialogs.npc19.state then
		if isNpcOnCell(98,28) and not dialogs.npc15.state then
			talkToNpcOnCell (98,28)
		elseif isNpcOnCell(80,17) and not dialogs.npc16.state then
			talkToNpcOnCell (80,17)
		elseif isNpcOnCell(95,40) and not dialogs.npc17.state then
			talkToNpcOnCell (95,40)
		elseif isNpcOnCell(7,26) and not dialogs.npc18.state then
			talkToNpcOnCell (7,26)
		elseif isNpcOnCell(6,26) and not dialogs.npc19.state then
			talkToNpcOnCell (6,26)
		end
	else moveToMap("Mauville City Stop House 2")
	end
	
end

function DynamoBadge:MauvilleCityGameCorner()
	if hasItem("TM13") then
		moveToMap("Mauville City")
	elseif not isShopOpen() then
		return 	talkToNpcOnCell(18,5)
	else
		return buyItem("TM13",1)
	end
end
	
function DynamoBadge:MauvilleCityHouse2()
	if not hasItem("TM114") then
		talkToNpc("Nerd Julian")
	else moveToMap("Mauville City")
	end
	
end

function DynamoBadge:PokecenterMauvilleCity()
	return self:pokecenter("Mauville City")
end



function DynamoBadge:MauvilleCityGym()
	if not hasItem("Dynamo Badge") then
		if not isNpcOnCell(7,9) and not isNpcOnCell(7,13) and not isNpcOnCell(9,15) and not  isNpcOnCell(11,13) then 
			if isNpcOnCell(4,10) and not dialogs.npc23.state then
				talkToNpcOnCell (4,10)
			elseif isNpcOnCell(1,17) and not dialogs.npc24.state then
				talkToNpcOnCell (1,17)
			elseif isNpcOnCell(13,12) and not dialogs.npc25.state then
				talkToNpcOnCell (13,12)
			elseif dialogs.npc25.state and not self:isTrainingOver() then
				moveToMap("Mauville City")
			else 
				talkToNpcOnCell (7,1)
			end
		elseif not isNpcOnCell(7,9) then 
			return talkToNpcOnCell(7,1) or talkToNpcOnCell(11,11)
		elseif isNpcOnCell(5,15) then 
			talkToNpcOnCell(1,17)
			log("2")
		elseif isNpcOnCell(3,13) and isNpcOnCell(7,13) and not isNpcOnCell(9,15) and isNpcOnCell(11,13) then
			talkToNpcOnCell(1,19)
			log("3")
		elseif isNpcOnCell(3,13) and isNpcOnCell(7,13) and isNpcOnCell(9,15) and isNpcOnCell(7,17) then
			talkToNpcOnCell(7,15)
			log("4")
		elseif isNpcOnCell(3,13) and isNpcOnCell(11,13) and isNpcOnCell(9,15) and isNpcOnCell(7,17) then
			talkToNpcOnCell(3,11)
			log("5")
		elseif isNpcOnCell(11,13) and isNpcOnCell(3,13) and not isNpcOnCell(9,15) and not isNpcOnCell(7,13)  then
			talkToNpcOnCell(3,11)
			log("6")
		elseif isNpcOnCell(9,15) and not isNpcOnCell(7,13) and not isNpcOnCell(11,13) and not isNpcOnCell(3,13) then
			talkToNpcOnCell(1,19)
			log("7")
		elseif isNpcOnCell(11,13) and not isNpcOnCell(3,13) and not isNpcOnCell(7,13) and not isNpcOnCell(9,15) then
			talkToNpcOnCell(7,15)
			log("8")
		elseif isNpcOnCell(7,13) and not isNpcOnCell(9,15) and not isNpcOnCell(11,13) then
			talkToNpcOnCell(11,11)
			log("9")
		elseif isNpcOnCell(7,9) and not isNpcOnCell(7,13) and not isNpcOnCell(3,13) and not isNpcOnCell(11,13) and not isNpcOnCell(9,15) then
			talkToNpcOnCell(11,11)
			log("a")
		else relog(5,"relog")
		end
	end
		
end



return DynamoBadge