//
//  GestureRecognizer.h
//  book
//
//  Created by nelson on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GestureRecognizer : UISwipeGestureRecognizer
{
    int page,tag;
}
@property (nonatomic,assign) int page,tag;

-(void)init:(id)sender action:(SEL)action page:(int)page tag:(int)tag;

@end
