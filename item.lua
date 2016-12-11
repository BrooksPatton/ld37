local Item = {}
Item.__index = Item

function Item.new(i, brick)
  local self = setmetatable({}, Item)

  self.brickId = brick.id

  self.possibleItems = {
    {name = 'paddle size up', value = 5, logo = 'P+'},
    {name = 'ball speed up', value = 0.2, logo = 'B+'},
    {name = 'paddle speed up', value = 15, logo = 'PS+'},
    {name = 'paddle size down', value = -5, logo = 'P-'},
    {name = 'ball speed down', value = -0.2, logo = 'B-'},
    {name = 'paddle speed down', value = -15, logo = 'PS-'},
  }

  self.item = self.possibleItems[i]

  self.font = love.graphics.newFont(18)
  self.falling = false
  self.speed = 100
  self.y = brick.y + brick.height / 2 - self.font:getHeight() / 2
  self.x = brick.x
  self.width = brick.width
  self.height = self.font:getHeight()

  return self
end

function Item:draw()
  if self.falling then
    love.graphics.setColor(255, 255, 255)
  else
    love.graphics.setColor(0, 0, 0)
  end

  love.graphics.setFont(self.font)
  love.graphics.printf(self.item.logo, self.x, self.y, self.width, 'center')
end

function Item:startFalling()
  self.falling = true
end

function Item:collideWithPaddle(paddle)
  return (self.x > paddle.x and self.x < paddle.x + paddle.width and self.y + self.height > paddle.y and self.y + self.height < paddle.y + paddle.height)
        or (self.x > paddle.x and self.x < paddle.x + paddle.width and self.y > paddle.y and self.y < paddle.y + paddle.height)
        or (self.x + self.width > paddle.x and self.x + self.width < paddle.x + paddle.width and self.y + self.height > paddle.y and self.y + self.height < paddle.y + paddle.height)
        or (self.x + self.width > paddle.x and self.x + self.width < paddle.x + paddle.width and self.y > paddle.y and self.y < paddle.y + paddle.height)
end

return Item
