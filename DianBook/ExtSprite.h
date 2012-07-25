//
//  ExtSprite.h
//  DianBook
//
//  Created by 1 1 on 7/23/12.
//  Copyright 2012 111. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ExtSprite : CCSprite {
    NSArray *movmentsSelf;
    int     flag1;
    
    NSArray *movmentsChild;
    int     flag2;
}

- (void) setMovments: (NSArray *) mov;
- (void) setChildMovments: (NSArray *) mov;
- (void) runMovments;
- (void) runChildMovmentsOn: (CCLayer *) layer;

@end
