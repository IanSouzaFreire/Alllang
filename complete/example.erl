%% Erlang

-module(game_sim).
-export([
    new_vec2/2, add_vec2/2, scale_vec2/2,
    new_size/2,
    new_game_object/2, horizontal_collision/2, vertical_collision/2, collide/2,
    new_movable_object/4, update_movable/2,
    new_car/5, turn_car/2, update_car/2
]).

%% Vec2
new_vec2(X, Y) ->
    {vec2, X, Y}.

add_vec2({vec2, X1, Y1}, {vec2, X2, Y2}) ->
    {vec2, X1 + X2, Y1 + Y2}.

scale_vec2({vec2, X, Y}, Scalar) ->
    {vec2, X * Scalar, Y * Scalar}.

%% Size
new_size(W, H) ->
    {size, W, H}.

%% GameObject
new_game_object(Position, Size) ->
    {game_object, Position, Size}.

horizontal_collision({game_object, {vec2, X1, _}, {size, W1, _}},
                     {game_object, {vec2, X2, _}, {size, W2, _}}) ->
    X2 < X1 + W1 andalso X2 + W2 > X1.

vertical_collision({game_object, {vec2, _, Y1}, {size, _, H1}},
                   {game_object, {vec2, _, Y2}, {size, _, H2}}) ->
    Y2 < Y1 + H1 andalso Y2 + H2 > Y1.

collide(G1, G2) ->
    horizontal_collision(G1, G2) andalso vertical_collision(G1, G2).

%% MovableObject
new_movable_object(Pos, Size, Vel, Acc) ->
    {movable_object, Pos, Size, Vel, Acc}.

update_movable({movable_object, Pos, Size, Vel, Acc}, DeltaTime) ->
    ScaledAcc = scale_vec2(Acc, DeltaTime),
    NewVel = add_vec2(Vel, ScaledAcc),
    ScaledVel = scale_vec2(NewVel, DeltaTime),
    NewPos = add_vec2(Pos, ScaledVel),
    {movable_object, NewPos, Size, NewVel, Acc}.

%% Car
new_car(Pos, Size, Vel, Acc, TurnAngle) ->
    {car, Pos, Size, Vel, Acc, TurnAngle}.

turn_car({car, Pos, Size, Vel, Acc, Angle}, Delta) ->
    {car, Pos, Size, Vel, Acc, Angle + Delta}.

update_car({car, Pos, Size, Vel, Acc, Angle}, DeltaTime) ->
    {movable_object, NewPos, NewSize, NewVel, NewAcc} =
        update_movable({movable_object, Pos, Size, Vel, Acc}, DeltaTime),
    {car, NewPos, NewSize, NewVel, NewAcc, Angle}.
