local Brick = {}
Brick.__index = Brick

function Brick.new(x, y)
  local self = setmetatable({}, Brick)

  self.width = 61.5
  self.height = 25
  self.x = x
  self.y = y
  self.color = {115, 195, 112}

  return self
end

function Brick:draw()
  love.graphics.setColor(self.color[1], self.color[2], self.color[3])
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Brick
