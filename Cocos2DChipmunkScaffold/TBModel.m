//
//  TBModel.m
//  Cocos2DChipmunkScaffold
//
//  Created by Tony BELTRAMELLI on 31/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TBModel.h"

@implementation TBModel

@synthesize resetString = _resetString;
@synthesize stopString = _stopString;
@synthesize playString = _playString;
@synthesize animationDelayString = _animationDelayString;
@synthesize animationDelay = _animationDelay;
@synthesize cameraHeroString = _cameraHeroString;
@synthesize cameraSceneString = _cameraSceneString;
@synthesize isCameraOnPlayer = _isCameraOnPlayer;
@synthesize gravityString = _gravityString;

- (id)init
{
    self = [super init];
    if (self) {
        _resetString = @"Reset";
        _stopString = @"Stop anim";
        _playString = @"Play anim";
        _animationDelayString = @"Delay";
        _animationDelay = 0.05f;
        _cameraHeroString = @"Camera on hero";
        _cameraSceneString = @"Camera on scene";
        _isCameraOnPlayer = false;
        _gravityString = @"Gravity";
    }
    return self;
}

@end
