//
//  PainterViewController.h
//  喻园早教
//
//  Created by Visible Chinese Human on 12-6-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorPicker.h"

@class PaintingView;
@interface PainterViewController : UIViewController<UIPopoverControllerDelegate,ColorPickerDelegate>
{
    UIPopoverController *popoverController; // for iPad device
    UIColor *color;                         // our color 
    UIImageView *backView,*smallView;
    PaintingView *drawingView;
    UIButton *a0,*a1,*a2,*a3,*a4,*a5,*a6,*a7,*a8,*a9,*a10,*a11,*a12,*a13,*a14,*a15,*a16,*a17,*a18,*a19,*a20,*a21,*a22,*a23,*a24,*a25,*a26,*a27,*a28,*a29,*a30,*a31;
    UIButton *b1,*b2,*b3,*b4,*b5;
    int imageNum;
 
}
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic, retain) IBOutlet PaintingView *drawingView;


-(void)ScreenShots;
-(void)buttonClick:(id)sender;
// the needed delegate methods for the ColorPicker
- (void)colorPicker:(ColorPicker *)colorPicker didSelectColorWithTag:(NSInteger)tag Red: (NSUInteger)red Green:(NSUInteger)green Blue:(NSUInteger)blue Alpha:(NSUInteger)alpha;
- (void)colorPicker:(ColorPicker *)colorPicker didCancelWithTag:(NSInteger)tag;
@end
