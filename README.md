#Cocos2D-Chipmunk-Scaffold
======================

##A scaffold project for Cocos2D iPhone Framework and Chipmunk physics engine.

The aim of this project is to provide a simple scaffold project with examples to easily and fastly start a new game development using Cocos2D.

Features :

* Items with both sprite sheets animations and physics properties.
* A "focus on hero" style camera.
* A native IOS user interface on top of the Cocos2D stage.
* Supported on iPhone, iPad, iPhone HD retina, iPad HD retina.
* A fully functionnal joystick.
* An example of particle effects.
* The class TBSimpleItem :
This class have been created to easily create a dynamic Chipmunk physics object with graphics features as the interface below describe.
You can easily override this class to create your own custom items based on theses functionnalities.

<pre><code>
	// TBSimpleItem.h
	-(void) drawAt:(CGPoint)pos;
		
	-(void) setPhysicProperties:(float)mass andFriction:(float)friction andElasticity:(float)elasticity;
	
	-(void) buildWithImage:(NSString *)name;
	-(void) buildWithImage:(NSString *)name at:(CGPoint)pos;
	-(void) buildWithImage:(NSString *)name andAnimateWith:(NSString *)atlasFormat with:(int)imageNumber;
	-(void) buildWithImage:(NSString *)name andAnimateWith:(NSString *)atlasFormat with:(int)imageNumber andDelay:(float)delay;
	-(void) buildWithImage:(NSString *)name at:(CGPoint)pos andAnimateWith:(NSString *)atlasFormat with:(int)imageNumber;
	-(void) buildWithImage:(NSString *)name at:(CGPoint)pos andAnimateWith:(NSString *)atlasFormat with:(int)imageNumber andDelay:(float)delay;
	
	-(void) setAnimation:(NSString *)atlasFormat with:(int)imageNumber andDelay:(float)delay;
	-(void) setAnimationDelay:(float)delay;
	
	-(void) play;
	-(void) stop;
</code></pre>

Have fun !
@Tbeltramelli <http://twitter.com/#!/tbeltramelli/>

![Cocos2D-Chipmunk-Scaffold - screen shot splashscreen](https://raw.github.com/tonybeltramelli/Cocos2D-Chipmunk-Scaffold/master/Cocos2DChipmunkScaffold/Resources/screen_shot_splashscreen.jpg)
![Cocos2D-Chipmunk-Scaffold - screen shot action1](https://raw.github.com/tonybeltramelli/Cocos2D-Chipmunk-Scaffold/master/Cocos2DChipmunkScaffold/Resources/screen_shot_action1.jpg)
![Cocos2D-Chipmunk-Scaffold - screen shot action2](https://raw.github.com/tonybeltramelli/Cocos2D-Chipmunk-Scaffold/master/Cocos2DChipmunkScaffold/Resources/screen_shot_action2.jpg)