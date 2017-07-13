-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys = require "Libs/syslib"

local IndividualValues = {}

function IndividualValues:new(arrayOfIv)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	assert(type(arrayOfIv) == 'table' and #arrayOfIv == 6, "The IndividualValues constructor expects an array of 6 numbers")
	o.attack    = arrayOfIv[0]
	o.defense   = arrayOfIv[1]
	o.speed     = arrayOfIv[2]
	o.spAttack  = arrayOfIv[3]
	o.spDefense = arrayOfIv[4]
	o.health    = arrayOfIv[5]
	return o
end

function IndividualValues:newFromPC(boxIndex, boxPokemonIndex)
	sys.assert(getCurrentPCBoxId() == boxIndex, "IndividualValues:newFromPC", "Box index does not match the current box")
	return IndividualValues:new({
		getPokemonIndividualValueFromPC(boxIndex, boxPokemonIndex, 'attack'),
		getPokemonIndividualValueFromPC(boxIndex, boxPokemonIndex, 'defense'),
		getPokemonIndividualValueFromPC(boxIndex, boxPokemonIndex, 'speed'),
		getPokemonIndividualValueFromPC(boxIndex, boxPokemonIndex, 'spattack'),
		getPokemonIndividualValueFromPC(boxIndex, boxPokemonIndex, 'spdefense'),
		getPokemonIndividualValueFromPC(boxIndex, boxPokemonIndex, 'health')
	})
end

function IndividualValues:newFromTeam(teamIndex)
	sys.assert(getCurrentPCBoxId() == boxIndex, "IndividualValues:newFromPC", "Box index does not match the current box")
	return IndividualValues:new({
		getPokemonIndividualValue('attack'),
		getPokemonIndividualValue('defense'),
		getPokemonIndividualValue('speed'),
		getPokemonIndividualValue('spattack'),
		getPokemonIndividualValue('spdefense'),
		getPokemonIndividualValue('health')
	})
end

return IndividualValues
