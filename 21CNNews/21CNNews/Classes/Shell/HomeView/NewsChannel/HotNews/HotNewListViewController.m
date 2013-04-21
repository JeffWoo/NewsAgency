/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: HotNewListViewController.m
 *
 * Description	: 热点新闻view controller
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/4, chenggk, Create the file
 ***************************************************************************************
 **/

#import "HotNewListViewController.h"
#import "HotNewsManager.h"
#import "HotNewsNotificationKeys.h"
#import "HotNewsButton.h"

@interface HotNewListViewController ()

@property (nonatomic, retain) UIScrollView* scrollView;             ///< 底部scrollview
@property (nonatomic, retain) NSArray* hotNewList;                  ///< 热点新闻数据
@property (nonatomic, retain) NSMutableArray* hotNewsButtonList;    ///< 热点新闻项列表

@end

@implementation HotNewListViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didHotNewsListChanged) name:kHotNewsListChanged object:nil];  ///< 注册监听热点列表
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_scrollView];
        
        self.view.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self releaseHotNewsButton];
    [_hotNewsButtonList release];
    
    [_scrollView release];
    [_hotNewList release];
    [super dealloc];
}


- (void)releaseHotNewsButton
{
    for (HotNewsButton* button in self.hotNewsButtonList)
    {
        [button removeTarget:self action:nil forControlEvents:UIControlEventAllEvents];
        [button removeFromSuperview];
    }
    
    [self.hotNewsButtonList removeAllObjects];
}


//计算布局
- (void)layout
{
    [self releaseHotNewsButton];
    self.hotNewList = [[HotNewsManager shareInstance] getHotNewsList];
    
    int originX = 15;
    int originY = 10;
    for (HotNewsItem* item in self.hotNewList)
    {
        HotNewsButton* button = [[[HotNewsButton alloc] initWithFrame:CGRectMake(originX, originY, 275, 25)] autorelease];  ///< 按钮的最大宽度为275
        [button setHotNewsItem:item];
        [self.scrollView addSubview:button];
        originX += (button.frame.size.width + 18);  ///< 计算下个按钮的起点位置，两个按钮横向间隔为18px
        if (originX >= 275) ///< 如果下个button起点x值大于最大可展现宽度，则放到下一行展现
        {
            originX = 15;
            originY += (button.frame.size.height + 10); ///< 计算下个按钮起点位置y值，两个按钮纵向间隔为10px
            
            button.frame = CGRectMake(originX, originY, button.frame.size.width, button.frame.size.height); ///< 更新按钮位置
            originX += (button.frame.size.width + 18);
            if (originX >= 275) ///< 如果下个button起点x值大于最大可展现宽度，则放到下一行展现
            {
                originX = 15;
                originY += (button.frame.size.height + 10);
            }
        }
        
    }
    
    originY += (15 + 25);   ///< 加上最后一行高度
    if (originY > self.scrollView.frame.size.height)    ///< 如果所有按钮总超过最大可展现高度，则scrollview可滚动
    {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, originY);
    }
    else
    {
        self.scrollView.contentSize = self.scrollView.frame.size;
    }
}


- (void)showInView:(UIView*)superView frame:(CGRect)frame
{
    self.view.frame = frame;
    self.view.backgroundColor = [UIColor clearColor];
    [superView addSubview:self.view];
    
    self.scrollView.frame = self.view.bounds;
    [self.view addSubview:self.scrollView];
        
    [self layout];
}


//热点新闻列表更新通知
- (void)didHotNewsListChanged
{
    [self layout];
}

@end
