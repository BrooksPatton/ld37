local Ball = {}
Ball.__index = Ball

function Ball.new()
  local self = setmetatable({}, Ball)

  self.width = 10
  self.height = self.width
  self.x = 400 - self.width / 2
  self.y = 500
  self.color = {255, 255, 255}
  self.moving = false
  self.speedX = 250
  self.speedY = -250

  return self
end

function Ball:draw()
  love.graphics.setColor(self.color[1], self.color[2], self.color[3])
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Ball:move(dt)
  if self.x <= board.x or self.x + self.width >= board.width + board.x then
    self.speedX = self.speedX * -1
  elseif self.y <= board.y or self.y + self.height >= board.height + board.y then
    self.speedY = self.speedY * -1
  end

  self.x = self.x + self.speedX * dt
  self.y = self.y + self.speedY * dt
end

return Ball
