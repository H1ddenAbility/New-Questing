-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"


local name		  = 'Training for Saffron'
local description = 'Exp in Seafoam'
local level = 95

local ExpForSaffronQuest = Quest:new()

function ExpForSaffronQuest:new()
	return Quest.new(ExpForSaffronQuest, name, description, level)
end

function ExpForSaffronQuest:isDoable()
	if self:hasMap() and not hasItem("Marsh Badge") then
		return true
	end
	return false
end

function ExpForSaffronQuest:isDone()
	if getMapName() == "Route 19" or getMapName() == "Pokecenter Fuchsia" then
		return true
	end
	return false
end



function ExpForSaffronQuest:Route20()
		return moveToCell(60,32) --Seafoam 1F
end

function ExpForSaffronQuest:Seafoam1F()
		return moveToCell(20,8) --Seafom B1F
end

function ExpForSaffronQuest:SeafoamB1F()
		return moveToCell(64,25) --Seafom B2F
end

function ExpForSaffronQuest:SeafoamB2F()
	if isNpcOnCell(67,31) then --Item: TM13 - Ice Beam
		return talkToNpcOnCell(67,31)
	else
		return moveToCell(63,19) --Seafom B3F
	end
end

function ExpForSaffronQuest:SeafoamB3F()
	log("Training until 55000$")
	return moveToCell(57,26) --Seafom B4F
end

function ExpForSaffronQuest:SeafoamB4F()
	if isNpcOnCell(57,20) then --Item: Nugget (15000 Money)
		return talkToNpcOnCell(57,20)
	elseif  getMoney() <= 55000 then
		return moveToRectangle(50,10,62,32)
	elseif hasItem("Escape Rope") then
		useItem("Escape Rope")
	else 
		log("You dont have Escape Rope, go back to pokecenter manually")
		fatal()
	end
end

return ExpForSaffronQuest