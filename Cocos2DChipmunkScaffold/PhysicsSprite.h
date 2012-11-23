//
//  PhysicsSprite.h
//  Cocos2DChipmunkScaffold
//
//  Created by Tony BELTRAMELLI on 19/10/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "cocos2d.h"
#import "chipmunk.h"

@interface PhysicsSprite : CCSprite
{
	cpBody *_body;
}

-(void) setPhysicsBody:(cpBody*)body;

@end