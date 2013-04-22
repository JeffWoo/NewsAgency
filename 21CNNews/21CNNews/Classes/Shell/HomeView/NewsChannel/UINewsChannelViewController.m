/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: UINewsChannelViewController.m
 *
 * Description	: 新闻频道view controller
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/4, chenggk, Create the file
 ***************************************************************************************
 **/

#import "UINewsChannelViewController.h"
#import "UINewsChannelTitleView.h"
#import "UINewsChannelTableViewController.h"
#import "HotNewListViewController.h"
#import "ResManager.h"

@interface UINewsChannelViewController ()

@property (nonatomic, retain) UIImageView* bgImageView;
@property (nonatomic, retain) UINewsChannelTitleView* titleView;                        ///< 标题栏
@property (nonatomic, retain) UINewsChannelTableViewController* tableViewController;    ///< 新闻频道列表
@property (nonatomic, retain) HotNewListViewController* hotNewListViewController;       ///< 热点新闻

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
