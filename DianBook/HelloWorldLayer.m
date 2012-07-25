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

//导入所有页面类
//在每个Page里面用@class Page1;来说明


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
- (void) onEnterTransitionDidFinish {
    
}

-(id) init
{
	if((self = [super init])) {        
        //获取窗口大小
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        //初始化按钮数组
        //左翻页tag = 1 ，右翻页tag = 2 。在 selectSpriteForTouch 函数中判断用
        movableSprites = [[NSMutableArray alloc] init];
        
        //左翻页
        CCSprite *buttonLeft = [CCSprite spriteWithFile:@"page_left.png"];
        buttonLeft.position = ccp(winSize.width * 0.05, winSize.height * 0.95);
        buttonLeft.tag = 1;
        [self addChild:buttonLeft z:10];
        [movableSprites addObject:buttonLeft ];
        //右翻页
        CCSprite *buttonRight = [CCSprite spriteWithFile:@"page_right.png"];
        buttonRight.position = ccp(winSize.width * 0.95, winSize.height * 0.95);
        buttonRight.tag = 2;
        [self addChild:buttonRight z:10];
        [movableSprites addObject:buttonRight ];
        
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0  swallowsTouches:YES];
        thisPageCount = 1;
        
        CCSprite *coverFLow = [CCSprite spriteWithFile:@"page_home.png"];
        coverFLow.position = ccp(winSize.width * 0.5, winSize.height * 0.95);
        coverFLow.tag = 3;
        [self addChild:coverFLow z:10];
        [movableSprites addObject:coverFLow];
        
        CCSprite *arcade = [CCSprite spriteWithFile:@"arcade.png"];
        arcade.position = ccp(winSize.width * 0.05, winSize.height * 0.05);
        arcade.tag = 4;
        [self addChild:arcade z:10];
        [movableSprites addObject:arcade];
        
        
        [buttonLeft release];
        [buttonRight release];
        [coverFLow release];
        [arcade release];
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
    //  [super dealloc];
    
}

#pragma mark Scenes
//重写须修改scene
//场景切换函数：下一页
-(void) nextPage:(int)thisPageCount{
    // NSLog(@"nextPage");
    //此处等待重写
    //每个Page的下一个Page
}
//场景切换函数：上一页
-(void) prevPage:(int)thisPageCount
{
    //  NSLog(@"prevPage");    
    //此处等待重写
    //每个Page的上一个Page
}

#pragma mark Touch matics
//精灵的点击
- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    NSLog(@"touch1");
    CCSprite * newSprite = nil;
    //循环到点击的那个精灵，返回给newSprit
    int i=1;
    for (CCSprite *sprite in movableSprites) {
        i++;
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
        debuglog(@"touched left:%d");
        //加条件判句
        if(thisPageCount >0){
            thisPageCount --;
            [self prevPage:thisPageCount];        
        }
        
    }
    
    if(selSprite.tag == 2){
        NSLog(@"touched right :%d",thisPageCount);
        if(thisPageCount <3){
            thisPageCount ++;
            [self nextPage:thisPageCount];        
        }
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

-(void)selectSpriteOnPage:(CGPoint)touchLocation{
    //在每个Page里面重写
}

- (void) enterCoverFlow
{
    //停止cocos2d视图
    [[CCDirector sharedDirector] stopAnimation];
    //进入coverflow
    CoverflowViewController *cf;
    cf = [[CoverflowViewController alloc] initWithNibName:@"CoverflowViewController" bundle:nil];
    [cf setImageNumber:10 currentPage:1 imageName:@"cover_1.jpg"];
    [[[CCDirector sharedDirector] view] addSubview:cf.view];
    //释放View
    [cf.view release];
}

- (void) enterGame 
{
    //停止cocos2d视图
    [[CCDirector sharedDirector] stopAnimation];
    //载入画图游戏
    PainterViewController *patinter;
    patinter = [[PainterViewController alloc] initWithNibName:@"PainterViewController" bundle:nil];
    [[[[CCDirector sharedDirector] view] window] addSubview:patinter.view];    
    //释放View
    [patinter.view release];
}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];
    [self selectSpriteOnPage:touchLocation];
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
