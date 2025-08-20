// Objective-C

#import <Foundation/Foundation.h>

@interface Vec2 : NSObject
@property (nonatomic) double x;
@property (nonatomic) double y;
- (instancetype)initWithX:(double)x y:(double)y;
- (void)add:(Vec2 *)other;
- (Vec2 *)scale:(double)scalar;
@end

@implementation Vec2
- (instancetype)initWithX:(double)x y:(double)y {
    if (self = [super init]) {
        _x = x;
        _y = y;
    }
    return self;
}
- (void)add:(Vec2 *)other {
    _x += other.x;
    _y += other.y;
}
- (Vec2 *)scale:(double)scalar {
    return [[Vec2 alloc] initWithX:_x * scalar y:_y * scalar];
}
@end

@interface Size : NSObject
@property (nonatomic) double width;
@property (nonatomic) double height;
- (instancetype)initWithWidth:(double)width height:(double)height;
@end

@implementation Size
- (instancetype)initWithWidth:(double)width height:(double)height {
    if (self = [super init]) {
        _width = width;
        _height = height;
    }
    return self;
}
@end

@interface GameObject : NSObject
@property (nonatomic, strong) Vec2 *position;
@property (nonatomic, strong) Size *size;
- (instancetype)initWithPosition:(Vec2 *)position size:(Size *)size;
- (BOOL)horizontalCollision:(GameObject *)other;
- (BOOL)verticalCollision:(GameObject *)other;
- (BOOL)collide:(GameObject *)other;
@end

@implementation GameObject
- (instancetype)initWithPosition:(Vec2 *)position size:(Size *)size {
    if (self = [super init]) {
        _position = position;
        _size = size;
    }
    return self;
}
- (BOOL)horizontalCollision:(GameObject *)other {
    return (other.position.x < self.position.x + self.size.width) &&
           (other.position.x + other.size.width > self.position.x);
}
- (BOOL)verticalCollision:(GameObject *)other {
    return (other.position.y < self.position.y + self.size.height) &&
           (other.position.y + other.size.height > self.position.y);
}
- (BOOL)collide:(GameObject *)other {
    return [self horizontalCollision:other] && [self verticalCollision:other];
}
@end

@interface MovableObject : GameObject
@property (nonatomic, strong) Vec2 *velocity;
@property (nonatomic, strong) Vec2 *acceleration;
- (instancetype)initWithPosition:(Vec2 *)position
                            size:(Size *)size
                        velocity:(Vec2 *)velocity
                     acceleration:(Vec2 *)acceleration;
- (void)update:(double)deltaTime;
@end

@implementation MovableObject
- (instancetype)initWithPosition:(Vec2 *)position
                            size:(Size *)size
                        velocity:(Vec2 *)velocity
                     acceleration:(Vec2 *)acceleration {
    if (self = [super initWithPosition:position size:size]) {
        _velocity = velocity;
        _acceleration = acceleration;
    }
    return self;
}
- (void)update:(double)deltaTime {
    [self.velocity add:[self.acceleration scale:deltaTime]];
    [self.position add:[self.velocity scale:deltaTime]];
}
@end

@interface Car : MovableObject
@property (nonatomic) double turnAngle;
- (instancetype)initWithPosition:(Vec2 *)position
                            size:(Size *)size
                        velocity:(Vec2 *)velocity
                     acceleration:(Vec2 *)acceleration
                       turnAngle:(double)turnAngle;
- (void)turn:(double)angle;
@end

@implementation Car
- (instancetype)initWithPosition:(Vec2 *)position
                            size:(Size *)size
                        velocity:(Vec2 *)velocity
                     acceleration:(Vec2 *)acceleration
                       turnAngle:(double)turnAngle {
    if (self = [super initWithPosition:position size:size velocity:velocity acceleration:acceleration]) {
        _turnAngle = turnAngle;
    }
    return self;
}
- (void)turn:(double)angle {
    _turnAngle += angle;
}
- (void)update:(double)deltaTime {
    [super update:deltaTime];
}
@end
