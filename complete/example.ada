-- Ada Spark

package body Example is
    type Vec2 is record
        X : Float;
        Y : Float;
        end record;

    procedure Add (V1 : in out Vec2; V2 : in Vec2) is
        begin
        V1.X := V1.X + V2.X;
        V1.Y := V1.Y + V2.Y;
        end Add;

    procedure Scale (V : in out Vec2; Scalar : in Float) is
        begin
        V.X := V.X * Scalar;
        V.Y := V.Y * Scalar;
        end Scale;

    type Size is record
        Width  : Float;
        Height : Float;
        end record;

    type GameObject is abstract tagged record
        Position : Vec2;
        Size     : Size;
        end record;

    function Horizontal_Collision (G1 : in GameObject; G2 : in GameObject) return Boolean is
        begin
        return (G2.Position.X < G1.Position.X + G1.Size.Width and
                G2.Position.X + G2.Size.Width > G1.Position.X);
        end Horizontal_Collision;

    function Vertical_Collision (G1 : in GameObject; G2 : in GameObject) return Boolean is
        begin
        return (G2.Position.Y < G1.Position.Y + G1.Size.Height and
                G2.Position.Y + G2.Size.Height > G1.Position.Y);
        end Vertical_Collision;

    function Collide (G1 : in GameObject; G2 : in GameObject) return Boolean is
        begin
        return Horizontal_Collision(G1, G2) and Vertical_Collision(G1, G2);
        end Collide;

    type MovableObject is new GameObject with record
        Velocity    : Vec2;
        Acceleration : Vec2;
        end record;

    function Update (M : in out MovableObject; DeltaTime : in Float) return MovableObject is
        begin
        Add(M.Velocity, M.Acceleration);
        Scale(M.Velocity, DeltaTime);
        Add(M.Position, M.Velocity);
        end Update;

    type Car is new MovableObject with record
        TurnAngle : Float;
        end record;

    function Turn (C : in out Car; Angle : in Float) return Car is
        begin
        C.TurnAngle := C.TurnAngle + Angle;
        end Turn;

    function Update (C : in out Car; DeltaTime : in Float) return Car is
        begin
        Update(C.MovableObject, DeltaTime);
        end Update;
end Example;
