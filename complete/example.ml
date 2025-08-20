(* OCaml *)

type vec2 = {
  mutable x : float;
  mutable y : float;
}

let create_vec2 x y = { x; y }

let add v1 v2 =
  v1.x <- v1.x +. v2.x;
  v1.y <- v1.y +. v2.y

let scale v scalar =
  v.x <- v.x *. scalar;
  v.y <- v.y *. scalar

type size = {
  width : float;
  height : float;
}

let create_size width height = { width; height }

class game_object (position : vec2) (size : size) =
  object (self)
    val mutable position = position
    val mutable size = size

    method horizontal_collision (other : game_object) =
      other#position.x < position.x +. size.width &&
      other#position.x +. other#size.width > position.x

    method vertical_collision (other : game_object) =
      other#position.y < position.y +. size.height &&
      other#position.y +. other#size.height > position.y

    method collide (other : game_object) =
      self#horizontal_collision other && self#vertical_collision other

    method position = position
    method size = size
  end

class movable_object (position : vec2) (size : size) (velocity : vec2) (acceleration : vec2) =
  object (self)
    inherit game_object position size

    method update delta_time =
      add velocity (scale acceleration delta_time);
      add position (scale velocity delta_time)
  end

class car (position : vec2) (size : size) (velocity : vec2) (acceleration : vec2) (turn_angle : float) =
  object (self)
    inherit movable_object position size velocity acceleration

    val mutable turn_angle = turn_angle

    method turn angle =
      turn_angle <- turn_angle +. angle

    method update delta_time =
      super#update delta_time
  end