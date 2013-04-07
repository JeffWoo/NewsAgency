//
//  SplashViewController.m
//  Shell
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

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
