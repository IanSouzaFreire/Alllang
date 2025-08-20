// Scala

class Vec2(var x: Double, var y: Double) {
  def add(other: Vec2): Unit = {
    this.x += other.x
    this.y += other.y
  }

  def scale(scalar: Double): Vec2 = {
    this.x *= scalar
    this.y *= scalar
    this
  }
}

class Size(val width: Double, val height: Double)

class GameObject(val position: Vec2, val size: Size) {
  def horizontalCollision(other: GameObject): Boolean = {
    (other.position.x < this.position.x + this.size.width) &&
    (other.position.x + other.size.width > this.position.x)
  }

  def verticalCollision(other: GameObject): Boolean = {
    (other.position.y < this.position.y + this.size.height) &&
    (other.position.y + other.size.height > this.position.y)
  }

  def collide(other: GameObject): Boolean = {
    horizontalCollision(other) && verticalCollision(other)
  }
}

class MovableObject(
  position: Vec2,
  size: Size,
  var velocity: Vec2,
  var acceleration: Vec2
) extends GameObject(position, size) {

  def update(deltaTime: Double): Unit = {
    velocity.add(acceleration.scale(deltaTime))
    position.add(velocity.scale(deltaTime))
  }
}

class Car(
  position: Vec2,
  size: Size,
  velocity: Vec2,
  acceleration: Vec2,
  var turnAngle: Double
) extends MovableObject(position, size, velocity, acceleration) {

  def turn(angle: Double): Unit = {
    turnAngle += angle
  }

  override def update(deltaTime: Double): Unit = {
    super.update(deltaTime)
  }
}
