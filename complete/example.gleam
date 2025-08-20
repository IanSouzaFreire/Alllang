// Gleam

type Vec2 {
  Vec2(x: Float, y: Float)
}

fn vec2_add(a: Vec2, b: Vec2) -> Vec2 {
  let Vec2(x1, y1) = a
  let Vec2(x2, y2) = b
  Vec2(x1 + x2, y1 + y2)
}

fn vec2_scale(v: Vec2, scalar: Float) -> Vec2 {
  let Vec2(x, y) = v
  Vec2(x *. scalar, y *. scalar)
}

type Size {
  Size(width: Float, height: Float)
}

type GameObject {
  GameObject(position: Vec2, size: Size)
}

fn horizontal_collision(this: GameObject, other: GameObject) -> Bool {
  let GameObject(position1, size1) = this
  let GameObject(position2, size2) = other
  let Vec2(x1, _) = position1
  let Vec2(x2, _) = position2
  let Size(w1, _) = size1
  let Size(w2, _) = size2
  x2 < x1 +. w1 && x2 +. w2 > x1
}

fn vertical_collision(this: GameObject, other: GameObject) -> Bool {
  let GameObject(position1, size1) = this
  let GameObject(position2, size2) = other
  let Vec2(_, y1) = position1
  let Vec2(_, y2) = position2
  let Size(_, h1) = size1
  let Size(_, h2) = size2
  y2 < y1 +. h1 && y2 +. h2 > y1
}

fn collide(this: GameObject, other: GameObject) -> Bool {
  horizontal_collision(this, other) && vertical_collision(this, other)
}

type MovableObject {
  MovableObject(
    position: Vec2,
    size: Size,
    velocity: Vec2,
    acceleration: Vec2
  )
}

fn update_movable(obj: MovableObject, delta_time: Float) -> MovableObject {
  let MovableObject(pos, size, vel, acc) = obj
  let new_velocity = vec2_add(vel, vec2_scale(acc, delta_time))
  let new_position = vec2_add(pos, vec2_scale(new_velocity, delta_time))
  MovableObject(new_position, size, new_velocity, acc)
}

type Car {
  Car(
    position: Vec2,
    size: Size,
    velocity: Vec2,
    acceleration: Vec2,
    turn_angle: Float
  )
}

fn turn(car: Car, angle: Float) -> Car {
  let Car(pos, size, vel, acc, turn_angle) = car
  Car(pos, size, vel, acc, turn_angle +. angle)
}

fn update_car(car: Car, delta_time: Float) -> Car {
  let Car(pos, size, vel, acc, angle) = car
  let MovableObject(new_pos, _, new_vel, new_acc) =
    update_movable(MovableObject(pos, size, vel, acc), delta_time)
  Car(new_pos, size, new_vel, new_acc, angle)
}