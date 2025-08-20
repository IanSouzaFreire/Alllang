# Python

class Vec2:
  def __init__(self, x: float, y: float) -> None:
    self.x = x
    self.y = y

  def add(self, other: Vec2) -> None:
    self.x += other.x
    self.y += other.y

  def scale(self, scalar: float) -> Vec2:
    return Vec2(self.x * scalar, self.y * scalar)


class Size:
  def __init__(self, width: float, height: float) -> None:
    self.width = width
    self.height = height


class GameObject:
  def __init__(self, position: Vec2, size: Size) -> None:
    self.position = position
    self.size = size

  def horizontal_collision(self, other: GameObject) -> bool:
    return (other.position.x < self.position.x + self.size.width and
        other.position.x + other.size.width > self.position.x)

  def vertical_collision(self, other: GameObject) -> bool:
    return (other.position.y < self.position.y + self.size.height and
        other.position.y + other.size.height > self.position.y)

  def collide(self, other: GameObject) -> bool:
    return self.horizontal_collision(other) and self.vertical_collision(other)


class MovableObject(GameObject):
  def __init__(self, position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2) -> None:
    super().__init__(position, size)
    self.velocity = velocity
    self.acceleration = acceleration

  def update(self, delta_time: float) -> None:
    self.velocity.add(self.acceleration.scale(delta_time))
    self.position.add(self.velocity.scale(delta_time))


class Car(MovableObject):
  def __init__(self, position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2, turn_angle: float) -> None:
    super().__init__(position, size, velocity, acceleration)
    self.turn_angle = turn_angle

  def turn(self, angle: float) -> None:
    self.turn_angle += angle

  def update(self, delta_time: float) -> None:
    super().update(delta_time)
