//
//  NewsListViewController.m
//  Shell
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "NewsListViewController.h"
#import "ArticlelistViewController.h"
#import "ImageListViewController.h"
#import "NewsListManager.h"
#import "UITitleView.h"
#import "ResManager.h"
#import "NSNotificationCenterKeys.h"
#import "NewsChannelObject.h"
#import "NewsChannelManager.h"
#import "NewChannelNotificationKeys.h"
#import "AriticleListViewDelegate.h"
#import "NewsContentViewer.h"

@interface NewsListViewController ()<AriticleListViewDelegate>

@property (nonatomic, retain) UITitleView* titleView;
@property (nonatomic, retain) ArticlelistViewController* articlelistViewController;
@property (nonatomic, retain) ImageListViewController* imageListViewController;

@end

@implementation NewsListViewController

@synthesize articlelistViewController = _articlelistViewController;
@synthesize titleView = _titleView;


- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNewsChannelChanged:) name:DidNewsChannelChanged object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNewsChannelListUpdata:) name:kDidNewsChannelListUpdata object:nil];
        [[NewsListManager shareInstance] loadData:0];
    }
    
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self releaseAll];
    [super dealloc];
}


- (void)releaseAll
{
    [_titleView addLeftButonTarget:self action:nil forControlEvents:UIControlEventAllEvents];
    [_titleView addRightButonTarget:self action:nil forControlEvents:UIControlEventAllEvents];
    [_titleView release];
    _titleView = nil;
    
    [_articlelistViewController release];
    _articlelistViewController = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!_titleView)
    {
        _titleView = [[UITitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 48)];
        _titleView.backgroundColor = [UIColor yellowColor];
        [_titleView setTitleText:@"头条"];
        [_titleView setLeftButtonImage:resGetImage(@"blueArrow.png")];
        [_titleView addLeftButonTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [_titleView setRightButtonImage:resGetImage(@"blueArrow.png")];
        [_titleView addRightButonTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_titleView];
    }
    
    if (!_articlelistViewController && !_imageListViewController)
    {
        [self initData];
    }
}


- (void)initData
{
    NewsChannelObject* channelObject = [[NewsChannelManager shareInstance] getDefaultChannel];
    if (!channelObject)
    {
        return;
    }
    
    [self loadChannel:channelObject];
}


- (void)createArticlelistViewControllerIfNeed
{
    if (_articlelistViewController)
    {
        return;
    }
    
    _articlelistViewController = [[ArticlelistViewController alloc] init];
    _articlelistViewController.delegate = self;
    [_articlelistViewController showInViwe:self.view frame:CGRectMake(0, 48, self.view.frame.size.width, self.view.frame.size.height - 48)];
}


- (void)createImageListViewController
{
    if (_imageListViewController)
    {
        return;
    }
    
    _imageListViewController = [[ImageListViewController alloc] init];
    [_imageListViewController showInViwe:self.view frame:CGRectMake(0, 48, self.view.frame.size.width, self.view.frame.size.height - 48)];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [self releaseAll];
}


- (void)leftButtonClicked
{
    [self.delegate notifyGoToLeft:self];
}


- (void)rightButtonClicked
{
    [self.delegate notifyGoToRight:self];
}


- (void)loadChannel:(NewsChannelObject*)channelObject
{
    switch (channelObject.articleType)
    {
        case NewsChannelArticleTypeNormal:
        {
            [self createArticlelistViewControllerIfNeed];
            [self.imageListViewController.view removeFromSuperview];
            [self.articlelistViewController loadChannel:channelObject];
            [self.view addSubview:self.articlelistViewController.view];
        }
            break;
        case NewsChannelArticleTypeImage:
        {
            [self createImageListViewController];
            [self.articlelistViewController.view removeFromSuperview];
            [self.imageListViewController loadChannel:channelObject];
            [self.view addSubview:self.imageListViewController.view];
        }
            break;
            
        default:
            break;
    }
    
    [self.titleView setTitleText:channelObject.title];
}


- (void)didReceiveNewsChannelChanged:(NSNotification*)notification
{
    NSDictionary *dictionary = [notification userInfo];
    if (!dictionary)
    {
        return;
    }
    
    NewsChannelObject* channelObject = [dictionary objectForKey:ParamKey_ChanenlObject];
    [self loadChannel:channelObject];
    
    [self.delegate notifyGoToMid:self];
}


- (void)didNewsChannelListUpdata:(NSNotification*)notification
{
    if (!_articlelistViewController && !_imageListViewController)
    {
        [self initData];
    }
}


- (void)ariticleListCellDidSelect:(int)ariticleID
{
    NewsContentViewer* viewer = [[NewsContentViewer alloc] init];
    [viewer showInUIViewController:self articleID:ariticleID];
    [viewer release];
}


@end
