# Ruby

class Vec2
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def add(other)
    @x += other.x
    @y += other.y
  end

  def scale(scalar)
    @x *= scalar
    @y *= scalar
  end
end

class Size
  attr_accessor :width, :height

  def initialize(width, height)
    @width = width
    @height = height
  end
end

class GameObject
  attr_accessor :position, :size

  def initialize(position, size)
    @position = position
    @size = size
  end

  def horizontal_collision(other)
    other.position.x < @position.x + @size.width &&
    other.position.x + other.size.width > @position.x
  end

  def vertical_collision(other)
    other.position.y < @position.y + @size.height &&
    other.position.y + other.size.height > @position.y
  end

  def collide(other)
    horizontal_collision(other) && vertical_collision(other)
  end
end

class MovableObject < GameObject
  attr_accessor :velocity, :acceleration

  def initialize(position, size, velocity, acceleration)
    super(position, size)
    @velocity = velocity
    @acceleration = acceleration
  end

  def update(delta_time)
    @velocity.add(@acceleration.scale(delta_time))
    @position.add(@velocity.scale(delta_time))
  end
end

class Car < MovableObject
  attr_accessor :turn_angle

  def initialize(position, size, velocity, acceleration, turn_angle)
    super(position, size, velocity, acceleration)
    @turn_angle = turn_angle
  end

  def turn(angle)
    @turn_angle += angle
  end

  def update(delta_time)
    super(delta_time)
  end
end
