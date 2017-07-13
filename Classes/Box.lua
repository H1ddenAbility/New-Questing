-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys = require "Libs/syslib"

local Pokemon = require "Classes/Pokemon"

local Box = {}

function Box:new(boxIndex)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	sys.assert(getCurrentPCBoxId() == boxIndex, "Box:new", "Tried to create a box from a closed box.")
	o.index   = boxIndex
	o.size    = getCurrentPCBoxSize()
	o.pokemon = {}
	for i = 1, o.size do
		o.pokemon[i] = Pokemon:newFromPC(boxIndex, i)
	end
	return o
end

function Box:toString(indentation)
	local value = ""
	if not indentation then
		indentation = ""
	end
	if self.size <= 0 then
		value = indentation .. "empty"
	else
		for i = 1, self.size do
			value = value .. indentation .. "#" .. i .. ":\n"
			value = value .. self.pokemon[i]:toString(indentation .. " ")
			if i ~= self.size then
				value = value .. "\n"
			end
		end
	end
	return value
end

return Box
