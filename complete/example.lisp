
;;;; Lisp

(defclass vec2 ()
  ((x :initarg :x :accessor x)
   (y :initarg :y :accessor y)))

(defmethod add ((v vec2) (other vec2))
  (incf (x v) (x other))
  (incf (y v) (y other)))

(defmethod scale ((v vec2) (scalar number))
  (make-instance 'vec2
                 :x (* (x v) scalar)
                 :y (* (y v) scalar)))


(defclass size ()
  ((width  :initarg :width  :accessor width)
   (height :initarg :height :accessor height)))


(defclass game-object ()
  ((position :initarg :position :accessor position)
   (size     :initarg :size     :accessor size)))

(defmethod horizontal-collision ((a game-object) (b game-object))
  (let ((ax (x (position a)))
        (aw (width (size a)))
        (bx (x (position b)))
        (bw (width (size b))))
    (and (< bx (+ ax aw))
         (> (+ bx bw) ax))))

(defmethod vertical-collision ((a game-object) (b game-object))
  (let ((ay (y (position a)))
        (ah (height (size a)))
        (by (y (position b)))
        (bh (height (size b))))
    (and (< by (+ ay ah))
         (> (+ by bh) ay))))

(defmethod collide ((a game-object) (b game-object))
  (and (horizontal-collision a b)
       (vertical-collision a b)))


(defclass movable-object (game-object)
  ((velocity     :initarg :velocity     :accessor velocity)
   (acceleration :initarg :acceleration :accessor acceleration)))

(defmethod update ((m movable-object) (delta-time number))
  (let ((acc-scaled (scale (acceleration m) delta-time)))
    (add (velocity m) acc-scaled))
  (let ((vel-scaled (scale (velocity m) delta-time)))
    (add (position m) vel-scaled)))


(defclass car (movable-object)
  ((turn-angle :initarg :turn-angle :accessor turn-angle)))

(defmethod turn ((c car) (angle number))
  (incf (turn-angle c) angle))

(defmethod update ((c car) (delta-time number))
  (call-next-method)) ; reuses MovableObject update
