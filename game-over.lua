local GameOver = {}
GameOver.__index = GameOver

function GameOver.new()
  local self = setmetatable({}, GameOver)

  self.mainTitle = {
    fontSize = 48,
    color = {228, 235, 248},
    text = 'Game Over'
  }

  self.mainTitle.font = love.graphics.newFont(self.mainTitle.fontSize)

  self.begin = {
    fontSize = 24,
    text = 'Press Enter to play again'
  }

  self.begin.font = love.graphics.newFont(self.begin.fontSize)

  return self
end

function GameOver:draw()
  love.graphics.setFont(self.mainTitle.font)
  love.graphics.setColor(self.mainTitle.color[1], self.mainTitle.color[2], self.mainTitle.color[3])

  local fontWidth = self.mainTitle.font:getWidth(self.mainTitle.text)
  local fontHeight = self.mainTitle.font:getHeight(self.mainTitle.text)

  love.graphics.print(self.mainTitle.text, 400 - fontWidth / 2, 200 - fontHeight / 2)

  love.graphics.setFont(self.begin.font)
  love.graphics.printf(self.begin.text, 0, 500, 800, 'center')
end

function GameOver:updateTitle(ball)
  if ball.ballsLeft > 0 then
    self.mainTitle.text = 'You Win!!!'
  else
    self.mainTitle.text = 'You did not escape the room'
  end
end

return GameOver
