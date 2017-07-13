-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys = require "Libs/syslib"

local Actions = require "Classes/Actions"

local Box = require "Classes/Box"

local PC = {}

function PC:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	sys.assert(getCurrentPCBoxId() == boxIndex, "PC:new", "Tried to create a box from a closed box.")
	o.boxCount = nil
	o.box  = {}
	o.Box = Box
	return o
end

function PC:isValidIndex(boxIndex, pokemonIndex)
	if getCurrentPCBoxId() == boxIndex and pokemonIndex <= getCurrentBoxSize() then
		return true
	end
	return false
end

function PC:isReady()
	if isPCOpen() and isCurrentPCBoxRefreshed() then
			return true
	end
	return false
end

function PC:use()
	self.onPathActionSave = onPathAction
	if isPCOpen() then
		if isCurrentPCBoxRefreshed() then
			onPathAction = self.onPathActionSave
			return
		else
			-- we wait
			return
		end
	else
		if not usePC() then
			sys.error("PC:use", "Tried to use the PC in a zone without PC")
		end
	end
end

-- this function needs to be called multiple time
-- returns true once the swap is done
function PC:swap(boxIndex, boxPokemonIndex, teamIndex)
	if not pc.isReady() then
		pc.use()
		return false
	else
		if not swapPokemonFromPC(boxIndex, boxPokemonIndex, teamIndex) then
			return sys.error("PC:swap", "Failed to swap")
		else
			return true
		end
	end
	return false
end

-- this function needs to be called multiple time
-- returns true once deposit is done
function PC:deposit(teamIndex)
	if not pc.isReady() then
		pc.use()
		return false
	else
		if not depositPokemonToPC(__teamIndex) then
			return sys.error("PC:deposit", "Failed to deposit")
		end
		return true
	end
	return false
end

-- this function needs to be called multiple time
-- returns true once withdraw is done
function PC:withdraw(boxIndex, boxPokemonIndex)
	if not pc.isReady() then
		pc.use()
		return false
	else
		if getTeamSize() == 6 then
			return sys.error("PC:withdraw", "Team full. Could not withdraw the pokemon "
				.. getPokemonNameFromPC(boxIndex, boxPokemonIndex))
		end
		if not withdrawPokemonFromPC(boxIndex, boxPokemonIndex, teamIndex) then
			return sys.error("PC:deposit", "Failed to deposit")
		end
		return true
	end
	return false
end

function PC:hasDatas()
	if self.boxCount == nil
		or (getPCBoxCount() > 0 and self.box[self.boxCount] == nil) then
		return false
	end
	return true
end

function PC:gatherDatasCondition()
	return not self:hasDatas()
end

function PC:gatherDatasAction()
	if getCurrentPCBoxId() ~= self.currentBoxToRefresh then
		return openPCBox(self.currentBoxToRefresh)
	elseif isCurrentPCBoxRefreshed() then
		self.boxCount = getPCBoxCount()
		if self.boxCount <= 0 then
			self.boxCount = 0
			return true
		end
		self.box[self.currentBoxToRefresh] = self.Box:new(self.currentBoxToRefresh)
		if getPCBoxCount() > self.currentBoxToRefresh then
			self.currentBoxToRefresh = self.currentBoxToRefresh + 1
			return openPCBox(self.currentBoxToRefresh)
		end
		return true
	else
		return true
	end
end

function PC:gatherDatas()
	sys.assert(isPCOpen(), "PC:gatherDatas", "PC is closed")
	self.currentBoxToRefresh = 1
	local actions = Actions:new(self, self.gatherDatasCondition, self.gatherDatasAction)
	actions:run()
end

function PC:toString()
	local value = ""
	if self.boxCount == nil then
		value = "PC object has no datas"
	elseif self.boxCount == 0 then
		value = "PC is empty"
	else
		value = "PC has " .. self.boxCount .. " boxes:\n"
		for i = 1, self.boxCount do
			value = value .. " Box #" .. i .. " (" .. self.box[i].size .. " pokemons):\n"
			value = value .. self.box[i]:toString("  ")
			if i ~= self.boxCount then
				value = value .. "\n"
			end
		end
	end
	return value
end

-- sortingFunction must take 2 pokemons  as parameters (id + box) and return a bool
-- i.e.: 
--[[
	function sortByUniqueId(boxIndexA, boxPokemonIndexA, boxIndexB, boxPokemonIndexB)
		if (getPokemonUniqueIdFromPC(boxIndexA, boxPokemonIndexA) >
			getPokemonUniqueIdFromPC(boxIndexB, boxPokemonIndexB)
		then
			return true
		end
		return false
	end
	
	pc.sort(sortByUniqueId)
--]]
function PC:sort(sortingFunction)

end

return PC
