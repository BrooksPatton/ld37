local Board = {}
Board.__index = Board

function Board.new(door, Brick)
  local self = setmetatable({}, Board)

  self.door = door

  self.y = 25
  self.x = 25
  self.width = 750
  self.height = 550
  self.color = {241, 241, 241}

  self.fontSize = 24
  self.font = love.graphics.newFont(self.fontSize)
  self.fontColor = {0, 156, 220}

  self.bricks = self:generateBricks()

  self:startGame()

  return self
end

function Board:draw(ballsLeft)
  love.graphics.setColor(self.color[1], self.color[2], self.color[3])
  love.graphics.rectangle('line', self.x, self.y, self.width, self.height)

  love.graphics.setFont(self.font)
  love.graphics.setColor(self.fontColor[1], self.fontColor[2], self.fontColor[3])
  love.graphics.print('Balls left: ' .. ballsLeft, self.x, (self.y / 2) - (self.fontSize / 2))

  self.door:draw()

  for i,brick in ipairs(self.bricks) do
    brick:draw()
  end
end

function Board:collideWithDoor(ball)
  if ball.y <= self.door.y + self.door.height + self.y and ball.x > self.door.x and ball.x + ball.width < self.door.x + self.door.width then
    if self.door.isOpen then
      ball:disappear()
      self:endGame()
    else
      self.door:open()
      return true
    end
  end
end

function Board:endGame()
  self.gameOver = true
end

function Board:startGame()
  self.gameOver = false
  self:removeBricks()
  self.bricks = self:generateBricks()
end

function Board:generateBricks()
  local bricks = {}
  local x = self.x
  local y = self.y *2
  local brick

  for i=1,12 do
    brick = Brick.new(x, y)
    table.insert(bricks, brick)
    x = x + brick.width + 1
  end

  return bricks
end

function Board:removeBrick(i)
  table.remove(self.bricks, i)
end

function Board:removeBricks()
  self.bricks = {}
end

return Board
