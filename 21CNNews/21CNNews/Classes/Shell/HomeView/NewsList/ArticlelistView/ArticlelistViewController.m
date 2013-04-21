//
//  ArticlelistViewController.m
//  Shell
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "ArticlelistViewController.h"
#import "PullingRefreshTableView.h"
#import "NewsListManager.h"
#import "NewListNotificationKeys.h"
#import "NewsListItem.h"
#import "UIArticleListTableViewCell.h"
#import "NewsChannelObject.h"

@interface ArticlelistViewController () <PullingRefreshTableViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) PullingRefreshTableView* tableView;
@property (nonatomic, retain) NewsChannelObject* currentChannel;
@property (nonatomic, retain) NSArray* newList;

@end

@implementation ArticlelistViewController

@synthesize tableView = _tableView;


- (id)init
{
    self = [super init];
    if (self)
    {
        _currentChannel = nil;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNewListLoadFinish:) name:kNewListLoadFinish object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNewListLoadFailed) name:kNewListLoadFailed object:nil];
    }
    
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    _tableView.pullingDelegate = nil;
    [_tableView release];
    _tableView = nil;
    
    [_newList release];
    
    [_currentChannel release];
    
    [super dealloc];
}


//在parentView中展现
- (void)showInViwe:(UIView*)parentView frame:(CGRect)frame
{
    self.view.frame = frame;
    if (!_tableView)
    {
        _tableView = [[PullingRefreshTableView alloc] initWithFrame:self.view.bounds pullingDelegate:self];
        [self.view addSubview:_tableView];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;        
    }
    
    [parentView addSubview:self.view];
}


//加载一个新闻频道
- (void)loadChannel:(NewsChannelObject*)channelObject
{
    if (self.currentChannel.regionId == channelObject.regionId)
    {
        return;
    }
    
    self.newList = [[NewsListManager shareInstance] getNewsList:channelObject.regionId];
    [self.tableView reloadData];
    
    self.currentChannel = channelObject;
    [self.tableView launchRefreshing];
    [[NewsListManager shareInstance] refreshData:channelObject];
}


#pragma mark - TableView*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.newList count];
}


- (CGFloat)tableView:(UITableView *)tableview heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Contentidentifier = @"UIArticleListTableViewCell";
    UIArticleListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Contentidentifier];
    if (cell == nil)
    {
        //设置cell 样式
        cell = [[UIArticleListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Contentidentifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    
    [cell setNewsListItem:(NewsListItem*)[self.newList objectAtIndex:indexPath.row]];
    

    return cell;
}


#pragma mark - PullingRefreshTableViewDelegate
//上拉刷新
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    [[NewsListManager shareInstance] refreshData:self.currentChannel];
}


//下拉继续加载
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    [[NewsListManager shareInstance] loadData:self.currentChannel];
}


#pragma mark - Scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.tableView tableViewDidEndDragging:scrollView];
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListItem* item = [self.newList objectAtIndex:indexPath.row];
    
    [self.delegate ariticleListCellDidSelect:item.articleId];
}



#pragma mark NSNotificationCenter call backfunction
//加载接收通知处理函数
- (void)didReceiveNewListLoadFinish:(NSNotification*)notification
{
    NSDictionary *dictionary = [notification userInfo];
    if (!dictionary)
    {
        self.tableView.reachedTheEnd  = NO;
                
        if (self.tableView.contentOffset.y < 0)
        {
            [self.tableView tableViewDidFinishedLoading];
        }
        
        return;
    }
    
    int regionID = [[dictionary objectForKey:kParam_ChannelRegionId] intValue];
    if (self.currentChannel && regionID != self.currentChannel.regionId) 
    {
        return;
    }
    
    self.newList = [[NewsListManager shareInstance] getNewsList:regionID];
    [self.tableView tableViewDidFinishedLoading];
    self.tableView.reachedTheEnd  = NO;
    [self.tableView reloadData];
}


- (void)didReceiveNewListLoadFailed
{
    [self.tableView tableViewDidFinishedLoading];
    self.tableView.reachedTheEnd  = NO;
}


@end
