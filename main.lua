local w, h = 216, 144
local dw, dh = love.graphics.getDimensions()
local cw, ch = dw/w, dh/h

local game = require("game")
local map = game.blank(w, h)
local paused = true

function love.keypressed (key)
  if key == ' ' or key == 'space' then
    if paused == true then
      paused = false
    elseif paused == false then
      paused = true
    end
  end
  if paused == true then
    if key == 'r' then
      map = game.random(w,h)
    end
    if key == 'z' then
      map = game.blank(w, h)
    end
  end
  if key == 'escape' then love.event.quit () end
  return paused
end

function mouseDraw ()
  -- edit map using the mouse
  local x, y = love.mouse.getPosition()
  local x2 = math.ceil(x/cw)
  local y2 = math.ceil(y/ch)
  if love.mouse.isDown('l') then
    map[x2][y2] = 1
    paused = true
  elseif love.mouse.isDown('r') then
    map[x2][y2] = 0
    paused = true
  else
    --paused = false
  end
  return x2, y2
end

function love.load ()
  time = 0
end

function love.update(dt)
  mouseDraw ()
  -- update the map
  if not paused then
    map = game.step(map)
    time = time + 1
  end
end

function love.draw()
  for i = 1, w do
    for j = 1, h do
      if map[i][j] == 1 then
        love.graphics.setColor (0,255,255)
        love.graphics.rectangle('fill', cw*i - cw, ch*j - ch, cw, ch)
      elseif map[i][j] == 0 then
        love.graphics.setColor (25,0,0)
        love.graphics.rectangle('fill', cw*i - cw, ch*j - ch, cw, ch)
      end
    end
  end

  love.graphics.setColor (255,0,0)
  --if paused == false then
    local x, y = love.mouse.getPosition()
    local x2 = math.ceil(x/cw)
    local y2 = math.ceil(y/ch)
    love.graphics.rectangle ('line', x2*(cw)-cw,y2*(ch)-ch, ch,cw)
  --end
    love.graphics.setColor (255,255,0)
    love.graphics.print ("generations "..time.." population "..game.getPopulation (map), 10, 10)
  if paused == true then
    love.graphics.print ("SPACEBAR = PAUSE, LMB = ADD CELL, RMB = KILL CELL, R = RANDOM, Z = BLANK", 10, 30)
  end
end
