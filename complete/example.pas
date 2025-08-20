(* Pascal *)

type
  TVec2 = class
  public
    x: Double;
    y: Double;
    constructor Create(AX, AY: Double);
    procedure Add(const Other: TVec2);
    procedure Scale(const Scalar: Double);
  end;

  TSize = class
  public
    Width: Double;
    Height: Double;
    constructor Create(AWidth, AHeight: Double);
  end;

  TGameObject = class
  protected
    Position: TVec2;
    Size: TSize;
  public
    constructor Create(APosition: TVec2; ASize: TSize);
    function HorizontalCollision(const Other: TGameObject): Boolean;
    function VerticalCollision(const Other: TGameObject): Boolean;
    function Collide(const Other: TGameObject): Boolean;
  end;

  TMovableObject = class(TGameObject)
  protected
    Velocity: TVec2;
    Acceleration: TVec2;
  public
    constructor Create(APosition: TVec2; ASize: TSize; AVelocity, AAcceleration: TVec2);
    procedure Update(const DeltaTime: Double);
  end;

  TCar = class(TMovableObject)
  private
    TurnAngle: Double;
  public
    constructor Create(APosition: TVec2; ASize: TSize; AVelocity, AAcceleration: TVec2; ATurnAngle: Double);
    procedure Turn(const Angle: Double);
    procedure Update(const DeltaTime: Double); override;
  end;


{ TVec2 }

constructor TVec2.Create(AX, AY: Double);
begin
  x := AX;
  y := AY;
end;

procedure TVec2.Add(const Other: TVec2);
begin
  x := x + Other.x;
  y := y + Other.y;
end;

procedure TVec2.Scale(const Scalar: Double);
begin
  x := x * Scalar;
  y := y * Scalar;
end;


{ TSize }

constructor TSize.Create(AWidth, AHeight: Double);
begin
  Width := AWidth;
  Height := AHeight;
end;


{ TGameObject }

constructor TGameObject.Create(APosition: TVec2; ASize: TSize);
begin
  Position := APosition;
  Size := ASize;
end;

function TGameObject.HorizontalCollision(const Other: TGameObject): Boolean;
begin
  Result := (Other.Position.x < Position.x + Size.Width) and
            (Other.Position.x + Other.Size.Width > Position.x);
end;

function TGameObject.VerticalCollision(const Other: TGameObject): Boolean;
begin
  Result := (Other.Position.y < Position.y + Size.Height) and
            (Other.Position.y + Other.Size.Height > Position.y);
end;

function TGameObject.Collide(const Other: TGameObject): Boolean;
begin
  Result := HorizontalCollision(Other) and VerticalCollision(Other);
end;


{ TMovableObject }

constructor TMovableObject.Create(APosition: TVec2; ASize: TSize; AVelocity, AAcceleration: TVec2);
begin
  inherited Create(APosition, ASize);
  Velocity := AVelocity;
  Acceleration := AAcceleration;
end;

procedure TMovableObject.Update(const DeltaTime: Double);
begin
  Acceleration.Scale(DeltaTime);
  Velocity.Add(Acceleration);
  Velocity.Scale(DeltaTime);
  Position.Add(Velocity);
end;


{ TCar }

constructor TCar.Create(APosition: TVec2; ASize: TSize; AVelocity, AAcceleration: TVec2; ATurnAngle: Double);
begin
  inherited Create(APosition, ASize, AVelocity, AAcceleration);
  TurnAngle := ATurnAngle;
end;

procedure TCar.Turn(const Angle: Double);
begin
  TurnAngle := TurnAngle + Angle;
end;

procedure TCar.Update(const DeltaTime: Double);
begin
  inherited Update(DeltaTime);
end;
