//
//  TBOverrideSimpleItemExample.m
//  Cocos2DChipmunkScaffold
//
//  Created by Tony BELTRAMELLI on 25/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TBOverrideSimpleItemExample.h"

@implementation TBOverrideSimpleItemExample

-(void) buildWithImage:(NSString *)name at:(CGPoint)pos andAnimateWith:(NSString *)atlasFormat with:(int)imageNumber andDelay:(float)delay
{
    [super buildWithImage:name at:pos andAnimateWith:atlasFormat with:imageNumber andDelay:delay];
    
    cpBody *body = cpBodyNew(100.0, INFINITY);
	cpBodySetPos( body, pos );
    
    cpShape *shape = cpCircleShapeNew(body, 15, CGPointZero);
    cpShapeSetElasticity(shape, 0.5f);
	cpShapeSetFriction(shape, 1.0f);
    
    [[super sprite] setPhysicsBody:body];
    
    [super setBody:body];
    [super setShape:shape];
}

- (void)dealloc
{
    [super dealloc];
}

@end
