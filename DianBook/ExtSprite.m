//
//  ExtSprite.m
//  DianBook
//
//  Created by 1 1 on 7/23/12.
//  Copyright 2012 111. All rights reserved.
//

#import "ExtSprite.h"


@implementation ExtSprite

- (void) setMovments: (NSArray *) mov {
    movmentsSelf = mov;
    flag1 = 1;
    //flag1 = 1 说明精灵动作已经设置，可以执行 runMovments 函数
}

- (void) setChildMovments: (NSArray *) mov {
    movmentsChild = mov;
    flag2 = 1;
    //flag2 = 1 说明子精灵动作已经设置，可以执行 unChildMovmentsOn 函数
}

- (void) runMovments {
    debuglog(@"running movments");
    if (flag1 == 1) {
        [self runAction:[CCSequence actionWithArray:movmentsSelf]];
    }
}

- (void) runChildMovmentsOn: (CCLayer *) layer{
    debuglog(@"running child movments");
    if (flag2 == 1) {
        CCSprite *child = [[CCSprite alloc] init];
        [child runAction:[CCSequence actionWithArray:movmentsSelf]];
        [layer addChild:child];
    }
}

- (id) init {
    if (self = [super init]) {
        flag1 = 0;
        flag2 = 0;
    }
    return self;
}


- (void) dealloc {
    [movmentsSelf release];
    movmentsSelf = nil;
    [movmentsChild release];
    movmentsChild = nil;
    
    [super dealloc];
}





@end