//
//  TBJoystick.m
//  Cocos2DChipmunkScaffold
//
//  Created by Tony BELTRAMELLI on 18/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TBJoystick.h"

const float PAD_RADIUS = 90.0f;
const float BTN_RADIUS = 50.0f;

static CGPoint convertCoordinate(CGPoint point) {
	return [[CCDirector sharedDirector] convertToUI:point];
}

static bool isPointInCircle(CGPoint point, CGPoint center, float radius) {
	float dx = (point.x - center.x);
	float dy = (point.y - center.y);
	return (radius >= sqrt( (dx * dx) + (dy * dy) ));
}

@implementation TBJoystick

@synthesize location = _location;
@synthesize size = _size;
@synthesize values = _values;
@synthesize isCenterWithTouchEnd = _isCenterWithTouchEnd;

- (id)init
{
    return [self initWithIsCenterWithTouchEnd:FALSE];
}

- (id)initWithIsCenterWithTouchEnd:(BOOL)isCenterWithTouchEnd
{
    self = [super init];
    if (self)
    {
        #ifdef __CC_PLATFORM_IOS
            self.isTouchEnabled = YES;
        #elif defined(__CC_PLATFORM_MAC)
            self.isMouseEnabled = YES;
        #endif
        
        _isCenterWithTouchEnd = isCenterWithTouchEnd;
        
        _values = CGPointZero;
        
        _size = CGSizeMake(PAD_RADIUS, PAD_RADIUS);
        
        CGSize s = [[CCDirector sharedDirector] winSize];
        _center = CGPointMake(s.width - BTN_RADIUS - 10 , BTN_RADIUS + 10);
        
        _location = CGPointMake(_center.x - _size.width / 2, _center.y - _size.height / 2);
        
        _pad = [CCSprite spriteWithSpriteFrameName:@"joystick_pad.png"];
        [_pad setPosition:_center];
        [self addChild:_pad];
        
        _btn = [CCSprite spriteWithSpriteFrameName:@"joystick_btn.png"];
        [_btn setPosition:_center];
        [self addChild:_btn];
    }
    return self;
}


- (void)updateVelocity:(CGPoint)point {
	float dx = point.x - _center.x;
	float dy = point.y - _center.y;
    
	float distance = sqrt(dx * dx + dy * dy);
	float angle = atan2(dy, dx);
    
	if (distance > PAD_RADIUS) {
		dx = cos(angle) * PAD_RADIUS;
		dy = sin(angle) *  PAD_RADIUS;
	}
    
	_values = CGPointMake(dx/PAD_RADIUS, dy/PAD_RADIUS);
    
	if (distance > BTN_RADIUS) {
		point.x = _center.x + cos(angle) * BTN_RADIUS;
		point.y = _center.y + sin(angle) * BTN_RADIUS;
	}
    
	[_btn setPosition:point];
}

- (CGPoint)getPosition {
    return _center;
}

- (void)reset {
	[self updateVelocity:_center];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView: [touch view]];
	point = convertCoordinate(point);
    
	if (isPointInCircle(point, _center, PAD_RADIUS)) {
		_isPressed = YES;
		[self updateVelocity:point];
	}
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (_isPressed) {
		UITouch *touch = [touches anyObject];
		CGPoint point = [touch locationInView: [touch view]];
		point = convertCoordinate(point);
        
		[self updateVelocity:point];
	}
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	_isPressed = false;
    
    if(_isCenterWithTouchEnd) [self updateVelocity:_center];
}

- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    _isPressed = false;
}

- (void)dealloc
{
    _pad = nil;
    _btn = nil;
    
    [self removeFromParentAndCleanup:YES];
    
    [super dealloc];
}

@end
