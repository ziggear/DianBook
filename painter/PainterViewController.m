//
//  PainterViewController.m
//  喻园早教
//
//  Created by Visible Chinese Human on 12-6-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PainterViewController.h"
#import "PaintingView.h"
#import "AppDelegate.h"
//#import "CBookFoudation.h"
//#import "ViewController.h"
#import "ColorPicker.h"

//CONSTANTS:
#define kPaletteHeight			30
#define kPaletteSize			5
#define kMinEraseInterval		0.5
// Padding for margins
#define kLeftMargin				10.0
#define kTopMargin				10.0
#define kRightMargin			10.0

@interface PainterViewController ()

@end

@implementation PainterViewController
@synthesize drawingView,color,popoverController;
// take a look on which device we are running
-(BOOL)deviceIsiPad
{
    NSString *devstr=[[UIDevice currentDevice] model];
    if([devstr isEqualToString:@"iPad"] || [devstr isEqualToString:@"iPad Simulator"])
        return YES;
    return NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //添加Log
    NSLog(@"%@ : %@", NSStringFromSelector(_cmd), self);
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        imageNum = 1;
        int xOffset,yOffset;
        xOffset = 24;
        yOffset =272;
        
        //补充：添加背景图
        UIImageView *background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"grass.png"]];
        background.frame = CGRectMake(0, 0, 768, 1024);
        //设置背景图的透明度
        background.alpha = 1.0f;
        //先不急addSubView
        //否则会把画图内容遮挡
        //[self.view addSubview:background];
        //[self.view sendSubviewToBack:background];
        //[background release];
        //补充完毕
        
        //验证颜色空间
        color=[UIColor blueColor];
        //该控件放到后面后，图像视图无图显示
        UISlider *slider=[[UISlider alloc] initWithFrame:CGRectMake(60, 100, 300, 30)];
        slider.maximumValue = 36;
        slider.minimumValue = 0.0;
        slider.value = 16;
        [slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:slider];
        [slider release];
        
        //补充：给Slide配大小的示意图
        UIButton *pencilSmall = [[UIButton alloc] init];
        pencilSmall.frame = CGRectMake(40, 140, 44, 44);
        pencilSmall.showsTouchWhenHighlighted = NO;
        [pencilSmall setBackgroundImage:[UIImage imageNamed:@"pencil-small.png"] forState:UIControlStateNormal];
        [self.view addSubview:pencilSmall]; 
        [pencilSmall release];
        
        UIButton *pencilLarge = [[UIButton alloc] init];
        pencilLarge.frame = CGRectMake(300, 130, 80, 80);
        pencilLarge.showsTouchWhenHighlighted = NO;
        [pencilLarge setBackgroundImage:[UIImage imageNamed:@"pencil-large.png"] forState:UIControlStateNormal];
        [self.view addSubview:pencilLarge]; 
        [pencilLarge release]; 
        //补充完毕

        
        

        
        drawingView.backgroundColor = [UIColor clearColor];
        drawingView.opaque = YES;
        drawingView.frame = CGRectMake(xOffset, yOffset, 720, 480);
        
        //补充：添加drawingView防止遮挡
        [self.view insertSubview:drawingView atIndex:1];
        
        smallView=[[UIImageView alloc] initWithFrame:CGRectMake(400,30,360, 240)];
        smallView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",imageNum]];
        smallView.opaque =NO;
        [self.view addSubview:smallView];
        
        backView = [[UIImageView alloc] initWithFrame:CGRectMake(xOffset, yOffset, 720, 480)];
        backView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",imageNum]];
        backView.opaque =NO;
        
        //补充：添加背景
        [self.view addSubview:background];
        //补充完毕
        
        [self.view addSubview:backView];
        [self.view sendSubviewToBack:backView];
        
        //补充：设置背景为最底层
        [self.view sendSubviewToBack:background];
        [background release];
        //补充完毕
        
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
                                                [NSArray arrayWithObjects:
                                                 @"Red",
                                                 @"Yellow",
                                                 @"Green",
                                                 @"Blue",
                                                 @"Purple",
                                                 nil]];
        CGRect frame = CGRectMake(80,800,600,40);
        segmentedControl.frame = frame;
        [segmentedControl addTarget:self action:@selector(changeBrushColor:) forControlEvents:UIControlEventValueChanged];
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        segmentedControl.tintColor = [UIColor darkGrayColor];
        segmentedControl.selectedSegmentIndex = 2;
        [drawingView setBrushColorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
        [self.view addSubview:segmentedControl];
        [segmentedControl release];
        
        
        UISegmentedControl *segtyle = [[UISegmentedControl alloc] initWithItems:
                                       [NSArray arrayWithObjects:
                                        @"铅笔",
                                        @"毛笔",
                                        @"蜡笔",
                                        @"粉笔",
                                        @"钢笔",
                                        nil]];
        CGRect tframe = CGRectMake(80,850,600,40);
        segtyle.frame = tframe;
        [segtyle addTarget:self action:@selector(changeBrushtype:) forControlEvents:UIControlEventValueChanged];
        segtyle.segmentedControlStyle = UISegmentedControlStyleBar;
        segtyle.tintColor = [UIColor darkGrayColor];
        segtyle.selectedSegmentIndex = 1;
        [drawingView setBrushTypeWithtag:1];
        [self.view addSubview:segtyle];
        [segtyle release];
        
        
        //最下方5个按钮 
        
        //返回按钮
        UIButton *rebutton = [[UIButton alloc] init];
        rebutton.frame = CGRectMake(40, 940, 80, 80);
        //原大小：CGRectMake(190, 950, 95, 50);
        //rebutton.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        //[rebutton.titleLabel setTextColor:[UIColor blueColor]];
        //rebutton.backgroundColor = [UIColor lightGrayColor];
        //[rebutton setTitle:@"返回" forState:0];
        //添加图片
        [rebutton setBackgroundImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
        rebutton.showsTouchWhenHighlighted = YES;
        [rebutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        rebutton.tag = 1;
        [self.view addSubview:rebutton]; 
        [rebutton release];                
        
        UIButton *colorbutton = [[UIButton alloc] init];
        colorbutton.frame = CGRectMake(190, 940, 80, 80);   
        //原大小：CGRectMake(190, 950, 95, 50);
        //colorbutton.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        //[colorbutton setTitle:@"颜色" forState:0];
        //[colorbutton.titleLabel setTextColor:[UIColor blueColor]];
        //colorbutton.backgroundColor = [UIColor lightGrayColor];
        
        [colorbutton setBackgroundImage:[UIImage imageNamed:@"colors.png"] forState:UIControlStateNormal];
        
        colorbutton.showsTouchWhenHighlighted = YES;
        [colorbutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        colorbutton.tag = 2;
        [self.view addSubview:colorbutton]; 
        [colorbutton release];

        
        UIButton *easebutton = [[UIButton alloc] init];
        easebutton.frame = CGRectMake(340, 940, 80, 80);
        //easebutton.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        //[easebutton.titleLabel setTextColor:[UIColor blueColor]];
        //easebutton.backgroundColor = [UIColor lightGrayColor];
        //[easebutton setTitle:@"清空" forState:0];
        
        [easebutton setBackgroundImage:[UIImage imageNamed:@"erase.png"] forState:UIControlStateNormal];
        
        easebutton.showsTouchWhenHighlighted = YES;
        [easebutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        easebutton.tag = 3;
        [self.view addSubview:easebutton]; 
        [easebutton release];

        
        UIButton *selectbutton = [[UIButton alloc] init];
        selectbutton.frame = CGRectMake(490, 940, 80, 80);
        //selectbutton.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        //[selectbutton.titleLabel setTextColor:[UIColor blueColor]];
        //selectbutton.backgroundColor = [UIColor lightGrayColor];
        //[selectbutton setTitle:@"选择" forState:0];
        
        [selectbutton setBackgroundImage:[UIImage imageNamed:@"choose.png"] forState:UIControlStateNormal];
        
        selectbutton.showsTouchWhenHighlighted = YES;
        [selectbutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        selectbutton.tag = 4;
        [self.view addSubview:selectbutton]; 
        [selectbutton release];
        
        UIButton *cabutton = [[UIButton alloc] init];
        cabutton.frame = CGRectMake(640, 940, 80, 80);
        //cabutton.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        //[cabutton.titleLabel setTextColor:[UIColor blueColor]];
        //cabutton.backgroundColor = [UIColor lightGrayColor];
        //[cabutton setTitle:@"擦除" forState:0];
        
        [cabutton setBackgroundImage:[UIImage imageNamed:@"ca.png"] forState:UIControlStateNormal];
        
        cabutton.showsTouchWhenHighlighted = YES;
        [cabutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        cabutton.tag = 5;
        [self.view addSubview:cabutton]; 
        [cabutton release];

    }
    return self;
}
-(void)buttonClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    switch (btn.tag)
    {
        case 1:
            [self.view removeFromSuperview];
            [self.view release];
            break;
        case 2:
        {
            // create the ColorPicker with iPad layout
            ColorPicker *picker=[[ColorPicker alloc] initWithNibName:@"ColorPicker_iPad" bundle:nil Tag:1 Color:color];
            if(picker)
            {
                // set delegate
                picker.delegate=self;
                // and create PopoverController
                popoverController=[[UIPopoverController alloc] initWithContentViewController:picker];
                popoverController.delegate=self;
                [popoverController setPopoverContentSize:CGSizeMake(430, 435)];
                picker.popOver=popoverController;
                // and show it next to our Button
                [popoverController presentPopoverFromRect:btn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            }
            [picker release], picker=nil;
            break;
        }
        case 3:
            [drawingView erase];
            break;
        case 4:
        {
            //backView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3];
            imageNum +=1;
            if (imageNum>9)
            {
                imageNum=1;
            }
           backView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",imageNum]];
           smallView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",imageNum]];
           [drawingView erase];
            break;
        }
        case 5:
        { 
            [drawingView changeBlendMode:YES];
            [drawingView setBrushColorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
          
            break;
        }
        default:
            break;
    }
 
}
- (void)changeBrushtype:(id)sender
{
    [drawingView changeBlendMode:NO];
    UISegmentedControl *seg = (UISegmentedControl*)sender;
    [drawingView setBrushTypeWithtag:[seg selectedSegmentIndex]];
}
// Change the brush color
- (void)changeBrushColor:(id)sender
{
    [drawingView changeBlendMode:NO];
    UISegmentedControl *seg = (UISegmentedControl*)sender;
    switch (seg.selectedSegmentIndex) 
    {
        case 0:
            [drawingView setBrushColorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
            break;
        case 1:
            [drawingView setBrushColorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0];
            break;
        case 2:
            [drawingView setBrushColorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
            break;
        case 3:
            [drawingView setBrushColorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0];
            break;
        case 4:
            [drawingView setBrushColorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0];
            break;
            
        default:
            break;
    }
}

-(void)sliderValueChange:(id)sender
{
    UISlider *slder = (UISlider*)sender;
    [drawingView setBrushSize:slder.value];
    
}
#pragma mark -
#pragma mark Color picker delegate methods

// the delegate mehtods

// just to dismiss the PopoverController
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popController
{
    [popController dismissPopoverAnimated:YES];
	self.popoverController=nil;
}
// ColorPicker did cancel
- (void)colorPicker:(ColorPicker *)colorPicker didCancelWithTag:(NSInteger)userTag 
{
    // act on device and clear Popover or Modal controller
    if([self deviceIsiPad])
    {
        [self popoverControllerDidDismissPopover:popoverController];
    }
    else 
        [self dismissModalViewControllerAnimated:YES];
    
    return;
}

// ColorPicker has done with OK Button
- (void)colorPicker:(ColorPicker *)colorPicker didSelectColorWithTag:(NSInteger)userTag Red:(NSUInteger)red Green:(NSUInteger)green Blue:(NSUInteger)blue Alpha:(NSUInteger)alpha
{
    // here we can act different depending on the userTag
	switch(userTag)
    {
        case 1:
            [drawingView setBrushColorWithRed:(float)red/255.0 green:(float)green/255.0 blue:(float)blue/255.0 alpha:(float)alpha/255.0];
            // we just set our Color. Color comes from the ColorPicker in RGBA 0-255 Values
            //self.color=[UIColor colorWithRed:(float)red/255.0 green:(float)green/255.0 blue:(float)blue/255.0 alpha:(float)alpha/255.0];
            //self.view.backgroundColor=color;
            break;
        default:
            break;
    }
    
    // dismiss the Picker
    if([self deviceIsiPad])
    {
        [self popoverControllerDidDismissPopover:popoverController];
    }
    else 
        [self dismissModalViewControllerAnimated:YES];
    
    return;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation==UIInterfaceOrientationPortrait  || interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}

@end
