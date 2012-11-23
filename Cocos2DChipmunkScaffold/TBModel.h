//
//  TBModel.h
//  Cocos2DChipmunkScaffold
//
//  Created by Tony BELTRAMELLI on 31/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBModel : NSObject

@property (assign) NSString *resetString;
@property (assign) NSString *stopString;
@property (assign) NSString *playString;
@property (assign) NSString *animationDelayString;
@property (assign) NSString *cameraHeroString;
@property (assign) NSString *cameraSceneString;
@property (assign) NSString *gravityString;

@property (assign) float animationDelay;
@property (assign) BOOL isCameraOnPlayer;

@end
