//
//  TBMonsterBox.m
//  Cocos2DChipmunkScaffold
//
//  Created by Tony BELTRAMELLI on 21/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TBMonsterBox.h"

@implementation TBMonsterBox

-(id) initInSpace:(cpSpace *)space
{
    CGSize s = [[CCDirector sharedDirector] winSize];
    
    _bottom = [[TBWall alloc] initInSpace:space at:CGPointMake(0, 0) withSize:CGPointMake(s.width, 0)];
    _top = [[TBWall alloc] initInSpace:space at:CGPointMake(0, s.height) withSize:CGPointMake(s.width, s.height)];
    _left = [[TBWall alloc] initInSpace:space at:CGPointMake(0, 0) withSize:CGPointMake(0, s.height)];
    _right = [[TBWall alloc] initInSpace:space at:CGPointMake(s.width, 0) withSize:CGPointMake(s.width, s.height)];
    
    return self;
}

-(void) clean
{
    [_top clean];
    [_bottom clean];
    [_left clean];
    [_right clean];
}

- (void)dealloc
{
    [self clean];
    [super dealloc];
}

@end
