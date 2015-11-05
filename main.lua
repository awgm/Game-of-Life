local cells = require "cells"

function love.load ()
  cells.load ()
end

function love.update (dt)
  cells.update ()
  love.timer.sleep( .1 )
end

function love.draw ()
  cells.draw ()
  cells.print ()
  --for i = 1, cells.x do
  --  for j = 1, cells.y do
  --    love.graphics.print (tostring (cells.map[i][j]), 0 + (10 * i) - 10, 0 + (10 * j) - 10)
  --  end
  --end
end
