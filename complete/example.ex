# Elixir

defmodule Vec2 do
  defstruct [:x, :y]

  def new(x, y), do: %Vec2{x: x, y: y}

  def add(%Vec2{x: x1, y: y1}, %Vec2{x: x2, y: y2}) do
    %Vec2{x: x1 + x2, y: y1 + y2}
  end

  def scale(%Vec2{x: x, y: y}, scalar) do
    %Vec2{x: x * scalar, y: y * scalar}
  end
end

defmodule Size do
  defstruct [:width, :height]

  def new(width, height), do: %Size{width: width, height: height}
end

defmodule GameObject do
  defstruct [:position, :size]

  def new(position, size), do: %GameObject{position: position, size: size}

  def horizontal_collision(%GameObject{position: %Vec2{x: x1}, size: %Size{width: w1}},
                           %GameObject{position: %Vec2{x: x2}, size: %Size{width: w2}}) do
    x2 < x1 + w1 and x2 + w2 > x1
  end

  def vertical_collision(%GameObject{position: %Vec2{y: y1}, size: %Size{height: h1}},
                         %GameObject{position: %Vec2{y: y2}, size: %Size{height: h2}}) do
    y2 < y1 + h1 and y2 + h2 > y1
  end

  def collide(this, other) do
    horizontal_collision(this, other) and vertical_collision(this, other)
  end
end

defmodule MovableObject do
  defstruct [:position, :size, :velocity, :acceleration]

  def new(position, size, velocity, acceleration) do
    %MovableObject{
      position: position,
      size: size,
      velocity: velocity,
      acceleration: acceleration
    }
  end

  def update(%MovableObject{position: pos, velocity: vel, acceleration: acc} = obj, delta_time) do
    new_velocity = Vec2.add(vel, Vec2.scale(acc, delta_time))
    new_position = Vec2.add(pos, Vec2.scale(new_velocity, delta_time))

    %MovableObject{obj | velocity: new_velocity, position: new_position}
  end
end

defmodule Car do
  defstruct [:position, :size, :velocity, :acceleration, :turn_angle]

  def new(position, size, velocity, acceleration, turn_angle) do
    %Car{
      position: position,
      size: size,
      velocity: velocity,
      acceleration: acceleration,
      turn_angle: turn_angle
    }
  end

  def turn(%Car{turn_angle: angle} = car, delta_angle) do
    %Car{car | turn_angle: angle + delta_angle}
  end

  def update(%Car{} = car, delta_time) do
    movable = MovableObject.new(car.position, car.size, car.velocity, car.acceleration)
    updated = MovableObject.update(movable, delta_time)

    %Car{car |
      position: updated.position,
      velocity: updated.velocity
    }
  end
end