local Welcome = {}
Welcome.__index = Welcome

function Welcome.new()
  local self = setmetatable({}, Welcome)


  self.mainTitle = {
    fontSize = 64,
    color = {228, 235, 248},
    text = 'Breakout Da Room!'
  }

  self.mainTitle.font = love.graphics.newFont(self.mainTitle.fontSize)

  self.objectives = {
    fontSize = 14,
    text = {
      'You are trapped in a room',
      'Break down the door',
      '...and escape'
    }
  }

  self.objectives.font = love.graphics.newFont(self.objectives.fontSize)

  self.attribution = {
    fontSize = 14,
    text = {
      'A Ludum Dare game (ld37)',
      'made by brookzerker'
    }
  }

  self.attribution.font = love.graphics.newFont(self.attribution.fontSize)

  self.controls = {
    fontSize = 16,
    text = {
      '"A" moves paddle left',
      '"D" moves paddle right',
      '"SPACE" starts the ball moving'
    }
  }

  self.controls.font = love.graphics.newFont(self.controls.fontSize)

  self.begin = {
    fontSize = 24,
    text = 'Press any key to begin'
  }

  self.begin.font = love.graphics.newFont(self.begin.fontSize)

  return self
end

function Welcome:draw()
  love.graphics.setFont(self.mainTitle.font)
  love.graphics.setColor(self.mainTitle.color[1], self.mainTitle.color[2], self.mainTitle.color[3])

  local fontWidth = self.mainTitle.font:getWidth(self.mainTitle.text)
  local fontHeight = self.mainTitle.font:getHeight(self.mainTitle.text)

  love.graphics.print(self.mainTitle.text, 400 - fontWidth / 2, 200 - fontHeight / 2)

  love.graphics.setFont(self.objectives.font)
  fontHeight = self.objectives.font:getHeight(self.objectives.text[1])
  local x = 75
  local y = 300

  for i,text in ipairs(self.objectives.text) do
    love.graphics.print(text, x, y)
    y = y + fontHeight + 5
  end

  love.graphics.setFont(self.attribution.font)
  fontHeight = self.attribution.font:getHeight(self.attribution.text[1])
  fontWidth = self.attribution.font:getWidth(self.attribution.text[1])
  local x = 800 - fontWidth - 75
  local y = 300

  for i,text in ipairs(self.attribution.text) do
    love.graphics.print(text, x, y)
    y = y + fontHeight + 5
  end

  love.graphics.setFont(self.controls.font)
  local y = 400

  for i,text in ipairs(self.controls.text) do
    love.graphics.printf(text, 0, y, 800, 'center')
    y = y + fontHeight + 5
  end

  love.graphics.setFont(self.begin.font)
  love.graphics.printf(self.begin.text, 0, 500, 800, 'center')
end

return Welcome
