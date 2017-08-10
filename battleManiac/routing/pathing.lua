require "battleManiac.util.math"
require "battleManiac.util.collection"
Terrain = require "battleManiac.enum.terrains"

VIEW_RANGE = 15
local ALIGNMENT = {X="x", Y="y"}
local SWITCH = {[ALIGNMENT.X]=ALIGNMENT.Y, [ALIGNMENT.Y]=ALIGNMENT.X}

--checks if path is blocked from on cell to the next
local function isStepPossible(posA, posB)
  if getSimpleDistance(posA, posB)>1 then
    fatal("\"isStepPossible()\" was intended for single cell distance comparison")
  end


  local cellTypeA = getCellType(posA.x, posA.y)
  local cellTypeB = getCellType(posB.x, posB.y)

  local pathBlocked = Set{Terrain.COLLIDER, Terrain.PC, Terrain.LINK}

  --no sight, if view is blocked
  if pathBlocked[cellTypeA] or pathBlocked[cellTypeB] then
    return false

      --no sight if separated by water
  elseif cellTypeA ~= cellTypeB
    and cellTypeA == Terrain.WATER
    or cellTypeB == Terrain.WATER
  then
    return false
  end

  return true
end

--iterates through either x or y and checks if any obstacles occur
local function isLineBlocked(posA, posB, alignment)
  --for basic loop call can only count up
  -->switch positions if loop wouln't iterate
  if posA[alignment] > posB[alignment] then
    return isLineBlocked(posB, posA, alignment)
  end


  --actual method
  local iterPos = copy(posA)

  for i = iterPos[alignment], posB[alignment] do

    local iterPos2 = iterPos
    iterPos2[alignment] = i

    if not isStepPossible(iterPos, iterPos2) then return true end

    iterPos[alignment] = i
  end

  --no interception, so view is possible
  return false
end

--this function checks if terrain on line between player and
--battler is not iterrupted from obj or water
function isInSight(posA, posB)
  for _, alignment in pairs(ALIGNMENT) do
    
    --check if posA is on same height (x or y-wise)
    if posA[alignment] == posB[alignment]

      --check if other graph value (x or y) is in view range
      and math.abs(posA[SWITCH[alignment]] - posB[SWITCH[alignment]]) <= VIEW_RANGE
    then
      return not isLineBlocked(posA, posB, SWITCH[alignment])
    end
  end

  return false
end


function getAnticipatedOnPathActionPositions(player)

  local functions = {
    function(p) p.x=p.x+1; return p end,  --move east
    function(p) p.x=p.x-1; return p end,  --move west
    function(p) p.y=p.y+1; return p end,  --move north
    function(p) p.y=p.y-1; return p end   --move south
  }

  local anticipatedPositions = {}
  for _, f in ipairs(functions) do
    local posA = copy(player)
    local posB = copy(player)

    while(isStepPossible(posA,posB))
    do
      table.insert(anticipatedPositions, copy(posB))
      posA = posB
      posB = f(posB)
    end
  end

  return anticipatedPositions
end
