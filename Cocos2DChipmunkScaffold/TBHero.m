//
//  TBHero.m
//  Cocos2DChipmunkScaffold
//
//  Created by Tony BELTRAMELLI on 20/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TBHero.h"

@implementation TBHero

-(void) drawAt:(CGPoint)pos
{
    [super buildWithImage:@"hero_1.png" at:pos andAnimateWith:@"hero_%d.png" with:9 andDelay:0.1f];   
}

- (void)dealloc
{
    [super dealloc];
}

@end
