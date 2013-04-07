//
//  HomeViewController.m
//  Shell
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "HomeViewController.h"
#import "UISideBarViewController.h"
#import "UINewsChannelViewController.h"
#import "NewsListViewController.h"

@interface HomeViewController ()

@property (nonatomic, retain) UISideBarViewController* sideBarController;
@property (nonatomic, retain) UINewsChannelViewController* leftController;
@property (nonatomic, retain) NewsListViewController* mainController;
@property (nonatomic, retain) UISideBarSubViewController* rightController;

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
        _mainController.view.backgroundColor = [UIColor redColor];
        
        _leftController = [[UINewsChannelViewController alloc] init];
        _leftController.view.frame = frame;
        _leftController.view.backgroundColor = [UIColor blueColor];
        
        _rightController = [[UISideBarSubViewController alloc] init];
        _rightController.view.frame = frame;
        _rightController.view.backgroundColor = [UIColor yellowColor];
        
        _sideBarController = [[UISideBarViewController alloc] init];
        _sideBarController.view.frame = frame;
        _sideBarController.leftSideBarViewController = _leftController;
        _leftController.delegate = _sideBarController;
        
        _sideBarController.rightSideBarViewController = _rightController;
        _rightController.delegate = _sideBarController;
        
        _sideBarController.contentViewController = _mainController;
        _mainController.delegate = _sideBarController;
        
        _sideBarController.contentOffset = 60.0f;
        [self.view addSubview:_sideBarController.view];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [self releaseAll];
}

@end
