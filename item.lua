local Item = {}
Item.__index = Item

function Item.new(i, brick)
  local self = setmetatable({}, Item)

  self.brickId = brick.id

  self.possibleItems = {
    {name = 'paddle size up', value = 10, logo = 'P+'},
    {name = 'ball speed up', value = 25, logo = 'B+'},
    {name = 'paddle speed up', value = 50, logo = 'PS+'}
  }

  self.item = self.possibleItems[i]

  self.font = love.graphics.newFont(18)
  self.falling = false
  self.speed = 100
  self.y = brick.y + brick.height / 2 - self.font:getHeight() / 2
  self.x = brick.x
  self.brickWidth = brick.width

  return self
end

function Item:draw()
  if self.falling then
    love.graphics.setColor(255, 255, 255)
  else
    love.graphics.setColor(0, 0, 0)
  end

  love.graphics.setFont(self.font)
  love.graphics.printf(self.item.logo, self.x, self.y, self.brickWidth, 'center')
end

function Item:startFalling()
  self.falling = true
end

return Item
