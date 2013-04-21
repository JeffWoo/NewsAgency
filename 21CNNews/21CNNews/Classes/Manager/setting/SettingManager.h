/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: SettingManager.h
 *
 * Description	: 系统设置管理器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>
#import "SettingCellObject.h"

@interface SettingManager : NSObject

//获取单例对象
+ (SettingManager*)shareInstance;

#pragma mark getter
- (BOOL)isOffLineDownLoadOpen;

- (BOOL)isNoneImageMode;

- (BOOL)isApnsOpen;

- (BOOL)isNightMode;

- (NSArray*)getSettingData;

#pragma mark setter
- (void)setOfflineDownLoadOpen:(BOOL)bOpen;

- (void)setNoneImageModeOpen:(BOOL)bOpen;

- (void)setApnsOpen:(BOOL)bOpen;

- (void)setNightModeOpen:(BOOL)bOpen;



@end
