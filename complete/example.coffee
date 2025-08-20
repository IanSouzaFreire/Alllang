# coffescript

class Vec2
  constructor: (X, Y) ->
    @x = X
    @y = Y

  add: (other) ->
    @x += other.x
    @y += other.y

  scale: (scalar) ->
    @x *= scalar
    @y *= scalar

class Size
  constructor: (w, h) ->
    @width = w
    @height = h

class GameObject
  constructor: (position, size) ->
    @position = position
    @size = size

  horizontalCollision: (other) ->
    other.position.x < @position.x + @size.width and
    other.position.x + other.size.width > @position.x

  verticalCollision: (other) ->
    other.position.y < @position.y + @size.height and
    other.position.y + other.size.height > @position.y

  collide: (other) ->
    @horizontalCollision(other) and @verticalCollision(other)

class MovableObject extends GameObject
  constructor: (position, size, velocity, acceleration) ->
    super(position, size)
    @velocity = velocity
    @acceleration = acceleration

  update: (deltaTime) ->
    @velocity.add(@acceleration.scale(deltaTime))
    @position.add(@velocity.scale(deltaTime))

class Car extends MovableObject
  constructor: (position, size, velocity, acceleration, turnAngle) ->
    super(position, size, velocity, acceleration)
    @turnAngle = turnAngle

  turn: (angle) ->
    @turnAngle += angle

  update: (deltaTime) ->
    super(deltaTime)