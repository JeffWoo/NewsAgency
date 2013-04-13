//
//  SettingViewController.m
//  Shell
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewController.h"
#import "UITitleView.h"
#import "ResManager.h"
#import "SettingCellSelectedHandle.h"

@interface SettingViewController ()

@property (nonatomic, retain) UITitleView* titleView;
@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) SettingTableViewController* tableViewController;
@property (nonatomic, retain) SettingCellSelectedHandle* handle;

@end


@implementation SettingViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        _handle = [[SettingCellSelectedHandle alloc] init];
        
    }
    
    return self;
}


- (void)dealloc
{
    [_handle release];
    
    [self releaseAllView];
    
    [super dealloc];
}


- (void)releaseAllView
{
    [_titleView addLeftButonTarget:self action:nil forControlEvents:UIControlEventAllEvents];
    [_titleView addRightButonTarget:self action:nil forControlEvents:UIControlEventAllEvents];
    [_titleView release];
    _titleView = nil;
    
    [_tableViewController release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_titleView)
    {
        _titleView = [[UITitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
        _titleView.backgroundColor = [UIColor yellowColor];
        [_titleView setTitleText:@"设置"];
        [_titleView setLeftButtonImage:resGetImage(@"blueArrow.png") frame:CGRectMake(0, 0, 44, 44)];
        [_titleView addLeftButonTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_titleView];
        
        _tableViewController = [[SettingTableViewController alloc] init];
        _tableViewController.view.frame = CGRectMake(0, _titleView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - 30);
        [_tableViewController showInView:self.view];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)showInUIViewController:(UIViewController*)parentViewController
{
    if (!parentViewController)
    {
        return;
    }
    
    [parentViewController presentViewController:self animated:YES completion:nil];
    [self retain];
}


- (void)backButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:^()
     {
         [self release];
     }];
}

@end
