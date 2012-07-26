//
//  Page10.h
//  DianBook
//
//  Created by 1 1 on 7/20/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HelloWorldLayer.h"

@interface Page10 : HelloWorldLayer {
   CCSprite *background;
   CCSprite *rabbitR;    
   CCSprite *balloon; 
   CCSprite *rabbitW;
   CCSprite *balloonW;  
    
   CCSprite * selSprite2;
   NSMutableArray * movableSprites2; 

   int bgnum;
}

+(CCScene *) scene;
//-（）void
@end
