//
//  Page2.h
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HelloWorldLayer.h"

@interface Page2 : HelloWorldLayer {
    CCSprite *wind;
    CCSprite *nest;
    CCSprite *dog;
    CCSprite *dogsmashed;
    CCSprite * selSprite2;
    NSMutableArray * movableSprites2; 
}
+(CCScene *) scene; 
@end
