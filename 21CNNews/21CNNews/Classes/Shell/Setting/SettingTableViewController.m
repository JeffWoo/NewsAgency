//
//  SettingTableViewController.m
//  Shell
//
//  Created by chenggk on 13-4-6.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "SettingTableViewController.h"
#import "UITitleView.h"
#import "SettingManager.h"
#import "SettingTableViewCell.h"

@interface SettingTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, retain) NSArray* settingData;

@end

@implementation SettingTableViewController

- (void)dealloc
{
    _tableView.dataSource = self;
    _tableView.delegate = nil;
    [_tableView release];
    _tableView = nil;
    
    [_settingData release];
    
    [super dealloc];
}


- (void)showInView:(UIView*)parentView
{
    self.settingData = [[SettingManager shareInstance] getSettingData];
    
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self.view addSubview:_tableView];
    }
    
    [parentView addSubview:self.view];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0f;
    SettingCellObject* object = [self.settingData objectAtIndex:indexPath.row];
    if (object.isCanBeSelected)
    {
        height = 42;
    }
    else
    {
        height = 25;
    }
    
    return height;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.settingData count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SettingTableViewCell";
    
    SettingTableViewCell *cell = (SettingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
            
    
    cell.settingCellObject = [self.settingData objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCellObject* object = [self.settingData objectAtIndex:indexPath.row];
    
    if (object.command)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:object.command object:self userInfo:nil];
    }
    
    self.settingData = [[SettingManager shareInstance] getSettingData];
    [self.tableView reloadData];
}

@end
