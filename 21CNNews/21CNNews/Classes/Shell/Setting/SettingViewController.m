/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: SettingViewController.m
 *
 * Description	: 系统设置view controller
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import "SettingViewController.h"
#import "SettingTableViewController.h"
#import "UITitleView.h"
#import "ResManager.h"
#import "SettingCellSelectedHandle.h"

@interface SettingViewController ()

@property (nonatomic, retain) UITitleView* titleView;       ///< 系统设置界面标题栏
@property (nonatomic, retain) SettingTableViewController* tableViewController;  ///< 系统设置tableview controller
@property (nonatomic, retain) SettingCellSelectedHandle* handle;    ///< 系统设置命令处理器

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
    [self retain];  ///< retain+1是为了使得系统设置界面能够实现生命周期自管理，当系统设置界面收起时，将对其进行release，从而析构自己
}


- (void)backButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:^()
     {
         [self release];    ///< 对应- (void)showInUIViewController:(UIViewController*)parentViewController 中的[sele retain]
     }];
}

@end
