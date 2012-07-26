//
//  Page6.m
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import "Page6.h"


@implementation Page6
@synthesize arr;
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	Page6 *layer = [Page6 node];
	[scene addChild: layer];
	return scene;
}

//重写须修改scene
//场景切换函数：下一页
-(void) nextPage:(int)thisPageCount{
    
    NSLog(@"nextPage^^^^^^^^^^^^^^^^^6");
    CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page7 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}
//场景切换函数：上一页
-(void) prevPage:(int)thisPageCount{
    NSLog(@"prevPage^^^^^^^^^^^^^^^^^6");	
	CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page5 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}


- (void) onEnterTransitionDidFinish {
    debuglog(@"onEnterTransitionDidFinish");
    CGSize size = [[CCDirector sharedDirector] winSize]; 
    
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
    background2 = [CCSprite spriteWithFile:@"bg6_2.png"];
    background2.position = ccp(512,384);
    background2.scale = 1;
    background2.opacity=0;
    [self addChild:background2 z:1];       
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
    
    butterfly = [CCSprite spriteWithFile:@"butterfly.png"]; 
    butterfly.position = ccp(0, size.height*0.58);
    butterfly.opacity = 0; 
    [self addChild:butterfly z:2];
    
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
    background3 = [CCSprite spriteWithFile:@"bg6_3.png"];
    background3.position = ccp(512,384);
    background3.scale = 1;
    background3.opacity=0;
    [self addChild:background3 z:3];       
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
    
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
    background4 = [CCSprite spriteWithFile:@"bg6_4.png"];
    background4.position = ccp(512,384);
    background4.scale = 1;
    background4.opacity=0;
    [self addChild:background4 z:4];       
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];

}


- (id) init {
    if(self = [super init]) {
        debuglog(@"---------------init6");
        
        bgnum = 1;
      
        
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background1 = [CCSprite spriteWithFile:@"bg6_1.png"];
        background1.position = ccp(512,384);
        background1.scale = 1;
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
            //图bg2 播放“6_2.MP3，蝴蝶位移动画
            debuglog(@"bg61"); 
            background2.opacity = 255;
            butterfly.opacity = 255; 
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"6_2.mp3" loop:NO]; 
            CGSize size = [[CCDirector sharedDirector] winSize]; 
            ccBezierConfig bezier; // 创建贝塞尔曲线             
            bezier.controlPoint_1 = ccp(0, size.height*0.75); // 起始点  
            bezier.controlPoint_2 = ccp(size.width*0.25, size.height*0.9); //控制点  
            bezier.endPosition = ccp(512, size.height*0.75); // 结束位置     
            CCBezierTo *actionMove = [CCBezierTo actionWithDuration:2.5 bezier:bezier];   
            //创建精灵旋转的动作  
            CCRotateTo *actionRotate =[CCRotateTo actionWithDuration:2.5 angle:45];  
            //将两个动作封装成一个同时播放进行的动作  
            id  action = [CCSpawn actions:actionMove, actionRotate, nil];  
            
            ccBezierConfig bezier2; // 创建贝塞尔曲线             
            bezier2.controlPoint_1 = ccp(512, size.height*0.75); // 起始点  
            bezier2.controlPoint_2 = ccp(size.width*0.75, size.height*0.5); //控制点  
            bezier2.endPosition = ccp(1200,518); // 结束位置     
            CCBezierTo *actionMove2 = [CCBezierTo actionWithDuration:1.5 bezier:bezier2];   
            //创建精灵旋转的动作  
            CCRotateTo *actionRotate2 =[CCRotateTo actionWithDuration:1.5 angle:45]; 
            id action2 = [CCSpawn actions:actionMove2, actionRotate2, nil];              
            
            id actionSequence = [CCSequence actions:action,action2,nil];             
            [butterfly runAction:actionSequence];
            break;
        }
        case 2:
        {
            //换图bg3 播放鸟叫 和狗叫。朗读 唱歌
            debuglog(@"bg62");
            background3.opacity = 255;
            
            break;
        }
        case 3:
        {
            //换图bg4，播放6_1.MP3
            debuglog(@"bg63");
            background4.opacity = 255;
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"6_1.mp3" loop:NO];
            break;
        }
        default:
            break;
    }
    
    bgnum++;
}


-(float)strack:(float) x{
    return 200*sin(3.1415926*x/512); 
}
- (void) dealloc
{
    [background1 release];
    background1 = nil;
    
    [background2 release];
    background2 = nil;
    
    [background3 release];
    background3 = nil;
    
    [background4 release];
    background4 = nil;
    
    [butterfly release];
    butterfly = nil;
    
	[super dealloc];
}

@end
