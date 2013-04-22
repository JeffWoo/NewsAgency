/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: UINewsChannelTableViewController.m
 *
 * Description	: 新闻频道table view controller
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/4, chenggk, Create the file
 ***************************************************************************************
 **/

#import "UINewsChannelTableViewController.h"
#import "UINewsChannelTableCell.h"
#import "NewsChannelManager.h"
#import "NewChannelNotificationKeys.h"
#import "NSNotificationCenterKeys.h"

@interface UINewsChannelTableViewController ()

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) NewChannelList* dataList; ///< 频道数据列表

@end

@implementation UINewsChannelTableViewController

@synthesize tableView = _tableView;
@synthesize dataList = _dataList;

- (id)initWithFrame:(CGRect)frame;
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNewsChannelListUpdata) name:kDidNewsChannelListUpdata object:nil];
        
        self.view.frame = frame;
        
        self.dataList = [[NewsChannelManager shareInstance] getNewChannelList]; ///< 初始化频道数据
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _tableView.separatorColor = [UIColor colorWithRed:0x1A / 255.0f green:0x1C / 255.0f blue:0x20 / 255.0f alpha:1];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
    }
    
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    [_tableView release];
    
    [super dealloc];
}


#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"UINewsChannelTableCell";
    
    UINewsChannelTableCell *cell = (UINewsChannelTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UINewsChannelTableCell alloc] initWithStyle:UITableViewCellStyleDefault frame:CGRectMake(0, 0, 275, 60) reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NewsChannelObject* object = [self.dataList getNewsChannelObject:indexPath.row];
    [cell setImageUrl:object.thumbImgUrl];
    [cell setTitle:object.title];
    
    cell.contentView.backgroundColor = [UIColor blackColor];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsChannelObject* object = [self.dataList getNewsChannelObject:indexPath.row];
    
    NSDictionary *userInfo = [[[NSDictionary alloc] initWithObjectsAndKeys:object, ParamKey_ChanenlObject, nil] autorelease];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DidNewsChannelChanged object:self userInfo:userInfo];
}


#pragma mark NewsChannelManager Call Back
//更新频道数据列表
- (void)didNewsChannelListUpdata
{
    self.dataList = [[NewsChannelManager shareInstance] getNewChannelList];
    [self.tableView reloadData];
}


@end
