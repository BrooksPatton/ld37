local Ball = {}
Ball.__index = Ball

function Ball.new(paddle, board)
  local self = setmetatable({}, Ball)

  self.paddle = paddle
  self.board = board

  self.width = 10
  self.height = self.width
  self.color = {255, 255, 255}

  self:resetBall()
  self:resetNumberOfBalls()
  return self
end

function Ball:resetBall()
  self.x = 400 - self.width / 2
  self.y = 500
  self.moving = false
  self.speedX = 150
  self.speedY = -150
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
      self.x = self.board.x
      self:reverseX()
    elseif self:collideWithRight() then
      self.x = self.board.width + self.board.x - self.width
      self:reverseX()
    elseif self:collideWithPaddle() then
      local angle = self:getOffsetOfPaddle()
      self.y = self.paddle.y - self.height
      self:reverseY()
      self:changeX(angle)
    elseif self.board:collideWithDoor(self) then
      self.y = self.board.door.y + self.board.door.height + self.board.y
      self:reverseY()
    elseif self:collideWithTop() then
      self.y = self.board.y
      self.speedY = self.speedY * -1
    elseif self:collideWithBottom() then
      self:loseLife()
      self:resetBall()
    elseif self:collideWithBrick() then
      self:reverseY()
    end

    local speedboostX = self.speedX * self.paddle.ballSpeedUp
    local speedboostY = self.speedY * self.paddle.ballSpeedUp

    self.x = self.x + speedboostX * dt
    self.y = self.y + speedboostY * dt
  end
end

function Ball:collideWithPaddle()
  return self.x > self.paddle.x and self.x + self.width < self.paddle.x + self.paddle.width and self.y + self.height > self.paddle.y and self.y + self.height < self.paddle.y + self.paddle.height
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
    if self.x > brick.x and self.x + self.width < brick.x + brick.width and self.y < brick.y + brick.height and self.y + self.height > brick.y then
      self.board:resolveBrickHit(i)
      return true
    end
  end

  return false
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

return Ball
