// Hare

type Vec2 struct {
  x: f64
  y: f64
}

fn newVec2(x: f64, y: f64) -> Vec2 {
  return Vec2{x, y}
}

fn (v: *Vec2) add(other: Vec2) {
  v.x += other.x
  v.y += other.y
}

fn (v: *Vec2) scale(scalar: f64) -> Vec2 {
  return Vec2{v.x * scalar, v.y * scalar}
}

type Size struct {
  width: f64
  height: f64
}

fn newSize(w: f64, h: f64) -> Size {
  return Size{w, h}
}

type GameObject struct {
  position: Vec2
  size: Size
}

fn newGameObject(position: Vec2, size: Size) -> GameObject {
  return GameObject{position, size}
}

fn (g: *GameObject) horizontalCollision(other: GameObject) -> bool {
  return other.position.x < g.position.x + g.size.width && 
         other.position.x + other.size.width > g.position.x
}

fn (g: *GameObject) verticalCollision(other: GameObject) -> bool {
  return other.position.y < g.position.y + g.size.height && 
         other.position.y + other.size.height > g.position.y
}

fn (g: *GameObject) collide(other: GameObject) -> bool {
  return g.horizontalCollision(other) && g.verticalCollision(other)
}

type MovableObject struct {
  GameObject
  velocity: Vec2
  acceleration: Vec2
}

fn newMovableObject(position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2) -> MovableObject {
  return MovableObject{GameObject: newGameObject(position, size), velocity, acceleration}
}

fn (m: *MovableObject) update(deltaTime: f64) {
  m.velocity.add(m.acceleration.scale(deltaTime))
  m.position.add(m.velocity.scale(deltaTime))
}

type Car struct {
  MovableObject
  turnAngle: f64
}

fn newCar(position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2, turnAngle: f64) -> Car {
  return Car{MovableObject: newMovableObject(position, size, velocity, acceleration), turnAngle}
}

fn (c: *Car) turn(angle: f64) {
  c.turnAngle += angle
}

fn (c: *Car) update(deltaTime: f64) {
  c.MovableObject.update(deltaTime)
}
