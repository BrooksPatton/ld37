local images = {
  paddleSpeedUp = love.graphics.newImage('images/paddle_speed_up.png'),
  ballSpeedUp = love.graphics.newImage('images/ball_speed_up.png'),
  paddleSizeUp = love.graphics.newImage('images/paddle_size_up.png'),
  paddleSpeedDown = love.graphics.newImage('images/paddle_speed_down.png'),
  ballSpeedDown = love.graphics.newImage('images/ball_speed_down.png'),
  paddleSizeDown = love.graphics.newImage('images/paddle_size_down.png')
}

local fallingSound = love.audio.newSource('sounds/item_breaks_free.wav', 'static')

local Item = {}
Item.__index = Item

function Item.new(i, brick)
  local self = setmetatable({}, Item)

  self.brickId = brick.id

  self.possibleItems = {
    {name = 'paddle size up', value = 5, logo = images.paddleSizeUp},
    {name = 'ball speed up', value = 0.2, logo = images.ballSpeedUp},
    {name = 'paddle speed up', value = 15, logo = images.paddleSpeedUp},
    {name = 'paddle size down', value = -5, logo = images.paddleSizeDown},
    {name = 'ball speed down', value = -0.2, logo = images.ballSpeedDown},
    {name = 'paddle speed down', value = -15, logo = images.paddleSpeedDown}
  }

  self.fallingSound = fallingSound

  self.item = self.possibleItems[i]

  self.falling = false
  self.speed = 100
  self.y = brick.y
  self.x = brick.x
  self.width = self.possibleItems[1].logo:getWidth()
  self.brickWidth = brick.width
  self.height = self.possibleItems[1].logo:getHeight()
  self.brickColor = brick.colors[brick.color]

  return self
end

function Item:draw()
  -- love.graphics.setColor(self.brickColor[1], self.brickColor[2], self.brickColor[3])
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(self.item.logo, self.x + (self.brickWidth / 2) - (self.width / 2), self.y)
end

function Item:startFalling()
  self.falling = true
  love.audio.setVolume(1)
  love.audio.play(self.fallingSound)
end

function Item:collideWithPaddle(paddle)
  return (self.x > paddle.x and self.x < paddle.x + paddle.width and self.y + self.height > paddle.y and self.y + self.height < paddle.y + paddle.height)
        or (self.x > paddle.x and self.x < paddle.x + paddle.width and self.y > paddle.y and self.y < paddle.y + paddle.height)
        or (self.x + self.width > paddle.x and self.x + self.width < paddle.x + paddle.width and self.y + self.height > paddle.y and self.y + self.height < paddle.y + paddle.height)
        or (self.x + self.width > paddle.x and self.x + self.width < paddle.x + paddle.width and self.y > paddle.y and self.y < paddle.y + paddle.height)
end

return Item
