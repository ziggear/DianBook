//
//  Page1.m
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import "Page1.h"


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
        thisPageCount = 1;
        
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
        
        background = [CCSprite spriteWithFile:@"bg1.jpg"];
        background.position = ccp(512,384);
        background.opacity = 0;
        //设置z为-1让各种按钮显示出来
        //z是节点显示的层次
        [self addChild:background z:-5];
        
        //在后面添加各种元素
         alpha = [CCSprite node];
    }
    return self;
}

- (void) SpriteMove {
    background.opacity = 255;
}

- (void) dealloc {
    [background release];
    [alpha release];
    [super dealloc];
}

@end
