# Julia

mutable struct Vec2
  x::Float64
  y::Float64
end

function add!(v::Vec2, other::Vec2)
  v.x += other.x
  v.y += other.y
  return nothing
end

function scale(v::Vec2, scalar::Float64)::Vec2
  return Vec2(v.x * scalar, v.y * scalar)
end

mutable struct Size
  width::Float64
  height::Float64
end

mutable struct GameObject
  position::Vec2
  size::Size
end

function horizontal_collision(self::GameObject, other::GameObject)::Bool
  return (other.position.x < self.position.x + self.size.width) &&
         (other.position.x + other.size.width > self.position.x)
end

function vertical_collision(self::GameObject, other::GameObject)::Bool
  return (other.position.y < self.position.y + self.size.height) &&
         (other.position.y + other.size.height > self.position.y)
end

function collide(self::GameObject, other::GameObject)::Bool
  return horizontal_collision(self, other) && vertical_collision(self, other)
end

mutable struct MovableObject <: GameObject
  velocity::Vec2
  acceleration::Vec2
end

function MovableObject(position::Vec2, size::Size, velocity::Vec2, acceleration::Vec2)
  mo = new()
  mo.position = position
  mo.size = size
  mo.velocity = velocity
  mo.acceleration = acceleration
  return mo
end

function update!(self::MovableObject, delta_time::Float64)
  add!(self.velocity, scale(self.acceleration, delta_time))
  add!(self.position, scale(self.velocity, delta_time))
  return nothing
end

mutable struct Car <: MovableObject
  turn_angle::Float64
end

function Car(position::Vec2, size::Size, velocity::Vec2, acceleration::Vec2, turn_angle::Float64)
  c = new()
  c.position = position
  c.size = size
  c.velocity = velocity
  c.acceleration = acceleration
  c.turn_angle = turn_angle
  return c
end

function turn!(self::Car, angle::Float64)
  self.turn_angle += angle
  return nothing
end

function update!(self::Car, delta_time::Float64)
  update!(MovableObject(self), delta_time)
  return nothing
end
