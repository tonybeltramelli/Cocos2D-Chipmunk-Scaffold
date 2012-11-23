//
//  TBWall.h
//  Cocos2DChipmunkScaffold
//
//  Created by Tony BELTRAMELLI on 21/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "chipmunk.h"

@interface TBWall : NSObject
{
    cpShape *_shape;
}

-(id) initInSpace:(cpSpace *)space at:(CGPoint)position withWidth:(float)width andHeight:(float)height;
-(id) initInSpace:(cpSpace *)space at:(CGPoint)position withSize:(CGPoint)size;
-(void) clean;

@end
