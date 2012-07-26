//
//  Assist.m
//  DianBook
//
//  Created by FreeTymeKiyan on 7/24/12.
//  Copyright 2012 111. All rights reserved.
//

#import "Assist.h"

@implementation Assist

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end

void debuglog(NSString *str){
    
    if (IS_DEBUG == 1) {
        NSLog(@"%@",str);
    }
}
