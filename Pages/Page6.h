//
//  Page6.h
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HelloWorldLayer.h"

@interface Page6 : HelloWorldLayer {
    CCSprite *background1;
    CCSprite *background2;
    CCSprite *background3;
    CCSprite *background4;
    
    CCSprite *butterfly;
    int bgnum;
}
@property (nonatomic,retain) NSArray *arr;
+(CCScene *) scene;
-(float)strack:(float) x;
@end
