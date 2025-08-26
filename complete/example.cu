// Cuda-C++

#include <cuda_runtime.h>

struct Vec2 {
  double x, y;

  __host__ __device__ Vec2(double X, double Y) noexcept
    : x(X), y(Y) {}

  __host__ __device__ Vec2& add(const Vec2& other) noexcept {
    x += other.x;
    y += other.y;
    return *this;
  }

  __host__ __device__ Vec2& scale(double scalar) noexcept {
    x *= scalar;
    y *= scalar;
    return *this;
  }
};

struct Size {
  double width, height;

  __host__ __device__ Size(double w, double h) noexcept
    : width(w), height(h) {}
};

struct GameObject {
  Vec2 position;
  Size size;

  __host__ __device__ GameObject(const Vec2& pos, const Size& sz) noexcept
    : position(pos), size(sz) {}

  __host__ __device__ bool horizontalCollision(const GameObject& other) const noexcept {
    return (other.position.x < position.x + size.width &&
            other.position.x + other.size.width > position.x);
  }

  __host__ __device__ bool verticalCollision(const GameObject& other) const noexcept {
    return (other.position.y < position.y + size.height &&
            other.position.y + other.size.height > position.y);
  }

  __host__ __device__ bool collide(const GameObject& other) const noexcept {
    return horizontalCollision(other) && verticalCollision(other);
  }
};

struct MovableObject : public GameObject {
  Vec2 velocity;
  Vec2 acceleration;

  __host__ __device__ MovableObject(const Vec2& pos, const Size& sz, const Vec2& vel, const Vec2& acc) noexcept
    : GameObject(pos, sz), velocity(vel), acceleration(acc) {}

  __host__ __device__ void update(double deltaTime) noexcept {
    velocity.add(acceleration.scale(deltaTime));
    position.add(velocity.scale(deltaTime));
  }
};

struct Car : public MovableObject {
  double turnAngle;

  __host__ __device__ Car(const Vec2& pos, const Size& sz, const Vec2& vel, const Vec2& acc, double angle) noexcept
    : MovableObject(pos, sz, vel, acc), turnAngle(angle) {}

  __host__ __device__ void turn(double angle) noexcept {
    turnAngle += angle;
  }

  __host__ __device__ void update(double deltaTime) noexcept {
    MovableObject::update(deltaTime);
  }
};
