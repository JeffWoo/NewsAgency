/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: MainFrameViewController.m
 *
 * Description	: 主界面view controller，主页、系统设置界面等均是加载在该view controller中
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import "MainFrameViewController.h"
#import "HomeViewController.h"
#import "NSNotificationCenterKeys.h"
#import "SettingViewController.h"

@interface MainFrameViewController ()

@property (nonatomic, retain) HomeViewController* homeViewController;   ///< 主页view controller

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
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
- (void)showSettingView ///< 弹出系统设计界面
{
    SettingViewController* settingViewControll = [[[SettingViewController alloc] init] autorelease];
    [settingViewControll showInUIViewController:self];
}

@end
