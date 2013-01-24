//
//  TBMonsterBox.h
//  Cocos2DChipmunkScaffold
//
//  Created by Tony BELTRAMELLI on 21/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "chipmunk.h"
#import "cocos2d.h"
#import "TBWall.h"

@interface TBMonsterBox : NSObject
{
    TBWall *_top;
    TBWall *_left;
    TBWall *_bottom;
    TBWall *_right;
}

-(id) initInSpace:(cpSpace *)space;

@end
