// action script

package {
  public class Vec2 {
    public var x:Number;
    public var y:Number;

    public function Vec2(X:Number, Y:Number) {
      this.x = X;
      this.y = Y;
    }

    public function add(other:Vec2):void {
      this.x += other.x;
      this.y += other.y;
    }

    public function scale(scalar:Number):void {
      this.x *= scalar;
      this.y *= scalar;
    }
  }
}

package {
  public class Size {
    public var width:Number;
    public var height:Number;

    public function Size(w:Number, h:Number) {
      this.width = w;
      this.height = h;
    }
  }
}

package {
  public class GameObject {
    protected var position:Vec2;
    protected var size:Size;

    public function GameObject(position:Vec2, size:Size) {
      this.position = position;
      this.size = size;
    }

    public function horizontalCollision(other:GameObject):Boolean {
      return (other.position.x < this.position.x + this.size.width &&
              other.position.x + other.size.width > this.position.x);
    }

    public function verticalCollision(other:GameObject):Boolean {
      return (other.position.y < this.position.y + this.size.height &&
              other.position.y + other.size.height > this.position.y);
    }

    public function collide(other:GameObject):Boolean {
      return this.horizontalCollision(other) && this.verticalCollision(other);
    }
  }
}

package {
  public class MovableObject extends GameObject {
    protected var velocity:Vec2;
    protected var acceleration:Vec2;

    public function MovableObject(position:Vec2, size:Size, velocity:Vec2, acceleration:Vec2) {
      super(position, size);
      this.velocity = velocity;
      this.acceleration = acceleration;
    }

    public function update(deltaTime:Number):void {
      this.velocity.add(this.acceleration.scale(deltaTime));
      this.position.add(this.velocity.scale(deltaTime));
    }
  }
}

package {
  public class Car extends MovableObject {
    public var turnAngle:Number;

    public function Car(position:Vec2, size:Size, velocity:Vec2, acceleration:Vec2, turnAngle:Number) {
      super(position, size, velocity, acceleration);
      this.turnAngle = turnAngle;
    }

    public function turn(angle:Number):void {
      this.turnAngle += angle;
    }

    public function update(deltaTime:Number):void {
      super.update(deltaTime);
    }
  }
}