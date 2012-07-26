//
//  Page8.h
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HelloWorldLayer.h"

@interface Page8 : HelloWorldLayer {
    CCSprite *background;
    
    CCSprite *birdfly;
    
    int bgnum;
}

+(CCScene *) scene;
//-（）void
@end
