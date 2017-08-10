function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end


function isOnList(List)
  result = false
  if List[1] ~= "" then
    for i=1, TableLength(List), 1 do
      if getOpponentName() == List[i] then
        result = true
      end
    end
  end
  return result
end

--iterates over table in sorted order
--https://www.lua.org/pil/19.3.html
function pairsByKeys (t, f)
  local a = {}
  for n in pairs(t) do table.insert(a, n) end
  table.sort(a, f)
  local i = 0      -- iterator variable
  local iter = function ()   -- iterator function
    i = i + 1
    if a[i] == nil then return nil
    else return a[i], t[a[i]]
    end
  end
  return iter
end

--https://stackoverflow.com/questions/640642/how-do-you-copy-a-lua-table-by-values
function copy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
  return res
end
