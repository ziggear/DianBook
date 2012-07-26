//
//  TapGestureRecognizer.m
//  book
//
//  Created by nelson on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TapGestureRecognizer.h"

@implementation TapGestureRecognizer
@synthesize tag;

-(void)init:(id)sender action:(SEL)action tag:(int)thetag
{
    [super initWithTarget:sender action:action];
    self.tag=thetag;
}
@end
