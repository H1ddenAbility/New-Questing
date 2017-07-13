-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys = require "Libs/syslib"

local EffortValues = {}

function EffortValues:new(arrayOfEv)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	assert(type(arrayOfEv) == 'table' and #arrayOfEv == 6, "The EffortValues constructor expects an array of 6 numbers")
	o.attack    = arrayOfEv[0]
	o.defense   = arrayOfEv[1]
	o.speed     = arrayOfEv[2]
	o.spAttack  = arrayOfEv[3]
	o.spDefense = arrayOfEv[4]
	o.health    = arrayOfEv[5]
	return o
end

function EffortValues:newFromPC(boxIndex, boxPokemonIndex)
	sys.assert(getCurrentPCBoxId() == boxIndex, "EffortValues:newFromPC", "Box index does not match the current box")
	return EffortValues:new({
		getPokemonEffortValueFromPC(boxIndex, boxPokemonIndex, 'attack'),
		getPokemonEffortValueFromPC(boxIndex, boxPokemonIndex, 'defense'),
		getPokemonEffortValueFromPC(boxIndex, boxPokemonIndex, 'speed'),
		getPokemonEffortValueFromPC(boxIndex, boxPokemonIndex, 'spattack'),
		getPokemonEffortValueFromPC(boxIndex, boxPokemonIndex, 'spdefense'),
		getPokemonEffortValueFromPC(boxIndex, boxPokemonIndex, 'health')
	})
end

function EffortValues:newFromTeam(teamIndex)
	sys.assert(getCurrentPCBoxId() == boxIndex, "EffortValues:newFromPC", "Box index does not match the current box")
	return EffortValues:new({
		getPokemonEffortValue('attack'),
		getPokemonEffortValue('defense'),
		getPokemonEffortValue('speed'),
		getPokemonEffortValue('spattack'),
		getPokemonEffortValue('spdefense'),
		getPokemonEffortValue('health')
	})
end

return EffortValues
