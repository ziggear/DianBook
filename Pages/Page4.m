//
//  Page5.m
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import "Page4.h"
@class Page3;
@class Page5;

@implementation Page4

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	Page4 *layer = [Page4 node];
	[scene addChild: layer];
	return scene;
}

//重写须修改scene
//场景切换函数：下一页
-(void) nextPage{    
    //debuglog(@"nextPage^^^^^^^^^^^^^^^^^4");
	CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page5 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}
//场景切换函数：上一页
-(void) prevPage{
    //debuglog(@"prevPage^^^^^^^^^^^^^^^^^4");	
	CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page3 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}

- (void) onEnterTransitionDidFinish {
     //debuglog(@"onEnterTransitionDidFinish");
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"4.mp3" loop:NO];
}

- (id) init {
    if(self = [super init]) {
        //debuglog(@"---------------init4");
        movableSprites4 = [[NSMutableArray alloc] init];    

        background = [CCSprite spriteWithFile:@"bg4_1.png"];
        background.position = ccp(512,384);
        background.scale = 1;
        background.tag = 41;
        [self addChild:background z:-1];       
        
        [movableSprites4 addObject:background];
        bgnum = 1;
    }
    return self;
}

-(void)selectSpriteOnPage:(CGPoint)touchLocation{
    debuglog(@"touch2");
    CCSprite * newSprite = nil;
    //CGSize size = [[CCDirector sharedDirector] winSize];
    //循环到点击的那个精灵，返回给newSprit
    for (CCSprite *sprite in movableSprites4) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) { 
            newSprite = sprite;
            break;
        }
    }
    
    if (newSprite != selSprite4) {
        [selSprite4 stopAllActions];          
        selSprite4 = newSprite;
    }
    
    if(selSprite4.tag == 41){
        NSLog(@"num:%d",bgnum);
        switch (bgnum) {
            case 1:
                debuglog(@"bgnum1");
                //点击画面，朗读“小鸟” 发出咕咕鸟叫
                bgnum++;                  
                break;
            case 2:
                debuglog(@"bgnum2");
                //声音播放完后， 画面渐渐切换 bg4_2
                background.opacity=0;                    
                UIImage * image=[UIImage imageNamed:@"bg4_2.png"];  
                CCTexture2D  * newTexture=[[CCTextureCache sharedTextureCache]  addCGImage:image.CGImage forKey:nil];                  
                CCFadeTo* fadeto =[CCFadeTo actionWithDuration:1.5f opacity:255]; 
                [background  setTexture:newTexture]; 
                [background runAction:fadeto]; 
                bgnum++;
                break; 
            case 3:
                debuglog(@"bgnum3");
                //声音播放完后， 画面渐渐切换 bg4_2
                background.opacity=0;                    
                image=[UIImage imageNamed:@"bg4_3.png"];  
                newTexture=[[CCTextureCache sharedTextureCache]  addCGImage:image.CGImage forKey:nil];                  
                fadeto =[CCFadeTo actionWithDuration:1.5f opacity:255]; 
                [background  setTexture:newTexture]; 
                [background runAction:fadeto]; 
                break;  
            default:
                break;
        }  
    }


}



- (void) dealloc
{
    [selSprite4 release];
    selSprite4 = nil;
    
    [movableSprites4 release];
    movableSprites4 = nil;
    
    [background release];
    background = nil;
    
	[super dealloc];
}

@end
