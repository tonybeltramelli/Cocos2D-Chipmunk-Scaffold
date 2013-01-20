//
//  TBSimpleItem.h
//  Cocos2DChipmunkScaffold
//
//  Created by Tony BELTRAMELLI on 20/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"
#import "PhysicsSprite.h"

@interface TBSimpleItem : NSObject

@property (assign, nonatomic) PhysicsSprite *sprite;
@property (assign, nonatomic) cpBody *body;
@property (assign, nonatomic) cpShape *shape;

-(void) drawAt:(CGPoint)pos;

-(void) setPhysicProperties:(float)mass andFriction:(float)friction andElasticity:(float)elasticity;

-(void) buildWithImage:(NSString *)name;
-(void) buildWithImage:(NSString *)name at:(CGPoint)pos;
-(void) buildWithImage:(NSString *)name andAnimateWith:(NSString *)atlasFormat with:(int)imageNumber;
-(void) buildWithImage:(NSString *)name andAnimateWith:(NSString *)atlasFormat with:(int)imageNumber andDelay:(float)delay;
-(void) buildWithImage:(NSString *)name at:(CGPoint)pos andAnimateWith:(NSString *)atlasFormat with:(int)imageNumber;
-(void) buildWithImage:(NSString *)name at:(CGPoint)pos andAnimateWith:(NSString *)atlasFormat with:(int)imageNumber andDelay:(float)delay;

-(void) setAnimation:(NSString *)atlasFormat with:(int)imageNumber andDelay:(float)delay;
-(void) setAnimation:(NSString *)atlasFormat with:(int)imageNumber;
-(void) setAnimationDelay:(float)delay;

-(void) play;
-(void) stop;

-(void) setPosition:(CGPoint)pos;
-(CGPoint) getPosition;

-(void) setX:(CGFloat)xPos;
-(CGFloat) getX;

-(void) setY:(CGFloat)yPos;
-(CGFloat) getY;

-(CGSize) getSize;
-(CGFloat) getWidth;
-(CGFloat) getHeight;

@end