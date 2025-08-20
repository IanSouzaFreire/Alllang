*> COBOL

IDENTIFICATION DIVISION.
PROGRAM-ID. GameObjects.

DATA DIVISION.
WORKING-STORAGE SECTION.
01  Vec2.
    05  x          PIC 9(10)V99.
    05  y          PIC 9(10)V99.
01  Size.
    05  width      PIC 9(10)V99.
    05  height     PIC 9(10)V99.
01  GameObject.
    05  position   REDEFINES GameObject.
        10  posX   PIC 9(10)V99.
        10  posY   PIC 9(10)V99.
    05  size       REDEFINES GameObject.
        10  sizeWidth  PIC 9(10)V99.
        10  sizeHeight PIC 9(10)V99.
01  MovableObject.
    05  velocity    REDEFINES MovableObject.
        10  velX    PIC 9(10)V99.
        10  velY    PIC 9(10)V99.
    05  acceleration REDEFINES MovableObject.
        10  accX    PIC 9(10)V99.
        10  accY    PIC 9(10)V99.
01  Car.
    05  turnAngle   PIC 9(10)V99.

PROCEDURE DIVISION.
MAIN-LOGIC.
    PERFORM INITIALIZE
    PERFORM GAME-LOOP
    STOP RUN.

INITIALIZE.
    MOVE 0 TO posX
    MOVE 0 TO posY
    MOVE 0 TO sizeWidth
    MOVE 0 TO sizeHeight
    MOVE 0 TO velX
    MOVE 0 TO velY
    MOVE 0 TO accX
    MOVE 0 TO accY
    MOVE 0 TO turnAngle.

GAME-LOOP.
    PERFORM UPDATE.

UPDATE.
    ADD accX TO velX
    ADD accY TO velY
    ADD velX TO posX
    ADD velY TO posY.

HORIZONTAL-COLLISION.
    IF (posX < (posX + sizeWidth) AND
        (posX + sizeWidth) > posX)
    THEN
        DISPLAY "Horizontal Collision Detected".

VERTICAL-COLLISION.
    IF (posY < (posY + sizeHeight) AND
        (posY + sizeHeight) > posY)
    THEN
        DISPLAY "Vertical Collision Detected".

COLLIDE.
    PERFORM HORIZONTAL-COLLISION
    PERFORM VERTICAL-COLLISION.

TURN.
    ADD angle TO turnAngle.