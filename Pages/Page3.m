//
//  Page3.m
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import "Page3.h"

@implementation Page3

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	Page3 *layer = [Page3 node];
	[scene addChild: layer];
	return scene;
}

//重写须修改scene
//场景切换函数：下一页
-(void) nextPage:(int)thisPageCount{
    //debuglog(@"nextPage^^^^^^^^^^^^^^^^^3");
	CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page4 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}
//场景切换函数：上一页
-(void) prevPage:(int)thisPageCount
{
    
    //debuglog(@"prevPage^^^^^^^^^^^^^^^^^3");	
	CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page2 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}

- (id) init {
    if(self = [super init]) {
        //debuglog(@"---------------init3");
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"3.mp3"];
        [[SimpleAudioEngine sharedEngine] playEffect:@"3.mp3"];
        
        CCSprite *background;
        background = [CCSprite spriteWithFile:@"bg3.png"];
        background.position = ccp(512,384);
        background.scale = 1;
        //设置z为-1让各种按钮显示出来
        //z是节点显示的层次
        [self addChild:background z:0];
        
                
        //文字
        CCSprite *words = [CCSprite spriteWithFile:@"word3_1.png"];   
        words.opacity=0;
        words.position=ccp(512,384);
        [self addChild:words z:1];
        CCFadeTo* fadeto =[CCFadeTo actionWithDuration:2.5f opacity:255];      
        [words runAction:fadeto]; 
        
//        //点击画面，播放“呜呜”的声音，小狗头上起了个红包，红包渐渐出现
//        CCMenuItemSprite* wordm = [CCMenuItemSprite itemWithNormalSprite:words selectedSprite:nil block:^(id sender) {

//        }]; 
//        
//        CCMenu* menu = [CCMenu menuWithItems:wordm,nil];
//        [menu setPosition:ccp(0,0)];       
//        wordm.position = ccp(512,384);
//        [self addChild:menu];
    
    }
    return self;
}

- (void) dealloc {
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"3.mp3"];
    [super dealloc];
}

@end
