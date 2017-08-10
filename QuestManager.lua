-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.

local QuestManager = {}

--Kanto
local StartKantoQuest     = require('Quests/Kanto/StartKantoQuest')
local PalletStartQuest    = require('Quests/Kanto/PalletStartQuest')
local ViridianSchoolQuest = require('Quests/Kanto/ViridianSchoolQuest')
local BoulderBadgeQuest   = require('Quests/Kanto/BoulderBadgeQuest')
local MoonFossilQuest     = require('Quests/Kanto/MoonFossilQuest')
local CascadeBadgeQuest   = require('Quests/Kanto/CascadeBadgeQuest')
local LanceVermilionQuest = require('Quests/Kanto/LanceVermilionQuest')
local SSAnneQuest         = require('Quests/Kanto/SSAnneQuest')
local ThunderBadgeQuest   = require('Quests/Kanto/ThunderBadgeQuest')
local HmFlashQuest        = require('Quests/Kanto/HmFlashQuest')
local RockTunnelQuest     = require('Quests/Kanto/RockTunnelQuest')
local RocketCeladonQuest  = require('Quests/Kanto/RocketCeladonQuest')
local PokeFluteQuest      = require('Quests/Kanto/PokeFluteQuest')
local SnorlaxQuest        = require('Quests/Kanto/SnorlaxQuest')
local SoulBadgeQuest      = require('Quests/Kanto/SoulBadgeQuest')
local RainbowBadgeQuest   = require('Quests/Kanto/RainbowBadgeQuest')
local HmSurfQuest         = require('Quests/Kanto/HmSurfQuest')
local ExpForSaffronQuest  = require('Quests/Kanto/ExpForSaffronQuest')
local SaffronGuardQuest   = require('Quests/Kanto/SaffronGuardQuest')
local MarshBadgeQuest     = require('Quests/Kanto/MarshBadgeQuest')
local BuyBikeQuest        = require('Quests/Kanto/BuyBikeQuest')
local SilphCoQuest        = require('Quests/Kanto/SilphCoQuest')
local ToCinnabarQuest     = require('Quests/Kanto/ToCinnabarQuest')
local CinnabarKeyQuest    = require('Quests/Kanto/CinnabarKeyQuest')
local VolcanoBadgeQuest   = require('Quests/Kanto/VolcanoBadgeQuest')
local ReviveFossilQuest   = require('Quests/Kanto/ReviveFossilQuest')
local EarthBadgeQuest     = require('Quests/Kanto/EarthBadgeQuest')
local ExpForElite4Kanto   = require('Quests/Kanto/ExpForElite4Kanto')
local Elite4Kanto         = require('Quests/Kanto/Elite4Kanto')
local GoToJohtoQuest      = require('Quests/Kanto/GoToJohtoQuest')


--Johto
local StartJohtoQuest     = require('Quests/Johto/StartJohtoQuest')
local ZephyrBadgeQuest    = require('Quests/Johto/ZephyrBadgeQuest')
local SproutTowerQuest    = require('Quests/Johto/SproutTowerQuest')
local HiveBadgeQuest      = require('Quests/Johto/HiveBadgeQuest')
local IlexForestQuest     = require('Quests/Johto/IlexForestQuest')
local GoldenrodCityQuest  = require('Quests/Johto/GoldenrodCityQuest')
local PlainBadgeQuest     = require('Quests/Johto/PlainBadgeQuest')
local FogBadgeQuest		  = require('Quests/Johto/FogBadgeQuest')
local StormBadgeQuest     = require('Quests/Johto/StormBadgeQuest')
local MineralBadgeQuest	  = require('Quests/Johto/MineralBadgeQuest')
local GlacierBadgeQuest	  = require('Quests/Johto/GlacierBadgeQuest')
local RisingBadgeQuest	  = require('Quests/Johto/RisingBadgeQuest')
local Elite4Johto	  = require('Quests/Johto/Elite4Johto')

--Hoenn
local FromLittlerootToWoodsQuest = require('Quests/Hoenn/FromLittlerootToWoodsQuest')
local StoneBadgeQuest 			 = require('Quests/Hoenn/StoneBadgeQuest')
local getSLetter 				 = require('Quests/Hoenn/getSLetter')
local KnuckleBadgeQuest 		 = require('Quests/Hoenn/KnuckleBadgeQuest')
local toMauville 				 = require('Quests/Hoenn/toMauville')
local DynamoBadge				 = require('Quests/Hoenn/DynamoBadge')
local ToLavaridgeTown	  		 = require('Quests/Hoenn/ToLavaridgeTown')
local ToBalanceBadge 		     = require('Quests/Hoenn/ToBalanceBadge')
local ToFortreeCity  		     = require('Quests/Hoenn/ToFortreeCity')
local GetTheOrbs 				 = require('Quests/Hoenn/GetTheOrbs')
local MagmaHideout			     = require('Quests/Hoenn/MagmaHideout')
local ToMossdeepCity			 = require('Quests/Hoenn/ToMossdeepCity')
local meetKyogre			     = require('Quests/Hoenn/meetKyogre')
local beatDeoxys				 = require('Quests/Hoenn/beatDeoxys')
local e4Hoenn					 = require('Quests/Hoenn/e4Hoenn')

local quests = {
	-- Kanto Quests
	StartKantoQuest:new(),
	PalletStartQuest:new(),
	ViridianSchoolQuest:new(),
	BoulderBadgeQuest:new(),
	MoonFossilQuest:new(),
	CascadeBadgeQuest:new(),
	LanceVermilionQuest:new(),
	SSAnneQuest:new(),
	ThunderBadgeQuest:new(),
	HmFlashQuest:new(),
	RockTunnelQuest:new(),
	RocketCeladonQuest:new(),
	PokeFluteQuest:new(),
	SnorlaxQuest:new(),
	SoulBadgeQuest:new(),
	RainbowBadgeQuest:new(),
	HmSurfQuest:new(),
	ExpForSaffronQuest:new(),
	SaffronGuardQuest:new(),
	MarshBadgeQuest:new(),
	BuyBikeQuest:new(),
	SilphCoQuest:new(),
	ToCinnabarQuest:new(),
	CinnabarKeyQuest:new(),
	VolcanoBadgeQuest:new(),
	ReviveFossilQuest:new(),
	EarthBadgeQuest:new(),
	ExpForElite4Kanto:new(),
	Elite4Kanto:new(),
	GoToJohtoQuest:new(),
	
	-- Johto Quests 
	StartJohtoQuest:new(),
	ZephyrBadgeQuest:new(),
	SproutTowerQuest:new(),
	HiveBadgeQuest:new(),
	IlexForestQuest:new(),
	GoldenrodCityQuest:new(),
	PlainBadgeQuest:new(),
	FogBadgeQuest:new(),
	StormBadgeQuest:new(),
	MineralBadgeQuest:new(),
	GlacierBadgeQuest:new(),
	RisingBadgeQuest:new(),
	Elite4Johto:new(),
	
	--HoennQuest
	FromLittlerootToWoodsQuest:new(),
	StoneBadgeQuest:new(),
	getSLetter:new(),
	KnuckleBadgeQuest:new(),
	toMauville:new(),
	DynamoBadge:new(),
	ToLavaridgeTown:new(),
	ToBalanceBadge:new(),
	ToFortreeCity:new(),
	GetTheOrbs:new(),
	MagmaHideout:new(),
	ToMossdeepCity:new(),
	meetKyogre:new(),
	beatDeoxys:new(),
	e4Hoenn:new()
}

function QuestManager:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.quests = quests
	o.selected = nil
	o.isOver = false
	return o
end

function QuestManager:message()
	if self.selected then
		return self.selected:message()
	end
	return nil
end

function QuestManager:pause()
	if self.selected then
		log("Pause Quest: " .. self:message())
	end
end

function QuestManager:next()
	for _, quest in pairs(self.quests) do
		if quest:isDoable() == true then
			self.selected = quest
			return quest
		end
	end
	self.selected = nil
	return nil
end

function QuestManager:isQuestOver()
	if not self.selected or self.selected:isDone() then
		return true
	end
	return false
end

function QuestManager:updateQuest()
	if getMapName() == "" then
		return false
	end
	if self:isQuestOver() then
		if self.selected then
			log(self.selected.name .. " is over")
		end
		if not self:next() then
			self.isOver = true
			return false
		end
		log('Starting new quest: ' .. self.selected:message())
	end
	return true
end

function QuestManager:path()
	if not self:updateQuest() then
		return false
	end
	return self.selected:path()
end

function QuestManager:battle()
	if not self:updateQuest() then
		return false
	end
	return self.selected:battle()
end

function QuestManager:dialog(message)
	if not self.selected then
		return false
	end
	return self.selected:dialog(message)
end

function QuestManager:battleMessage(message)
	if not self:updateQuest() then
		return false
	end
	return self.selected:battleMessage(message)
end

function QuestManager:systemMessage(message)
	if not self.selected then
		return false
	end
	return self.selected:systemMessage(message)
end

function QuestManager:learningMove(moveName, pokemonIndex)
	if not self:updateQuest() then
		return false
	end
	return self.selected:learningMove(moveName, pokemonIndex)
end

return QuestManager
