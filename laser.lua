local Laser = {}
Laser.__index = Laser

function Laser.new()
  local self = setmetatable({}, Laser)

  return self
end

return Laser
