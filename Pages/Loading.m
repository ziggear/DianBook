//
//  Loading.m
//  DianBook
//
//  Created by 1 1 on 7/27/12.
//  Copyright (c) 2012 111. All rights reserved.
//

#import "Loading.h"

@implementation Loading

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	Loading *layer = [Loading node];
	[scene addChild: layer];
	return scene;
}

- (id) init {
    if(self = [super init]) {
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0  swallowsTouches:YES];
        
        background = [CCSprite spriteWithFile:@"black.jpg"];
        background.position = ccp(512, 384);
        [self addChild:background];
        
        roll = [CCSprite spriteWithFile:@"roll-white.png"];
        roll.position = ccp(512, 384);    
        
        
        id action = [CCRotateBy actionWithDuration:0.5 angle:180];
        [roll runAction:[CCRepeatForever actionWithAction:action]];
        [self addChild:roll];
    }
    
    return self;
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
}

- (void) dealloc {
    [roll release];
    [super dealloc];
}


@end

