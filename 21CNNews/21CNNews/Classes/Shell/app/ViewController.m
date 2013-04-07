//
//  ViewController.m
//  21CNNews
//
//  Created by chenggk on 13-4-3.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "ViewController.h"
#import "MainFrameViewController.h"
#import "InitManager.h"

@interface ViewController ()

@property (nonatomic, retain) MainFrameViewController* mainFrameViewController;

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        [[InitManager shareInstance] initJob];
    }
    
    return self;
}

- (void)dealloc
{
    [_mainFrameViewController release];
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
 
    if (!_mainFrameViewController)
    {
        CGSize size = self.view.frame.size;
        CGRect frame = CGRectMake(0, 0, size.width, size.height);
        
        _mainFrameViewController = [[MainFrameViewController alloc] init];
        _mainFrameViewController.view.frame = frame;
        [self.view addSubview:_mainFrameViewController.view];
    }    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [_mainFrameViewController release];
    _mainFrameViewController = nil;
}



- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
//    [self.sideBarController didRotateFromInterfaceOrientation];
//    [[NSNotificationCenter defaultCenter] postNotificationName:DidRotateFromInterfaceOrientation object:self userInfo:nil];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{    
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

//for ios6
- (BOOL)shouldAutorotate
{
    return YES;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


@end
