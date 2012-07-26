//
//  TapGestureRecognizer.h
//  book
//
//  Created by nelson on 12-7-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TapGestureRecognizer : UITapGestureRecognizer
{
    int tag;
    
}
@property(nonatomic,assign) int tag;
-(void)init :(id)sender action:(SEL)action tag:(int)tag;
@end
