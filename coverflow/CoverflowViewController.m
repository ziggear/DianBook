//
//  CoverflowViewController.m
//  iHouseA
//
//  Created by Visible Chinese Human on 11-10-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CoverflowViewController.h"
#import "AppDelegate.h"
//#import "ViewController.h"

@implementation CoverflowViewController
@synthesize flowCoverView,label,imgStr;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        flowCoverView = [[FlowCoverView alloc] initWithFrame:CGRectMake(0, 0, 1024,768)];
       flowCoverView.backgroundColor = [UIColor blackColor];
        flowCoverView.delegate = self;
        // Custom initialization
        self.view = flowCoverView;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(400, 100, 220, 40)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:32];
        label.textColor = [UIColor whiteColor];
        [self.view addSubview:label];    
        
        imgStr = [[NSString alloc] init];

    }
    return self;
}

- (void)dealloc
{
    [imgStr release];
    [flowCoverView release];
    [label release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)setImageNumber:(int)number currentPage:(int)current imageName:(NSString*)str
{
    imageNumber = number;
    currentPage = current;
    imgStr = str;
}
/************************************************************************/
/*																		*/
/*	FlowCover Callbacks													*/
/*																		*/
/************************************************************************/

- (int)flowCoverNumberImages:(FlowCoverView *)view
{
	return imageNumber;
}

- (UIImage *)flowCover:(FlowCoverView *)view cover:(int)image
{
//    int a,b,c,d;
//    a = image/1000;
//    b = (image%1000)/100;
//    c = (image%100)/10;
//    d = image%10;
//    NSString *imagename = [NSString stringWithFormat:@"%@%d%d%d%d.jpg",imgStr,a,b,c,d];     
//    return [UIImage imageNamed:imagename];
    NSString *imagename = [NSString stringWithFormat:@"cover_%d.jpg",image];
    return [UIImage imageNamed:imagename];
}

-(void)flowCover:(FlowCoverView*)view imageIndex:(int)index
{
    label.text = [NSString stringWithFormat:@"第%d页/共%d页",index+1,imageNumber];
}

- (void)flowCover:(FlowCoverView *)view didSelect:(int)image
{
    if (image >= 0) {
        image++;
    }
    label.text = [NSString stringWithFormat:@"第%d页/共%d页",image+1,imageNumber];
    //[(ViewController*)CBAppDelegate.viewController changeCurrentPageIndex:image];
    //[(ViewController*)CBAppDelegate.viewController  dismissModalViewControllerAnimated:YES];
	NSLog(@"Selected Index %d",image);
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
   
    flowCoverView.offset = currentPage;
  
    label.text = [NSString stringWithFormat:@"第%d页/共%d页",currentPage+1,imageNumber];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation==UIInterfaceOrientationLandscapeRight)
    {
        flowCoverView.frame = CGRectMake(0, 0, 1024, 768);
        label.frame = CGRectMake(400, 110, 220, 40);
    }else
    {
        flowCoverView.frame = CGRectMake(0, 0, 768, 1024);
        label.frame = CGRectMake(274, 180, 220, 40);
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
