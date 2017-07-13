-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest4"
local Dialog = require "Quests/Dialog"

local name        = 'Get S Letter'
local description = 'We will save Peeko ♥,and get the SLetter from Devon Corp'

local level       = 15
local clock = os.clock
local getSLetter = Quest:new()

local dialogs = {
	devCheck = Dialog:new({ 
		"Did you get the Devon Goods yet?"
		
	}),
	Peeko = Dialog:new({
		"I'm so happy that you're alive"
		
	}),
	Steven = Dialog:new({ 
		"Steven",
	}),
	magmaCheck = Dialog:new({
		"What have we done to you"
		
	})
}

function getSLetter:new()
	return Quest.new(getSLetter, name, description, level, dialogs)
end


function getSLetter:isDoable()
	if hasItem("Stone Badge") and not hasItem("Knuckle Badge") and self:hasMap() then
		return true
	end
	return false
end

function getSLetter:isDone()
	return getMapName() == "Petalburg Woods"
end 


function getSLetter:Route116()
	if self:needPokecenter() or not dialogs.devCheck.state  then 
	moveToMap("Rustboro City")
	elseif not self:isTrainingOver() then
		moveToGrass()
	elseif not dialogs.Peeko.state then
		moveToMap("Rusturf Tunnel")
	else moveToMap("Rustboro City")
end
end

function getSLetter:RusturfTunnel()
	if isNpcOnCell(18,8)and not dialogs.magmaCheck.state  then
		talkToNpcOnCell (18,8)
	elseif isNpcOnCell(19,9) then 
		talkToNpcOnCell(19,9)
	else moveToMap("Route 116")
end
end

function getSLetter:RustboroCity()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Rustboro City" then
		return moveToMap("Pokecenter Rustboro City")
	elseif isNpcOnCell(52,20) and not dialogs.devCheck.state then
		log("dd")
		talkToNpcOnCell (52,20) 
	elseif isNpcOnCell(52,20) and  dialogs.devCheck.state and not dialogs.Peeko.state then 
		moveToMap("Route 116")
	elseif dialogs.Peeko.state and isNpcOnCell(52,20) then
		talkToNpcOnCell (52,20)
	elseif not isNpcOnCell(52,20) and not dialogs.Steven.state then
		moveToMap("Devon Corporation 1F")
	else moveToMap("Route 104")
	end
end

function getSLetter:Route104()
	return moveToMap("Petalburg Woods")
end	

function getSLetter:PokecenterRustboroCity()
	return self:pokecenter("Rustboro City")
end

function getSLetter:RustboroCityGym()
	return moveToMap("Rustboro City")
end	

function getSLetter:DevonCorporation1F()
	if not dialogs.Steven.state then
		moveToMap("Devon Corporation 2F")
	else moveToMap("Rustboro City")
end
end

function getSLetter:DevonCorporation2F()
	if not dialogs.Steven.state then
		moveToMap("Devon Corporation 3F")
	else moveToMap("Devon Corporation 1F")
end
end

function getSLetter:DevonCorporation3F()
	if not dialogs.Steven.state then
		talkToNpcOnCell(25,8)
	else moveToMap("Devon Corporation 2F")
end
end

return getSLetter
