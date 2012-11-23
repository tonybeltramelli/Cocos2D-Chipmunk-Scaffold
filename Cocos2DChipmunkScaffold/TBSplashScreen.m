//
//  IntroLayer.m
//  Cocos2DChipmunkScaffold
//
//  Created by Tony BELTRAMELLI on 19/10/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import "TBSplashScreen.h"
#import "TBMainScreen.h"

@implementation TBSplashScreen

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
	
	TBSplashScreen *layer = [TBSplashScreen node];
	[scene addChild: layer];
	
    return scene;
}

-(void) onEnter
{
	[super onEnter];

	CGSize size = [[CCDirector sharedDirector] winSize];

	CCSprite *background;
	
	if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
		background = [CCSprite spriteWithFile:@"Default.png"];
		background.rotation = 90;
	} else {
		background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
	}
	background.position = ccp(size.width/2, size.height/2);

	[self addChild: background];
	
	[self scheduleOnce:@selector(makeTransition:) delay:1];
}

-(void) makeTransition:(ccTime)dt
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[TBMainScreen scene] withColor:ccBLACK]];
}
@end
