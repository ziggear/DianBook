//
//  GestureRecognizer.m
//  book
//
//  Created by nelson on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GestureRecognizer.h"

@implementation GestureRecognizer
@synthesize page,tag;
-(void)init:(id)sender action:(SEL)action page:(int)thepage tag:(int)thetag
{
    [super initWithTarget:sender action:action];
    self.tag=thetag;
    self.page=thepage;
}

@end
