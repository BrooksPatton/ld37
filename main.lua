require('lib/lovedebug')

function love.load()
  Board = require('board')
  door = require('door')
  Paddle = require('paddle')
  Ball = require('ball')
  Door = require('door')
  Welcome = require('welcome')
  GameOver = require('game-over')
  Brick = require('brick')
  Item = require('item')
  Laser = require('laser')
  sounds = {
    itemCaughtDown = love.audio.newSource('sounds/item_caught_down.wav', 'static'),
    itemCaughtUp = love.audio.newSource('sounds/item_caught_up.wav', 'static')
  }

  welcomeScreen = Welcome.new()

  door = Door.new()
  board = Board.new(door, Brick, Item)
  playerPaddle = Paddle.new()
  ball = Ball.new(playerPaddle, board)
  lasers = {}

  gameOverScreen = GameOver.new()

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
    gameOverScreen:draw()
  end

  if ball.moving then
    drawLasers()
  end
end

function love.keypressed(key, scancode, isrepeat)
  -- We want the scancode here as it is the physical key pressed and ignores whatever strange keyboard layout the user has
  if state == 'starting' and scancode == 'enter' or scancode == 'return' then
    state = 'playing'
  end

  if state == 'playing' then
    if scancode == 'space' then
      ball:start()
    end
  end

  if state == 'gameOver' and scancode == 'enter' or scancode == 'return' then
    resetGame()
  end
end

function love.update(dt)
  playerPaddle:move(dt)

  if board.gameOver then
    gameOverScreen:updateTitle(ball)
    lasers = {}
    state = 'gameOver'
  end

  ball:move(dt)

  if ball.moving then
    for i,laser in ipairs(lasers) do
      if laser.finished then
        table.remove(lasers, i)
      end

      laser:setFiringStatus()

      if laser:hitPaddle(playerPaddle) then
        ball:loseLife()
      end
    end

    if shouldWeFireLaser() then
      local laser = Laser.new(lasers)

      laser:startFiringSequence(board)

      table.insert(lasers, laser)
    end
  end

  dropItems(board.items, dt)
  checkItemCollison(board.items)
end

function resetGame()
  ball:resetNumberOfBalls()
  ball:resetBall()
  board:startGame()
  door:reset()
  laesrs = {}
  state = 'playing'
end

function dropItems(items, dt)
  for i,item in ipairs(items) do
    if item.falling then
      item.y = item.y + item.speed * dt
    end
  end
end

function checkItemCollison(items)
  for i,item in ipairs(items) do
    if item:collideWithPaddle(playerPaddle) then
      love.audio.setVolume(1)
      if item.item.value > 0 then
        love.audio.play(sounds.itemCaughtUp)
      else
        love.audio.play(sounds.itemCaughtDown)
      end
      playerPaddle:applyItem(item)
      board:removeItem(item)
    end
  end
end

function drawLasers()
  for i,laser in ipairs(lasers) do
    laser:draw()
  end
end

function shouldWeFireLaser()
  return math.random(0, 200) < 1
end
