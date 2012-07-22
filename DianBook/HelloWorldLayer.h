//
//  HelloWorldLayer.h
//  DianBook
//
//  Created by 1 1 on 7/19/12.
//  Copyright 111 2012. All rights reserved.
//


#import <GameKit/GameKit.h>


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

@class Page1;
@class Page2;


// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    CCSprite * selSprite;
    NSMutableArray * movableSprites;
    int         thisPageCount;         //本页的页数，初始化为零 表示封面
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
