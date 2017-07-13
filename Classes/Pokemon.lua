-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys = require "Libs/syslib"

local EffortValues      = require "Classes/EffortValues"
local IndividualValues  = require "Classes/IndividualValues"
local Move              = require "Classes/Move"

local Pokemon = {}

function Pokemon:newFromPC(boxIndex, boxPokemonIndex)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.ev          = EffortValues:newFromPC(boxIndex, boxPokemonIndex)
	o.iv          = IndividualValues:newFromPC(boxIndex, boxPokemonIndex)
	o.moves       = {
		Move:newFromPC(boxIndex, boxPokemonIndex, 1),
		Move:newFromPC(boxIndex, boxPokemonIndex, 2),
		Move:newFromPC(boxIndex, boxPokemonIndex, 3),
		Move:newFromPC(boxIndex, boxPokemonIndex, 4)
	}
	o.name        = getPokemonNameFromPC               (boxIndex, boxPokemonIndex)
	o.nature      = getPokemonNatureFromPC             (boxIndex, boxPokemonIndex)
	o.ability     = getPokemonAbilityFromPC            (boxIndex, boxPokemonIndex)
	o.happiness   = getPokemonHappinessFromPC          (boxIndex, boxPokemonIndex)
	o.region      = getPokemonRegionFromPC             (boxIndex, boxPokemonIndex)
	o.trainer     = getPokemonOriginalTrainerFromPC    (boxIndex, boxPokemonIndex)
	o.gender      = getPokemonGenderFromPC             (boxIndex, boxPokemonIndex)
	o.totalXp     = getPokemonTotalExperienceFromPC    (boxIndex, boxPokemonIndex)
	o.remainingXP = getPokemonRemainingExperienceFromPC(boxIndex, boxPokemonIndex)
	o.uniqueId    = getPokemonUniqueIdFromPC           (boxIndex, boxPokemonIndex)
	o.isShiny     = isPokemonFromPCShiny               (boxIndex, boxPokemonIndex)
	o.item        = getPokemonHeldItemFromPC           (boxIndex, boxPokemonIndex)
	o.level       = getPokemonLevelFromPC              (boxIndex, boxPokemonIndex)
	o.totalHP     = getPokemonMaxHealthFromPC          (boxIndex, boxPokemonIndex)
	o.percentHP   = getPokemonHealthPercentFromPC      (boxIndex, boxPokemonIndex)
	o.currentHP   = getPokemonHealthFromPC             (boxIndex, boxPokemonIndex)
	return o
end

function valueToString(value)
	if value == true then
		return "Yes"
	elseif value == false then
		return "No"
	elseif value == nil then
		return "None"
	end
	return value
end

function Pokemon:toString(indentation)
	local value = ""
	if not indentation then
		indentation = ""
	end
	value = value .. indentation .. "Name:         " .. self.name .. "\n"
	value = value .. indentation .. "Level:        " .. self.level .. "\n"
	value = value .. indentation .. "HP:           " .. self.currentHP .. "/" .. self.totalHP .. "\n"
	value = value .. indentation .. "Nature:       " .. self.nature .. "\n"
	value = value .. indentation .. "Ability:      " .. valueToString(self.ability) .. "\n"
	value = value .. indentation .. "Happiness:    " .. self.happiness .. "\n"
	value = value .. indentation .. "Region:       " .. self.region .. "\n"
	value = value .. indentation .. "Trainer:      " .. self.trainer .. "\n"
	value = value .. indentation .. "Gender:       " .. self.gender .. "\n"
	value = value .. indentation .. "Experience:   " .. self.totalXp .. "\n"
	value = value .. indentation .. "Remaining xp: " .. self.remainingXP .. "\n"
	value = value .. indentation .. "Unique ID:    " .. self.uniqueId .. "\n"
	value = value .. indentation .. "Shiny:        " .. valueToString(self.isShiny) .. "\n"
	value = value .. indentation .. "Item:         " .. valueToString(self.item)
	return value
end

return Pokemon
