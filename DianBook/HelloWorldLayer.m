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
        //设置接受点击
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
    [selSprite release];
    selSprite = nil;
    
    [movableSprites release];
    movableSprites = nil;
	[super dealloc];
}

#pragma mark Scenes

- (void) onEnterTransitionDidFinish {
    //获取窗口大小
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    //初始化按钮数组
    //左翻页tag = 1 ，右翻页tag = 2 。在 selectSpriteForTouch 函数中判断用
    movableSprites = [[NSMutableArray alloc] init];
    
    //左翻页
    ExtSprite *buttonLeft = [ExtSprite spriteWithFile:@"bt01.png"];
    buttonLeft.position = ccp(winSize.width * 0.1, winSize.height * 0.9);
    buttonLeft.tag = 1;
    [self addChild:buttonLeft];
    [movableSprites addObject:buttonLeft];
    //右翻页
    ExtSprite *buttonRight = [ExtSprite spriteWithFile:@"bt02.png"];
    buttonRight.position = ccp(winSize.width * 0.9, winSize.height * 0.9);
    buttonRight.tag = 2;
    [self addChild:buttonRight];
    [movableSprites addObject:buttonRight];
    //CoverFlow
    ExtSprite *coverFLow = [ExtSprite spriteWithFile:@"coverflow.png"];
    coverFLow.position = ccp(winSize.width * 0.5, winSize.height * 0.9);
    coverFLow.tag = 3;
    [self addChild:coverFLow];
    [movableSprites addObject:coverFLow];
    //画图游戏
    ExtSprite *arcade = [ExtSprite spriteWithFile:@"arcade.png"];
    arcade.position = ccp(winSize.width * 0.1, winSize.height * 0.1);
    arcade.tag = 4;
    [self addChild:arcade];
    [movableSprites addObject:arcade];
    
    [buttonLeft release];
    [buttonRight release];
    [coverFLow release];
    [arcade release];
    
    buttonLeft = nil;
    buttonRight = nil;
    coverFLow = nil;
    arcade = nil;
}

//重写须修改scene
//场景切换函数：下一页
-(void) nextPage
{
    //此处等待重写
    //每个Page的下一个Page
}
//场景切换函数：上一页
-(void) prevPage
{
    //此处等待重写
    //每个Page的上一个Page
}

- (void) enterCoverFlow
{
    //停止cocos2d的图像
    [[CCDirector sharedDirector] stopAnimation];
    //载入coverflow效果 
    CoverflowViewController *cf;
    cf = [[CoverflowViewController alloc] initWithNibName:@"CoverflowViewController" bundle:nil];
    [cf setImageNumber:10 currentPage:thisPageCount imageName:@"cover_0.jpg"];
    [[[CCDirector sharedDirector] view] addSubview:cf.view];
    
}

- (void) enterGame 
{
    //停止cocos2d的图像
    [[CCDirector sharedDirector] stopAnimation];
    //载入画图游戏
    PainterViewController *patinter;
    patinter = [[PainterViewController alloc] initWithNibName:@"PainterViewController" bundle:nil];
    [[[[CCDirector sharedDirector] view] window] addSubview:patinter.view];    
}

#pragma mark Touch matics

//精灵接受点击机制
- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    ExtSprite * newSprite = nil;
    //循环到点击的那个精灵，返回给newSprite
    for (ExtSprite *sprite in movableSprites) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {            
            newSprite = sprite;
            break;
        }
    }
    
    if (newSprite != selSprite) {
        [selSprite stopAllActions];          
        selSprite = newSprite;
    }
    //
    
    if(selSprite.tag == 1){

        debuglog(@"touched left");

        [self prevPage];
    }
    
    if(selSprite.tag == 2){
        debuglog(@"touched right");
        [self nextPage];
    }
    
    if(selSprite.tag == 3){
        debuglog(@"touched middle");
        [self enterCoverFlow];
    }
    
    if(selSprite.tag == 4){
        debuglog(@"touched game");
        [self enterGame];
    }
    
}

- (void) SpriteMove {
    //留给每页的精灵来重写
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {  
    debuglog(@"touch began");
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation]; 
    [self SpriteMove];
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
