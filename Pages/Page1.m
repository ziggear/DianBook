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
-(void) nextPage:(int)thisPageCount{
     NSLog(@"nextPage^^^^^^^^^^^^^^^^^1");
    CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page2 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}
//场景切换函数：上一页
-(void) prevPage:(int)thisPageCount{
     NSLog(@"prevPage^^^^^^^^^^^^^^^^^1");  
	//CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page1 scene] backwards:YES];
    //[[CCDirector sharedDirector] replaceScene: transitionScene];
}

- (id) init {
    if(self = [super init]) {
//    if(self = [super onEnterTransitionDidFinish]){
        NSLog(@"---------------init1");
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"1.mp3" loop:NO];
        
        movableSprites1 = [[NSMutableArray alloc] init];
        CGSize size = [[CCDirector sharedDirector] winSize];         
        CCSprite *background;
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background = [CCSprite spriteWithFile:@"bg1.jpg"];        
        background.position = ccp(size.width/2,size.height/2);
        background.scale = 1;
        //设置z为-1让各种按钮显示出来
        //z是节点显示的层次,z越大越接近屏幕
        [self addChild:background z:-1]; 
        //[background release];
               
        //恢复颜色设置
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
                
        //文字
        words = [CCSprite spriteWithFile:@"1_1_1.png"];        
        words.position = ccp(718,size.height/2);
        [self addChild:words];
                    
        //大树,只是一个区域
        CCSprite *tree = [CCSprite node];
        tree.textureRect = CGRectMake(0, 0, size.width*0.67, size.height*0.88);
        tree.opacity=0;//半透明[0~255] 
        tree.tag = 11;
        tree.position=ccp(size.width/2,size.height/2);
        [self addChild:tree];
        [movableSprites1 addObject:tree];
        [tree release];
    }
    return self;
}


-(void)selectSpriteOnPage:(CGPoint)touchLocation{
    CCSprite * newSprite = nil;
    //循环到点击的那个精灵，返回给newSprit
    for (CCSprite *sprite in movableSprites1) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) { 
            newSprite = sprite;
            break;
        }
    }
    
    if (newSprite != selSprite1) {
        [selSprite1 stopAllActions];          
        selSprite1 = newSprite;
    }
    
    if(selSprite1.tag == 11){
        //“文字.png”渐渐出现渐渐消失
        words.opacity=0;
        CCFadeTo* fadeto =[CCFadeTo actionWithDuration:1.5f opacity:255];      
        CCFadeOut* fade =[CCFadeOut actionWithDuration:1.5f];
        id actionSequence = [CCSequence actions:fadeto,fade,nil]; 
        [words runAction:actionSequence];   
        //发出树叶的“沙沙”声
        
        //树叶抖动动画 
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"tree.mp3" loop:NO];      
        
    }
}

- (void) dealloc
{
    [selSprite1 release];
    selSprite = nil;
    
    [words release];  
    words = nil;
    
    [movableSprites1 release];  
    movableSprites1 = nil;
    
	[super dealloc];
}


@end