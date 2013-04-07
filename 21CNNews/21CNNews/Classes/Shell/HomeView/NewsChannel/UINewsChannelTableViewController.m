//
//  UINewsChannelTableViewController.m
//  Shell
//
//  Created by chenggk on 13-4-4.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "UINewsChannelTableViewController.h"
#import "UINewsChannelTableCell.h"
#import "NewsChannelManager.h"
#import "NewChannelNotificationKeys.h"
#import "NSNotificationCenterKeys.h"

@interface UINewsChannelTableViewController ()

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) NewChannelList* dataList;

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
        
        self.dataList = [[NewsChannelManager shareInstance] getNewChannelList];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 260, 300)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
        cell = [[[UINewsChannelTableCell alloc] initWithStyle:UITableViewCellStyleDefault frame:CGRectMake(0, 0, 260, 60) reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NewsChannelObject* object = [self.dataList getNewsChannelObject:indexPath.row];
    [cell setImageUrl:object.thumbImgUrl];
    [cell setTitle:object.title];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsChannelObject* object = [self.dataList getNewsChannelObject:indexPath.row];
    
    NSDictionary *userInfo = [[[NSDictionary alloc] initWithObjectsAndKeys:object, ParamKey_ChanenlObject, nil] autorelease];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DidNewsChannelChanged object:self userInfo:userInfo];
}


#pragma mark NewsChannelManagerDelegate
- (void)didNewsChannelListUpdata
{
    self.dataList = [[NewsChannelManager shareInstance] getNewChannelList];
    [self.tableView reloadData];
}


@end
