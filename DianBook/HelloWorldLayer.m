//
//  HelloWorldLayer.m
//  DianBook
//
//  Created by 1 1 on 7/19/12.
//  Copyright 111 2012. All rights reserved.
//
//
//
//  ！！！！注意：
//  不直接用HelloWorldLayer 
//  仅供Pages目录下的 Cover 和 Page 类继承

// Import the interfaces
#import "HelloWorldLayer.h"
#import "AppDelegate.h"

#import "PainterViewController.h"
#import "CoverflowViewController.h"

//导入所有页面类
//在每个Page里面用@class Page1;来说明
#import "Page1.h"
#import "Page2.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	if((self = [super init])) {        
        //获取窗口大小
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        //初始化按钮数组
        //左翻页tag = 1 ，右翻页tag = 2 。在 selectSpriteForTouch 函数中判断用
        movableSprites = [[NSMutableArray alloc] init];

        CCSprite *buttonLeft = [CCSprite spriteWithFile:@"bt01.png"];
        buttonLeft.position = ccp(winSize.width * 0.1, winSize.height * 0.9);
        buttonLeft.tag = 1;
        [self addChild:buttonLeft];
        [movableSprites addObject:buttonLeft];
        
        CCSprite *buttonRight = [CCSprite spriteWithFile:@"bt02.png"];
        buttonRight.position = ccp(winSize.width * 0.9, winSize.height * 0.9);
        buttonRight.tag = 2;
        [self addChild:buttonRight];
        [movableSprites addObject:buttonRight];
        
        CCSprite *coverFLow = [CCSprite spriteWithFile:@"coverflow.png"];
        coverFLow.position = ccp(winSize.width * 0.5, winSize.height * 0.9);
        coverFLow.tag = 3;
        [self addChild:coverFLow];
        [movableSprites addObject:coverFLow];
        
        CCSprite *arcade = [CCSprite spriteWithFile:@"arcade.png"];
        arcade.position = ccp(winSize.width * 0.1, winSize.height * 0.1);
        arcade.tag = 4;
        [self addChild:arcade];
        [movableSprites addObject:arcade];
        
        //接受点击
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
        //设置初始页码为零
        thisPageCount = 0;
    }
    return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    //记得在此释放资源
	//先 release方法，再赋值 nil
    
	// don't forget to call "super dealloc"
    [selSprite release];
    selSprite = nil;
    
    [movableSprites release];
    movableSprites = nil;
	[super dealloc];
}

#pragma mark Scenes
//重写须修改scene
//场景切换函数：下一页
-(void) nextPage
{
    //此处等待重写
    //每个Page的下一个Page
	//CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page1 scene] backwards:YES];
    //[[CCDirector sharedDirector] replaceScene: transitionScene];
}
//场景切换函数：上一页
-(void) prevPage
{
    //此处等待重写
    //每个Page的上一个Page
	//CCTransitionPageTurn *transitionScene=[CCTransitionPageTurn transitionWithDuration:0.5 scene:[Page1 scene] backwards:YES];
    //[[CCDirector sharedDirector] replaceScene: transitionScene];
}

- (void) enterCoverFlow
{
    //载入画图游戏
//    PainterViewController *patinter;
//    patinter = [[PainterViewController alloc] initWithNibName:@"PainterViewController" bundle:nil];
//    [[[[CCDirector sharedDirector] view] window] addSubview:patinter.view];

    CoverflowViewController *cf;
    cf = [[CoverflowViewController alloc] initWithNibName:@"CoverflowViewController" bundle:nil];
    [cf setImageNumber:10 currentPage:1 imageName:@"cover_1.jpg"];
    [[[CCDirector sharedDirector] view] addSubview:cf.view];
    
}

- (void) enterGame 
{
//载入画图游戏
    PainterViewController *patinter;
    patinter = [[PainterViewController alloc] initWithNibName:@"PainterViewController" bundle:nil];
    [[[[CCDirector sharedDirector] view] window] addSubview:patinter.view];    
}

#pragma mark Touch matics
//精灵的点击
- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    CCSprite * newSprite = nil;
    //循环到点击的那个精灵，返回给newSprite
    for (CCSprite *sprite in movableSprites) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {            
            newSprite = sprite;
            break;
        }
    }
    
    if (newSprite != selSprite) {
        [selSprite stopAllActions];          
        selSprite = newSprite;
    }
    
    if(selSprite.tag == 1){
        NSLog(@"touched left");
        [self prevPage];
    }
    
    if(selSprite.tag == 2){
        NSLog(@"touched right");
        [self nextPage];
    }
    
    if(selSprite.tag == 3){
        NSLog(@"touched middle");
        [self enterCoverFlow];
    }
    
    if(selSprite.tag == 4){
        NSLog(@"touched game");
        [self enterGame];
    }
    
}
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];   
    //[self touchForPages:touchLocation];
    return TRUE;    
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
