---------------------------
-------- CONFIG -----------
---------------------------

-- These are additional settings for the module that harvest items

-- the berries you want to harvest or not.
-- to disable set value to false or comment the line.
-- to enable set the value to true.
local berries = {
    ["cherry"] = true,
    ["pecha"] = true,
    ["oran"] = true,
    ["leppa"] = true,
    ["chesto"] = true,
    ["kelpsy"] = true,
    ["hondew"] = true,
    ["qualot"] = true,
    ["grepa"] = true,
    ["rawst"] = true,
    ["aspear"] = true,
    ["persim"] = true,
    ["pomeg"] = true,
    ["tomato"] = true,
    ["sitrus"] = true,
    ["lum"] = true,
}

---------------------------
----- END OF CONFIG -------
---------------------------





local cpath = select(1, ...) or "" -- callee path
local function rmlast(str) return str:sub(1, -2):match(".+[%./]") or "" end -- removes last dir / file from the callee path
local cdpath = rmlast(cpath) -- callee dir path
local cpdpath = rmlast(cdpath) -- callee parent dir path

local Table = require (cpdpath .. "Pathfinder/Lib/Table")

local berriesTypes = {
    ["cherry"] = 42,
    ["pecha"] = 43,
    ["oran"] = 44,
    ["leppa"] = 45,
    ["chesto"] = 49,
    ["rawst"] = 50,
    ["aspear"] = 51,
    ["persim"] = 52,
    ["pomeg"] = 55,
    ["kelpsy"] = 56,
    ["qualot"] = 57,
    ["hondew"] = 58,
    ["grepa"] = 59,
    ["tomato"] = 60,
    ["sitrus"] = 61,
    ["lum"] = 62,
}

local npcTypes           = {}
npcTypes.items           = {[11] = "item"}
npcTypes.dig             = {[70] = "road dig spot", [71] = "cave dig spot"}
npcTypes.abandonnedPkm   = {[63] = "abandonned Pokemon"}
npcTypes.headbutt        = {[101] = "headbutt tree"}
npcTypes.pokeStop        = {[119] = "pokestop"}
-- npcTypes.test            = {[] = "test item"}

local function setBerriesTypes()
    local new = {}
    for berry, _ in pairs(berries) do
        assert(berriesTypes[berry], "Work Settings --> Unknown berry in settings.")
        new[berriesTypes[berry]] = "berry tree"
    end
    npcTypes.berries = new
end

local function getNpcTypes()
    if not npcTypes.berries then
        setBerriesTypes()
    end
    return npcTypes
end

return {
    getNpcTypes = getNpcTypes
}