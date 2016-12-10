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

  for i=1,5 do
    bricks = self:concatTables(self:addRowOfBricks(x, y), bricks)
    x = self.x
    y = y + bricks[1].height + 1
  end

  return bricks
end

function Board:addRowOfBricks(x, y)
  local brick
  local bricks = {}

  for i=1,12 do
    brick = Brick.new(x, y)
    table.insert(bricks, brick)
    x = x + brick.width + 1
  end

  return bricks
end


function Board:resolveBrickHit(i)
  if self.bricks[i].color == 'green' then
    table.remove(self.bricks, i)
  elseif self.bricks[i].color == 'red' then
    self.bricks[i].color = 'green'
  elseif self.bricks[i].color == 'blue' then
    self.bricks[i].color = 'red'
  end
end

function Board:removeBricks()
  self.bricks = {}
end

function Board:concatTables(t1, t2)
  for i,v in ipairs(t1) do
    table.insert(t2, v)
  end

  return t2
end

return Board
