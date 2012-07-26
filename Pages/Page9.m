//
//  Page9.m
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import "Page9.h"
@class Page8;
@class Page10;

@implementation Page9

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	Page9 *layer = [Page9 node];
	[scene addChild: layer];
	return scene;
}

//重写须修改scene
//场景切换函数：下一页
-(void) nextPage:(int)thisPageCount{
    CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page10 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}
//场景切换函数：上一页
-(void) prevPage:(int)thisPageCount{
	CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page8 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}

-(void)playmusic:(NSString*)filename{
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:filename loop:NO];
}

- (id) init {
    if(self = [super init]) {
        NSLog(@"---------------init9");
        
        CGSize size = [[CCDirector sharedDirector] winSize]; 
        
        CCSprite *background;
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background = [CCSprite spriteWithFile:@"bg9_1.png"];
        background.position = ccp(512,384);
        background.scale = 1;
        [self addChild:background z:-1];       
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"1.mp3" loop:NO];//2
        [self performSelector:@selector(playmusic:) withObject:@"des2.mp3" afterDelay:3];//6
        [self performSelector:@selector(playmusic:) withObject:@"3.mp3" afterDelay:10];  // 4     
        [self performSelector:@selector(playmusic:) withObject:@"4.mp3" afterDelay:15];  //  6    
        [self performSelector:@selector(playmusic:) withObject:@"5_1.mp3" afterDelay:22];//2
        [self performSelector:@selector(playmusic:) withObject:@"5_2.mp3" afterDelay:25];// 3
        [self performSelector:@selector(playmusic:) withObject:@"6_2.mp3" afterDelay:28];//1
        [self performSelector:@selector(playmusic:) withObject:@"6_1.mp3" afterDelay:31];// 1       
        [self performSelector:@selector(playmusic:) withObject:@"7_1.mp3" afterDelay:34];//2
        [self performSelector:@selector(playmusic:) withObject:@"8_1.mp3" afterDelay:36];//7         
}
    return self;
}

- (void) dealloc
{
	[super dealloc];
}

@end
