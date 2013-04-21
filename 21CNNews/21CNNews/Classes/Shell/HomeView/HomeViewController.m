/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: HomeViewController.m
 *
 * Description	: 主页view controller
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import "HomeViewController.h"
#import "UISideBarViewController.h"
#import "UINewsChannelViewController.h"
#import "NewsListViewController.h"
#import "UIUserInfoViewController.h"

@interface HomeViewController ()

@property (nonatomic, retain) UISideBarViewController* sideBarController;       ///< 主页三屏基础控件
@property (nonatomic, retain) UINewsChannelViewController* leftController;      ///< 左屏：频道列表，热点新闻
@property (nonatomic, retain) NewsListViewController* mainController;           ///< 中间屏：新闻列表
@property (nonatomic, retain) UIUserInfoViewController* rightController;        ///< 右屏：用户信息

@end

@implementation HomeViewController


- (void)dealloc
{
    [self releaseAll];
    [super dealloc];
}


- (void)releaseAll
{
    _leftController.delegate = nil;    
    [_leftController release];
    _leftController = nil;
    
    _mainController.delegate = nil;
    [_mainController release];
    _mainController = nil;
    
    _rightController.delegate = nil;
    [_rightController release];
    _rightController = nil;
    
    [_sideBarController release];
    _sideBarController = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_sideBarController)
    {
        CGSize size = self.view.frame.size;
        CGRect frame = CGRectMake(0, 0, size.width, size.height);
        
        _mainController = [[NewsListViewController alloc] init];
        _mainController.view.frame = frame;
        
        _leftController = [[UINewsChannelViewController alloc] init];
        _leftController.view.frame = frame;
        
        _rightController = [[UIUserInfoViewController alloc] init];
        _rightController.view.frame = frame;
        
        _sideBarController = [[UISideBarViewController alloc] init];
        _sideBarController.view.frame = frame;
        _sideBarController.leftSideBarViewController = _leftController;
        _leftController.delegate = _sideBarController;
        
        _sideBarController.rightSideBarViewController = _rightController;
        _rightController.delegate = _sideBarController;
        
        _sideBarController.contentViewController = _mainController;
        _mainController.delegate = _sideBarController;
        
        _sideBarController.contentOffset = 45.0f;
        [self.view addSubview:_sideBarController.view];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [self releaseAll];
}

@end
