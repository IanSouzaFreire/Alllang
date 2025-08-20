/* PHP */

class Vec2 {
    public $x;
    public $y;

    public function __construct($X, $Y) {
        $this->x = $X;
        $this->y = $Y;
    }

    public function add($other) {
        $this->x += $other->x;
        $this->y += $other->y;
    }

    public function scale($scalar) {
        $this->x *= $scalar;
        $this->y *= $scalar;
    }
}

class Size {
    public $width;
    public $height;

    public function __construct($w, $h) {
        $this->width = $w;
        $this->height = $h;
    }
}

class GameObject {
    protected $position;
    protected $size;

    public function __construct($position, $size) {
        $this->position = $position;
        $this->size = $size;
    }

    public function horizontalCollision($other) {
        return ($other->position->x < $this->position->x + $this->size->width &&
                $other->position->x + $other->size->width > $this->position->x);
    }

    public function verticalCollision($other) {
        return ($other->position->y < $this->position->y + $this->size->height &&
                $other->position->y + $other->size->height > $this->position->y);
    }

    public function collide($other) {
        return $this->horizontalCollision($other) && $this->verticalCollision($other);
    }
}

class MovableObject extends GameObject {
    protected $velocity;
    protected $acceleration;

    public function __construct($position, $size, $velocity, $acceleration) {
        parent::__construct($position, $size);
        $this->velocity = $velocity;
        $this->acceleration = $acceleration;
    }

    public function update($deltaTime) {
        $this->velocity->add($this->acceleration->scale($deltaTime));
        $this->position->add($this->velocity->scale($deltaTime));
    }
}

class Car extends MovableObject {
    protected $turnAngle;

    public function __construct($position, $size, $velocity, $acceleration, $turnAngle) {
        parent::__construct($position, $size, $velocity, $acceleration);
        $this->turnAngle = $turnAngle;
    }

    public function turn($angle) {
        $this->turnAngle += $angle;
    }

    public function update($deltaTime) {
        parent::update($deltaTime);
    }
}