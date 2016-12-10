function love.load()
  Board = require('board')
  door = require('door')
  Paddle = require('paddle')
  Ball = require('ball')
  Door = require('door')
  Welcome = require('welcome')

  welcomeScreen = Welcome.new()

  door = Door.new()
  board = Board.new(door)
  playerPaddle = Paddle.new()
  ball = Ball.new(playerPaddle, board)

  state = 'starting'
end

function love.draw()
  if state == 'starting' then
    welcomeScreen:draw()
  elseif state == 'playing' then
    board:draw(ball.ballsLeft)

    playerPaddle:draw()
    ball:draw()
  elseif state == 'gameOver' then
    -- show game over window
  end
end

function love.keypressed(key, scancode, isrepeat)
  -- We want the scancode here as it is the physical key pressed and ignores whatever strange keyboard layout the user has
  if scancode == 'a' then
    playerPaddle:setMoving('left')
  elseif scancode == 'd' then
    playerPaddle:setMoving('right')
  elseif scancode == 'space' then
    ball:start()
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

  if board.gameOver then
    state = 'gameOver'
  end

  ball:move(dt)
end
