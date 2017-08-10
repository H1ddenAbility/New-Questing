local Settings = nil

local function initSettings()
-----------------------
-- USER CUSTOM SETTINGS
-----------------------

-- It's possible to have setting defined for every of your bots.
-- Simply replace Default by your bot name.
-- Omitted settings in custom profiles will be replaced by those in Default profile.

-- About Subway and Boat paths:
-- the value defines how heavy the path is.
-- if you define H_SUBWAY = 1 the bot will consider subway path in hoenn to be of lenght 1,
-- which will result in taking the subway almost all the time.
-- in general if you do not care about money issue 10 is a good number.
-- if you never want to take these path use high value like 999.

-- digpath is dynamically supported depending on your team having a pokemon with dig and happiness.

Settings = {
--  Default Settings
    default        = {
        MOUNT      = "Bicycle",

        DISCOVER   = true,  --discover items.
        HARVEST    = true,  -- harvest berries.
        HEADBUTT   = true, -- headbutt trees.
        DIG        = true,  -- dig digSpots.

        K_SUBWAY   = 15, -- Weight for using the subway path. Kanto
        J_SUBWAY   = 15, -- Weight for using the subway path. Johto
        H_SUBWAY   = 999, -- Weight for using the subway path. Hoenn

        J_TO_K     = 10, -- Weight of the Subway from Johto to Kanto and reverse.
        H_TO_KJ    = 10 -- Weight of the Subway from Hoenn to Kanto/Johto and reverse.
    },
--  Custom Settings, loaded if the bot name match.
--  Omitted settings will be taken on Default profile.
    myAccountName      = {
        MOUNT      = "Latios Mount",

        K_SUBWAY   = 10, -- Weight for using the subway path. Kanto
        J_SUBWAY   = 10, -- Weight for using the subway path. Johto
        H_SUBWAY   = 999,-- Weight for using the subway path. Hoenn

        J_TO_K     = 10, -- Weight of the Subway from Johto to Kanto and reverse.
        H_TO_KJ    = 999 -- Weight of the Subway from Hoenn to Kanto/Johto and reverse.
    },
--  Custom Settings, loaded if the bot name match.
    myOtherAccountName = {
        MOUNT      = "Arcanine Mount",

        K_SUBWAY   = 5, -- Weight for using the subway path. Kanto
        J_SUBWAY   = 5, -- Weight for using the subway path. Johto
        H_SUBWAY   = 5, -- Weight for using the subway path. Hoenn

        J_TO_K     = 5, -- Weight of the Subway from Johto to Kanto and reverse.
        H_TO_KJ    = 5  -- Weight of the Subway from Hoenn to Kanto/Johto and reverse.
    },
}

-----------------------
-- End of Configuration
-----------------------
end

local version = "2.3.2"
local cpath = select(1, ...) or "" -- callee path
local function rmlast(str) return str:sub(1, -2):match(".+[%./]") or "" end -- removes last dir / file from the callee path
local cdpath = rmlast(cpath) -- callee dir path
local cpdpath = rmlast(cdpath) -- callee parent dir path

local Lib = require (cpdpath .. "Pathfinder/Lib/Lib")
local message = "Pathfinder v(" .. version .. ") :"
local loadedName = nil

local function fillOmittedSettings(accountName)
    default = "default"
    for key, value in pairs(Settings[default]) do
        if Settings[accountName][key] == nil then
            message = message .. "\n --> Filling omitted setting: " .. tostring(key) .. ", replacing with: " .. tostring(value) .. "."
            Settings[accountName][key] = Settings[default][key]
        end
    end
end

local function validateSettings(accountName)
    if not hasItem(Settings[accountName].MOUNT) then
        Settings[accountName].MOUNT = "Bicycle"
        message = message .. "\n -> Mount not found, setting to Bicycle."
    end
end

return function()
    local accountName = getAccountName()
    if accountName ~= loadedName then
        loadedName = accountName
        initSettings()
        if Settings[accountName] then
            message = message .. " Loading " .. accountName .. " settings."
            fillOmittedSettings(accountName)
            validateSettings(accountName)
        else
            message = message .. " Loading default settings."
        end
        Lib.log1time(message)
    end
    return Settings[accountName] or Settings["default"]
end
