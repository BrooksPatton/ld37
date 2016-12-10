function love.load()
  board = require('board')
  door = require('door')
end

function love.draw()
  love.graphics.setColor(board.color[1], board.color[2], board.color[3])
  love.graphics.rectangle('line', board.x, board.y, board.width, board.height)

  love.graphics.setColor(door.color[1], door.color[2], door.color[3])
  love.graphics.rectangle('fill', door.x, door.y, door.width, door.height)
end
