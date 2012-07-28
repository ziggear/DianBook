//
//  Page2.m
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import "Page2.h"
#import "Animate.h"


@implementation Page2

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	Page2 *layer = [Page2 node];
	[scene addChild: layer];
   	return scene;
}

//重写须修改scene
//场景切换函数：下一页
-(void) nextPage
{   
	CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page3 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}
//场景切换函数：上一页
-(void) prevPage{     	
    CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page1 scene] backwards:YES];
    [[CCDirector sharedDirector] replaceScene: transitionScene];
}
- (void) onEnterTransitionDidFinish {
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"des2.mp3" loop:NO];
    
    CCSprite *words = [CCSprite spriteWithFile:@"2_1_1.png"];
    CGSize size = [[CCDirector sharedDirector] winSize]; 
    words.position = ccp(size.width/2,size.height/2);      
    [self addChild:words z:1]; 
    
    //左上角风
    wind = [CCSprite spriteWithFile:@"2_2_1.png"]; 
    wind.position = ccp(size.width*0.23,size.height*0.73);
    wind.opacity=0;//半透明[0~255]
    wind.tag =21;
    [self addChild:wind z:1];
    [movableSprites2 addObject:wind ];
    
    //右上角鸟窝
    nest = [CCSprite spriteWithFile:@"2_3_1.png"];
    nest.position = ccp(size.width*0.66, size.height*0.9);        
    nest.opacity=0;//半透明[0~255]
    nest.tag=22;
    [self addChild:nest z:1];
    [movableSprites2 addObject:nest];
    
    //左下角小狗
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"2_4_00.plist"];
    dog = [CCSprite spriteWithSpriteFrameName:@"2_4_001.png"]; 
    dog.position = ccp(size.width*0.28, size.height*0.185);
    dog.opacity = 0;  
    dog.tag=23;
    [self addChild:dog z:1];
    [movableSprites2 addObject:dog] ;
    
    //右下角小狗被砸
    dogsmashed = [CCSprite spriteWithFile:@"2_5_1.png"];
    dogsmashed.position = ccp(size.width*0.77, size.height*0.26);
    dogsmashed.opacity=0;//半透明[0~255]        
    dogsmashed.tag =24;
    [self addChild:dogsmashed z:1];
    [movableSprites2 addObject:dogsmashed];
}

- (id) init {
    if(self = [super init]) {
         NSLog(@"---------------init2");
       
        //预载音效
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"gale.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"nest.mp3"];
        
        
        movableSprites2 = [[NSMutableArray alloc] init];       
        CGSize size = [[CCDirector sharedDirector] winSize]; 
        
        //背景
        CCSprite *background;
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
        background = [CCSprite spriteWithFile:@"bg2.png"];        
        background.position = ccp(size.width/2,size.height/2);
        background.scale = 1;
        //设置z为-1让各种按钮显示出来
        //z是节点显示的层次,z越大越接近屏幕
        [self addChild:background z:-1];
        
         //恢复颜色设置
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
    }
    return self;
}


-(void)selectSpriteOnPage:(CGPoint)touchLocation{
    
    CCSprite * newSprite = nil;
    CGSize size = [[CCDirector sharedDirector] winSize];
    //循环到点击的那个精灵，返回给newSprit
    for (CCSprite *sprite in movableSprites2) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) { 
            newSprite = sprite;
            break;
        }
    }
    
    if (newSprite != selSprite2) {
        [selSprite2 stopAllActions];          
        selSprite2 = newSprite;
    }
    
    if(selSprite2.tag == 21){
        NSLog(@"windm");
        //“呼呼”的风声,朗读大风(gale.mp3) 
        
        //风吹到树叶动画                        
        wind.opacity = 225;
        //   wind.zOrder = -1;
        //朗读大风
        [[SimpleAudioEngine sharedEngine] playEffect:@"gale.mp3"];        
    }
    
    if(selSprite2.tag == 22){
        NSLog(@"nestm");
        
        //发出“咕咕”的小鸟叫声        
        nest.opacity = 255;
        id actionJump2 = [CCJumpBy actionWithDuration:2 position:ccp(0, -size.height*0.23) height:5 jumps:1];
        CCFadeOut* fade =[CCFadeOut actionWithDuration:0.1f];
        id actionJump3 = [CCJumpBy actionWithDuration:0.1 position:ccp(0, size.height*0.23) height:5 jumps:1];          
        id actionSequence = [CCSequence actions:actionJump2,fade,actionJump3, nil]; 
        [nest runAction:actionSequence]; 
        
        //朗读鸟窝 
        [[SimpleAudioEngine sharedEngine] playEffect:@"nest.mp3"];        
    }
   
    if(selSprite2.tag == 23){
        //NSLog(@"dogm");
        //发出“汪汪”的狗叫声
        //播放小狗摇尾巴动画
        dog.opacity=255;
        Animate *anim = [[Animate alloc] init];
        NSArray *arr = [anim initWithMySpriteFrameName:2 anim:4 count:2];
        CCAnimation *animation = [CCAnimation animationWithSpriteFrames:arr]; 
        [animation setDelayPerUnit:0.07] ;//控制delay控制播放速度
        animation.loops = 5;            //控制循环次数
        CCAnimate *animate = [CCAnimate actionWithAnimation:animation]; 
        [dog runAction:animate];
        
        //朗读小狗          
    }

    if(selSprite2.tag == 24){
        //发出碰撞声
        //播过小狗被砸到动画
        //NSLog(@"dogsmashedm");
       dogsmashed.opacity = 255;
        
        //朗读哎哟 

        //翻页声
        thisPageCount++;
        CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page3 scene] backwards:YES];
        [[CCDirector sharedDirector] replaceScene: transitionScene];
    }
}



- (void) dealloc
{
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"gale.mp3"];
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"nest.mp3"];
    
    [wind release];
     wind = nil;
    
    [nest release];
    nest = nil;
    
    [dog release];
     dog = nil;
    
    [dogsmashed release];
    dogsmashed = nil;
    
    [selSprite2 release];
    selSprite2 = nil;
    
    [movableSprites2 release];
    selSprite2 = nil;
    
    [super dealloc];
}

@end
