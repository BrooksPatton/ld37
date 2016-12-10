local Paddle = {}
Paddle.__index = Paddle

function Paddle.new()
  local self = setmetatable({}, Paddle)

  self.x = 375
  self.y = 550
  self.width = 50
  self.height = 15
  self.color = {171, 173, 156}
  self.movingDirection = nil
  self.speed = 250

  return self
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

return Paddle
