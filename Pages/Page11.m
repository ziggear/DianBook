//
//  Page11.m
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import "Page11.h"


@implementation Page11

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	Page11 *layer = [Page11 node];
	[scene addChild: layer];
	return scene;
}

//重写须修改scene
//场景切换函数：下一页
-(void) nextPage:(int)thisPageCount{
//    CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page12 scene] backwards:YES];
//    [[CCDirector sharedDirector] replaceScene: transitionScene];
}
//场景切换函数：上一页
-(void) prevPage:(int)thisPageCount{
    NSLog(@"prevPage11");	
	CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page10 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}

- (id) init {
    if(self = [super init]) {
        NSLog(@"---------------init11");
        
        CGSize size = [[CCDirector sharedDirector] winSize]; 
        
        CCSprite *background;
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background = [CCSprite spriteWithFile:@"bg4_1.png"];
        background.position = ccp(512,384);
        background.scale = 1;
        [self addChild:background z:-1];       
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"4.mp3" loop:NO];
        
        CCSprite *background2;
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background2 = [CCSprite spriteWithFile:@"bg4_2.png"];
        background2.position = ccp(512,384);
        background2.scale = 1;
        background2.opacity=0;
        [self addChild:background z:-1];       
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];        
        
        //点击大树发生响应
        CCMenuItemSprite* wordm = [CCMenuItemSprite itemWithNormalSprite:background selectedSprite:nil block:^(id sender) {
            //朗读“小鸟” 发出咕咕鸟叫
            //画面渐渐切换 bg4_2 
            
        }]; 
        
        CCMenu* menu = [CCMenu menuWithItems:wordm,nil];
        [menu setPosition:ccp(0,0)];      
        wordm.position = ccp(size.width/2,size.height/2);  
        [self addChild:menu];
        
    }
    return self;
}

- (void) dealloc
{
	[super dealloc];
}

@end
