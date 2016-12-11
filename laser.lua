local Laser = {}
Laser.__index = Laser

function Laser.new()
  local self = setmetatable({}, Laser)

  self.finished = false

  return self
end

function Laser:startFiringSequence(board)
  self.y = math.random(200, board.height + board.y)

  self.aiming = true
end

function Laser:draw()
  if self.aiming then
    love.graphics.setColor(255, 0, 0, 75)
    love.graphics.rectangle('fill', 0, self.y, 800, 1)
  end
end

return Laser
