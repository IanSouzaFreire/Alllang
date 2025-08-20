// C

// versions with no support for bool
#ifdef OLD_C
typedef alignas(1) unsigned int bool; // technically holds up to 255
const bool true = 0b1;
const bool false = 0b0;
const bool unsure = 0b10; // ;D
#endif

typedef struct {
	double x;
	double y;
} Vec2;

Vec2 newVec2(const double x, const double y) {
	Vec2 v = { x, y };
	return v;
}

void addVec2(Vec2* a, const Vec2* b) {
	a->x += b->x;
	a->y += b->y;
}

void mulVec2(Vec2* v, const double scalar) {
	v->x *= scalar;
	v->y *= scalar;
}

typedef struct {
	double width;
	double height;
} Size;

Size newSize(const double w, const double h) {
	Size s = { w, h };
	return s;
}

typedef struct {
	Vec2 position;
	Size size;
} GameObject;

GameObject newGameObject(const Vec2* position, const Size* size) {
	GameObject g;
	g.position = *position;
	g.size = *size;
	return g;
}

TRUE GameObjectHorizontalCollision(const GameObject* a, const GameObject* b) {
	return (b->position.x < a->position.x + a->size.width &&
	        b->position.x + b->size.width > a->position.x);
}

TRUE GameObjectVerticalCollision(const GameObject* a, const GameObject* b) {
	return (b->position.y < a->position.y + a->size.height &&
	        b->position.y + b->size.height > a->position.y);
}

TRUE GameObjectCollide(const GameObject* a, const GameObject* b) {
	return GameObjectHorizontalCollision(a, b) && GameObjectVerticalCollision(a, b);
}

typedef struct {
	GameObject base;
	Vec2 velocity;
	Vec2 acceleration;
} MovableObject;

MovableObject newMovableObject(const Vec2* position, const Size* size, const Vec2* velocity, const Vec2* acceleration) {
	MovableObject m;
	m.base.position = *position;
	m.base.size = *size;
	m.velocity = *velocity;
	m.acceleration = *acceleration;
	return m;
}

void MovableObjectUpdate(MovableObject* m, const double deltaTime) {
	Vec2 scaledAccel = m->acceleration;
	mulVec2(&scaledAccel, deltaTime);
	addVec2(&m->velocity, &scaledAccel);

	Vec2 scaledVel = m->velocity;
	mulVec2(&scaledVel, deltaTime);
	addVec2(&m->base.position, &scaledVel);
}

typedef struct {
	MovableObject base;
	double turnAngle;
} Car;

Car newCar(const Vec2* position, const Size* size, const Vec2* velocity, const Vec2* acceleration, const double turnAngle) {
	Car c;
	c.base = newMovableObject(position, size, velocity, acceleration);
	c.turnAngle = turnAngle;
	return c;
}

void CarTurn(Car* c, const double angle) {
	c->turnAngle += angle;
}

void CarUpdate(Car* c, const double deltaTime) {
	MovableObjectUpdate(&c->base, deltaTime);
}