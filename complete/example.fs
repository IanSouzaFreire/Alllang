// F#

type Vec2(x: float, y: float) =
  member val X = x with get, set
  member val Y = y with get, set

  member this.Add(other: Vec2) =
    this.X <- this.X + other.X
    this.Y <- this.Y + other.Y

  member this.Scale(scalar: float) =
    this.X <- this.X * scalar
    this.Y <- this.Y * scalar

type Size(width: float, height: float) =
  member val Width = width with get, set
  member val Height = height with get, set

type GameObject(position: Vec2, size: Size) =
  member val Position = position with get, set
  member val Size = size with get, set

  member this.HorizontalCollision(other: GameObject) =
    other.Position.X < this.Position.X + this.Size.Width &&
    other.Position.X + other.Size.Width > this.Position.X

  member this.VerticalCollision(other: GameObject) =
    other.Position.Y < this.Position.Y + this.Size.Height &&
    other.Position.Y + other.Size.Height > this.Position.Y

  member this.Collide(other: GameObject) =
    this.HorizontalCollision(other) && this.VerticalCollision(other)

type MovableObject(position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2) =
  inherit GameObject(position, size)
  member val Velocity = velocity with get, set
  member val Acceleration = acceleration with get, set

  member this.Update(deltaTime: float) =
    this.Velocity.Add(this.Acceleration.Scale(deltaTime))
    this.Position.Add(this.Velocity.Scale(deltaTime))

type Car(position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2, turnAngle: float) =
  inherit MovableObject(position, size, velocity, acceleration)
  member val TurnAngle = turnAngle with get, set

  member this.Turn(angle: float) =
    this.TurnAngle <- this.TurnAngle + angle

  member this.Update(deltaTime: float) =
    base.Update(deltaTime)