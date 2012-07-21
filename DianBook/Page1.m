//
//  Page1.m
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import "Page1.h"

@class Page1;
@class Page2;

@implementation Page1

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	Page1 *layer = [Page1 node];
	[scene addChild: layer];
	return scene;
}

//重写须修改scene
//场景切换函数：下一页
-(void) nextPage
{
	CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page2 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}
//场景切换函数：上一页
-(void) prevPage
{
	//CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page1 scene] backwards:YES];
    //[[CCDirector sharedDirector] replaceScene: transitionScene];
}

- (id) init {
    if(self = [super init]) {
        CCSprite *background;
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background = [CCSprite spriteWithFile:@"bg1.jpg"];
        background.position = ccp(512,384);
        background.scale = 1;
        //设置z为-1让各种按钮显示出来
        //z是节点显示的层次
        [self addChild:background z:-1];
            
        //恢复颜色设置
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
        
        //在后面添加各种元素
    }
    return self;
}
@end
