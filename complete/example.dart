// Dart

class Vec2 {
  double x;
  double y;

  Vec2(this.x, this.y);

  Vec2 add(Vec2 other) {
    x += other.x;
    y += other.y;
    return this;
  }

  Vec2 scale(double scalar) {
    x *= scalar;
    y *= scalar;
    return this;
  }
}

class Size {
  double width;
  double height;

  Size(this.width, this.height);
}

class GameObject {
  Vec2 position;
  Size size;

  GameObject(this.position, this.size);

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

class MovableObject extends GameObject {
  Vec2 velocity;
  Vec2 acceleration;

  MovableObject(Vec2 position, Size size, this.velocity, this.acceleration)
      : super(position, size);

  void update(double deltaTime) {
    velocity.add(acceleration.scale(deltaTime));
    position.add(velocity.scale(deltaTime));
  }
}

class Car extends MovableObject {
  double turnAngle;

  Car(Vec2 position, Size size, Vec2 velocity, Vec2 acceleration, this.turnAngle)
      : super(position, size, velocity, acceleration);

  void turn(double angle) {
    turnAngle += angle;
  }

  void update(double deltaTime) {
    super.update(deltaTime);
  }
}
