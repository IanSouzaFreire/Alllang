// Golang

package main

type Vec2 struct {
	x, y float64
}

func NewVec2(X, Y float64) Vec2 {
	return Vec2{x: X, y: Y}
}

func (v *Vec2) Add(other Vec2) Vec2 {
	v.x += other.x
	v.y += other.y
    return *v
}

func (v *Vec2) Scale(scalar float64) Vec2 {
	v.x *= scalar
	v.y *= scalar
    return *v
}

type Size struct {
	width, height float64
}

func NewSize(w, h float64) Size {
	return Size{width: w, height: h}
}

type GameObject struct {
	position Vec2
	size     Size
}

func NewGameObject(position Vec2, size Size) GameObject {
	return GameObject{position: position, size: size}
}

func (g *GameObject) HorizontalCollision(other GameObject) bool {
	return other.position.x < g.position.x+g.size.width &&
		other.position.x+other.size.width > g.position.x
}

func (g *GameObject) VerticalCollision(other GameObject) bool {
	return other.position.y < g.position.y+g.size.height &&
		other.position.y+other.size.height > g.position.y
}

func (g *GameObject) Collide(other GameObject) bool {
	return g.HorizontalCollision(other) && g.VerticalCollision(other)
}

type MovableObject struct {
	GameObject
	velocity    Vec2
	acceleration Vec2
}

func NewMovableObject(position Vec2, size Size, velocity Vec2, acceleration Vec2) MovableObject {
	return MovableObject{
		GameObject:  NewGameObject(position, size),
		velocity:    velocity,
		acceleration: acceleration,
	}
}

func (m *MovableObject) Update(deltaTime float64) {
	_ = m.velocity.Add(m.acceleration.Scale(deltaTime))
	_ = m.position.Add(m.velocity.Scale(deltaTime))
}

type Car struct {
	MovableObject
	turnAngle float64
}

func NewCar(position Vec2, size Size, velocity Vec2, acceleration Vec2, turnAngle float64) Car {
	return Car{
		MovableObject: NewMovableObject(position, size, velocity, acceleration),
		turnAngle:    turnAngle,
	}
}

func (c *Car) Turn(angle float64) {
	c.turnAngle += angle
}

func (c *Car) Update(deltaTime float64) {
	c.MovableObject.Update(deltaTime)
}
