# GDscript

class_name Vec2

var x: float
var y: float

func _init(x_: float, y_: float) -> void:
	x = x_
	y = y_

func add(other: Vec2) -> void:
	x += other.x
	y += other.y

func scale(scalar: float) -> Vec2:
	return Vec2.new(x * scalar, y * scalar)


class_name Size

var width: float
var height: float

func _init(w: float, h: float) -> void:
	width = w
	height = h


class_name GameObject

var position: Vec2
var size: Size

func _init(position_: Vec2, size_: Size) -> void:
	position = position_
	size = size_

func horizontal_collision(other: GameObject) -> bool:
	return (
		other.position.x < position.x + size.width and
		other.position.x + other.size.width > position.x
	)

func vertical_collision(other: GameObject) -> bool:
	return (
		other.position.y < position.y + size.height and
		other.position.y + other.size.height > position.y
	)

func collide(other: GameObject) -> bool:
	return horizontal_collision(other) and vertical_collision(other)


class_name MovableObject
extends GameObject

var velocity: Vec2
var acceleration: Vec2

func _init(position_: Vec2, size_: Size, velocity_: Vec2, acceleration_: Vec2) -> void:
	super._init(position_, size_)
	velocity = velocity_
	acceleration = acceleration_

func update(delta_time: float) -> void:
	velocity.add(acceleration.scale(delta_time))
	position.add(velocity.scale(delta_time))


class_name Car
extends MovableObject

var turn_angle: float

func _init(position_: Vec2, size_: Size, velocity_: Vec2, acceleration_: Vec2, turn_angle_: float) -> void:
	super._init(position_, size_, velocity_, acceleration_)
	turn_angle = turn_angle_

func turn(angle: float) -> void:
	turn_angle += angle

func update(delta_time: float) -> void:
	super.update(delta_time)
