local images = {
  paddleSpeedUp = love.graphics.newImage('images/paddle_speed_up.png')
}

local Item = {}
Item.__index = Item

function Item.new(i, brick)
  local self = setmetatable({}, Item)

  self.brickId = brick.id

  self.possibleItems = {
    {name = 'paddle size up', value = 5, logo = images.paddleSpeedUp},
    {name = 'ball speed up', value = 0.2, logo = images.paddleSpeedUp},
    {name = 'paddle speed up', value = 15, logo = images.paddleSpeedUp},
    {name = 'paddle size down', value = -5, logo = images.paddleSpeedUp},
    {name = 'ball speed down', value = -0.2, logo = images.paddleSpeedUp},
    {name = 'paddle speed down', value = -15, logo = images.paddleSpeedUp},
  }

  self.item = self.possibleItems[i]

  self.falling = false
  self.speed = 100
  self.y = brick.y
  self.x = brick.x
  self.width = self.possibleItems[1].logo:getWidth()
  self.brickWidth = brick.width
  self.height = self.possibleItems[1].logo:getHeight()

  return self
end

function Item:draw()
  love.graphics.draw(self.item.logo, self.x + (self.brickWidth / 2) - (self.width / 2), self.y)
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
