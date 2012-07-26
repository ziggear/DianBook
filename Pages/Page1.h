//
//  Page1.h
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HelloWorldLayer.h"

@interface Page1 : HelloWorldLayer {
    CCSprite * selSprite1;
    CCSprite *words;    
    NSMutableArray * movableSprites1;    
}

+(CCScene *) scene;
@end
