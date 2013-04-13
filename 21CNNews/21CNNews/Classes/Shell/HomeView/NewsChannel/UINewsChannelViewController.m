//
//  UINewsChannelViewController.m
//  Shell
//
//  Created by chenggk on 13-4-4.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "UINewsChannelViewController.h"
#import "UINewsChannelTitleView.h"
#import "UINewsChannelTableViewController.h"
#import "HotNewListViewController.h"
#import "ResManager.h"

@interface UINewsChannelViewController ()

@property (nonatomic, retain) UIImageView* bgImageView;
@property (nonatomic, retain) UINewsChannelTitleView* titleView;
@property (nonatomic, retain) UINewsChannelTableViewController* tableViewController;
@property (nonatomic, retain) HotNewListViewController* hotNewListViewController;

@end


@implementation UINewsChannelViewController

- (void)dealloc
{
    [_bgImageView release];
    [_titleView release];
    [_tableViewController release];
    [_hotNewListViewController release];
    
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.bgImageView = [[[UIImageView alloc] initWithFrame:self.view.bounds] autorelease];
    self.bgImageView.image = [resGetImage(@"home/left/leftViewBgImage.png") stretchableImageWithLeftCapWidth:160 topCapHeight:200];
    [self.view addSubview:self.bgImageView];
    
    self.titleView = [[[UINewsChannelTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 45, 44)] autorelease];
    [self.view addSubview:self.titleView];
    
    self.tableViewController = [[[UINewsChannelTableViewController alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width - 45, self.view.frame.size.height - 154)] autorelease];
    [self.view addSubview:self.tableViewController.view];
    
    self.hotNewListViewController = [[HotNewListViewController alloc] init];
    [self.hotNewListViewController showInView:self.view frame:CGRectMake(0, self.view.frame.size.height - 110, self.view.frame.size.width - 45, 110)];
    
    
    
}


@end
