//
//  TBGame.m
//  Cocos2DChipmunkScaffold
//
//  Created by Tony BELTRAMELLI on 20/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TBMainScreen.h"

enum {
    mainContainer = 1,
    backgroundContainer = 2,
};

static ccColor4F hexColorToRGBA(int hexValue, float alpha)
{    
    float pRed = (hexValue & 0xFF0000) >> 16;
    float pGreen = (hexValue & 0xFF00) >> 8;
    float pBlue = (hexValue & 0xFF);
    
	return (ccColor4F) {pRed/255, pGreen/255, pBlue/255, alpha};
}

@interface TBMainScreen ()
{
    CCTexture2D *_spriteTexture;
    
    cpSpace *_space;
    
	TBMonsterBox *_monsterBox;   
    TBHero *_hero;
    
    NSMutableArray *_monsters;
    
    TBModel *_model;
    TBJoystick *_joystick;
    
    UIButton *_restartButton;
    UIButton *_switchAnimationsButton;
    UISlider *_slider;
    UILabel *_labelSlider;
    UIButton *_cameraButton;
    UILabel *_labelJoystick;
}

-(void) addOrMoveHeroAtPosition:(CGPoint)pos;
-(void) buildUI;
-(void) initPhysics;

@end

@implementation TBMainScreen

+(CCScene *) scene
{    
	CCScene *scene = [CCScene node];
    
    TBMainScreen *layer = [TBMainScreen node];
	[scene addChild:layer z:0 tag:mainContainer];
    
	return scene;
}

-(id) init
{
    self = [super init];
	if (self)
    {
        #ifdef __CC_PLATFORM_IOS
            self.isTouchEnabled = YES;
        #elif defined(__CC_PLATFORM_MAC)
            self.isMouseEnabled = YES;
        #endif
		
		CGSize s = [[CCDirector sharedDirector] winSize];
        
        _model = [[TBModel alloc] init];
		
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[self isRetinaDisplay] ? @"sprite_sheet@2x.plist" : @"sprite_sheet.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:[self isRetinaDisplay] ? @"sprite_sheet@2x.png" : @"sprite_sheet.png" capacity:100];
        _spriteTexture = [spriteSheet texture];
		[self addChild:spriteSheet z:0 tag:mainContainer];
        
        _monsters = [[NSMutableArray alloc] init];
        
        CCSprite *background = [CCSprite spriteWithFile:@"mapPattern.png" rect:CGRectMake(0,0,s.width*5,s.height*5)];
        ccTexParams params = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};
        [background.texture setTexParameters: &params];
        [self addChild:background z:-1 tag:backgroundContainer];
        
        [self initPhysics];
        
		[self buildUI];
        
        [self addOrMoveHeroAtPosition: cpv(s.width / 2, s.height / 2)];
        
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) initPhysics
{
	_space = cpSpaceNew();
    
	cpSpaceSetGravity( _space, cpv(0, -100) );
	
	_monsterBox = [[TBMonsterBox alloc] initInSpace:_space];
}

-(void) update:(ccTime)delta
{
	int steps = 2;
	CGFloat dt = [[CCDirector sharedDirector] animationInterval]/(CGFloat)steps;
	
	for(int i=0; i<steps; i++){
		cpSpaceStep(_space, dt);
	}
    
    if(_model.isCameraOnPlayer)
    {
        CGSize s = [[CCDirector sharedDirector] winSize];

        CCNode *container = [self getChildByTag:mainContainer];
        container.position = cpv(-[_hero getPosition].x + s.width / 2, -[_hero getPosition].y + s.height / 2);
        
        [self getChildByTag:backgroundContainer].position = container.position;
    }
    
    CGPoint gravity = [_joystick values];

    cpSpaceSetGravity(_space, cpv(gravity.x * 100, gravity.y * 100));
}

-(void) buildUI
{
	_restartButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_restartButton addTarget:self action:@selector(restartAction:) forControlEvents:UIControlEventTouchDown];
    [_restartButton setTitle:[_model resetString] forState:UIControlStateNormal];
    _restartButton.frame = CGRectMake(-20.0, 410.0, 90.0, 30.0);
    _restartButton.transform = CGAffineTransformMakeRotation(-90.0*M_PI/180.0);
    
    _switchAnimationsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_switchAnimationsButton addTarget:self action:@selector(stopAllAnimationsAction:) forControlEvents:UIControlEventTouchDown];
    [_switchAnimationsButton setTitle:[_model stopString] forState:UIControlStateNormal];
    _switchAnimationsButton.frame = CGRectMake(-20.0, 300.0, 90.0, 30.0);
    _switchAnimationsButton.transform = CGAffineTransformMakeRotation(-90.0*M_PI/180.0);
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(-20.0, 190.0, 100.0, 30.0)];
    [_slider addTarget:self action:@selector(updateAnimationSpeed:) forControlEvents:UIControlEventValueChanged];
    [_slider setMinimumValue:0];
    [_slider setMaximumValue:0.1];
    [_slider setValue:_model.animationDelay];
    _slider.transform = CGAffineTransformMakeRotation(-90.0*M_PI/180.0);

    _labelSlider = [[UILabel alloc] initWithFrame:CGRectMake(-40.0, 180.0, 100.0, 30.0)];
    [_labelSlider setBackgroundColor:[UIColor clearColor]];
    [_labelSlider setTextColor:[UIColor whiteColor]];
    [_labelSlider setText:[NSString stringWithFormat:@"%@ %.2f",_model.animationDelayString,[_slider value]]];
    _labelSlider.transform = CGAffineTransformMakeRotation(-90.0*M_PI/180.0);
    
    _cameraButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_cameraButton addTarget:self action:@selector(switchCameraFocus:) forControlEvents:UIControlEventTouchDown];
    [_cameraButton setTitle:[_model cameraHeroString] forState:UIControlStateNormal];
    _cameraButton.frame = CGRectMake(-40.0, 60.0, 130.0, 30.0);
    _cameraButton.transform = CGAffineTransformMakeRotation(-90.0*M_PI/180.0);
    
    _joystick = [[TBJoystick alloc] init];
    
    CGSize s = [[CCDirector sharedDirector] winSize];
    
    _labelJoystick = [[UILabel alloc] initWithFrame:CGRectMake(s.height - _joystick.size.height * 2 + 10, 20.0, 100.0, 30.0)];
    [_labelJoystick setBackgroundColor:[UIColor clearColor]];
    [_labelJoystick setTextColor:[UIColor whiteColor]];
    [_labelJoystick setText:[NSString stringWithFormat:@"%@",_model.gravityString]];
    _labelJoystick.transform = CGAffineTransformMakeRotation(-90.0*M_PI/180.0);
    
    [[[[CCDirector sharedDirector] view] window] addSubview:_restartButton];
    [[[[CCDirector sharedDirector] view] window] addSubview:_switchAnimationsButton];
    [[[[CCDirector sharedDirector] view] window] addSubview:_slider];
    [[[[CCDirector sharedDirector] view] window] addSubview:_labelSlider];
    [[[[CCDirector sharedDirector] view] window] addSubview:_cameraButton];
    [[[[CCDirector sharedDirector] view] window] addSubview:_labelJoystick];
    
    [self addChild:_joystick];
}

-(void) addOrMoveHeroAtPosition:(CGPoint)pos
{    
    CCNode *container = [self getChildByTag:mainContainer];
    
    if(_hero)
    {
        [_hero setPosition:pos];
    }else{
        _hero = [[TBHero alloc] init];
        [_hero drawAt:pos];
        [_hero setAnimationDelay:_model.animationDelay];
        
        [self addParticle:0xa199cc at:pos];
        
        [container addChild:_hero.sprite];
        cpSpaceAddBody(_space, _hero.body);
        cpSpaceAddShape(_space, _hero.shape);
    }
}

-(void) addMonsterAt:(CGPoint)pos
{
    CCNode *container = [self getChildByTag:mainContainer];
    
    TBMonster *monster = [[TBMonster alloc] init];
    [monster setAnimationDelay:_model.animationDelay];
    [monster drawAt:pos];
    
    [self addParticle:[monster getColor] at:pos];
    
    [container addChild:monster.sprite];
    cpSpaceAddBody(_space, monster.body);
    cpSpaceAddShape(_space, monster.shape);
    
    [_monsters addObject:monster];
}

-(void) addParticle:(int)hexColor at:(CGPoint)pos
{
    CCParticleSystem *particle = [[CCParticleGalaxy alloc] initWithTotalParticles:20];
    [self addChild:particle];
    particle.position = pos;
    particle.startColor = hexColorToRGBA(hexColor, 1.0f);
    particle.startSize = 20;
    particle.endSize = 1;
    particle.emissionRate = 20;
    particle.life = 2.0f;
    particle.duration = 1.0f;
}

- (IBAction)restartAction:(id)sender
{
    [[CCDirector sharedDirector] replaceScene: [TBMainScreen scene]];
}

- (IBAction)stopAllAnimationsAction:(id)sender
{
    [_hero stop];
    
    NSInteger length = [_monsters count];
    
    for(int i = 0; i < length; i++)
    {
        id child = [_monsters objectAtIndex:i];
        [(TBMonster *)child stop];
    }
    
    [(UIButton *)sender setTitle:[_model playString] forState:UIControlStateNormal];
    [(UIButton *)sender removeTarget:self action:@selector(stopAllAnimationsAction:) forControlEvents:UIControlEventTouchDown];
    [(UIButton *)sender addTarget:self action:@selector(playAllAnimationsAction:) forControlEvents:UIControlEventTouchDown];
}

- (IBAction)playAllAnimationsAction:(id)sender
{
    [_hero play];
    
    NSInteger length = [_monsters count];
    
    for(int i = 0; i < length; i++)
    {
        id child = [_monsters objectAtIndex:i];
        [(TBMonster *)child play];
    }
    
    [(UIButton *)sender setTitle:[_model stopString] forState:UIControlStateNormal];
    [(UIButton *)sender removeTarget:self action:@selector(playAllAnimationsAction:) forControlEvents:UIControlEventTouchDown];
    [(UIButton *)sender addTarget:self action:@selector(stopAllAnimationsAction:) forControlEvents:UIControlEventTouchDown]; 
}

- (IBAction)updateAnimationSpeed:(id)sender
{
    float value = [(UISlider *)sender value];
    [_model setAnimationDelay:value];
    
    [_hero setAnimationDelay:_model.animationDelay];
    
    NSInteger length = [_monsters count];
    
    for(int i = 0; i < length; i++)
    {
        id child = [_monsters objectAtIndex:i];
        [(TBMonster *)child setAnimationDelay:_model.animationDelay];
    }
    
    [_labelSlider setText:[NSString stringWithFormat:@"%@ %.2f",_model.animationDelayString,_model.animationDelay]];
}

- (IBAction)switchCameraFocus:(id)sender
{
    if(_model.isCameraOnPlayer)
    {
        _model.isCameraOnPlayer = false;
        [(UIButton *)sender setTitle:[_model cameraHeroString] forState:UIControlStateNormal];
        
        CCNode *container = [self getChildByTag:mainContainer];
        container.position = cpv(0, 0);
        
        [self getChildByTag:backgroundContainer].position = container.position;        
    }else{
        _model.isCameraOnPlayer = true;
        [(UIButton *)sender setTitle:[_model cameraSceneString] forState:UIControlStateNormal];
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for( UITouch *touch in touches ) {
        CGPoint location = [touch locationInView: [touch view]];
        location = [[CCDirector sharedDirector] convertToGL: location];
        
        if(![self isHitJoystick:location])
        {
            [self addMonsterAt:location];
        }
    }
}

- (BOOL)isHitJoystick:(CGPoint)location
{
    CGPoint joystickLocation = [_joystick location];
    CGSize joystickSize = [_joystick size];
    
    if((location.x > joystickLocation.x && location.x < joystickLocation.x + joystickSize.width) &&
    (location.y > joystickLocation.y && location.y < joystickLocation.y + joystickSize.height))
    {
        return true;
    }
    return false;
}

- (BOOL)isRetinaDisplay
{
    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    {
        return [[UIScreen mainScreen] scale] == 2.0 ? YES : NO;
    }
    
    return NO;
}

- (void)dealloc
{
	cpSpaceFree(_space);
    
    [_monsterBox clean];
    
    _monsterBox = nil;
    
    [_restartButton removeFromSuperview];
    [_switchAnimationsButton removeFromSuperview];
    [_slider removeFromSuperview];
    [_labelSlider removeFromSuperview];
    [_labelJoystick removeFromSuperview];
    
    _restartButton = nil;
    _switchAnimationsButton = nil;
    _slider = nil;
    _labelSlider = nil;
    _labelJoystick = nil;
    
    
    _joystick = nil;
    
    _hero = nil;
    _monsters = nil;
    _model = nil;
    
    [super dealloc];
}

@end
