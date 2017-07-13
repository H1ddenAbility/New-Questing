-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local sys = require "Libs/syslib"

local Actions = {}

local __self

function Actions:new(their, condition, action)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.onPathAction = onPathAction
	o.condition = condition
	o.action = action
	__their = their
	__self = o
	return o
end

function Actions.customOnPathAction()
	if (not __their and __self.condition())
		or (__their and __self.condition(__their))
	then
		if (not __their and not __self.action())
			or (__their and not __self.action(__their))
		then
			sys.error("Actions.customOnPathAction", "action function returned false while condition was not yet true")
			onPathAction = __self.onPathAction
			return false
		else
			return true
		end
	else
		onPathAction = __self.onPathAction
		return false
	end
end

function Actions:run()
	if self.customOnPathAction() then
		onPathAction = self.customOnPathAction
		return true
	end
	return false
end

return Actions
