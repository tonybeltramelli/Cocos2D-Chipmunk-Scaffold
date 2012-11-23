//
//  TBWall.m
//  Cocos2DChipmunkScaffold
//
//  Created by Tony BELTRAMELLI on 21/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TBWall.h"

@implementation TBWall

-(id) initInSpace:(cpSpace *)space at:(CGPoint)position withWidth:(float)width andHeight:(float)height
{
    return [self initInSpace:space at:position withSize:CGPointMake(width, height)];
}

-(id) initInSpace:(cpSpace *)space at:(CGPoint)position withSize:(CGPoint)size
{
    _shape = cpSegmentShapeNew(space->staticBody, position, size, 0.0f);
   
    cpShapeSetElasticity(_shape, 1.0f);
    cpShapeSetFriction(_shape, 1.0f);
    cpSpaceAddStaticShape(space, _shape);
    
    return self;
}

-(void) clean
{
    cpShapeFree(_shape);
}

- (void)dealloc
{
    [self clean];
    [super dealloc];
}

@end
