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

@interface UINewsChannelViewController ()

@property (nonatomic, retain) UINewsChannelTitleView* titleView;
@property (nonatomic, retain) UINewsChannelTableViewController* tableViewController;

@end


@implementation UINewsChannelViewController

- (void)dealloc
{
    [_titleView release];
    [_tableViewController release];
    
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleView = [[[UINewsChannelTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 60, 66)] autorelease];
    
    self.tableViewController = [[[UINewsChannelTableViewController alloc] initWithFrame:CGRectMake(0, 66, self.view.frame.size.width - 60, 300)] autorelease];
    
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.tableViewController.view];
}


@end
