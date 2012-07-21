//
//  CoverflowViewController.h
//  iHouseA
//
//  Created by Visible Chinese Human on 11-10-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowCoverView.h"
#define CBAppDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])
@interface CoverflowViewController : UIViewController <FlowCoverViewDelegate>{
    FlowCoverView *flowCoverView;
    int imageNumber,currentPage;
    NSString *imgStr;
    UILabel *label;
}
@property (nonatomic,retain) NSString *imgStr;
@property (nonatomic,retain) FlowCoverView *flowCoverView;
@property (nonatomic,retain) UILabel *label;
-(void)setImageNumber:(int)number currentPage:(int)current imageName:(NSString*)str;
@end
