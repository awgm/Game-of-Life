local game = {}

function game.new(w, h)
  local map = { w = w, h = h }
  for i = 1, w do
    map[i] = {}
    for j = 1, h do
      map[i][j] = 0
    end
  end
  return map
end

function game.random(w, h)
  local map = game.new(w, h)
  for i = 1, w do
    for j = 1, h do
      if math.random(10) == 1 then
        map[i][j] = 1
      end
    end
  end
  return map
end

function game.blank(w, h)
  local map = game.new(w, h)
  for i = 1, w do
    for j = 1, h do
      map[i][j] = 0
    end
  end
  return map
end

-- neighbors table
local dirs = { {-1,-1}, {0,-1}, {1,-1}, {-1,0}, {1,0}, {-1,1}, {0,1}, {1,1} }

function game.getNeighbors(map, i, j)
  local w, h = map.w, map.h
  local v = 0
  -- iterate adjacent cells
  for _, dir in ipairs(dirs) do
    local i2, j2 = i + dir[1], j + dir[2]
    -- check if the neighbor is off the map
    if i2 >= 1 and i2 <= w then
      if j2 >= 1 and j2 <= h then
        v = v + map[i2][j2]
      end
    end
  end
  return v
end

-- rules table
local rules = {}
-- dead cells become alive if there are 3 live neighbors
rules[0] = { [0] = 0, 0, 0, 1, 0, 0, 0, 0, 0 }
-- live cells survive if there are 2 or 3 live neighbors
rules[1] = { [0] = 0, 0, 1, 1, 0, 0, 0, 0, 0 }

function game.step(map)
  local w, h = map.w, map.h
  local map2 = { w = w, h = h }
  for i = 1, w do
    map2[i] = {}
    for j = 1, h do
      local s = map[i][j]
      local n = game.getNeighbors(map, i, j)
      map2[i][j] = rules[s][n]
    end
  end
  return map2
end

function game.getPopulation (map)
  pop = 0
  for i = 1, map.w do
    for j = 1, map.h do
      pop = pop + map[i][j]
    end
  end
  return pop
end

return game
