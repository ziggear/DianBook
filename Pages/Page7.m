//
//  Page7.m
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import "Page7.h"

@implementation Page7

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	Page7 *layer = [Page7 node];
	[scene addChild: layer];
	return scene;
}

//重写须修改scene
//场景切换函数：下一页
-(void) nextPage:(int)thisPageCount{
    
    NSLog(@"nextPage^^^^^^^^^^^^^^^^^7");
    CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page8 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}
//场景切换函数：上一页
-(void) prevPage:(int)thisPageCount{
    NSLog(@"prevPage^^^^^^^^^^^^^^^^^7");	
	CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page6 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}


- (void) onEnterTransitionDidFinish {
    debuglog(@"onEnterTransitionDidFinish");
    CGSize size = [[CCDirector sharedDirector] winSize]; 

    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"7_1_00.plist"];
    dogrun = [CCSprite spriteWithSpriteFrameName:@"7_1_001.png"]; 
    dogrun.position = ccp(1300, size.height*0.75);
    [self addChild:dogrun z:1];

    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"7_2_00.plist"];
    birdjump1 = [CCSprite spriteWithSpriteFrameName:@"7_2_001.png"]; 
    birdjump1.position = ccp(-100, size.height*0.3);
    [self addChild:birdjump1 z:1];
    
    birdjump2 = [CCSprite spriteWithFile:@"7_3_00.png"]; 
    birdjump2.position = ccp(1124, size.height*0.3);
    [self addChild:birdjump2 z:2];
 
}

- (id) init {
    if(self = [super init]) {
        NSLog(@"---------------init7");
            
        bgnum = 1;
        
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background = [CCSprite spriteWithFile:@"bg7_1.png"];
        background.position = ccp(512,384);
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
            Animate *anim = [[Animate alloc] init];
            NSArray *arr = [anim initWithMySpriteFrameName:7 anim:1 count:2];
            CCAnimation *animation = [CCAnimation animationWithSpriteFrames:arr]; 
            [animation setDelayPerUnit:0.3] ;//控制delay控制播放速度
            animation.loops = 3;            //控制循环次数
            id animate = [CCAnimate actionWithAnimation:animation]; 
            id actionJump = [CCJumpBy actionWithDuration:2.1 position:ccp(-1300+size.width-512, 0) height:0 jumps:1];
            
            id action = [CCSpawn actions:actionJump, animate,nil];
 
            [dogrun runAction:action];
            break;
        }
        case 2:
        {
             //帧动画
            Animate *anim = [[Animate alloc] init];
            NSArray *arr = [anim initWithMySpriteFrameName:7 anim:2 count:2];
            CCAnimation *animation = [CCAnimation animationWithSpriteFrames:arr]; 
            [animation setDelayPerUnit:0.15] ;//控制delay控制播放速度
            animation.loops = 1;            //控制循环次数
            id animate = [CCAnimate actionWithAnimation:animation]; 
            
            //跳跃运动  总长：356，356/4=89
            id actionJump1 = [CCJumpBy actionWithDuration:0.3 position:ccp(89,100) height:0 jumps:1];
            id action1 = [CCSpawn actions:actionJump1, animate,nil];
            
            id actionJump2 = [CCJumpBy actionWithDuration:0.3 position:ccp(89,-100) height:0 jumps:1];
            id action2 = [CCSpawn actions:actionJump2, animate,nil];
            
            id actionJump3 = [CCJumpBy actionWithDuration:0.3 position:ccp(89,100) height:0 jumps:1];
            id action3 = [CCSpawn actions:actionJump3, animate,nil];
            
            id actionJump4 = [CCJumpBy actionWithDuration:0.3 position:ccp(89,-100) height:0 jumps:1];
            id action4 = [CCSpawn actions:actionJump4, animate,nil];
            
            id actionSequence = [CCSequence actions:action1,action2,action3,action4,nil]; 
            [birdjump1 runAction:actionSequence];
            break;            
        }
        case 3:
        {
            //跳跃运动  总长：356，356/4=133
            id actionJump1 = [CCJumpBy actionWithDuration:1.5 position:ccp(-89,100) height:0 jumps:1];            
            id actionJump2 = [CCJumpBy actionWithDuration:1.5 position:ccp(-89,-100) height:0 jumps:1];            
            id actionJump3 = [CCJumpBy actionWithDuration:1.5 position:ccp(-89,100) height:0 jumps:1];        
            id actionJump4 = [CCJumpBy actionWithDuration:1.5 position:ccp(-89,-100) height:0 jumps:1];         
            id actionSequence = [CCSequence actions:actionJump1,actionJump2,actionJump3,actionJump4,nil];
            [birdjump2 runAction:actionSequence];
            
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"7_1.mp3" loop:NO];
            break;
        }
        default:
            break;
    }
    
    bgnum++;

}

- (void) dealloc
{
    [background release];
    background = nil;
    
    [dogrun release];
    dogrun = nil;
    
    [birdjump1 release];
    birdjump1 = nil;
     
    [birdjump2 release];
    birdjump2 = nil;
    
	[super dealloc];
}

@end
