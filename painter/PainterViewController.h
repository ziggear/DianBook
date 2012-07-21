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
    
    int imageNum;
}
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic, retain) IBOutlet PaintingView *drawingView;
-(void)buttonClick:(id)sender;
// the needed delegate methods for the ColorPicker
- (void)colorPicker:(ColorPicker *)colorPicker didSelectColorWithTag:(NSInteger)tag Red: (NSUInteger)red Green:(NSUInteger)green Blue:(NSUInteger)blue Alpha:(NSUInteger)alpha;
- (void)colorPicker:(ColorPicker *)colorPicker didCancelWithTag:(NSInteger)tag;
@end
