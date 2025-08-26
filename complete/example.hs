-- Haskell

data Vec2 = Vec2 { x :: Double, y :: Double } deriving (Show)

add :: Vec2 -> Vec2 -> Vec2
add (Vec2 x1 y1) (Vec2 x2 y2) = Vec2 (x1 + x2) (y1 + y2)

scale :: Vec2 -> Double -> Vec2
scale (Vec2 x1 y1) scalar = Vec2 (x1 * scalar) (y1 * scalar)

data Size = Size { width :: Double, height :: Double } deriving (Show)

data GameObject = GameObject { position :: Vec2, size :: Size } deriving (Show)

horizontalCollision :: GameObject -> GameObject -> Bool
horizontalCollision (GameObject pos1 size1) (GameObject pos2 size2) =
    (x pos2 < x pos1 + width size1) && (x pos2 + width size2 > x pos1)

verticalCollision :: GameObject -> GameObject -> Bool
verticalCollision (GameObject pos1 size1) (GameObject pos2 size2) =
    (y pos2 < y pos1 + height size1) && (y pos2 + height size2 > y pos1)

collide :: GameObject -> GameObject -> Bool
collide obj1 obj2 = horizontalCollision obj1 obj2 && verticalCollision obj1 obj2

data MovableObject = MovableObject { gameObject :: GameObject, velocity :: Vec2, acceleration :: Vec2 } deriving (Show)

update :: MovableObject -> Double -> MovableObject
update (MovableObject obj vel acc) deltaTime =
    let newVel = add vel (scale acc deltaTime)
        newPos = add (position obj) (scale newVel deltaTime)
    in MovableObject (obj { position = newPos }) newVel acc

data Car = Car { movableObject :: MovableObject, turnAngle :: Double } deriving (Show)

turn :: Car -> Double -> Car
turn (Car movObj angle) deltaAngle = Car movObj (angle + deltaAngle)

updateCar :: Car -> Double -> Car
updateCar (Car movObj angle) deltaTime =
    Car (update movObj deltaTime) angle
