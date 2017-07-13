-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'Elite 4 - Kanto'
local description = ' Beat the League'
local level = 95

local dialogs = {
	leaderDone = Dialog:new({ 
		"you defeated me",
		"you may pass",
		"you are amazing",
		"you are strong"
	})
}

local Elite4Kanto = Quest:new()

function Elite4Kanto:new()
	return Quest.new(Elite4Kanto, name, description, level, dialogs)
end

function Elite4Kanto:isDoable()
	return self:hasMap()
end

function Elite4Kanto:isDone()
	if getMapName() == "Indigo Plateau Center" or getMapName() == "Player Bedroom Pallet" then
		return true
	end
	return false
end

function Elite4Kanto:useReviveItems() --Return false if team don't need heal
	if not hasItem("Revive") or not hasItem("Hyper Potion") then
		return false
	end
	for pokemonId=1, getTeamSize(), 1 do
		if getPokemonHealth(pokemonId) == 0 then
			return useItemOnPokemon("Revive", pokemonId)
		end
		if getPokemonHealthPercent(pokemonId) < 70 then
			return useItemOnPokemon("Hyper Potion", pokemonId)
		end		
	end
	return false
end

function Elite4Kanto:EliteFourLoreleiRoom()
	if self:useReviveItems() ~= false then
		return
	elseif not dialogs.leaderDone.state then
		talkToNpcOnCell(20,23) --Lorelei
	else
		dialogs.leaderDone.state = false
		return moveToCell(20,13) -- Bruno Room
	end
end

function Elite4Kanto:EliteFourBrunoRoom()
	if self:useReviveItems() ~= false then
		return
	elseif not dialogs.leaderDone.state then
		talkToNpcOnCell(21,25) --Bruno
	else
		dialogs.leaderDone.state = false
		return moveToCell(21,14) -- Agatha Room
	end
end


function Elite4Kanto:EliteFourAgathaRoom()
	if self:useReviveItems() ~= false then
		return
	elseif not dialogs.leaderDone.state then
		talkToNpcOnCell(20,25) --Agatha
	else
		dialogs.leaderDone.state = false
		return moveToCell(20,14) -- Lance Room
	end
end

function Elite4Kanto:EliteFourLanceRoom()
	if self:useReviveItems() ~= false then
		return
	elseif not dialogs.leaderDone.state then
		talkToNpcOnCell(21,26) --Lance
	else
		dialogs.leaderDone.state = false
		return moveToCell(21,15) -- Gary Room
	end
end

function Elite4Kanto:EliteFourChampionRoom()
	if self:useReviveItems() ~= false then
		return
	elseif not dialogs.leaderDone.state then
		talkToNpcOnCell(6,15) --Gary
	else
		return talkToNpcOnCell(6,4) -- Exit Prof.Oak
	end
end

return Elite4Kanto