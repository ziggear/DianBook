//
//  Loading.h
//  DianBook
//
//  Created by 1 1 on 7/27/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Loading : CCLayer {
    CCSprite *background;
    CCSprite *roll;   
}

+(CCScene *) scene;
@end