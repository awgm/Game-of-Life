math.randomseed (os.time ())

cells = {}

cells.map = {}

cells.x = 150
cells.y = 150

cells.w = 800 / cells.x
cells.h = 600 / cells.y

function cells.load ()
  for i = 1, cells.x do
    cells.map[i] = {}

    for j = 1, cells.y do
      if math.random (10) == 1 then
        cells.map[i][j] = 1
      else
        cells.map[i][j] = 0
      end
    end
  end
    time = 0
end


local dirs = { {-1,-1}, {0,-1}, {1,-1}, {-1,0}, {1,0}, {-1,1}, {0,1}, {1,1} }

function cells.getNeighbors(map, i, j)
  local living = 0
  -- iterate adjacent cells
  for _, dir in ipairs(dirs) do
    local i2, j2 = i + dir[1], j + dir[2]
    -- check if the neighbor is off the map
    if i2 >= 1 and i2 <= cells.x then
      if j2 >= 1 and j2 <= cells.y then
        living = living + map[i2][j2]
      end
    end
  end
  return living
end

function cells.getPopulation (map)
  pop = 0
  for i = 1, cells.x do
    for j = 1, cells.y do
      pop = pop + map[i][j]
    end
  end
  return pop
end
--TODO
--You need to create a copy of the board and compare your next generation against that instead of against the current generation as your calculating it. That's why it's going over to the left
function cells.update ()
  cells.newMap = cells.map
  cells.map = {}

  for i = 1, cells.x do
    cells.map[i] = {}
    for j = 1, cells.y do
    --cells.map[i][j] = {}

      local living = cells.getNeighbors (cells.newMap, i, j)

      if cells.newMap[i][j] == 1 then
        if living <2 then
          cells.map[i][j] = 0
        elseif living == 2 or living == 3 then
          cells.map[i][j] = 1
        elseif living >3 then
          cells.map[i][j] = 0
        else
          cells.newMap[i][j] = 1
        end
      elseif cells.newMap[i][j] == 0 then
        if living == 3 then
          cells.map[i][j] = 1
        else
          cells.map[i][j] = 0
        end
      end


    end
  end
  time = time + 1
  --cells.map = cells.newMap
end

function cells.draw ()
  for i = 1, cells.x do
    for j = 1, cells.y do
      if cells.map[i][j] == 0 then
        love.graphics.setColor (10,10,10)
        love.graphics.rectangle ('fill', ((cells.w * i) - cells.w), ((cells.h * j) - cells.h), cells.w, cells.h)
      else
        love.graphics.setColor (0,255,0)
        love.graphics.rectangle ('fill', ((cells.w * i) - cells.w), ((cells.h * j) - cells.h), cells.w, cells.h)
      end
    end
  end
end

function cells.print ()
  love.graphics.setColor (255,255,255)
  love.graphics.print ("population "..cells.getPopulation (cells.map), 10, 10)
  love.graphics.print ("generations "..time, 10, 20)
end


return cells
