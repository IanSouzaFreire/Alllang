// Kotlin

data class Vec2(var x: Double, var y: Double) {
  fun add(other: Vec2) {
    x += other.x
    y += other.y
  }

  fun scale(scalar: Double): Vec2 {
    x *= scalar
    y *= scalar
    return this
  }
}

data class Size(val width: Double, val height: Double)

open class GameObject(val position: Vec2, val size: Size) {

  fun horizontalCollision(other: GameObject): Boolean {
    return other.position.x < position.x + size.width &&
           other.position.x + other.size.width > position.x
  }

  fun verticalCollision(other: GameObject): Boolean {
    return other.position.y < position.y + size.height &&
           other.position.y + other.size.height > position.y
  }

  fun collide(other: GameObject): Boolean {
    return horizontalCollision(other) && verticalCollision(other)
  }
}

open class MovableObject(
  position: Vec2,
  size: Size,
  val velocity: Vec2,
  val acceleration: Vec2
) : GameObject(position, size) {

  fun update(deltaTime: Double) {
    velocity.add(acceleration.copy().scale(deltaTime))
    position.add(velocity.copy().scale(deltaTime))
  }
}

class Car(
  position: Vec2,
  size: Size,
  velocity: Vec2,
  acceleration: Vec2,
  var turnAngle: Double
) : MovableObject(position, size, velocity, acceleration) {

  fun turn(angle: Double) {
    turnAngle += angle
  }

  override fun update(deltaTime: Double) {
    super.update(deltaTime)
  }
}
