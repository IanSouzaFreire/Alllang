# Crystal

struct Vec2
  property x, y

  def initialize(@x : Float64, @y : Float64)
  end

  def add(other : Vec2)
    @x += other.x
    @y += other.y
  end

  def scale(scalar : Float64)
    @x *= scalar
    @y *= scalar
  end
end

struct Size
  property width, height

  def initialize(@width : Float64, @height : Float64)
  end
end

abstract class GameObject
  property position : Vec2
  property size : Size

  def initialize(position : Vec2, size : Size)
    @position = position
    @size = size
  end

  def horizontal_collision?(other : GameObject) : Bool
    other.position.x < @position.x + @size.width &&
    other.position.x + other.size.width > @position.x
  end

  def vertical_collision?(other : GameObject) : Bool
    other.position.y < @position.y + @size.height &&
    other.position.y + other.size.height > @position.y
  end

  def collide?(other : GameObject) : Bool
    horizontal_collision?(other) && vertical_collision?(other)
  end
end

abstract class MovableObject < GameObject
  property velocity : Vec2
  property acceleration : Vec2

  def initialize(position : Vec2, size : Size, velocity : Vec2, acceleration : Vec2)
    super(position, size)
    @velocity = velocity
    @acceleration = acceleration
  end

  def update(delta_time : Float64)
    @velocity.add(@acceleration.scale(delta_time))
    @position.add(@velocity.scale(delta_time))
  end
end

class Car < MovableObject
  property turn_angle : Float64

  def initialize(position : Vec2, size : Size, velocity : Vec2, acceleration : Vec2, turn_angle : Float64)
    super(position, size, velocity, acceleration)
    @turn_angle = turn_angle
  end

  def turn(angle : Float64)
    @turn_angle += angle
  end

  def update(delta_time : Float64)
    super
  end
end
