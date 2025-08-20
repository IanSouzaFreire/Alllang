// Nim

type
  Vec2 = object
    x: float64
    y: float64

  Size = object
    width: float64
    height: float64

  GameObject = object
    position: Vec2
    size: Size

  MovableObject = object
    gameObject: GameObject
    velocity: Vec2
    acceleration: Vec2

  Car = object
    movableObject: MovableObject
    turnAngle: float64

# Vec2 methods
proc newVec2(x, y: float64): Vec2 =
  result.x = x
  result.y = y

proc add(self: var Vec2, other: Vec2) =
  self.x += other.x
  self.y += other.y

proc scale(self: var Vec2, scalar: float64) =
  self.x *= scalar
  self.y *= scalar

# Size methods
proc newSize(width, height: float64): Size =
  result.width = width
  result.height = height

# GameObject methods
proc newGameObject(position: Vec2, size: Size): GameObject =
  result.position = position
  result.size = size

proc horizontalCollision(self: GameObject, other: GameObject): bool =
  (other.position.x < self.position.x + self.size.width) and
  (other.position.x + other.size.width > self.position.x)

proc verticalCollision(self: GameObject, other: GameObject): bool =
  (other.position.y < self.position.y + self.size.height) and
  (other.position.y + other.size.height > self.position.y)

proc collide(self: GameObject, other: GameObject): bool =
  self.horizontalCollision(other) and self.verticalCollision(other)

# MovableObject methods
proc newMovableObject(position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2): MovableObject =
  result.gameObject = newGameObject(position, size)
  result.velocity = velocity
  result.acceleration = acceleration

proc update(self: var MovableObject, deltaTime: float64) =
  self.velocity.add(self.acceleration.scale(deltaTime))
  self.gameObject.position.add(self.velocity.scale(deltaTime))

# Car methods
proc newCar(position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2, turnAngle: float64): Car =
  result.movableObject = newMovableObject(position, size, velocity, acceleration)
  result.turnAngle = turnAngle

proc turn(self: var Car, angle: float64) =
  self.turnAngle += angle

proc update(self: var Car, deltaTime: float64) =
  self.movableObject.update(deltaTime)