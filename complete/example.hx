// Haxe

class Vec2 {
  public var x:Float;
  public var y:Float;

  public function new(X:Float, Y:Float) {
    this.x = X;
    this.y = Y;
  }

  public function add(other:Vec2):Vec2 {
    this.x += other.x;
    this.y += other.y;
    return this;
  }

  public function scale(scalar:Float):Vec2 {
    this.x *= scalar;
    this.y *= scalar;
    return this;
  }
}

class Size {
  public var width:Float;
  public var height:Float;

  public function new(w:Float, h:Float) {
    this.width = w;
    this.height = h;
  }
}

class GameObject {
  public var position:Vec2;
  public var size:Size;

  public function new(position:Vec2, size:Size) {
    this.position = position;
    this.size = size;
  }

  public function horizontalCollision(other:GameObject):Bool {
    return (other.position.x < this.position.x + this.size.width &&
            other.position.x + other.size.width > this.position.x);
  }

  public function verticalCollision(other:GameObject):Bool {
    return (other.position.y < this.position.y + this.size.height &&
            other.position.y + other.size.height > this.position.y);
  }

  public function collide(other:GameObject):Bool {
    return this.horizontalCollision(other) && this.verticalCollision(other);
  }
}

class MovableObject extends GameObject {
  public var velocity:Vec2;
  public var acceleration:Vec2;

  public function new(position:Vec2, size:Size, velocity:Vec2, acceleration:Vec2) {
    super(position, size);
    this.velocity = velocity;
    this.acceleration = acceleration;
  }

  public function update(deltaTime:Float):Void {
    this.velocity.add(this.acceleration.scale(deltaTime));
    this.position.add(this.velocity.scale(deltaTime));
  }
}

class Car extends MovableObject {
  public var turnAngle:Float;

  public function new(position:Vec2, size:Size, velocity:Vec2, acceleration:Vec2, turnAngle:Float) {
    super(position, size, velocity, acceleration);
    this.turnAngle = turnAngle;
  }

  public function turn(angle:Float):Void {
    this.turnAngle += angle;
  }

  public function update(deltaTime:Float):Void {
    super.update(deltaTime);
  }

}
