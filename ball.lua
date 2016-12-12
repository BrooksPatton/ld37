local sounds = {
  hitWall = love.audio.newSource('sounds/ball_hit_wall.wav', 'static'),
  hitBrick = {
    green = love.audio.newSource('sounds/ball_hit_brick_1.wav', 'static'),
    red = love.audio.newSource('sounds/ball_hit_brick_2.wav', 'static'),
    blue = love.audio.newSource('sounds/ball_hit_brick_3.wav', 'static'),
    grey = love.audio.newSource('sounds/ball_hit_brick_4.wav', 'static')
  },
  hitPaddle = love.audio.newSource('sounds/ball_hit_paddle.wav', 'static'),
  ballLost = love.audio.newSource('sounds/ball_lost.wav', 'static'),
  hitDoor = love.audio.newSource('sounds/ball_hit_door.wav', 'static')
}

local Ball = {}
Ball.__index = Ball

function Ball.new(paddle, board)
  local self = setmetatable({}, Ball)

  self.startingSpeed = 350

  self.paddle = paddle
  self.board = board

  self.width = 10
  self.height = self.width
  self.color = {255, 255, 255}

  self.sounds = {
    hitWall = sounds.hitWall,
    hitBrick = sounds.hitBrick,
    hitPaddle = sounds.hitPaddle,
    ballLost = sounds.ballLost,
    hitDoor = sounds.hitDoor
  }

  self:resetBall()
  self:resetNumberOfBalls()
  return self
end

function Ball:resetBall()
  self.x = 400 - self.width / 2
  self.y = 500
  self.moving = false
  self.speedX = self.startingSpeed
  self.speedY = self.startingSpeed * -1
  self.display = true
  self.paddle:resetBallSpeedUp()
  self.paddle:resetPaddle()
  self.board:removeFallingItems()
end

function Ball:draw()
  if self.display then
    love.graphics.setColor(self.color[1], self.color[2], self.color[3])
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  end
end

function Ball:move(dt)
  if self.moving then
    if self:collideWithLeft() then
      love.audio.setVolume(1)
      love.audio.play(self.sounds.hitWall)
      self.x = self.board.x
      self:reverseX()
    elseif self:collideWithRight() then
      love.audio.setVolume(1)
      love.audio.play(self.sounds.hitWall)
      self.x = self.board.width + self.board.x - self.width
      self:reverseX()
    elseif self:collideWithPaddle() then
      love.audio.setVolume(1)
      love.audio.play(self.sounds.hitPaddle)
      local angle = self:getOffsetOfPaddle()
      self.y = self.paddle.y - self.height
      self:reverseY()
      self:changeX(angle)
    elseif self.board:collideWithDoor(self) then
      love.audio.setVolume(1)
      love.audio.play(self.sounds.hitDoor)
      self.y = self.board.door.y + self.board.door.height
      self:reverseY()
    elseif self:collideWithTop() then
      love.audio.setVolume(1)
      love.audio.play(self.sounds.hitWall)
      self.y = self.board.y
      self.speedY = self.speedY * -1
    elseif self:collideWithBottom() then
      self:loseLife()
      self:resetBall()
    else
      self:collideWithBrick()
    end

    local speedboostX = self.speedX * self.paddle.ballSpeedUp
    local speedboostY = self.speedY * self.paddle.ballSpeedUp

    self.x = self.x + speedboostX * dt
    self.y = self.y + speedboostY * dt
  end
end

function Ball:collideWithPaddle()
  return self.x > self.paddle.x and self.x < self.paddle.x + self.paddle.width and self.y > self.paddle.y and self.y < self.paddle.height
        or self.x + self.width > self.paddle.x and self.x + self.width < self.paddle.x + self.paddle.width and self.y > self.paddle.y and self.y < self.paddle.y + self.paddle.height
        or self.x > self.paddle.x and self.x < self.paddle.x + self.paddle.width and self.y + self.height > self.paddle.y and self.y + self.height < self.paddle.y + self.paddle.height
        or self.x + self.width > self.paddle.x and self.x + self.width < self.paddle.x + self.paddle.width and self.y + self.height > self.paddle.y and self.y + self.height < self.paddle.y + self.paddle.height
end

function Ball:collideWithLeft()
  return self.x <= self.board.x
end

function Ball:collideWithRight()
  return self.x + self.width >= self.board.width + self.board.x
end

function Ball:collideWithTop()
  return self.y <= self.board.y
end

function Ball:reverseX()
  self.speedX = self.speedX * -1
end

function Ball:reverseY()
  self.speedY = self.speedY * -1
end

function Ball:collideWithBottom()
  return self.y + self.height >= self.board.height + self.board.y
end

function Ball:start()
  self.moving = true
end

function Ball:loseLife()
  love.audio.setVolume(1)
  love.audio.play(self.sounds.ballLost)
  self.ballsLeft = self.ballsLeft - 1
  if self.ballsLeft == 0 then
    self.board:endGame()
  end
end

function Ball:disappear()
  self.display = false
  self.moving = false
end

function Ball:resetNumberOfBalls()
  self.ballsLeft = 3
end

function Ball:collideWithBrick()
  for i,brick in ipairs(self.board.bricks) do
    if self:checkCollision(brick) then
      love.audio.setVolume(1)
      love.audio.rewind(self.sounds.hitBrick[brick.color])
      love.audio.play(self.sounds.hitBrick[brick.color])
      self.board:resolveBrickHit(i)
      -- move the ball to the appropriate side so that it is not inside the brick
      self:moveOutsideCollidedObject(brick)
      return true
    end
  end

  return false
end

function Ball:checkCollision(item)
  local topLeft = self.x > item.x and self.x < item.x + item.width and self.y > item.y and self.y < item.y + item.height
  local bottomLeft = self.x > item.x and self.x < item.x + item.width and self.y + self.height > item.y and self.y + self.height < item.y + item.height
  local topRight = self.x + self.width > item.x and self.x + self.width < item.x + item.width and self.y > item.y and self.y < item.y + item.height
  local bottomRight = self.x + self.width > item.x and self.x + self.width < item.x + item.width and self.y + self.height > item.y and self.y + self.height < item.y + item.height

  return topLeft or bottomLeft or topRight or bottomRight
end

function Ball:getOffsetOfPaddle()
  local difference = (self.x + self.width / 2) - (self.paddle.x + self.paddle.width / 2)
  return difference
end

function Ball:changeX(angle)
  if angle < 0 then
    self.speedX = -90 + angle * 2
  elseif angle == 0 then
    self.speedX = 0
  else
    self.speedX = 90 + angle * 2
  end
end

function Ball:moveOutsideCollidedObject(item)
  local reverseY = false
  local reverseX = false

  if self.y + self.height < item.y + (item.height / 2) then
    -- if we are on the top, move to the top
    self.y = item.y - self.height
    reverseY = true
  elseif self.y > item.y + (item.height / 2) then
    -- if we are on the bottom, move to the bottom
    self.y = item.y + item.height
    reverseY = true
  elseif self.x + self.width < item.x + (item.width / 2) then
    -- if we are on the left, move to the left
    self.x = item.x - self.width
    reverseX = true
  elseif self.x > item.x + (item.width / 2) then
    -- if we are on the right, move to the right
    self.x = item.x + item.width
    reverseX = true
  end

  if reverseY then
    self:reverseY()
  elseif reverseX then
    self:reverseX()
  end
end

return Ball
