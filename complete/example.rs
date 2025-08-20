// Rust

#[derive(Debug, Clone)]
struct Vec2 {
  x: f64,
  y: f64,
}

impl Vec2 {
  fn new(x: f64, y: f64) -> Self {
    Vec2 { x, y }
  }

  fn add(&mut self, other: &Vec2) {
    self.x += other.x;
    self.y += other.y;
  }

  fn scale(&mut self, scalar: f64) {
    self.x *= scalar;
    self.y *= scalar;
  }
}

#[derive(Debug, Clone)]
struct Size {
  width: f64,
  height: f64,
}

impl Size {
  fn new(width: f64, height: f64) -> Self {
    Size { width, height }
  }
}

struct GameObject {
  position: Vec2,
  size: Size,
}

impl GameObject {
  fn new(position: Vec2, size: Size) -> Self {
    GameObject { position, size }
  }

  fn horizontal_collision(&self, other: &GameObject) -> bool {
    other.position.x < self.position.x + self.size.width &&
    other.position.x + other.size.width > self.position.x
  }

  fn vertical_collision(&self, other: &GameObject) -> bool {
    other.position.y < self.position.y + self.size.height &&
    other.position.y + other.size.height > self.position.y
  }

  fn collide(&self, other: &GameObject) -> bool {
    self.horizontal_collision(other) && self.vertical_collision(other)
  }
}

struct MovableObject {
  game_object: GameObject,
  velocity: Vec2,
  acceleration: Vec2,
}

impl MovableObject {
  fn new(position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2) -> Self {
    MovableObject {
      game_object: GameObject::new(position, size),
      velocity,
      acceleration,
    }
  }

  fn update(&mut self, delta_time: f64) {
    self.velocity.add(&self.acceleration.scale(delta_time));
    self.game_object.position.add(&self.velocity.scale(delta_time));
  }
}

struct Car {
  movable_object: MovableObject,
  turn_angle: f64,
}

impl Car {
  fn new(position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2, turn_angle: f64) -> Self {
    Car {
      movable_object: MovableObject::new(position, size, velocity, acceleration),
      turn_angle,
    }
  }

  fn turn(&mut self, angle: f64) {
    self.turn_angle += angle;
  }

  fn update(&mut self, delta_time: f64) {
    self.movable_object.update(delta_time);
  }
}
