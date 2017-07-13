-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = ' '
local description = ' '
local level = 000

local dialogs = {
	xxx = Dialog:new({ 
		" "
	})
}

local templatequest = Quest:new()

function templatequest:new()
	return Quest.new(templatequest, name, description, level, dialogs)
end

function templatequest:isDoable()
	if self:hasMap() and not hasItem("xxx") then
		return true
	end
	return false
end

function templatequest:isDone()
	if hasItem("xxx") and getMapName() == "xxx" then
		return true
	else
		return false
	end
end

function templatequest:MapName()
	
end

function templatequest:MapName()
	
end

function templatequest:MapName()
	
end

function templatequest:MapName()
	
end

return templatequest