//
//  HelloWorldLayer.h
//  DianBook
//
//  Created by 1 1 on 7/19/12.
//  Copyright 111 2012. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "SimpleAudioEngine.h"
#import "PainterViewController.h"
#import "CoverflowViewController.h"
#import "cocos2d.h"
#import "Assist.h"
#import "Animate.h"

//每添加一页在此加入一个@class PageX

@class  Loading;
@class  Page1;
@class  Page2;
@class  Page3;
@class  Page4;
@class  Page5;
@class  Page6;
@class  Page7;
@class  Page8;
@class  Page9;
@class  Page10;
@class  Page11;


// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    CCSprite * selSprite;
    NSMutableArray * movableSprites;
    int         thisPageCount;         //本页的页数，初始化为零 表示封面 
    
    //一些辅助数据
    CGSize globalWinSize;              //保存窗口大小
    int soundIds[5];                   //保存播放音效留下来的 soundID
    NSArray *soundPaths;               //保存需要载入和卸载的声音文件
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

- (void) nextPage;
- (void) prevPage;
- (void) selectSpriteOnPage:(CGPoint)touchLocation;
- (void) enterCoverFlow;
- (void) enterGame;

- (void) preLoadSound: (NSArray *) paths;
- (void) unLoadSound;

@end
