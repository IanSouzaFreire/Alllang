// Groovy

class Vec2 {
  double x
  double y

  Vec2(double x, double y) {
    this.x = x
    this.y = y
  }

  void add(Vec2 other) {
    this.x += other.x
    this.y += other.y
  }

  Vec2 scale(double scalar) {
    this.x *= scalar
    this.y *= scalar
    return this
  }
}

class Size {
  double width
  double height

  Size(double width, double height) {
    this.width = width
    this.height = height
  }
}

class GameObject {
  protected Vec2 position
  protected Size size

  GameObject(Vec2 position, Size size) {
    this.position = position
    this.size = size
  }

  boolean horizontalCollision(GameObject other) {
    return other.position.x < this.position.x + this.size.width &&
           other.position.x + other.size.width > this.position.x
  }

  boolean verticalCollision(GameObject other) {
    return other.position.y < this.position.y + this.size.height &&
           other.position.y + other.size.height > this.position.y
  }

  boolean collide(GameObject other) {
    return horizontalCollision(other) && verticalCollision(other)
  }
}

class MovableObject extends GameObject {
  protected Vec2 velocity
  protected Vec2 acceleration

  MovableObject(Vec2 position, Size size, Vec2 velocity, Vec2 acceleration) {
    super(position, size)
    this.velocity = velocity
    this.acceleration = acceleration
  }

  void update(double deltaTime) {
    this.velocity.add(this.acceleration.scale(deltaTime))
    this.position.add(this.velocity.scale(deltaTime))
  }
}

class Car extends MovableObject {
  double turnAngle

  Car(Vec2 position, Size size, Vec2 velocity, Vec2 acceleration, double turnAngle) {
    super(position, size, velocity, acceleration)
    this.turnAngle = turnAngle
  }

  void turn(double angle) {
    this.turnAngle += angle
  }

  @Override
  void update(double deltaTime) {
    super.update(deltaTime)
  }
}
