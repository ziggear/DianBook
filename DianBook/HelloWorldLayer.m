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
    CCLOG(@"%@ : %@", NSStringFromSelector(_cmd), self);
    
	if((self = [super init])) {  
        
        //初始化音效ID
        for (int i=0; i<=4; i++) {
            soundIds[i] = 0;
        }
        //获取窗口大小
        globalWinSize = [[CCDirector sharedDirector] winSize];
        
        //接受点击
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0  swallowsTouches:YES];
        
        //初始化页码
        thisPageCount = 0;
        
        
        //顶部按钮数组
        //左翻页tag = 1 ，右翻页tag = 2 。在 selectSpriteForTouch 函数中判断用
        movableSprites = [[NSMutableArray alloc] init];
        
        //左翻页
        CCSprite *buttonLeft = [CCSprite spriteWithFile:@"page_left.png"];
        buttonLeft.position = ccp(globalWinSize.width * 0.05, globalWinSize.height * 0.95);
        buttonLeft.tag = 1;
        [self addChild:buttonLeft z:10];
        [movableSprites addObject:buttonLeft ];
        //右翻页
        CCSprite *buttonRight = [CCSprite spriteWithFile:@"page_right.png"];
        buttonRight.position = ccp(globalWinSize.width * 0.95, globalWinSize.height * 0.95);
        buttonRight.tag = 2;
        [self addChild:buttonRight z:10];
        [movableSprites addObject:buttonRight ];
        
        CCSprite *coverFLow = [CCSprite spriteWithFile:@"page_home.png"];
        coverFLow.position = ccp(globalWinSize.width * 0.5, globalWinSize.height * 0.95);
        coverFLow.tag = 3;
        [self addChild:coverFLow z:10];
        [movableSprites addObject:coverFLow];
        
        CCSprite *arcade = [CCSprite spriteWithFile:@"arcade.png"];
        arcade.position = ccp(globalWinSize.width * 0.05, globalWinSize.height * 0.05);
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
    CCLOG(@"%@ : %@", NSStringFromSelector(_cmd), self);
    
    //停止所有音频播放
    for (int i=0; i<=4; i++) {
        [[SimpleAudioEngine sharedEngine] stopEffect:soundIds[i]];
    }
    [self unLoadSound];
    
    //记得在此释放资源
	//先 release方法，再赋值 nil
    [selSprite release];
    selSprite = nil;
    [movableSprites release];
    movableSprites = nil;
    [super dealloc];
}
#pragma mark Soundffects

- (void) preLoadSound: (NSArray *) paths
{
    soundPaths = paths;
    if(soundPaths.count > 0) {
        for(int i=0; i < (soundPaths.count); i++){
            [[SimpleAudioEngine sharedEngine] preloadEffect:[soundPaths objectAtIndex:i]];
        }
    }
    CCLOG(@"Loaded %d Effects", soundPaths.count);
}

- (void) unLoadSound
{
    for(int i=0; i < (soundPaths.count); i++){
        [[SimpleAudioEngine sharedEngine] unloadEffect:[soundPaths objectAtIndex:i]];
    }
    CCLOG(@"Unload %d Effects", soundPaths.count);
}

#pragma mark Scenes
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

#pragma mark Touch matics
//精灵的点击
- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    CCLOG(@"Touched");
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
        CCLOG(@"touched left");
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

-(void)selectSpriteOnPage:(CGPoint)touchLocation{
    //在每个Page里面重写
}

- (void) enterCoverFlow
{\
    //载入等待场景
    [[CCDirector sharedDirector] replaceScene:[Loading scene]];

    //进入coverflow
    CoverflowViewController *cf;
    cf = [[CoverflowViewController alloc] initWithNibName:@"CoverflowViewController" bundle:nil];
    [cf setImageNumber:10 currentPage:1 imageName:@"cover_1.jpg"];
    [[[CCDirector sharedDirector] view] addSubview:cf.view];
    //释放View
    [cf.view release];
    
    //停止cocos2d视图
    [[CCDirector sharedDirector] stopAnimation];
}

- (void) enterGame 
{
    //载入等待场景
    [[CCDirector sharedDirector] replaceScene:[Loading scene]];
    
    //载入画图游戏
    PainterViewController *patinter;
    patinter = [[PainterViewController alloc] initWithNibName:@"PainterViewController" bundle:nil];
    [[[CCDirector sharedDirector] view] addSubview:patinter.view]; 
    
    //释放View
    [patinter.view release];
    
    //停止cocos2d视图
    [[CCDirector sharedDirector] stopAnimation];
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
