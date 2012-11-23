//
//  AppDelegate.h
//  Cocos2DChipmunkScaffold
//
//  Created by Tony BELTRAMELLI on 19/10/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *_window;
	UINavigationController *_navController;
	
	CCDirectorIOS *_director;
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
