//
//  Page4.h
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HelloWorldLayer.h"

@interface Page4 : HelloWorldLayer {
    CCSprite * selSprite4;
    NSMutableArray * movableSprites4; 
    
    CCSprite *background;
    int bgnum;
}

+(CCScene *) scene;
//-（）void
@end
