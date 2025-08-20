// C3

struct Vec2 {
  f64 x;
  f64 y;

  fn init(f64 x, f64 y) -> Vec2 {
    return Vec2 { .x = x, .y = y };
  }

  fn add(self *Vec2, other Vec2) {
    self.x += other.x;
    self.y += other.y;
  }

  fn scale(self *Vec2, scalar f64) -> *Vec2 {
    self.x *= scalar;
    self.y *= scalar;
    return self;
  }
};

struct Size {
  f64 width;
  f64 height;

  fn init(f64 width, f64 height) -> Size {
    return Size { .width = width, .height = height };
  }
};

class GameObject {
  protected:
    Vec2 position;
    Size size;

  public:
    fn init(Vec2 position, Size size) {
      this.position = position;
      this.size = size;
    }

    fn horizontalCollision(self *GameObject, other *GameObject) -> bool {
      return other.position.x < self.position.x + self.size.width &&
             other.position.x + other.size.width > self.position.x;
    }

    fn verticalCollision(self *GameObject, other *GameObject) -> bool {
      return other.position.y < self.position.y + self.size.height &&
             other.position.y + other.size.height > self.position.y;
    }

    fn collide(self *GameObject, other *GameObject) -> bool {
      return self.horizontalCollision(other) && self.verticalCollision(other);
    }
};

class MovableObject : GameObject {
  protected:
    Vec2 velocity;
    Vec2 acceleration;

  public:
    fn init(Vec2 position, Size size, Vec2 velocity, Vec2 acceleration) {
      super.init(position, size);
      this.velocity = velocity;
      this.acceleration = acceleration;
    }

    fn update(self *MovableObject, deltaTime f64) {
      self.velocity.add(self.acceleration.scale(deltaTime).*); 
      self.position.add(self.velocity.scale(deltaTime).*);
    }
};

class Car : MovableObject {
  private:
    f64 turnAngle;

  public:
    fn init(Vec2 position, Size size, Vec2 velocity, Vec2 acceleration, f64 turnAngle) {
      super.init(position, size, velocity, acceleration);
      this.turnAngle = turnAngle;
    }

    fn turn(self *Car, angle f64) {
      self.turnAngle += angle;
    }

    fn update(self *Car, deltaTime f64) {
      super.update(deltaTime);
    }
};
