-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys = require "Libs/syslib"

local Move = {}

function Move:newFromPC(boxIndex, pokemonBoxIndex, moveIndex)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.name        = getPokemonMoveNameFromPC            (boxIndex, pokemonBoxIndex, moveIndex)
	if o.name == nil then
		return nil
	end
	o.accuracy    = getPokemonMoveAccuracyFromPC        (boxIndex, pokemonBoxIndex, moveIndex)
	o.power       = getPokemonMovePowerFromPC           (boxIndex, pokemonBoxIndex, moveIndex)
	o.type        = getPokemonMoveTypeFromPC            (boxIndex, pokemonBoxIndex, moveIndex)
	o.damageType  = getPokemonMoveDamageTypeFromPC      (boxIndex, pokemonBoxIndex, moveIndex)
	o.hasStatus   = getPokemonMoveStatusFromPC          (boxIndex, pokemonBoxIndex, moveIndex)
	o.remainingPP = getPokemonRemainingPowerPointsFromPC(boxIndex, pokemonBoxIndex, moveIndex)
	o.totalPP     = getPokemonMaxPowerPointsFromPC      (boxIndex, pokemonBoxIndex, moveIndex)
	return o
end

return Move
