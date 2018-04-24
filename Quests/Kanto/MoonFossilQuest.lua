-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"
            



local name        = 'Mt. Moon Fossil'
local description = 'from Route 3 to Cerulean City'
local level       = 30

local dialogs = {
	fossileGuyBeaten = Dialog:new({
		"Did you get the one you like?"--,
	}),
	karpDone = Dialog:new({ 
		"show me the Magikarp",
	})
}

local MoonFossilQuest = Quest:new()
function MoonFossilQuest:new()
	return Quest.new(MoonFossilQuest, name, description, level, dialogs)
end

function MoonFossilQuest:isDoable()
	if not hasItem("Cascade Badge") and self:hasMap()
	then
		return true
	end
	return false
end

function MoonFossilQuest:isDone()
	return getMapName() == "Cerulean City"
end

function MoonFossilQuest:Route3()
	if self:needPokecenter()
		or not game.isTeamFullyHealed()
		or self.registeredPokecenter ~= "Pokecenter Route 3"
	then
		return moveToMap("Pokecenter Route 3")
	elseif not hasItem("Escape Rope") and getMoney() >= 2000 then
		talkToNpcOnCell(85,17)
	else
		return moveToMap("Mt. Moon 1F")
	end
end

function MoonFossilQuest:MtMoon1F()
	if  not self:isTrainingOver() or not hasItem("Escape Rope") then
		log("Training until "..self.level .."Lv")
		return moveToRectangle(28, 51, 40, 54)
	elseif getMoney() >= 2000 and not hasItem("Escape Rope") then
		return moveToMap("Route 3")
	else
		return moveToCell(21, 20) -- Mt. Moon B1F
	end
end

function MoonFossilQuest:MtMoonB1F()
	if game.inRectangle(56, 18, 66, 21) then
		return moveToCell(65, 20) -- Mt. Moon B2F (wrong way)
	elseif game.inRectangle(73, 15, 78, 34)
		or game.inRectangle(53, 29, 78, 34)
	then
		return moveToCell(56, 34) -- Mt. Moon B2F (right way)
	elseif game.inRectangle(32, 19, 42, 22) then
		return moveToCell(41, 20) -- Mt. Moon Exit
	else
		error("MoonFossilQuest:MtMoonB1F(): [" .. getPlayerX() .. "," .. getPlayerY() .. "] is not a known position")
	end
end

function MoonFossilQuest:MtMoonB2F()
	if game.inRectangle(10, 22, 63, 64) then
		if isNpcOnCell(25, 29) and isNpcOnCell(26, 29) then -- fossile on the way
			if dialogs.fossileGuyBeaten.state then
				if KANTO_FOSSIL_ID == 1 then
					return talkToNpcOnCell(25, 29)
				elseif KANTO_FOSSIL_ID == 2 then
					return talkToNpcOnCell(26, 29)
				else
					fatal("undefined KANTO_FOSSIL_ID")
				end
			elseif game.inRectangle(21, 29, 29, 38) then
				if getPokemonHealthPercent(1) <= 90 and isPokemonUsable(1) then
					return useItemOnPokemon("Potion", 1)
				else 
					talkToNpcOnCell(23, 31)
				end
			else 
				return talkToNpcOnCell(23, 31)
			end
		elseif isNpcOnCell(26, 23) then
			return talkToNpcOnCell(26, 23) -- Team Rocket
		else
			return moveToCell(17, 27) -- Mt. Moon B1F
		end
	else
		error("MoonFossilQuest:MtMoonB2F(): [" .. getPlayerX() .. "," .. getPlayerY() .. "] is not a known position")
	end
end

function MoonFossilQuest:MtMoonExit()
	return moveToMap("Route 4")
end

function MoonFossilQuest:Route4()
	return moveToCell(96, 21) -- Cerulean City (avoid water link)
end

function MoonFossilQuest:PokecenterRoute3()
	if  getTeamSize() >=3 and not hasItem("HM03 - Surf") then
				if isPCOpen() then
					if isCurrentPCBoxRefreshed() then
							return depositPokemonToPC(3)
					else
						return
					end
				else
					return usePC()
				end
	elseif getTeamSize() >=1 and not hasItem("HM03 - Surf") and not hasPokemonInTeam("Magikarp") and getMoney() < 2500 then
		return self:pokecenter("Route 3")
	elseif  getTeamSize() >=1 and not hasItem("HM03 - Surf") and not hasPokemonInTeam("Magikarp") then
				if isPCOpen() then
					if isCurrentPCBoxRefreshed() then
						return depositPokemonToPC(1)
					else
						return
					end
				else
					return usePC()
				end
	elseif  getTeamSize() == 0 then
		return talkToNpcOnCell(2,17)	
	elseif  hasPokemonInTeam("Magikarp") and getTeamSize() == 1 then
		if isPCOpen() then
			if isCurrentPCBoxRefreshed() then
				if getCurrentPCBoxSize() ~= 0 then
					for pokemon=1, getCurrentPCBoxSize() do
						if getPokemonLevelFromPC(getCurrentPCBoxId(), pokemon) > 10 then
						return withdrawPokemonFromPC(getCurrentPCBoxId(),pokemon) 	
						end
					end
					return openPCBox(getCurrentPCBoxId()+1)
				end
			else
				return
			end
		else
			return usePC()
		end
	else
		self:pokecenter("Route 3")
	end
end


return MoonFossilQuest
