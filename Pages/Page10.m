//
//  Page10.m
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import "Page10.h"

@implementation Page10

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	Page10 *layer = [Page10 node];
	[scene addChild: layer];
	return scene;
}

//重写须修改scene
//场景切换函数：下一页
-(void) nextPage:(int)thisPageCount{
    NSLog(@"nextPage10");
    CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page11  scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}
//场景切换函数：上一页
-(void) prevPage:(int)thisPageCount{
    NSLog(@"prevPage10");	
	CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page9 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}

- (void) onEnterTransitionDidFinish {
    debuglog(@"onEnterTransitionDidFinish");
    CGSize size = [[CCDirector sharedDirector] winSize]; 
    
    //文字“小兔子”
    
    //文字“红气球”
    
    //右边兔子
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"8_1_00.plist"];
    rabbitR = [CCSprite spriteWithSpriteFrameName:@"rabbitr.png"]; 
    rabbitR.position = ccp(size.width/2-60, size.height-125);
    //rabbitR.opacity = 0;
    rabbitR.tag = 101;
    [self addChild:rabbitR z:1];
    
}


- (id) init {
    if(self = [super init]) {
        NSLog(@"---------------init10");
        
        CGSize size = [[CCDirector sharedDirector] winSize];         
        bgnum = 1;
        
        //播放气球移动动画
        balloon = [CCSprite spriteWithSpriteFrameName:@"balloon.png"];        
        balloon.position = ccp(-100, size.height-125);
        balloon.opacity = 0;
        [self addChild:balloon z:1];        
        id actionMove = [CCMoveTo actionWithDuration: 3  position: ccp(138.75, size.height-125)];
        [balloon runAction:actionMove];
        
        //渐渐显示bg1
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background = [CCSprite spriteWithFile:@"bg10_1.png"];
        background.position = ccp(512,384);
        background.opacity = 0;
        CCFadeTo* fadeto =[CCFadeTo actionWithDuration:3 opacity:255]; 
        [self addChild:background z:-1];  
        [background runAction:fadeto];
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
        
        //朗读“小兔子看见一个红气球”
        //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"1.mp3" loop:NO];//2        
    }
    return self;
}

-(void)selectSpriteOnPage:(CGPoint)touchLocation{
    debuglog(@"touch2");
    CGSize size = [[CCDirector sharedDirector] winSize]; 
    
    //渐渐显示bg2 播放“它高兴地和红气球玩儿了起来”
    if(bgnum == 1){
        background.opacity=0;                    
        UIImage * image=[UIImage imageNamed:@"bg10_2.png"];  
        CCTexture2D  * newTexture=[[CCTextureCache sharedTextureCache]  addCGImage:image.CGImage forKey:nil];                  
        CCFadeTo* fadeto =[CCFadeTo actionWithDuration:1.5f opacity:255]; 
        [background  setTexture:newTexture]; 
        [background runAction:fadeto]; 
    }

    
    bgnum++;
}


- (void) dealloc
{       
    [background release];
    background = nil;
    
    [rabbitR release];
    rabbitR = nil;
    
    [balloon release];
    balloon = nil;
    
    [rabbitW release];
    rabbitW = nil;
    
    [balloonW release];
    balloonW = nil;
    
    [selSprite2 release];
    selSprite2 = nil;
    
    [movableSprites2 release];
    movableSprites2 = nil;
    
	[super dealloc];
}

@end
