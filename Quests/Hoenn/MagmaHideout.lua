-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @WiWi__33[NetPapa]


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest4"
local Dialog = require "Quests/Dialog"

local name		  = 'The Magma HideOut '
local description = 'Clear the Magma Hideout and give the Red Orb'
local level = 000

local dialogs = {
	xxx = Dialog:new({ 
		" "
	})
}

local MagmaHideOut = Quest:new()

function MagmaHideOut:new()
	return Quest.new(MagmaHideOut, name, description, level, dialogs)
end

function MagmaHideOut:isDoable()
	if self:hasMap() and hasItem("Blue Orb") and hasItem("Red Orb") then
		return true
	end
	return false
end

function MagmaHideOut:isDone()
	if not hasItem("Red Orb") and getMapName() == "Magma Hideout 4F" then
		return true
	else
		return false
	end
end

function MagmaHideOut:MtPyreSummit()
	moveToMap("Mt. Pyre Exterior")
end

function MagmaHideOut:MtPyreExterior()
	moveToMap("Mt. Pyre 3F")
end

function MagmaHideOut:MtPyre3F()
	moveToMap("Mt. Pyre 2F")
end

function MagmaHideOut:MtPyre2F()
	moveToMap("Mt. Pyre 1F")
end

function MagmaHideOut:MtPyre1F()
	moveToMap("Route 122")
end

function MagmaHideOut:Route122()
	moveToMap("Route 123")
end

function MagmaHideOut:Route123()
	moveToMap("Route 118")
end

function MagmaHideOut:Route118()
	moveToMap("Mauville City Stop House 4")
end

function MagmaHideOut:MauvilleCityStopHouse4()
	moveToMap("Mauville City")
end

function MagmaHideOut:MauvilleCity()
	if  self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Mauville City" then
		moveToMap("Pokecenter Mauville City")
	else moveToMap("Mauville City Stop House 3")
	end
end

function MagmaHideOut:PokecenterMauvilleCity()
	return self:pokecenter("Mauville City")
end

	


function MagmaHideOut:MauvilleCityStopHouse3()
	moveToMap("Route 111 South")
end

function MagmaHideOut:Route111South()
	moveToMap("Route 112")
end

function MagmaHideOut:Route112()
	moveToMap("Cable Car Station 1")
end

function MagmaHideOut:CableCarStation1()
	talkToNpcOnCell(10,6)
end

function MagmaHideOut:CableCarStation2()
	moveToMap("Mt. Chimney")
end

function MagmaHideOut:MtChimney()
	moveToMap("Jagged Pass")
end

function MagmaHideOut:JaggedPass()
	talkToNpcOnCell(30,35)
end

function MagmaHideOut:MagmaHideout1F()
	moveToMap("Magma Hideout 2F1R")
end

function MagmaHideOut:MagmaHideout2F1R()
	moveToMap("Magma Hideout 3F1R")
end

function MagmaHideOut:MagmaHideout3F1R()
	moveToMap("Magma Hideout 4F")
end

function MagmaHideOut:MagmaHideout4F()
	if isNpcOnCell(16,31) then
		talkToNpcOnCell(16,31)
	else moveToMap("Magma Hideout 3F3R")
	end
end

function MagmaHideOut:MapName()
	
end

function MagmaHideOut:MapName()
	
end

function MagmaHideOut:MapName()
	
end

function MagmaHideOut:MapName()
	
end

function MagmaHideOut:MapName()
	
end

function MagmaHideOut:MapName()
	
end

function MagmaHideOut:MapName()
	
end

function MagmaHideOut:MapName()
	
end

function MagmaHideOut:MapName()
	
end

function MagmaHideOut:MapName()
	
end

function MagmaHideOut:MapName()
	
end

function MagmaHideOut:MapName()
	
end

return MagmaHideOut