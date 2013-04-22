/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: NewsListViewController.h
 *
 * Description	: 新闻列表view controller
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

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

@property (nonatomic, retain) UITitleView* titleView;                                   ///< title栏
@property (nonatomic, retain) ArticlelistViewController* articlelistViewController;     ///< 普通新闻列表
@property (nonatomic, retain) ImageListViewController* imageListViewController;         ///< 图片新闻列表

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
        
        self.view.backgroundColor = [UIColor whiteColor];
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
        _titleView = [[UITitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        [_titleView setBgImage:resGetImage(@"home/mid/homeNavBarBg.png")];
        [_titleView setTitleText:@"头条"];
        [_titleView setLeftButtonImage:resGetImage(@"home/mid/leftButton.png") frame:CGRectMake(14, 13, 25, 17)];
        [_titleView addLeftButonTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [_titleView setRightButtonImage:resGetImage(@"blueArrow.png") frame:CGRectMake(260, 0, 60, 44)];
        [_titleView addRightButonTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_titleView];
    }
    
    if (!_articlelistViewController && !_imageListViewController)
    {
        [self initData];
    }
}


//初始化数据
- (void)initData
{
    NewsChannelObject* channelObject = [[NewsChannelManager shareInstance] getDefaultChannel];
    if (!channelObject)
    {
        return;
    }
    
    [self loadChannel:channelObject];   ///< 加载默认频道
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


//加载对应频道
- (void)loadChannel:(NewsChannelObject*)channelObject
{
    switch (channelObject.articleType)
    {
        case NewsChannelArticleTypeNormal:  ///< 普通样式
        {
            [self createArticlelistViewControllerIfNeed];
            [self.imageListViewController.view removeFromSuperview];
            [self.articlelistViewController loadChannel:channelObject];
            [self.view addSubview:self.articlelistViewController.view];
        }
            break;
        case NewsChannelArticleTypeImage:   ///< 图片列表样式
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


//新闻列表发生变化响应函数
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


//新闻列表更新响应函数
- (void)didNewsChannelListUpdata:(NSNotification*)notification
{
    if (!_articlelistViewController && !_imageListViewController)
    {
        [self initData];
    }
}


//普通新闻列表新闻项被选中时响应函数
- (void)ariticleListCellDidSelect:(int)ariticleID
{
    NewsContentViewer* viewer = [[NewsContentViewer alloc] init];
    [viewer showInUIViewController:self articleID:ariticleID];  ///< 展现新闻正文
    [viewer release];
}


@end
