//
//  TBMonster.m
//  Cocos2DChipmunkScaffold
//
//  Created by Tony BELTRAMELLI on 20/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TBMonster.h"

@implementation TBMonster
{
    int n;
}

- (void) drawAt:(CGPoint)pos
{
    n = (arc4random() % 3) + 1;
    NSString *intString = [NSString stringWithFormat:@"monster%d", n];
    
    NSString *image = [NSString stringWithFormat:@"%@%@",intString,@"_1.png"];
    NSString *animation = [NSString stringWithFormat:@"%@%@",intString,@"_%d.png"];
    
    float ratio = (0.25f * n);
    [super setPhysicProperties:(float)(1.0f + ratio) andFriction:(float)(1.2f + ratio)andElasticity:(float)(2.0f + ratio)];
    [super buildWithImage:image at:pos andAnimateWith:animation with:3];
}

-(int) getColor
{
    int color = 0xFFFFFF;
    
    switch (n) {
        case 1:
            color = 0x5cb627;
            break;
        case 2:
            color = 0xcf2c34;
            break;
        case 3:
            color = 0x886a6a;
            break;
        default:
            break;
    }
    return color;
}

- (void)dealloc
{
    [super dealloc];
}

@end
