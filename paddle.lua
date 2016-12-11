local Paddle = {}
Paddle.__index = Paddle

function Paddle.new()
  local self = setmetatable({}, Paddle)

  self.x = 375
  self.y = 550
  self.height = 15
  self.color = {171, 173, 156}
  self.movingDirection = nil
  self.ballSpeedUp = 1

  self:resetPaddle()

  return self
end

function Paddle:resetPaddle()
  self.width = 50
  self.speed = 250
end

function Paddle:draw()
  love.graphics.setColor(self.color[1], self.color[2], self.color[3])
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Paddle:setMoving(direction)
  self.movingDirection = direction
end

function Paddle:moveRight(dt)
  if self.x + 50 >= 775 then
    self.x = 725
  else
    self.x = self.x + self.speed * dt
  end
end

function Paddle:moveLeft(dt)
  if self.x <= 25 then
    self.x = 25
  else
    self.x = self.x - self.speed * dt
  end
end

function Paddle:applyItem(item)
  if item.item.name == 'paddle size up' then
    self.width = self.width + item.item.value
  elseif item.item.name == 'paddle speed up' then
    self.speed = self.speed + item.item.value
  elseif item.item.name == 'ball speed up' then
    self.ballSpeedUp = self.ballSpeedUp + item.item.value
  elseif item.item.name == 'paddle size down' then
    self.width = self.width + item.item.value
  elseif item.item.name == 'paddle speed down' then
    self.speed = self.speed + item.item.value
  elseif item.item.name == 'ball speed down' then
    self.ballSpeedUp = self.ballSpeedUp + item.item.value
  end
end

function Paddle:resetBallSpeedUp()
  self.ballSpeedUp = 1
end

return Paddle
