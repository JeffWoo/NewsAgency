/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: HotNewsManager.h
 *
 * Description	: 热点新闻管理器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/13, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>
#import "HotNewsNotificationKeys.h"

@interface HotNewsManager : NSObject

//获取单例对象
+ (HotNewsManager*)shareInstance;

//检测并更新热点新闻
- (void)checkAndUpDataHotNewList;

//获取热点新闻
- (NSArray*)getHotNewsList;

@end
