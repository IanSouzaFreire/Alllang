/* beef */

struct Vec2 {
  public double x;
  public double y;

  Vec2(double X, double Y) {
    x = X;
    y = Y;
  }

  void add(Vec2 other) {
    x += other.x;
    y += other.y;
  }

  void scale(double scalar) {
    x *= scalar;
    y *= scalar;
  }
}

struct Size {
  public double width;
  public double height;

  Size(double w, double h) {
    width = w;
    height = h;
  }
}

class GameObject {
  friend MovableObject;
  public Vec2 position;
  public Size size;

  GameObject(Vec2 position, Size size) {
    this.position = position;
    this.size = size;
  }

  bool horizontalCollision(GameObject other) {
    return (other.position.x < position.x + size.width &&
            other.position.x + other.size.width > position.x);
  }

  bool verticalCollision(GameObject other) {
    return (other.position.y < position.y + size.height &&
            other.position.y + other.size.height > position.y);
  }

  bool collide(GameObject other) {
    return horizontalCollision(other) && verticalCollision(other);
  }
}

class MovableObject : GameObject {
  friend Car;
  public Vec2 velocity;
  public Vec2 acceleration;

  MovableObject(Vec2 position, Size size, Vec2 velocity, Vec2 acceleration) : GameObject(position, size) {
    this.velocity = velocity;
    this.acceleration = acceleration;
  }

  void update(double deltaTime) {
    velocity.add(acceleration.scale(deltaTime));
    position.add(velocity.scale(deltaTime));
  }
}

class Car : MovableObject {
  public double turnAngle;

  Car(Vec2 position, Size size, Vec2 velocity, Vec2 acceleration, double turnAngle) : MovableObject(position, size, velocity, acceleration) {
    this.turnAngle = turnAngle;
  }

  void turn(double angle) {
    turnAngle += angle;
  }

  void update(double deltaTime) {
    MovableObject.update(deltaTime);
  }
}