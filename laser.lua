local Laser = {}
Laser.__index = Laser

function Laser.new()
  local self = setmetatable({}, Laser)

  self.finished = false

  self.timeToFire = 3

  self.stopFiring = 6

  self.height = 20

  return self
end

function Laser:startFiringSequence(board)
  self.y = math.random(200, board.height + board.y)

  self.aiming = true
  self.startedAiming = love.timer.getTime()
end

function Laser:draw()
  if self.aiming then
    love.graphics.setColor(255, 0, 0, 75)
    love.graphics.rectangle('fill', 0, self.y, 800, 20)
  end

  if self.firing then
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle('fill', 0, self.y, 800, 20)
  end
end

function Laser:setFiringStatus()
  if love.timer.getTime() - self.startedAiming >= self.timeToFire then
    self.firing = true
  end

  if love.timer.getTime() - self.startedAiming >= self.stopFiring then
    self.firing = false
    self.aiming = false
    self.finished = true
  end
end

function Laser:hitPaddle(paddle)
  if self.firing and not self.finished then
    if paddle.y >= self.y and paddle.y <= self.y + self.height
              or paddle.y + paddle.height >= self.y and paddle.y + paddle.height <= self.y + self.height then 
      self.finished = true
      return true
    end
  end

  return false
end

return Laser
