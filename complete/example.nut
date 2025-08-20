/* squirrel */

class Vec2 {
    constructor(x, y) {
        this.x = x;
        this.y = y;
    }

    function add(other) {
        this.x += other.x;
        this.y += other.y;
    }

    function scale(scalar) {
        return Vec2(this.x * scalar, this.y * scalar);
    }
}

class Size {
    constructor(width, height) {
        this.width = width;
        this.height = height;
    }
}

class GameObject {
    constructor(position, size) {
        this.position = position;
        this.size = size;
    }

    function horizontal_collision(other) {
        return (other.position.x < this.position.x + this.size.width &&
                other.position.x + other.size.width > this.position.x);
    }

    function vertical_collision(other) {
        return (other.position.y < this.position.y + this.size.height &&
                other.position.y + other.size.height > this.position.y);
    }

    function collide(other) {
        return this.horizontal_collision(other) && this.vertical_collision(other);
    }
}

class MovableObject extends GameObject {
    constructor(position, size, velocity, acceleration) {
        base.constructor(position, size);
        this.velocity = velocity;
        this.acceleration = acceleration;
    }

    function update(delta_time) {
        this.velocity.add(this.acceleration.scale(delta_time));
        this.position.add(this.velocity.scale(delta_time));
    }
}

class Car extends MovableObject {
    constructor(position, size, velocity, acceleration, turn_angle) {
        base.constructor(position, size, velocity, acceleration);
        this.turn_angle = turn_angle;
    }

    function turn(angle) {
        this.turn_angle += angle;
    }

    function update(delta_time) {
        base.update(delta_time);
    }
}