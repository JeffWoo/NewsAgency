/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: SettingTableViewCell.h
 *
 * Description	: 系统设置table view cell
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import <UIKit/UIKit.h>

@class SettingCellObject;

@interface SettingTableViewCell : UITableViewCell

@property (nonatomic, retain) SettingCellObject* settingCellObject;

@end
