//
//  ImageListViewController.m
//  Shell
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "ImageListViewController.h"
#import "TMPullingRefreshQuiltViewDelegate.h"
#import "TMPullingRefreshQuiltViewController.h"
#import "TMQuiltView.h"
#import "NewsListManager.h"
#import "NewListNotificationKeys.h"
#import "TMPhotoQuiltViewCell.h"
#import "NewsListItem.h"
#import "EGOImageView.h"
#import "NewsChannelObject.h"

@interface ImageListViewController ()<TMPullingRefreshQuiltViewDataDelegate, TMPullingRefreshQuiltViewDelegate>

@property (nonatomic, retain) TMPullingRefreshQuiltViewController* tmQuiltViewController;
@property (nonatomic, retain) NewsChannelObject* currentChannel;
@property (nonatomic, retain) NSArray* newList;

@end

@implementation ImageListViewController

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
    
    _tmQuiltViewController.delegate = nil;
    _tmQuiltViewController.dataSource = nil;
    [_tmQuiltViewController release];
    
    [_currentChannel release];
    
    [super dealloc];
}


- (void)showInViwe:(UIView*)parentView frame:(CGRect)frame
{
    self.view.frame = frame;
    self.view.backgroundColor = [UIColor greenColor];
    [parentView addSubview:self.view];
    if (!_tmQuiltViewController)
    {
        _tmQuiltViewController = [[TMPullingRefreshQuiltViewController alloc] init];
        _tmQuiltViewController.footView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)] autorelease];
        _tmQuiltViewController.footView.backgroundColor = [UIColor greenColor];
        _tmQuiltViewController.headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)] autorelease];
        _tmQuiltViewController.headerView.backgroundColor = [UIColor redColor];
        _tmQuiltViewController.delegate = self;
        _tmQuiltViewController.dataSource = self;
        [self.view addSubview:_tmQuiltViewController.view];
    }
    
    _tmQuiltViewController.view.frame = [self.view bounds];
}


- (void)loadChannel:(NewsChannelObject*)channelObject
{
    if (self.currentChannel.regionId == channelObject.regionId)
    {
        return;
    }
    
    self.newList = [[NewsListManager shareInstance] getNewsList:channelObject.regionId];
    [self.tmQuiltViewController reloadData];
    
    
    self.currentChannel = channelObject;
    [self.tmQuiltViewController launchRefreshing];
    
    [[NewsListManager shareInstance] refreshData:self.currentChannel];
}


#pragma mark TMPullingRefreshQuiltViewDataDelegate && TMPullingRefreshQuiltViewDelegate
- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)quiltView
{
    return [self.newList count];
}


- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath*)indexPath
{
    TMPhotoQuiltViewCell *cell = (TMPhotoQuiltViewCell *)[quiltView dequeueReusableCellWithReuseIdentifier:@"TMPhotoQuiltViewCell"];
    if (!cell)
    {
        cell = [[[TMPhotoQuiltViewCell alloc] initWithReuseIdentifier:@"TMPhotoQuiltViewCell"] autorelease];
    }
    
    NewsListItem* item = [self.newList objectAtIndex:indexPath.row];
    EGOImageView* eGoImageView = [[[EGOImageView alloc] initWithPlaceholderImage:nil] autorelease];
    eGoImageView.frame = CGRectMake(0, 0, 80, 100);
    eGoImageView.imageURL = [NSURL URLWithString:item.thumbImgUrl];
    
    cell.photoView = eGoImageView;
    
    cell.titleLabel.text = item.title;
    
    return cell;
}


- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)quiltViewUpRefresh:(TMQuiltView *)quiltView
{
    [[NewsListManager shareInstance] refreshData:self.currentChannel];
}


- (void)quiltViewDownRefresh:(TMQuiltView *)quiltView
{
    [[NewsListManager shareInstance] loadData:self.currentChannel];
}


// Must return a number of column greater than 0. Otherwise a default value is used.
- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView
{
    return 2;
}


// Must return margins for all the possible values of TMQuiltViewMarginType. Otherwise a default value is used.
- (CGFloat)quiltViewMargin:(TMQuiltView *)quilView marginType:(TMQuiltViewMarginType)marginType
{
    return 0;
}


// Must return the height of the requested cell
- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}



#pragma mark NSNotificationCenter call backfunction
- (void)didReceiveNewListLoadFinish:(NSNotification*)notification
{
    NSDictionary *dictionary = [notification userInfo];
    if (!dictionary)
    {
        [self.tmQuiltViewController setLoadFinish];
        return;
    }
    
    int regionID = [[dictionary objectForKey:kParam_ChannelRegionId] intValue];
    if (self.currentChannel && regionID != self.currentChannel.regionId)
    {
        return;
    }
    
    self.newList = [[NewsListManager shareInstance] getNewsList:regionID];

    [self.tmQuiltViewController reloadData];
    [self.tmQuiltViewController setLoadFinish];
}


- (void)didReceiveNewListLoadFailed
{
    [self.tmQuiltViewController setLoadFinish];
}


@end
