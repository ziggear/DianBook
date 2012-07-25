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
//#import "Foudation.h"
//#import "ViewController.h"
#import "ColorPicker.h"
#import "TapGestureRecognizer.h"
#import "GestureRecognizer.h"


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
        xOffset =175;
        yOffset =145;
        
        //补充：添加背景图
        UIImageView *background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"huaban.jpg"]];
        background.frame = CGRectMake(0, 0, 1024, 768);
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
        UISlider *slider=[[UISlider alloc] initWithFrame:CGRectMake(384, 706, 300, 30)];
        slider.maximumValue = 36;
        slider.minimumValue = 0.0;
        slider.value = 16;
        [slider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:slider];
   //     [slider release];
        
        
        
        
        
        
        //补充：给Slide配大小的示意图
        UIButton *pencilSmall = [[UIButton alloc] init];
        pencilSmall.frame = CGRectMake(40, 140, 44, 44);
        pencilSmall.showsTouchWhenHighlighted = NO;
       // [pencilSmall setBackgroundImage:[UIImage imageNamed:@"pencil-small.png"] forState:UIControlStateNormal];
        [self.view addSubview:pencilSmall]; 
    //    [pencilSmall release];
        
        UIButton *pencilLarge = [[UIButton alloc] init];
        pencilLarge.frame = CGRectMake(300, 130, 80, 80);
        pencilLarge.showsTouchWhenHighlighted = NO;
       // [pencilLarge setBackgroundImage:[UIImage imageNamed:@"pencil-large.png"] forState:UIControlStateNormal];
       [self.view addSubview:pencilLarge]; 
     //   [pencilLarge release]; 
        //补充完毕

        
        

        
        drawingView.backgroundColor = [UIColor clearColor];
        drawingView.opaque = YES;
        drawingView.frame = CGRectMake(xOffset, yOffset, 465, 728);

        //补充：添加drawingView防止遮挡
        [self.view insertSubview:drawingView atIndex:1];
        
        smallView=[[UIImageView alloc] initWithFrame:CGRectMake(400,30,360, 240)];
        smallView.image = [UIImage imageNamed:[NSString stringWithFormat:@"0_%d.jpg",imageNum]];
        smallView.opaque =NO;
      //  [self.view addSubview:smallView];
        
        backView = [[UIImageView alloc] initWithFrame:CGRectMake(xOffset, yOffset, 720, 490)];
        backView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hbg%d.png",imageNum]];
        backView.opaque =NO;
        
        //补充：添加背景
        [self.view addSubview:background];
        //补充完毕
        
        [self.view addSubview:backView];
        [self.view sendSubviewToBack:backView];
        
        //补充：设置背景为最底层
        [self.view sendSubviewToBack:background];
     //   [background release];
        //补充完毕
        
        
        TapGestureRecognizer *tap0 = [TapGestureRecognizer alloc];
        [tap0 init:self action:@selector(changeBrushColor:) tag:0];
        a0 = [[UIButton alloc] initWithFrame:CGRectMake(19, 108, 30, 30)];
        a0.showsTouchWhenHighlighted = YES;        
        a0.userInteractionEnabled = YES;
        [a0 addGestureRecognizer:tap0];
        [self.view addSubview:a0];
        
        
        TapGestureRecognizer *tap1 = [TapGestureRecognizer alloc];
        [tap1 init:self action:@selector(changeBrushColor:) tag:1];
        a1 = [[UIButton alloc] initWithFrame:CGRectMake(19, 144, 30, 30)];
        a1.showsTouchWhenHighlighted = YES;  
        a1.userInteractionEnabled = YES;
        [a1 addGestureRecognizer:tap1];
        [self.view addSubview:a1];        
        
        
        TapGestureRecognizer *tap2 = [TapGestureRecognizer alloc];
        [tap2 init:self action:@selector(changeBrushColor:) tag:2];
        a2 = [[UIButton alloc] initWithFrame:CGRectMake(19, 180, 30, 30)];
        a2.showsTouchWhenHighlighted = YES;  
        a2.userInteractionEnabled = YES;
        [a2 addGestureRecognizer:tap2];  
        [self.view addSubview:a2];        
        
        TapGestureRecognizer *tap3 = [TapGestureRecognizer alloc];
        [tap3 init:self action:@selector(changeBrushColor:) tag:3];
        a3 = [[UIButton alloc] initWithFrame:CGRectMake(19, 216, 30, 30)];
          a3.showsTouchWhenHighlighted = YES;        
        a3.userInteractionEnabled = YES;
        [a3 addGestureRecognizer:tap3];
        [self.view addSubview:a3];        
        
        TapGestureRecognizer *tap4 = [TapGestureRecognizer alloc];
        [tap4 init:self action:@selector(changeBrushColor:) tag:4];
        a4 = [[UIButton alloc] initWithFrame:CGRectMake(19, 250, 30, 30)];
        a4.showsTouchWhenHighlighted = YES;  
        a4.userInteractionEnabled = YES;
        [a4 addGestureRecognizer:tap4]; 
        [self.view addSubview:a4];        
        
        TapGestureRecognizer *tap5 = [TapGestureRecognizer alloc];
        [tap5 init:self action:@selector(changeBrushColor:) tag:5];
        a5 = [[UIButton alloc] initWithFrame:CGRectMake(19, 290, 30, 30)];
             a5.showsTouchWhenHighlighted = YES;     
        a5.userInteractionEnabled = YES;
        [a5 addGestureRecognizer:tap5];
        [self.view addSubview:a5]; 
        
        
        TapGestureRecognizer *tap6 = [TapGestureRecognizer alloc];
        [tap6 init:self action:@selector(changeBrushColor:) tag:6];
        a6 = [[UIButton alloc] initWithFrame:CGRectMake(19, 327, 30, 30)];
        a6.showsTouchWhenHighlighted = YES;  
        a6.userInteractionEnabled = YES;
        [a6 addGestureRecognizer:tap6];  
         [self.view addSubview:a6];         
        
        
        TapGestureRecognizer *tap7 = [TapGestureRecognizer alloc];
        [tap7 init:self action:@selector(changeBrushColor:) tag:7];
        a7 = [[UIButton alloc] initWithFrame:CGRectMake(19, 363, 30, 30)];
        a7.showsTouchWhenHighlighted = YES;  
        a7.userInteractionEnabled = YES;
        [a7 addGestureRecognizer:tap7];   
         [self.view addSubview:a7]; 
        
        
        TapGestureRecognizer *tap8 = [TapGestureRecognizer alloc];
        [tap8 init:self action:@selector(changeBrushColor:) tag:8];
        a8 = [[UIButton alloc] initWithFrame:CGRectMake(19, 399, 30, 30)];
        a8.showsTouchWhenHighlighted = YES;  
        a8.userInteractionEnabled = YES;
        [a8 addGestureRecognizer:tap8]; 
         [self.view addSubview:a8];         
        
        TapGestureRecognizer *tap9 = [TapGestureRecognizer alloc];
        [tap9 init:self action:@selector(changeBrushColor:) tag:9];
        a9 = [[UIButton alloc] initWithFrame:CGRectMake(19, 434, 30, 30)];
        a9.showsTouchWhenHighlighted = YES;  
        a9.userInteractionEnabled = YES;
        [a9 addGestureRecognizer:tap9];
         [self.view addSubview:a9];         
        
        TapGestureRecognizer *tap10 = [TapGestureRecognizer alloc];
        [tap10 init:self action:@selector(changeBrushColor:) tag:10];
        a10 = [[UIButton alloc] initWithFrame:CGRectMake(19, 473, 30, 30)];
        a10.showsTouchWhenHighlighted = YES;  
        a10.userInteractionEnabled = YES;
        [a10 addGestureRecognizer:tap10];
         [self.view addSubview:a10];         
        
        TapGestureRecognizer *tap11 = [TapGestureRecognizer alloc];
        [tap11 init:self action:@selector(changeBrushColor:) tag:11];
        a11 = [[UIButton alloc] initWithFrame:CGRectMake(19, 508, 30, 30)];
        a11.showsTouchWhenHighlighted = YES;  
        a11.userInteractionEnabled = YES;
        [a11 addGestureRecognizer:tap11];
         [self.view addSubview:a11];         
        
        TapGestureRecognizer *tap12 = [TapGestureRecognizer alloc];
        [tap12 init:self action:@selector(changeBrushColor:) tag:12];
        a12 = [[UIButton alloc] initWithFrame:CGRectMake(19, 544, 30, 30)];
        a12.showsTouchWhenHighlighted = YES;  
        a12.userInteractionEnabled = YES;
        [a12 addGestureRecognizer:tap12]; 
         [self.view addSubview:a12];         
        
        TapGestureRecognizer *tap13 = [TapGestureRecognizer alloc];
        [tap13 init:self action:@selector(changeBrushColor:) tag:13];
        a13 = [[UIButton alloc] initWithFrame:CGRectMake(19, 580, 30, 30)];
        a13.showsTouchWhenHighlighted = YES;  
        a13.userInteractionEnabled = YES;
        [a13 addGestureRecognizer:tap13];
         [self.view addSubview:a13];         
        
        TapGestureRecognizer *tap14 = [TapGestureRecognizer alloc];
        [tap14 init:self action:@selector(changeBrushColor:) tag:14];
        a14 = [[UIButton alloc] initWithFrame:CGRectMake(19, 615, 30, 30)];
        a14.showsTouchWhenHighlighted = YES;  
        a14.userInteractionEnabled = YES;
        [a14 addGestureRecognizer:tap14];
         [self.view addSubview:a14];         
        
        TapGestureRecognizer *tap15 = [TapGestureRecognizer alloc];
        [tap15 init:self action:@selector(changeBrushColor:) tag:15];
        a15 = [[UIButton alloc] initWithFrame:CGRectMake(19, 651, 30, 30)];
        a15.showsTouchWhenHighlighted = YES;  
        a15.userInteractionEnabled = YES;
        [a15 addGestureRecognizer:tap15];
         [self.view addSubview:a15];         
        
        
        TapGestureRecognizer *tap16 = [TapGestureRecognizer alloc];
        [tap16 init:self action:@selector(changeBrushColor:) tag:16];
        a16 = [[UIButton alloc] initWithFrame:CGRectMake(67, 108, 30, 30)];
        a16.showsTouchWhenHighlighted = YES;  
        a16.userInteractionEnabled = YES;
        [a16 addGestureRecognizer:tap16];
        [self.view addSubview:a16];
        
        
        TapGestureRecognizer *tap17 = [TapGestureRecognizer alloc];
        [tap17 init:self action:@selector(changeBrushColor:) tag:17];
        a17 = [[UIButton alloc] initWithFrame:CGRectMake(67, 144, 30, 30)];
        a17.showsTouchWhenHighlighted = YES;  
        a17.userInteractionEnabled = YES;
        [a17 addGestureRecognizer:tap17];
        [self.view addSubview:a17];        
        
        
        TapGestureRecognizer *tap18 = [TapGestureRecognizer alloc];
        [tap18 init:self action:@selector(changeBrushColor:) tag:18];
        a18 = [[UIButton alloc] initWithFrame:CGRectMake(67, 180, 30, 30)];
        a18.showsTouchWhenHighlighted = YES;  
        a18.userInteractionEnabled = YES;
        [a18 addGestureRecognizer:tap18];  
        [self.view addSubview:a18];        
        
        TapGestureRecognizer *tap19 = [TapGestureRecognizer alloc];
        [tap19 init:self action:@selector(changeBrushColor:) tag:19];
        a19 = [[UIButton alloc] initWithFrame:CGRectMake(67, 216, 30, 30)];
        a19.showsTouchWhenHighlighted = YES;  
        a19.userInteractionEnabled = YES;
        [a19 addGestureRecognizer:tap19];
        [self.view addSubview:a19];        
        
        TapGestureRecognizer *tap20 = [TapGestureRecognizer alloc];
        [tap20 init:self action:@selector(changeBrushColor:) tag:20];
        a20 = [[UIButton alloc] initWithFrame:CGRectMake(67, 250, 30, 30)];
        a20.showsTouchWhenHighlighted = YES;  
        a20.userInteractionEnabled = YES;
        [a20 addGestureRecognizer:tap20]; 
        [self.view addSubview:a20];        
        
        TapGestureRecognizer *tap21 = [TapGestureRecognizer alloc];
        [tap21 init:self action:@selector(changeBrushColor:) tag:21];
        a21 = [[UIButton alloc] initWithFrame:CGRectMake(67, 290, 30, 30)];
        a21.showsTouchWhenHighlighted = YES;  
        a21.userInteractionEnabled = YES;
        [a21 addGestureRecognizer:tap21];
        [self.view addSubview:a21]; 
        
        
        TapGestureRecognizer *tap22 = [TapGestureRecognizer alloc];
        [tap22 init:self action:@selector(changeBrushColor:) tag:22];
        a22 = [[UIButton alloc] initWithFrame:CGRectMake(67, 327, 30, 30)];
        a22.showsTouchWhenHighlighted = YES;  
        a22.userInteractionEnabled = YES;
        [a22 addGestureRecognizer:tap22];  
        [self.view addSubview:a22];         
        
        
        TapGestureRecognizer *tap23 = [TapGestureRecognizer alloc];
        [tap23 init:self action:@selector(changeBrushColor:) tag:23];
        a23 = [[UIButton alloc] initWithFrame:CGRectMake(67, 363, 30, 30)];
        a23.showsTouchWhenHighlighted = YES;  
        a23.userInteractionEnabled = YES;
        [a23 addGestureRecognizer:tap23];   
        [self.view addSubview:a23]; 
        
        
        TapGestureRecognizer *tap24 = [TapGestureRecognizer alloc];
        [tap24 init:self action:@selector(changeBrushColor:) tag:24];
        a24 = [[UIButton alloc] initWithFrame:CGRectMake(67, 399, 30, 30)];
        a24.showsTouchWhenHighlighted = YES;  
        a24.userInteractionEnabled = YES;
        [a24 addGestureRecognizer:tap24]; 
        [self.view addSubview:a24];         
        
        TapGestureRecognizer *tap25 = [TapGestureRecognizer alloc];
        [tap25 init:self action:@selector(changeBrushColor:) tag:25];
        a25 = [[UIButton alloc] initWithFrame:CGRectMake(67, 434, 30, 30)];
        a25.showsTouchWhenHighlighted = YES;  
        a25.userInteractionEnabled = YES;
        [a25 addGestureRecognizer:tap25];
        [self.view addSubview:a25];         
        
        TapGestureRecognizer *tap26 = [TapGestureRecognizer alloc];
        [tap26 init:self action:@selector(changeBrushColor:) tag:26];
        a26 = [[UIButton alloc] initWithFrame:CGRectMake(67, 473, 30, 30)];
        a26.showsTouchWhenHighlighted = YES;  
        a26.userInteractionEnabled = YES;
        [a26 addGestureRecognizer:tap26];
        [self.view addSubview:a26];         
        
        TapGestureRecognizer *tap27 = [TapGestureRecognizer alloc];
        [tap27 init:self action:@selector(changeBrushColor:) tag:27];
        a27 = [[UIButton alloc] initWithFrame:CGRectMake(67, 508, 30, 30)];
        a27.showsTouchWhenHighlighted = YES;  
        a27.userInteractionEnabled = YES;
        [a27 addGestureRecognizer:tap27];
        [self.view addSubview:a27];         
        
        TapGestureRecognizer *tap28 = [TapGestureRecognizer alloc];
        [tap28 init:self action:@selector(changeBrushColor:) tag:28];
        a28 = [[UIButton alloc] initWithFrame:CGRectMake(67, 544, 30, 30)];
        a28.showsTouchWhenHighlighted = YES;  
        a28.userInteractionEnabled = YES;
        [a28 addGestureRecognizer:tap28]; 
        [self.view addSubview:a28];         
        
        TapGestureRecognizer *tap29 = [TapGestureRecognizer alloc];
        [tap29 init:self action:@selector(changeBrushColor:) tag:29];
        a29 = [[UIButton alloc] initWithFrame:CGRectMake(67, 580, 30, 30)];
        a29.showsTouchWhenHighlighted = YES;  
        a29.userInteractionEnabled = YES;
        [a29 addGestureRecognizer:tap29];
        [self.view addSubview:a29];         
        
        TapGestureRecognizer *tap30 = [TapGestureRecognizer alloc];
        [tap30 init:self action:@selector(changeBrushColor:) tag:30];
        a30 = [[UIButton alloc] initWithFrame:CGRectMake(67, 615, 30, 30)];
        a30.showsTouchWhenHighlighted = YES;  
        a30.userInteractionEnabled = YES;
        [a30 addGestureRecognizer:tap30];
        [self.view addSubview:a30];         
        
        TapGestureRecognizer *tap31 = [TapGestureRecognizer alloc];
        [tap31 init:self action:@selector(changeBrushColor:) tag:31];
        a31 = [[UIButton alloc] initWithFrame:CGRectMake(67, 651, 30, 30)];
        a31.showsTouchWhenHighlighted = YES;  
        a31.userInteractionEnabled = YES;
        [a31 addGestureRecognizer:tap31];
        [self.view addSubview:a31];         
        
        TapGestureRecognizer *tap01 = [TapGestureRecognizer alloc];
        [tap01 init:self action:@selector(changeBrushtype:) tag:41];
        b1 = [[UIButton alloc] initWithFrame:CGRectMake(939, 136,85, 75)];
   //sdds     [b1 setImage:[UIImage imageNamed:@"huabi1.png"] forState:UIControlStateNormal] ;
        b1.showsTouchWhenHighlighted = YES;  
        b1.userInteractionEnabled = YES;
        [b1 addGestureRecognizer:tap01];
        [self.view addSubview:b1];         
        
        TapGestureRecognizer *tap02 = [TapGestureRecognizer alloc];
        [tap02 init:self action:@selector(changeBrushtype:) tag:42];
        b2 = [[UIButton alloc] initWithFrame:CGRectMake(939, 223, 85, 75)];
  //       [b2 setImage:[UIImage imageNamed:@"huabi2.png"] forState:UIControlStateNormal] ;
        b2.showsTouchWhenHighlighted = YES;  
        b2.userInteractionEnabled = YES;
        [b2 addGestureRecognizer:tap02]; 
        [self.view addSubview:b2];         
        
        TapGestureRecognizer *tap03 = [TapGestureRecognizer alloc];
        [tap03 init:self action:@selector(changeBrushtype:) tag:43];
        b3 = [[UIButton alloc] initWithFrame:CGRectMake(939, 304, 85, 75)];
  //       [b3 setImage:[UIImage imageNamed:@"huabi3.png"] forState:UIControlStateNormal] ;        
        b3.showsTouchWhenHighlighted = YES;  
        b3.userInteractionEnabled = YES;
        [b3 addGestureRecognizer:tap03];
        [self.view addSubview:b3];         
        
        TapGestureRecognizer *tap04 = [TapGestureRecognizer alloc];
        [tap04 init:self action:@selector(changeBrushtype:) tag:44];
        b4 = [[UIButton alloc] initWithFrame:CGRectMake(939,394, 85, 75)];
 ///[b4 setImage:[UIImage imageNamed:@"huabi4.png"] forState:UIControlStateNormal] ;
        
        b4.showsTouchWhenHighlighted = YES;  
        b4.userInteractionEnabled = YES;
        [b4 addGestureRecognizer:tap04];
        [self.view addSubview:b4];         
        
        TapGestureRecognizer *tap05 = [TapGestureRecognizer alloc];
        [tap05 init:self action:@selector(changeBrushtype:) tag:45];
        b5 = [[UIButton alloc] initWithFrame:CGRectMake(939, 495, 85, 75)];
      //  [b5 setImage:[UIImage imageNamed:@"huabi5.png"] forState:UIControlStateNormal] ; 
        b5.showsTouchWhenHighlighted = YES;  
        b5.userInteractionEnabled = YES;
        [b5 addGestureRecognizer:tap05];
        [self.view addSubview:b5];  
        
        
        
        

        
        
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
                                                [NSArray arrayWithObjects:
                                                 @"Red",
                                                 @"Yellow",
                                                 @"Green",
                                                 @"Blue",
                                                 @"Purple",
                                                 nil]];
        CGRect frame = CGRectMake(939, 595, 85, 75);
        segmentedControl.frame = frame;
        [segmentedControl addTarget:self action:@selector(changeBrushColor:) forControlEvents:UIControlEventValueChanged];
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        segmentedControl.tintColor = [UIColor darkGrayColor];
        segmentedControl.selectedSegmentIndex = 2;
        [drawingView setBrushColorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
      //[self.view addSubview:segmentedControl];
     //   [segmentedControl release];
        
        
        
        
        
        
        UISegmentedControl *segtyle = [[UISegmentedControl alloc] initWithItems:
                                       [NSArray arrayWithObjects:
                                        @"铅笔",
                                        @"毛笔",
                                        @"蜡笔",
                                        @"粉笔",
                                        @"钢笔",
                                        nil]];
        CGRect tframe = CGRectMake(80,750,600,40);
        segtyle.frame = tframe;
        [segtyle addTarget:self action:@selector(changeBrushtype:) forControlEvents:UIControlEventValueChanged];
        segtyle.segmentedControlStyle = UISegmentedControlStyleBar;
        segtyle.tintColor = [UIColor darkGrayColor];
        segtyle.selectedSegmentIndex = 1;
        [drawingView setBrushTypeWithtag:1];
    // [self.view addSubview:segtyle];
   //     [segtyle release];
        
        
        //最下方5个按钮 
        
        //返回按钮
        UIButton *rebutton = [[UIButton alloc] init];
        rebutton.frame = CGRectMake(695, 40, 40, 40);
        //原大小：CGRectMake(190, 950, 95, 50);
        //rebutton.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        //[rebutton.titleLabel setTextColor:[UIColor blueColor]];
        //rebutton.backgroundColor = [UIColor lightGrayColor];
        //[rebutton setTitle:@"返回" forState:0];
        //添加图片
      //  [rebutton setBackgroundImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
        rebutton.showsTouchWhenHighlighted = YES;
        [rebutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        rebutton.tag = 1;
        [self.view addSubview:rebutton]; 
    //    [rebutton release];                
        
    /*    UIButton *colorbutton = [[UIButton alloc] init];
        colorbutton.frame = CGRectMake(190, 940, 80, 80);   
        //原大小：CGRectMake(190, 950, 95, 50);
        //colorbutton.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        //[colorbutton setTitle:@"颜色" forState:0];
        //[colorbutton.titleLabel setTextColor:[UIColor blueColor]];
        //colorbutton.backgroundColor = [UIColor lightGrayColor];
        
     //   [colorbutton setBackgroundImage:[UIImage imageNamed:@"colors.png"] forState:UIControlStateNormal];
        
        colorbutton.showsTouchWhenHighlighted = YES;
        [colorbutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        colorbutton.tag = 2;
       // [self.view addSubview:colorbutton]; 
   //     [colorbutton release];
*/
        
        UIButton *easebutton = [[UIButton alloc] init];
        easebutton.frame = CGRectMake(393, 495, 85, 75);
        //easebutton.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        //[easebutton.titleLabel setTextColor:[UIColor blueColor]];
        //easebutton.backgroundColor = [UIColor lightGrayColor];
        //[easebutton setTitle:@"清空" forState:0];
        
       // [easebutton setBackgroundImage:[UIImage imageNamed:@"erase.png"] forState:UIControlStateNormal];
        
         easebutton.showsTouchWhenHighlighted = YES;
        [easebutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
         easebutton.tag = 3;
     //    [self.view addSubview:easebutton]; 
   //     [easebutton release];

        
        UIButton *selectbutton = [[UIButton alloc] init];
        selectbutton.frame = CGRectMake(774, 40, 40,40);
        //selectbutton.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        //[selectbutton.titleLabel setTextColor:[UIColor blueColor]];
        //selectbutton.backgroundColor = [UIColor lightGrayColor];
        //[selectbutton setTitle:@"选择" forState:0];
        
      //  [selectbutton setBackgroundImage:[UIImage imageNamed:@"choose.png"] forState:UIControlStateNormal];
        
        selectbutton.showsTouchWhenHighlighted = YES;
        [selectbutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        selectbutton.tag = 4;
        [self.view addSubview:selectbutton]; 
     //   [selectbutton release];
        
        UIButton *cabutton = [[UIButton alloc] init];
        cabutton.frame = CGRectMake(939, 595, 105, 75);
        //cabutton.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        //[cabutton.titleLabel setTextColor:[UIColor blueColor]];
        //cabutton.backgroundColor = [UIColor lightGrayColor];
        //[cabutton setTitle:@"擦除" forState:0];
        
       // [cabutton setBackgroundImage:[UIImage imageNamed:@"ca.png"] forState:UIControlStateNormal];
        
        cabutton.showsTouchWhenHighlighted = YES;
        [cabutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        cabutton.tag = 5;
        [self.view addSubview:cabutton]; 
     //   [cabutton release];
        
        
        UIButton *savebutton = [[UIButton alloc] init];
        savebutton.frame = CGRectMake(853, 40, 40,40);
        //selectbutton.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        //[selectbutton.titleLabel setTextColor:[UIColor blueColor]];
        //selectbutton.backgroundColor = [UIColor lightGrayColor];
        //[selectbutton setTitle:@"选择" forState:0];
        
        //  [selectbutton setBackgroundImage:[UIImage imageNamed:@"choose.png"] forState:UIControlStateNormal];
        
        savebutton.showsTouchWhenHighlighted = YES;
        [savebutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        savebutton.tag = 2;
        [self.view addSubview:savebutton]; 
        
        

    }
    return self;
}



-(UIImage *) glToUIImage 
{
    NSInteger myDataLength = 1024 * 768 * 4;
    
    // allocate array and read pixels into it.
    GLubyte *buffer = (GLubyte *) malloc(myDataLength);
    glReadPixels(-140, -140, 1024, 768, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
    
    // gl renders "upside down" so swap top to bottom into new array.
    // there's gotta be a better way, but this works.
    GLubyte *buffer2 = (GLubyte *) malloc(myDataLength);
  
    for(int y = 0; y <768; y++)
    {
        for(int x = 0; x <1024 * 4; x++)
        {
            if(buffer[y * 4 * 1024 + x]!=0)
            {
            buffer2[(767 - y) * 1024 * 4 + x] = buffer[y * 4 * 1024 + x];
            }
            else {
                buffer2[(767 - y) * 1024 * 4 + x]=0;
            }
           
        }
    }
    
    // make data provider with data.
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer2, myDataLength, NULL);
    
    // prep the ingredients
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4 * 1024;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    // make the cgimage
    CGImageRef imageRef = CGImageCreate(1024, 768, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
    
    // then make the uiimage from that
    UIImage *myImage = [UIImage imageWithCGImage:imageRef];
    return myImage;
}  
   
    


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo; 

{
    
    if (!error) 
        {
            UIAlertView *alert1=[[UIAlertView alloc] initWithTitle:nil message:@"保存图片成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
        }
        
    
    else
    {
        UIAlertView *alert2=[[UIAlertView alloc] initWithTitle:nil message:@"保存图片失败" delegate:self cancelButtonTitle:@"error" otherButtonTitles:nil];
        [alert2 show];
    }
     
    
}


-(void)buttonClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    switch (btn.tag)
    {
        case 1:
        
            [(ViewController*)CBAppDelegate.viewController  dismissModalViewControllerAnimated:YES];
            break;
        case 2:
            
        {
            
            
            
         
                               
            UIImage *image = [self glToUIImage];
            
            
         /*  UIImage  *frontImage =backView.image; 
            UIGraphicsBeginImageContext(self.view.bounds.size);  
            [frontImage drawAtPoint:CGPointMake(0,0)];  
            [image drawAtPoint:CGPointMake(0,0)];  
         //   UIImage *image = UIGraphicsGetImageFromCurrentImageContext();  
            UIGraphicsEndImageContext();
          
          */
       //     [drawingView addSubview:[[UIImageView alloc] initWithImage:image]];
        
             
    
     
            
       /*   CGRect rect =drawingView.frame;            
      //    CGRect rect = self.view.frame;
            UIGraphicsBeginImageContext(rect.size);
            CGContextRef context =UIGraphicsGetCurrentContext();
        
            [drawingView.layer renderInContext:context];
            UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();            
*/
                    
         
     UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
         
               
            // create the ColorPicker with iPad layout
       /*     ColorPicker *picker=[[ColorPicker alloc] initWithNibName:@"ColorPicker_iPad" bundle:nil Tag:1 Color:color];
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
        //    [picker release], 
            picker=nil;*/
            break;
        }
        case 3:
            [drawingView erase];
            break;
        case 4:
        {
            //backView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3];
            imageNum +=1;
            if (imageNum>8)
            {
                imageNum=1;
            }
           backView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hbg%d.png",imageNum]];
           smallView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hbg%d.png",imageNum]];
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
   // UISegmentedControl *seg = (UISegmentedControl*)sender;
    TapGestureRecognizer *tap = (TapGestureRecognizer*)sender;
    int tag = tap.tag;  
    switch (tag)
    {
        case 41:
             [drawingView setBrushTypeWithtag:0];
            break;
        case 42:
             [drawingView setBrushTypeWithtag:1];
            break;   
        case 43:
            [drawingView setBrushTypeWithtag:2];
            break;
        case 44:
            [drawingView setBrushTypeWithtag:3];
            break; 
        case 45:
            [drawingView setBrushTypeWithtag:4];
            break;    
            
        default:
            break;
    }
    //   [drawingView setBrushTypeWithtag:[seg selectedSegmentIndex]];
}
// Change the brush color
- (void)changeBrushColor:(id)sender
{
    [drawingView changeBlendMode:NO];
   // UISegmentedControl *seg = (UISegmentedControl*)sender;
    
    TapGestureRecognizer *tap = (TapGestureRecognizer*)sender;
    int tag = tap.tag;
    
    
    
    switch (tag) 
    {
        case 0:
            [drawingView setBrushColorWithRed:(float)247/255 green:(float)197/255 blue:(float)180/255 alpha:1.0];
            break;
        case 01:
            [drawingView setBrushColorWithRed:(float)238/255 green:(float)154/255 blue:(float)133/255 alpha:1.0];
            break;
        case 2:
            [drawingView setBrushColorWithRed:(float)227/255 green:(float)85/255 blue:(float)106/255 alpha:1.0];
       
            break;
        case 3:
            [drawingView setBrushColorWithRed:(float)218/255 green:(float)37/255 blue:(float)29/255 alpha:1.0];
            break;
        case 4:
            [drawingView setBrushColorWithRed:(float)173/255 green:(float)41/255 blue:(float)47/255 alpha:1.0];
            break;
        case 5:
            [drawingView setBrushColorWithRed:(float)255/255 green:(float)251/255 blue:(float)177/255 alpha:1.0];
            break;
        case 6:
            [drawingView setBrushColorWithRed:(float)255/255 green:(float)249/255 blue:(float)116/255 alpha:1.0];
            break;
        case 7:
            [drawingView setBrushColorWithRed:1.0 green:(float)245/255 blue:0.0 alpha:1.0];
            break;
        case 8:
            [drawingView setBrushColorWithRed:(float)243/255 green:(float)174/255 blue:0.0 alpha:1.0];
            break;
        case 9:
            [drawingView setBrushColorWithRed:(float)231/255 green:(float)120/255 blue:(float)23/255 alpha:1.0];
            break;
        case 10:
            [drawingView setBrushColorWithRed:(float)179/255 green:(float)222/255 blue:(float)248/255 alpha:1.0];
            break;
        case 11:
            [drawingView setBrushColorWithRed:(float)117/255 green:(float)197/255 blue:(float)240/255 alpha:1.0];
            break;
        case 12:
            [drawingView setBrushColorWithRed:0.0 green:(float)163/255 blue:(float)228/255 alpha:1.0];
            break;
        case 13:
            [drawingView setBrushColorWithRed:0.0 green:(float)124/255 blue:(float)195/255 alpha:1.0];
            break;
        case 14:
            [drawingView setBrushColorWithRed:(float)34/255 green:(float)57/255 blue:(float)113/255 alpha:1.0];
            break;
        case 15:
            [drawingView setBrushColorWithRed:(float)31/255 green:(float)26/255 blue:(float)23/255 alpha:1.0];
            break;
        case 16:
            [drawingView setBrushColorWithRed:(float)238/255 green:(float)154/255 blue:(float)105/255 alpha:1.0];
            break;
        case 17:
            [drawingView setBrushColorWithRed:(float)239/255 green:(float)154/255 blue:(float)72/255 alpha:1.0];
            break;
        case 18:
            [drawingView setBrushColorWithRed:(float)231/255 green:(float)120/255 blue:(float)68/255 alpha:1.0];
            break;
        case 19:
            [drawingView setBrushColorWithRed:(float)183/255 green:(float)103/255 blue:(float)60/255 alpha:1.0];
            break;            
        case 20:
            [drawingView setBrushColorWithRed:(float)143/255 green:(float)84/255 blue:(float)68/255 alpha:1.0];
            break;
        case 21:
            [drawingView setBrushColorWithRed:(float)183/255 green:(float)220/255 blue:(float)160/255 alpha:1.0];
            break;
        case 22:
            [drawingView setBrushColorWithRed:(float)156/255 green:(float)206/255 blue:(float)89/255 alpha:1.0];
            break;
        case 23:
            [drawingView setBrushColorWithRed:(float)132/255 green:(float)194/255 blue:(float)37/255 alpha:1.0];
            break;
        case 24:
            [drawingView setBrushColorWithRed:(float)5/255 green:(float)147/255 blue:(float)65/255 alpha:1.0];
            break;
        case 25:
            [drawingView setBrushColorWithRed:0.0 green:(float)100/255 blue:(float)55/255 alpha:1.0];
            break;
        case 26:
            [drawingView setBrushColorWithRed:(float)241/255 green:(float)154/255 blue:(float)190/255 alpha:1.0];
            break;
        case 27:
            [drawingView setBrushColorWithRed:(float)221/255 green:(float)19/255 blue:(float)123/255 alpha:1.0];
            break;
        case 28:
            [drawingView setBrushColorWithRed:(float)186/255 green:(float)143/255 blue:(float)186/255 alpha:1.0];
            break;
        case 29:
            [drawingView setBrushColorWithRed:(float)163/255 green:(float)77/255 blue:(float)142/255 alpha:1.0];
            break;
        case 30:
            [drawingView setBrushColorWithRed:(float)149/255 green:(float)27/255 blue:(float)103/255 alpha:1.0];
            break;
        case 31:
            [drawingView setBrushColorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
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
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);    
	//return (interfaceOrientation==UIInterfaceOrientationPortrait  || interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}

@end
