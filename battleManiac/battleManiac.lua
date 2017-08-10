require "battleManiac.routing.pathing"



local function simpleBattlersDistanceComparer(a,b)
  local player = {x=getPlayerX(), y=getPlayerY()}
  return getSimpleDistance(player, getActiveBattlers()[a]) < getSimpleDistance(player, getActiveBattlers()[b])
end

--this function battles all npcs, that are within view of an single onPathAction call
local function isBattling()

  --Pokecenter Chanseys are battlers for some reason - lol :D
  if getMapName():find("Pokecenter") then
    return false
  end

  --onPathAction is called only when e.g. a direction change occurs
  --no permanent calling, so player location cannot be observed
  --anticipate movement into all 4 directions
  local anticipatedPath = getAnticipatedOnPathActionPositions({x=getPlayerX(), y=getPlayerY()})
  local activeBattlers = getActiveBattlers()
  
  for _, playerPos in ipairs(anticipatedPath) do
    
    --iterate battlers by distance
    for name, battlerPos in pairsByKeys(activeBattlers, simpleBattlersDistanceComparer) do

      --if battler is in view, fight him
      if isInSight(playerPos, battlerPos) then
        
        log("Attempting to fight " .. name .. " at " .. battlerPos.x .. ", " .. battlerPos.y .. ".")
        talkToNpcOnCell(battlerPos.x, battlerPos.y)
        return true
      end
    end
  end

  --if no battler appears on path, do nothing
  return false
end



return {
  isBattling = isBattling
}
