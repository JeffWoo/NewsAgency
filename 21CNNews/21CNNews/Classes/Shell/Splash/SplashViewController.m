/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: SplashViewController.m
 *
 * Description	: 启动画面view controller
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import "SplashViewController.h"
#import "SplashManager.h"
#import <UIKit/UIKit.h>

@interface SplashViewController ()

@end

@implementation SplashViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView* splashImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    splashImageView.image = [[SplashManager shareInstance] getSplashImage];
    
    [self.view addSubview:splashImageView];
    
    [splashImageView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
