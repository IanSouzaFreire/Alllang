# Bend

object Vec2 { x, y }

def new_Vec2(x, y):
  return Vec2 { x: x, y: y }

def Vec2_add(self, other):
  return Vec2 { x: self.x + other.x, y: self.y + other.y }

def Vec2_scale(self, scalar):
  return new_Vec2(self.x * scalar, self.y * scalar)

object Size { width, height }

def new_Size(width, height):
  return Size { width: width, height: height }

object GameObject { position, size }

def new_GameObject(position, size):
  return GameObject { position: position, size: size }

def GameObject_horizontal_collision(self, other):
  return (other.position.x < self.position.x + self.size.width) and
         (other.position.x + other.size.width > self.position.x)

def GameObject_vertical_collision(self, other):
  return (other.position.y < self.position.y + self.size.height) and
         (other.position.y + other.size.height > self.position.y)

def GameObject_collide(self, other):
  return GameObject_horizontal_collision(self, other) and
         GameObject_vertical_collision(self, other)

object MovableObject { position, size, velocity, acceleration }

def new_MovableObject(position, size, velocity, acceleration):
  return MovableObject { position: position,
                         size: size,
                         velocity: velocity,
                         acceleration: acceleration }

def MovableObject_update(self, delta_time):
  new_velocity = Vec2_add(self.velocity, Vec2_scale(self.acceleration, delta_time))
  new_position = Vec2_add(self.position, Vec2_scale(new_velocity, delta_time))
  return MovableObject { position: new_position,
                         size: self.size,
                         velocity: new_velocity,
                         acceleration: self.acceleration }

object Car { position, size, velocity, acceleration, turn_angle }

def new_Car(position, size, velocity, acceleration, turn_angle):
  return Car { position: position,
               size: size,
               velocity: velocity,
               acceleration: acceleration,
               turn_angle: turn_angle }

def Car_turn(self, angle):
  return Car { position: self.position,
               size: self.size,
               velocity: self.velocity,
               acceleration: self.acceleration,
               turn_angle: self.turn_angle + angle }

def Car_update(self, delta_time):
  updated = MovableObject_update(
               MovableObject {
                 position: self.position,
                 size: self.size,
                 velocity: self.velocity,
                 acceleration: self.acceleration
               },
               delta_time)
  return Car {
    position: updated.position,
    size: updated.size,
    velocity: updated.velocity,
    acceleration: updated.acceleration,
    turn_angle: self.turn_angle
  }
