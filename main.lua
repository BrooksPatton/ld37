function love.load()
  board = require('board')
  door = require('door')
  Paddle = require('paddle')
  Ball = require('ball')

  playerPaddle = Paddle.new()
  ball = Ball.new(playerPaddle)
end

function love.draw()
  love.graphics.setColor(board.color[1], board.color[2], board.color[3])
  love.graphics.rectangle('line', board.x, board.y, board.width, board.height)

  love.graphics.setColor(door.color[1], door.color[2], door.color[3])
  love.graphics.rectangle('fill', door.x, door.y, door.width, door.height)

  playerPaddle:draw()
  ball:draw()
end

function love.keypressed(key, scancode, isrepeat)
  -- We want the scancode here as it is the physical key pressed and ignores whatever strange keyboard layout the user has
  if scancode == 'a' then
    playerPaddle:setMoving('left')
  elseif scancode == 'd' then
    playerPaddle:setMoving('right')
  end
end

function love.keyreleased(key)
  playerPaddle:setMoving(nil)
end

function love.update(dt)
  if playerPaddle.movingDirection and playerPaddle.movingDirection == 'right' then
    playerPaddle:moveRight(dt)
  elseif playerPaddle.movingDirection and playerPaddle.movingDirection == 'left' then
    playerPaddle:moveLeft(dt)
  end

  ball:move(dt)
end
