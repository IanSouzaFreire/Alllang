# Cython

cdef class Vec2:
  cdef double x
  cdef double y

  def __cinit__(self, double X, double Y):
    self.x = X
    self.y = Y

  cpdef void add(self, Vec2 other):
    self.x += other.x
    self.y += other.y

  cpdef void scale(self, double scalar):
    self.x *= scalar
    self.y *= scalar


cdef class Size:
  cdef double width
  cdef double height

  def __cinit__(self, double w, double h):
    self.width = w
    self.height = h


cdef class GameObject:
  cdef Vec2 position
  cdef Size size

  def __cinit__(self, Vec2 position, Size size):
    self.position = position
    self.size = size

  cpdef bint horizontalCollision(self, GameObject other):
    return (other.position.x < self.position.x + self.size.width and
            other.position.x + other.size.width > self.position.x)

  cpdef bint verticalCollision(self, GameObject other):
    return (other.position.y < self.position.y + self.size.height and
            other.position.y + other.size.height > self.position.y)

  cpdef bint collide(self, GameObject other):
    return self.horizontalCollision(other) and self.verticalCollision(other)


cdef class MovableObject(GameObject):
  cdef Vec2 velocity
  cdef Vec2 acceleration

  def __cinit__(self, Vec2 position, Size size, Vec2 velocity, Vec2 acceleration):
    GameObject.__cinit__(self, position, size)
    self.velocity = velocity
    self.acceleration = acceleration

  cpdef void update(self, double deltaTime):
    self.velocity.add(self.acceleration.scale(deltaTime))
    self.position.add(self.velocity.scale(deltaTime))


cdef class Car(MovableObject):
  cdef double turnAngle

  def __cinit__(self, Vec2 position, Size size, Vec2 velocity, Vec2 acceleration, double turnAngle):
    MovableObject.__cinit__(self, position, size, velocity, acceleration)
    self.turnAngle = turnAngle

  cpdef void turn(self, double angle):
    self.turnAngle += angle

  cpdef void update(self, double deltaTime):
    MovableObject.update(self, deltaTime)