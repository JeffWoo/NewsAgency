//
//  MainFrameViewController.m
//  Shell
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "MainFrameViewController.h"
#import "HomeViewController.h"
#import "NSNotificationCenterKeys.h"
#import "SettingViewController.h"

@interface MainFrameViewController ()

@property (nonatomic, retain) HomeViewController* homeViewController;

@end



@implementation MainFrameViewController

@synthesize homeViewController = _homeViewController;


- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSettingView) name:ShowSettingViewNotification object:nil];
    }
    
    return self;
}


- (void)dealloc
{
    [_homeViewController release];
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_homeViewController)
    {
        _homeViewController = [[HomeViewController alloc] init];
        _homeViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view addSubview:_homeViewController.view];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [_homeViewController release];
    _homeViewController = nil;
}


#pragma mark notification call back function
- (void)showSettingView
{
    SettingViewController* settingViewControll = [[[SettingViewController alloc] init] autorelease];
    [settingViewControll showInUIViewController:self];
}

@end
