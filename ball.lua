local Ball = {}
Ball.__index = Ball

function Ball.new(paddle, board)
  local self = setmetatable({}, Ball)

  self.paddle = paddle
  self.board = board

  self.width = 10
  self.height = self.width
  self.color = {255, 255, 255}
  self.ballsLeft = 3

  self:resetBall()
  return self
end

function Ball:resetBall()
  self.x = 400 - self.width / 2
  self.y = 500
  self.moving = false
  self.speedX = 250
  self.speedY = -250
end

function Ball:draw()
  love.graphics.setColor(self.color[1], self.color[2], self.color[3])
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
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
      self.y = self.paddle.y - self.height
      self:reverseY()
    elseif self:collideWithTop() then
      self.y = self.board.y
      self.speedY = self.speedY * -1
    elseif self:collideWithBottom() then
      self:loseLife()
      self:resetBall()
    end

    self.x = self.x + self.speedX * dt
    self.y = self.y + self.speedY * dt
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
end

return Ball
