// C#

public struct Vec2
{
  public double x;
  public double y;

  public Vec2(double X, double Y)
  {
    x = X;
    y = Y;
  }

  public Vec2 Add(Vec2 other)
  {
    this.x += other.x;
    this.y += other.y;
    return this;
  }

  public Vec2 Scale(double scalar)
  {
    this.x *= scalar;
    this.y *= scalar;
    return this;
  }
}

public struct Size
{
  public double width;
  public double height;

  public Size(double w, double h)
  {
    width = w;
    height = h;
  }
}

public class GameObject
{
  protected Vec2 position;
  protected Size size;

  public GameObject(Vec2 position, Size size)
  {
    this.position = position;
    this.size = size;
  }

  public bool HorizontalCollision(GameObject other)
  {
    return (other.position.x < this.position.x + this.size.width &&
            other.position.x + other.size.width > this.position.x);
  }

  public bool VerticalCollision(GameObject other)
  {
    return (other.position.y < this.position.y + this.size.height &&
            other.position.y + other.size.height > this.position.y);
  }

  public bool Collide(GameObject other)
  {
    return this.HorizontalCollision(other) && this.VerticalCollision(other);
  }
}

public class MovableObject : GameObject
{
  protected Vec2 velocity;
  protected Vec2 acceleration;

  public MovableObject(Vec2 position, Size size, Vec2 velocity, Vec2 acceleration)
    : base(position, size)
  {
    this.velocity = velocity;
    this.acceleration = acceleration;
  }

  public void Update(double deltaTime)
  {
    this.velocity.Add(this.acceleration.Scale(deltaTime));
    this.position.Add(this.velocity.Scale(deltaTime));
  }
}

public class Car : MovableObject
{
  private double turnAngle;

  public Car(Vec2 position, Size size, Vec2 velocity, Vec2 acceleration, double turnAngle)
    : base(position, size, velocity, acceleration)
  {
    this.turnAngle = turnAngle;
  }

  public void Turn(double angle)
  {
    this.turnAngle += angle;
  }

  public new void Update(double deltaTime)
  {
    base.Update(deltaTime);
  }
}
