/* React */

class Vec2 {
  constructor(x, y) {
    this.x = x;
    this.y = y;
  }

  add(other) {
    this.x += other.x;
    this.y += other.y;
  }

  scale(scalar) {
    this.x *= scalar;
    this.y *= scalar;
  }
}

class Size {
  constructor(width, height) {
    this.width = width;
    this.height = height;
  }
}

class GameObject {
  constructor(position, size) {
    this.position = position;
    this.size = size;
  }

  horizontalCollision(other) {
    return (
      other.position.x < this.position.x + this.size.width &&
      other.position.x + other.size.width > this.position.x
    );
  }

  verticalCollision(other) {
    return (
      other.position.y < this.position.y + this.size.height &&
      other.position.y + other.size.height > this.position.y
    );
  }

  collide(other) {
    return this.horizontalCollision(other) && this.verticalCollision(other);
  }
}

class MovableObject extends GameObject {
  constructor(position, size, velocity, acceleration) {
    super(position, size);
    this.velocity = velocity;
    this.acceleration = acceleration;
  }

  update(deltaTime) {
    this.velocity.add(this.acceleration.scale(deltaTime));
    this.position.add(this.velocity.scale(deltaTime));
  }
}

class Car extends MovableObject {
  constructor(position, size, velocity, acceleration, turnAngle) {
    super(position, size, velocity, acceleration);
    this.turnAngle = turnAngle;
  }

  turn(angle) {
    this.turnAngle += angle;
  }

  update(deltaTime) {
    super.update(deltaTime);
  }
}
