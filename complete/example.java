// Java

class Vec2 {
    public float x;
    public float y;

    public Vec2(float x, float y) {
        this.x = x;
        this.y = y;
    }

    public void add(Vec2 other) {
        this.x += other.x;
        this.y += other.y;
    }

    public void scale(float scalar) {
        this.x *= scalar;
        this.y *= scalar;
    }
}

class Size {
    public float width;
    public float height;

    public Size(float width, float height) {
        this.width = width;
        this.height = height;
    }
}

class GameObject {
    protected Vec2 position;
    protected Size size;

    public GameObject(Vec2 position, Size size) {
        this.position = position;
        this.size = size;
    }

    public boolean horizontalCollision(GameObject other) {
        return (other.position.x < this.position.x + this.size.width &&
                other.position.x + other.size.width > this.position.x);
    }

    public boolean verticalCollision(GameObject other) {
        return (other.position.y < this.position.y + this.size.height &&
                other.position.y + other.size.height > this.position.y);
    }

    public boolean collide(GameObject other) {
        return horizontalCollision(other) && verticalCollision(other);
    }
}

// Movable object
class MovableObject extends GameObject {
    public Vec2 velocity;
    public Vec2 acceleration;

    public MovableObject(Vec2 position, Size size, Vec2 velocity, Vec2 acceleration) {
        super(position, size);
        this.velocity = velocity;
        this.acceleration = acceleration;
    }

    public void update(float deltaTime) {
        velocity.add(acceleration.scale(deltaTime));
        position.add(velocity.scale(deltaTime));
    }
}

class Car extends MovableObject {
    public float turnAngle;

    public Car(Vec2 position, Size size, Vec2 velocity, Vec2 acceleration, float turnAngle) {
        super(position, size, velocity, acceleration);
        this.turnAngle = turnAngle;
    }

    public void turn(float angle) {
        this.turnAngle += angle;
    }

    @Override
    public void update(float deltaTime) {
        super.update(deltaTime);
    }
}