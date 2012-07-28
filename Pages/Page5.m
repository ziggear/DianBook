//
//  Page5.m
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import "Page5.h"


@implementation Page5

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	Page5 *layer = [Page5 node];
	[scene addChild: layer];
	return scene;
}

//重写须修改scene
//场景切换函数：下一页
-(void) nextPage{
    //NSLog(@"nextPage^^^^^^^^^^^^^^^^^5");
    CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page6 scene] backwards:YES];
        [[CCDirector sharedDirector] replaceScene: transitionScene];
}
//场景切换函数：上一页
-(void) prevPage{
    //NSLog(@"prevPage^^^^^^^^^^^^^^^^^5");	
	CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page4 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}


- (void) onEnterTransitionDidFinish {
    //debuglog(@"onEnterTransitionDidFinish");
    CGSize size = [[CCDirector sharedDirector] winSize]; 
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"5_1_00.plist"];
    birdeat = [CCSprite spriteWithSpriteFrameName:@"5_1_001.png"]; 
    birdeat.position = ccp(size.width*0.535, size.height*0.58);
    birdeat.opacity = 0; 
    [self addChild:birdeat z:1];
    
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
    background2 = [CCSprite spriteWithFile:@"bg5_2.png"];
    background2.position = ccp(512,384);
    background2.opacity=0;
    [self addChild:background2 z:2];       
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"5_2_00.plist"];
    birddrink = [CCSprite spriteWithSpriteFrameName:@"5_2_001.png"]; 
    birddrink.position = ccp(size.width*0.56, size.height*0.53);
    birddrink.opacity = 0;  
    [self addChild:birddrink z:3];
    
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
    background3 = [CCSprite spriteWithFile:@"bg5_3.png"];
    background3.position = ccp(512,384);
    background3.opacity=0;
    [self addChild:background3 z:4];       
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"5_3_00.plist"];
    birdanddog = [CCSprite spriteWithSpriteFrameName:@"5_3_001.png"]; 
    birdanddog.position = ccp(512, 384);
    birdanddog.opacity = 0;  
    [self addChild:birdanddog z:5];
}


- (id) init {
    if(self = [super init]) {
        NSLog(@"---------------init5");
        
        bgnum = 1;
        
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background1 = [CCSprite spriteWithFile:@"bg5_1.png"];
        background1.position = ccp(512,384);
        [self addChild:background1 z:-1];       
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
}
    return self;
}

-(void)selectSpriteOnPage:(CGPoint)touchLocation{
    debuglog(@"touch2");
    //觉得动画比较生硬
    switch (bgnum) {
        case 1:
        {
            //点击画面， 播放小鸟啄米动画
            debuglog(@"bg51");
            birdeat.opacity = 255;        
            Animate *anim = [[Animate alloc] init];
            NSArray *arr = [anim initWithMySpriteFrameName:5 anim:1 count:2];
            CCAnimation *animation = [CCAnimation animationWithSpriteFrames:arr]; 
            [animation setDelayPerUnit:0.4] ;//控制delay控制播放速度
            animation.loops = 3;            //控制循环次数
            CCAnimate *animate = [CCAnimate actionWithAnimation:animation]; 
//            CCFadeTo* fadeto =[CCFadeTo actionWithDuration:1.5f opacity:0]; 
//            id actionSpan = [CCSpawn actions:fadeto, actionJump2, nil];
//                   id actionSpan2 = [CCSpawn actions:actionRotate3, actionJump3, nil];        
//                    id actionSequence = [CCSequence actions:actionSpan,actionSpan2,nil]; 
//                    CCAction *action = [CCRepeatForever actionWithAction:actionSequence]; 
            [birdeat runAction:animate];
            break;
        }
        case 2:
        {
            //画面渐渐切换 bg2播放小鸡喝水动画。播放“5_1.MP3”
            debuglog(@"bg52");
            //CCFadeTo* fadeto =[CCFadeTo actionWithDuration:1.5f opacity:255]; 
            //[background2 runAction:fadeto];
            background2.opacity = 255;
            birddrink.opacity = 255;            
            Animate *anim = [[Animate alloc] init];
            NSArray *arr = [anim initWithMySpriteFrameName:5 anim:2 count:2];
            CCAnimation *animation = [CCAnimation animationWithSpriteFrames:arr]; 
            [animation setDelayPerUnit:0.4] ;//控制delay控制播放速度
            animation.loops = 3;            //控制循环次数
            CCAnimate *animate = [CCAnimate actionWithAnimation:animation]; 
            [birddrink runAction:animate];
            break;
        }
        case 3:
        {
            //切换bg3播放5_2.MP3
            debuglog(@"bg53");
            //CCFadeTo* fadeto =[CCFadeTo actionWithDuration:1.5f opacity:255]; 
            //[background3 runAction:fadeto];
            background3.opacity = 255;
            //birdanddog.opacity = 255;
//            Animate *anim = [[Animate alloc] init];
//            NSArray *arr = [anim initWithMySpriteFrameName:5 anim:3 count:4];
//            CCAnimation *animation = [CCAnimation animationWithSpriteFrames:arr]; 
//            [animation setDelayPerUnit:0.4] ;//控制delay控制播放速度
//            animation.loops = 3;            //控制循环次数
//            CCAnimate *animate = [CCAnimate actionWithAnimation:animation]; 
//            [birdanddog runAction:animate];
            break;
        }
        default:
            break;
    }
    
     bgnum++;
}




- (void) dealloc
{
    [background1 release];
    background1 = nil;
    
    [background2 release];
    background2 = nil;
    
    [background3 release];
    background3 = nil;
    
    [birdeat release];
    birdeat = nil;
    
    [birddrink release];
    birddrink = nil;
    
    [birdanddog release];
    birdanddog = nil;
    
	[super dealloc];
}

@end
