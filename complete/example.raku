# Raku

class Vec2 {
    has Num $.x is rw;
    has Num $.y is rw;

    method add(Vec2 $other) {
        $!x += $other.x;
        $!y += $other.y;
    }

    method scale(Num $scalar --> Vec2) {
        Vec2.new(x => $!x * $scalar, y => $!y * $scalar);
    }
}

class Size {
    has Num $.width is rw;
    has Num $.height is rw;
}

class GameObject {
    has Vec2 $.position is rw;
    has Size $.size is rw;

    method horizontal-collision(GameObject $other --> Bool) {
        $other.position.x < $!position.x + $!size.width
            && $other.position.x + $other.size.width > $!position.x
    }

    method vertical-collision(GameObject $other --> Bool) {
        $other.position.y < $!position.y + $!size.height
            && $other.position.y + $other.size.height > $!position.y
    }

    method collide(GameObject $other --> Bool) {
        self.horizontal-collision($other) && self.vertical-collision($other)
    }
}

class MovableObject is GameObject {
    has Vec2 $.velocity is rw;
    has Vec2 $.acceleration is rw;

    method update(Num $delta-time) {
        $!velocity.add($!acceleration.scale($delta-time));
        $!position.add($!velocity.scale($delta-time));
    }
}

class Car is MovableObject {
    has Num $.turn-angle is rw;

    method turn(Num $angle) {
        $!turn-angle += $angle;
    }

    method update(Num $delta-time) {
        callsame; # calls MovableObject.update
    }
}
