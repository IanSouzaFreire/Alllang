;; Clojure

(defrecord Vec2 [x y]
  Object
  (add [this other]
    (->Vec2 (+ x (:x other)) (+ y (:y other))))
  (scale [this scalar]
    (->Vec2 (* x scalar) (* y scalar))))

(defrecord Size [width height])

(defprotocol ICollidable
  (horizontal-collision? [this other])
  (vertical-collision? [this other])
  (collide? [this other]))

(defrecord GameObject [position size]
  ICollidable
  (horizontal-collision? [this other]
    (let [p1 (:position this)
          p2 (:position other)
          s1 (:size this)
          s2 (:size other)]
      (and (< (:x p2) (+ (:x p1) (:width s1)))
           (> (+ (:x p2) (:width s2)) (:x p1)))))
  (vertical-collision? [this other]
    (let [p1 (:position this)
          p2 (:position other)
          s1 (:size this)
          s2 (:size other)]
      (and (< (:y p2) (+ (:y p1) (:height s1)))
           (> (+ (:y p2) (:height s2)) (:y p1)))))
  (collide? [this other]
    (and (horizontal-collision? this other)
         (vertical-collision? this other))))

(defrecord MovableObject [position size velocity acceleration]
  ICollidable
  (horizontal-collision? [this other] (horizontal-collision? (:gameobject this) other))
  (vertical-collision? [this other] (vertical-collision? (:gameobject this) other))
  (collide? [this other] (collide? (:gameobject this) other))
  (update [this delta-time]
    (let [new-velocity (add velocity (scale acceleration delta-time))
          new-position (add position (scale new-velocity delta-time))]
      (assoc this :velocity new-velocity :position new-position)))

(defrecord Car [position size velocity acceleration turn-angle]
  ICollidable
  (horizontal-collision? [this other] (horizontal-collision? (:movableobject this) other))
  (vertical-collision? [this other] (vertical-collision? (:movableobject this) other))
  (collide? [this other] (collide? (:movableobject this) other))
  (turn [this angle]
    (assoc this :turn-angle (+ turn-angle angle)))
  (update [this delta-time]
    (update (:movableobject this) delta-time)))
