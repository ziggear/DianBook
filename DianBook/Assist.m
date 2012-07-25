//
//  Assist.m
//  DianBook
//
//  Created by 1 1 on 7/24/12.
//  Copyright (c) 2012 111. All rights reserved.
//



#import "Assist.h"

@implementation Assist

@end

void debuglog(NSString *str) {
    if (myDEBUG == 1) {
        NSLog(@"%@",str);
    }
}