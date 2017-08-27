name = "Simple Example"
author = "MeltWS"

description = [[Simple application of the PathFinder, this script moves to a destination from anywhere.]]

-- First you need to get the module loaded in your script :
local PathFinder = require "Pathfinder/MoveToApp"  -- loading the module MoveToApp and getting the functions it sends back in a table: PathFinder.
-- Now to use PathFinder functions you can write PathFinder.functionName().
-- You can require MoveToApp from anywhere above in the hierarchie.
local map = nil -- we want to only call getMapName() on time per onPathAction() so we use this variable

--[[

----- /!\ Check out settings in Pathfind/Settings/Static_Settings.lua /!\ -------------------------------

-- Most usefull calls :
moveTo(map, dest) --> Main function for moving to dest. return false when done. true if destination is not reached. Need to be called multiple times. dest can be a string or a list of string. map is the current player map
moveToPC(map)   --> Move to nearest Pokecenter.
useNearestPokecenter(map) --> Go heal your team to the nearest Pokecenter.
useNearestPokemart(map, item, amount) --> /!\ experimental, item map is not completed./!\ Go to nearest pokemart buy item, at amount times. Return false when successfully buy item, true when moving.

--> Possible Setting Calls (If for some reason you want to disable some path or enable them manually)
--> Those setting are set on loading dynamically depending on your bot items and Pokemons, so you don't have to worry about them usually.
    - enableDigPath() -- to use Bike exclusive paths
    - disableDigPath()

if you need more details see HOWTO and README
------------------]]

function onPathAction()
    map = getMapName() -- get the map name
    PathFinder.moveTo(map, "Littleroot Town")
    -- the line above will move the bot to the map "Indigo Plateau Center"
end

function onBattleAction()
    return run() or attack() -- we use this to not get stuck in battle.
end

