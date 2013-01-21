//
//  TBJoystick.h
//  Cocos2DChipmunkScaffold
//
//  Created by Tony BELTRAMELLI on 18/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"

@interface TBJoystick : CCLayer
{
    CCSprite *_pad;
    CCSprite *_btn;
    CGPoint _center;
    
    BOOL _isPressed;
}

@property (assign, nonatomic) CGPoint location;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint values;
@property (assign, nonatomic) BOOL isCenterWithTouchEnd;

- (id)initWithIsCenterWithTouchEnd:(BOOL)isCenterWithTouchEnd;
- (void)reset;

@end
- (void)reset;

@end
