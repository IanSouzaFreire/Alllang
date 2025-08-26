// Odin

package Example

Vec2 :: struct {
	x: f64,
	y: f64,
}

new_vec2 :: proc(x: f64, y: f64) -> Vec2 {
	return Vec2{x, y};
}

add_vec2 :: proc(v: ^Vec2, other: Vec2) {
	v.x += other.x;
	v.y += other.y;
}

scale_vec2 :: proc(v: Vec2, scalar: f64) -> Vec2 {
	return Vec2{v.x * scalar, v.y * scalar};
}


Size :: struct {
	width: f64,
	height: f64,
}

new_size :: proc(width: f64, height: f64) -> Size {
	return Size{width, height};
}


GameObject :: struct {
	position: Vec2,
	size: Size,
}

new_game_object :: proc(position: Vec2, size: Size) -> GameObject {
	return GameObject{position, size};
}

horizontal_collision :: proc(a: ^GameObject, b: GameObject) -> bool {
	return b.position.x < a.position.x + a.size.width &&
	       b.position.x + b.size.width > a.position.x;
}

vertical_collision :: proc(a: ^GameObject, b: GameObject) -> bool {
	return b.position.y < a.position.y + a.size.height &&
	       b.position.y + b.size.height > a.position.y;
}

collide :: proc(a: ^GameObject, b: GameObject) -> bool {
	return horizontal_collision(a, b) && vertical_collision(a, b);
}


MovableObject :: struct {
	base: GameObject,
	velocity: Vec2,
	acceleration: Vec2,
}

new_movable_object :: proc(position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2) -> MovableObject {
	return MovableObject{
		base = GameObject{position, size},
		velocity = velocity,
		acceleration = acceleration,
	};
}

update_movable_object :: proc(m: ^MovableObject, delta_time: f64) {
	accel_scaled := scale_vec2(m.acceleration, delta_time);
	add_vec2(&m.velocity, accel_scaled);

	vel_scaled := scale_vec2(m.velocity, delta_time);
	add_vec2(&m.base.position, vel_scaled);
}


Car :: struct {
	base: MovableObject,
	turn_angle: f64,
}

new_car :: proc(position: Vec2, size: Size, velocity: Vec2, acceleration: Vec2, turn_angle: f64) -> Car {
	return Car{
		base = new_movable_object(position, size, velocity, acceleration),
		turn_angle = turn_angle,
	};
}

turn_car :: proc(c: ^Car, angle: f64) {
	c.turn_angle += angle;
}

update_car :: proc(c: ^Car, delta_time: f64) {
	update_movable_object(&c.base, delta_time);
}
