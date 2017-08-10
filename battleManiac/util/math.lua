function getSimpleDistance(pos1, pos2)
  local distX = math.abs(pos1.x - pos2.x)
  local distY = math.abs(pos1.y - pos2.y)

  return distX + distY
end


