local Brick = {}
Brick.__index = Brick

function Brick.new(x, y)
  local self = setmetatable({}, Brick)

  -- green 1 hit 80%
  -- red 2 hits 10 %
  -- blue 3 hits 7%
  -- grey cannot break 3%

  local random = math.random(0, 100)

  self.colors = {
    green = {115, 195, 112},
    red = {206, 72, 64},
    blue = {42, 124, 159},
    grey = {141, 149, 163}
  }

  if random < 80 then
    self.color = 'green'
  elseif random < 90 then
    self.color = 'red'
  elseif random < 97 then
    self.color = 'blue'
  else
    self.color = 'grey'
  end

  self.width = 61.5
  self.height = 25
  self.x = x
  self.y = y

  return self
end

function Brick:draw()
  love.graphics.setColor(self.colors[self.color], self.colors[self.color], self.colors[self.color])
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Brick
