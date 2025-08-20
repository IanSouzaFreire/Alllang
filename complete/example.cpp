// C++

typedef struct Vec2 {
  double x;
  double y;

  Vec2(const double& X, const double& Y) noexcept
  : x(X), y(Y) {}

  void add(const Vec2& other) noexcept {
    this->x += other.x;
    this->y += other.y;
  }

  void scale(const double& scalar) noexcept {
    this->x *= scalar;
    this->y *= scalar;
  }
} Vec2;

typedef struct Size {
  double width;
  double height;

  Size(const double& w, const double& h) noexcept
  : width(w), height(h) {}
} Size;

class MovableObject;
class Car;

class GameObject {
  friend MovableObject;
  Vec2 position;
  Size size;
public:
  GameObject(const Vec2& position, const Size& size) noexcept
  : position(position), size(size) {}

  bool horizontalCollision(const GameObject& other) noexcept {
    return (other.position.x < this->position.x + this->size.width &&
            other.position.x + other.size.width > this->position.x);
  }

  bool verticalCollision(const GameObject& other) {
    return (other.position.y < this->position.y + this->size.height &&
            other.position.y + other.size.height > this->position.y);
  }

  bool collide(const GameObject& other) noexcept {
    return this->horizontalCollision(other) && this->verticalCollision(other);
  }
};

class MovableObject : GameObject {
  friend Car;
  Vec2 velocity;
  Vec2 acceleration;
public:
  MovableObject(const Vec2& position, const Size& size, const Vec2& velocity, const Vec2& acceleration) noexcept
  : GameObject::GameObject(position, size), velocity(velocity), acceleration(acceleration) {}

  void update(const double& deltaTime) noexcept {
    this->velocity.add(this->acceleration.scale(deltaTime));
    this->position.add(this->velocity.scale(deltaTime));
  }
};

class Car : MovableObject {
  double turnAngle;
public:
  Car(const Vec2& position, const Size& size, const Vec2& velocity, const Vec2& acceleration, const double& turnAngle) noexcept
  : MovableObject::MovableObject(position, size, velocity, acceleration), turnAngle(turnAngle) {}

  void turn(const double& angle) noexcept {
    this->turnAngle += angle;
  }

  void update(const double& deltaTime) noexcept {
    MovableObject::update(deltaTime);
  }
};