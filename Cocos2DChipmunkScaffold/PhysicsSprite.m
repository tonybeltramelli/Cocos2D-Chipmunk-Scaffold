//
//  PhysicsSprite.m
//  Cocos2DChipmunkScaffold
//
//  Created by Tony BELTRAMELLI on 19/10/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import "PhysicsSprite.h"

void removeShape( cpBody *body, cpShape *shape, void *data )
{
	cpShapeFree( shape );
}

#pragma mark - PhysicsSprite
@implementation PhysicsSprite

-(void) setPhysicsBody:(cpBody *)body
{
	_body = body;
}

-(BOOL) dirty
{
	return YES;
}

-(CGAffineTransform) nodeToParentTransform
{	
	CGFloat x = _body->p.x;
	CGFloat y = _body->p.y;
	
	if ( ignoreAnchorPointForPosition_ ) {
		x += anchorPointInPoints_.x;
		y += anchorPointInPoints_.y;
	}
	
	CGFloat c = _body->rot.x;
	CGFloat s = _body->rot.y;
	
	if( ! CGPointEqualToPoint(anchorPointInPoints_, CGPointZero) ){
		x += c*-anchorPointInPoints_.x + -s*-anchorPointInPoints_.y;
		y += s*-anchorPointInPoints_.x + c*-anchorPointInPoints_.y;
	}
	
	transform_ = CGAffineTransformMake( c,  s,
									   -s,	c,
									   x,	y );
	
	return transform_;
}

-(void) dealloc
{
	cpBodyEachShape(_body, removeShape, NULL);
	cpBodyFree(_body);
	
	[super dealloc];
}

@end
