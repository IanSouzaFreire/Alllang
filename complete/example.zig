// Zig

const Vec2 = struct {
  x: f64,
  y: f64,

  pub fn init(x: f64, y: f64) Vec2 {
    return Vec2{ .x = x, .y = y };
  }

  pub fn add(self: *Vec2, other: Vec2) void {
    self.x += other.x;
    self.y += other.y;
  }

  pub fn scale(self: *Vec2, scalar: f64) void {
    self.x *= scalar;
    self.y *= scalar;
  }
};

const Size = struct {
  width: f64,
  height: f64,

  pub fn init(width: f64, height: f64) Size {
    return Size{ .width = width, .height = height };
  }
};

const GameObject = struct {
  position: Vec2,
  size: Size,

  pub fn init(position: Vec2, size: Size) GameObject {
    return GameObject{ .position = position, .size = size };
  }

  pub fn horizontalCollision(self: *const GameObject, other: *const GameObject) bool {
    return other.position.x < self.position.x + self.size.width and
           other.position.x + other.size.width > self.position.x;
  }

  pub fn verticalCollision(self: *const GameObject, other: *const GameObject) bool {
    return other.position.y < self.position.y + self.size.height and
           other.position.y + other.size.height > self.position.y;
  }

  pub fn collide(self: *const GameObject, other: *const GameObject) bool {
    return self.horizontalCollision(other) and self.verticalCollision(other);
  }
};

const MovableObject = struct {
  base: GameObject,
  velocity: Vec2,
  acceleration: Vec2,

  pub fn init(position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2) MovableObject {
    return MovableObject{
      .base = GameObject.init(position, size),
      .velocity = velocity,
      .acceleration = acceleration,
    };
  }

  pub fn update(self: *MovableObject, deltaTime: f64) void {
    var scaledAcc = self.acceleration;
    scaledAcc.scale(deltaTime);
    self.velocity.add(scaledAcc);

    var scaledVel = self.velocity;
    scaledVel.scale(deltaTime);
    self.base.position.add(scaledVel);
  }
};

const Car = struct {
  base: MovableObject,
  turnAngle: f64,

  pub fn init(position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2, turnAngle: f64) Car {
    return Car{
      .base = MovableObject.init(position, size, velocity, acceleration),
      .turnAngle = turnAngle,
    };
  }

  pub fn turn(self: *Car, angle: f64) void {
    self.turnAngle += angle;
  }

  pub fn update(self: *Car, deltaTime: f64) void {
    self.base.update(deltaTime);
  }
};
