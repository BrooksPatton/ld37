local Door = {}
Door.__index = Door

function Door.new()
  local self = setmetatable({}, Door)

  self.doorHeight = 12.5

  self.width = 50
  self.height = self.doorHeight
  self.x = 375
  self.y = 25 - self.height + 1
  self.color = {224, 108, 117}
  self.isOpen = false

  return self
end

function Door:draw()
  love.graphics.setColor(door.color[1], door.color[2], door.color[3])
  love.graphics.rectangle('fill', door.x, door.y, door.width, door.height)
end

function Door:open()
  self.isOpen = true
  self.color = {0, 0, 0}
end

return Door
