-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'HM Surf'
local description = 'Kanto Safari'
local level = 4

local HmSurfQuest = Quest:new()

function HmSurfQuest:new()
	return Quest.new(HmSurfQuest, name, description, level)
end

function HmSurfQuest:isDoable()
	return self:hasMap()	
end

function HmSurfQuest:isDone()
	if (hasItem("HM03 - Surf") and getMapName() == "Safari Stop") or getMapName() == "Pokecenter Fuchsia" then --Fix Blackout
		return true		
	end
	return false
end

function HmSurfQuest:SafariStop()
	if hasItem("HM03 - Surf") then
	fatal("Hoc duoc surf cmnr")
	end
end

function HmSurfQuest:SafariEntrance()
	if getTeamSize() == 2  then 
		if getPlayerX() == 31 and getPlayerY() == 16 then
            return useItem("Old Rod")
        else
            moveToCell(31, 16)
        end
	else
		return moveToMap("Safari Area 1")
	end
end

function HmSurfQuest:SafariArea1()
	if not hasItem("HM03 - Surf") then
		if game.inRectangle(0,22,50,40) then
			return moveToCell(16,21)
		elseif game.inRectangle(14,19,27,21) then
			return moveToCell(32,18)
		elseif game.inRectangle(29,16,38,21) then
			return moveToMap("Safari Area 2")
		else
			return moveToMap("Safari Area 2")
		end
	else
		return moveToMap("Safari Entrance")
	end
end

function HmSurfQuest:SafariArea2()
	if not hasItem("HM03 - Surf") then
		return moveToMap("Safari Area 3")
	else
		return moveToMap("Safari Area 1")
	end
end

function HmSurfQuest:SafariArea3()
	if not hasItem("HM03 - Surf") then
		return moveToMap("Safari House 4")
	else
		return moveToMap("Safari Area 2")
	end
end

function HmSurfQuest:SafariHouse4()
	if not hasItem("HM03 - Surf") then
		return talkToNpcOnCell(11,3)
			
	elseif hasItem("HM03 - Surf") then
		return  relog(4,"Relogging")
	end
end

return HmSurfQuest