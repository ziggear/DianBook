//
//  Page8.m
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import "Page8.h"


@implementation Page8

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	Page8 *layer = [Page8 node];
	[scene addChild: layer];
	return scene;
}

//重写须修改scene
//场景切换函数：下一页
-(void) nextPage:(int)thisPageCount{
    NSLog(@"nextPage^^^^^^^^^^^^^^^^^8");
    CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page9 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}
//场景切换函数：上一页
-(void) prevPage:(int)thisPageCount{
    NSLog(@"prevPage^^^^^^^^^^^^^^^^^8");	
	CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page7 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}


- (void) onEnterTransitionDidFinish {
    debuglog(@"onEnterTransitionDidFinish");
    CGSize size = [[CCDirector sharedDirector] winSize]; 
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"8_1_00.plist"];
    birdfly = [CCSprite spriteWithSpriteFrameName:@"8_1_001.png"]; 
    birdfly.position = ccp(size.width/2-60, size.height-125);
    birdfly.opacity = 0;
    [self addChild:birdfly z:1];
}
- (id) init {
    if(self = [super init]) {
        NSLog(@"---------------init8");
        
        bgnum = 1;
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background = [CCSprite spriteWithFile:@"bg8_1.png"];
        background.position = ccp(512,384);
        background.scale = 1;
        [self addChild:background z:-1];       
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
        
    }
    return self;
}

-(void)selectSpriteOnPage:(CGPoint)touchLocation{
    debuglog(@"touch2");
    CGSize size = [[CCDirector sharedDirector] winSize]; 
    
    switch (bgnum) {
        case 1:{
            debuglog(@"bg1");
            //显示bg2
            UIImage * image=[UIImage imageNamed:@"bg8_2.png"];  
            CCTexture2D  * newTexture=[[CCTextureCache sharedTextureCache]  addCGImage:image.CGImage forKey:nil];                  
            [background  setTexture:newTexture]; 
            birdfly.opacity = 255;
            
            //帧动画
            Animate *anim = [[Animate alloc] init];
            NSArray *arr = [anim initWithMySpriteFrameName:8 anim:1 count:2];
            CCAnimation *animation = [CCAnimation animationWithSpriteFrames:arr]; 
            [animation setDelayPerUnit:0.15] ;//控制delay控制播放速度
            animation.loops = 1;            //控制循环次数
            id animate = [CCAnimate actionWithAnimation:animation]; 
            
            //上下移动
            id actionJump1 = [CCJumpBy actionWithDuration:0.3 position:ccp(0,20) height:0 jumps:1];
            id actionJump2 = [CCJumpBy actionWithDuration:0.3 position:ccp(0,-20) height:0 jumps:1];
            id actionSequence = [CCSequence actions:actionJump1,actionJump2,nil];
            
            id actions = [CCSpawn actions:actionSequence, animate,nil];

            CCAction *actionf = [CCRepeatForever actionWithAction:actions]; 
            
            [birdfly runAction:actionf];          
            break;
        }
        case 2:{
            debuglog(@"bg2");
            //帧动画
            Animate *anim = [[Animate alloc] init];
            NSArray *arr = [anim initWithMySpriteFrameName:8 anim:1 count:2];
            CCAnimation *animation = [CCAnimation animationWithSpriteFrames:arr]; 
            [animation setDelayPerUnit:0.4] ;//控制delay控制播放速度
            animation.loops = 3;            //控制循环次数
            id animate = [CCAnimate actionWithAnimation:animation]; 
            
            //向上飞
            id actionMove = [CCMoveTo actionWithDuration: 3  position: ccp(size.width/2-60, size.height+125)];
            id actionHide = [CCHide action];
            id action = [CCSpawn actions:animate, actionMove, nil];
            id actionSequence = [CCSequence actions:action,actionHide,nil];

            [birdfly runAction:actionSequence];
            break;
        }
    }
    bgnum++;
}
    
    
    
- (void) dealloc
{
    [background release];
    background = nil;
    
    [birdfly release];
    birdfly = nil;
    
    
	[super dealloc];
}

@end
