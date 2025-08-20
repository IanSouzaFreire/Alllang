// Carbon

package Geometry api;

class Vec2 {
  var x: f64;
  var y: f64;

  fn init(X: f64, Y: f64) -> Self {
    return Vec2{.x = X, .y = Y};
  }

  fn Add(self: addr, other: Vec2) {
    self.x += other.x;
    self.y += other.y;
  }

  fn Scale(self: addr, scalar: f64) -> Vec2 {
    return Vec2{.x = self.x * scalar, .y = self.y * scalar};
  }
};

class Size {
  var width: f64;
  var height: f64;

  fn init(w: f64, h: f64) -> Self {
    return Size{.width = w, .height = h};
  }
};

class GameObject {
  var position: Vec2;
  var size: Size;

  fn init(position: Vec2, size: Size) -> Self {
    return GameObject{.position = position, .size = size};
  }

  fn HorizontalCollision(self: addr, other: GameObject) -> bool {
    return other.position.x < self.position.x + self.size.width &&
           other.position.x + other.size.width > self.position.x;
  }

  fn VerticalCollision(self: addr, other: GameObject) -> bool {
    return other.position.y < self.position.y + self.size.height &&
           other.position.y + other.size.height > self.position.y;
  }

  fn Collide(self: addr, other: GameObject) -> bool {
    return self.HorizontalCollision(other) && self.VerticalCollision(other);
  }
};

class MovableObject extends GameObject {
  var velocity: Vec2;
  var acceleration: Vec2;

  fn init(position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2) -> Self {
    return MovableObject{
      .position = position,
      .size = size,
      .velocity = velocity,
      .acceleration = acceleration
    };
  }

  fn Update(self: addr, deltaTime: f64) {
    let scaledAccel = self.acceleration.Scale(deltaTime);
    self.velocity.Add(scaledAccel);

    let scaledVel = self.velocity.Scale(deltaTime);
    self.position.Add(scaledVel);
  }
};

class Car extends MovableObject {
  var turnAngle: f64;

  fn init(position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2, turnAngle: f64) -> Self {
    return Car{
      .position = position,
      .size = size,
      .velocity = velocity,
      .acceleration = acceleration,
      .turnAngle = turnAngle
    };
  }

  fn Turn(self: addr, angle: f64) {
    self.turnAngle += angle;
  }

  fn Update(self: addr, deltaTime: f64) {
    MovableObject::Update(self, deltaTime);
  }
};
