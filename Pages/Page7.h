//
//  Page7.h
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HelloWorldLayer.h"

@interface Page7 : HelloWorldLayer {
   CCSprite *background;

    CCSprite *dogrun;
    CCSprite *birdjump1;
    CCSprite *birdjump2;
    
    int bgnum;
}

+(CCScene *) scene;
//-（）void
@end
