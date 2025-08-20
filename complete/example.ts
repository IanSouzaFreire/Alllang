// Typescript

class Vec2 {
  x: number;
  y: number;

  constructor(x: number, y: number) {
      this.x = x;
      this.y = y;
  }

  add(other: Vec2): void {
      this.x += other.x;
      this.y += other.y;
  }

  scale(scalar: number): Vec2 {
      this.x *= scalar;
      this.y *= scalar;
      return this;
  }
}

class Size {
  width: number;
  height: number;

  constructor(width: number, height: number) {
      this.width = width;
      this.height = height;
  }
}

class GameObject {
  protected position: Vec2;
  protected size: Size;

  constructor(position: Vec2, size: Size) {
      this.position = new Vec2(position.x, position.y);
      this.size = new Size(size.width, size.height);
  }

  horizontalCollision(other: GameObject): boolean {
      return (other.position.x < this.position.x + this.size.width &&
              other.position.x + other.size.width > this.position.x);
  }

  verticalCollision(other: GameObject): boolean {
      return (other.position.y < this.position.y + this.size.height &&
              other.position.y + other.size.height > this.position.y);
  }

  collide(other: GameObject): boolean {
      return this.horizontalCollision(other) && this.verticalCollision(other);
  }
}

class MovableObject extends GameObject {
  protected velocity: Vec2;
  protected acceleration: Vec2;

  constructor(position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2) {
      super(position, size);
      this.velocity = new Vec2(velocity.x, velocity.y);
      this.acceleration = new Vec2(acceleration.x, acceleration.y);
  }

  update(deltaTime: number): void {
      this.velocity.add(this.acceleration.scale(deltaTime));
      this.position.add(this.velocity.scale(deltaTime));
  }
}

class Car extends MovableObject {
  private turnAngle: number;

  constructor(position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2, turnAngle: number) {
      super(position, size, velocity, acceleration);
      this.turnAngle = turnAngle;
  }

  turn(angle: number): void {
      this.turnAngle += angle;
  }

  update(deltaTime: number): void {
      super.update(deltaTime);
  }
}
