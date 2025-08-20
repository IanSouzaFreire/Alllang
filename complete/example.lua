-- Lua

Vec2 = {}
Vec2.__index = Vec2

function Vec2:new(X, Y)
  local obj = {x = X, y = Y}
  setmetatable(obj, Vec2)
  return obj
end

function Vec2:add(other)
  self.x = self.x + other.x
  self.y = self.y + other.y
end

function Vec2:scale(scalar)
  self.x = self.x * scalar
  self.y = self.y * scalar
end

Size = {}
Size.__index = Size

function Size:new(w, h)
  local obj = {width = w, height = h}
  setmetatable(obj, Size)
  return obj
end

GameObject = {}
GameObject.__index = GameObject

function GameObject:new(position, size)
  local obj = {position = position, size = size}
  setmetatable(obj, GameObject)
  return obj
end

function GameObject:horizontalCollision(other)
  return (other.position.x < self.position.x + self.size.width and
          other.position.x + other.size.width > self.position.x)
end

function GameObject:verticalCollision(other)
  return (other.position.y < self.position.y + self.size.height and
          other.position.y + other.size.height > self.position.y)
end

function GameObject:collide(other)
  return self:horizontalCollision(other) and self:verticalCollision(other)
end

MovableObject = setmetatable({}, {__index = GameObject})
MovableObject.__index = MovableObject

function MovableObject:new(position, size, velocity, acceleration)
  local obj = GameObject:new(position, size)
  obj.velocity = velocity
  obj.acceleration = acceleration
  setmetatable(obj, MovableObject)
  return obj
end

function MovableObject:update(deltaTime)
  self.velocity:add(self.acceleration:scale(deltaTime))
  self.position:add(self.velocity:scale(deltaTime))
end

Car = setmetatable({}, {__index = MovableObject})
Car.__index = Car

function Car:new(position, size, velocity, acceleration, turnAngle)
  local obj = MovableObject:new(position, size, velocity, acceleration)
  obj.turnAngle = turnAngle
  setmetatable(obj, Car)
  return obj
end

function Car:turn(angle)
  self.turnAngle = self.turnAngle + angle
end

function Car:update(deltaTime)
  MovableObject.update(self, deltaTime)
end