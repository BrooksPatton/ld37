local Board = {}
Board.__index = Board

function Board.new()
  local self = setmetatable({}, Board)

  self.y = 25
  self.x = 25
  self.width = 750
  self.height = 550
  self.color = {241, 241, 241}

  self.fontSize = 24
  self.font = love.graphics.newFont(self.fontSize)
  self.fontColor = {0, 156, 220}

  return self
end

function Board:draw(ballsLeft)
  love.graphics.setColor(self.color[1], self.color[2], self.color[3])
  love.graphics.rectangle('line', self.x, self.y, self.width, self.height)

  love.graphics.setFont(self.font)
  love.graphics.setColor(self.fontColor[1], self.fontColor[2], self.fontColor[3])
  love.graphics.print('Balls left: ' .. ballsLeft, self.x, (self.y / 2) - (self.fontSize / 2))
end

return Board
