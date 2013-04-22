/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: NewsListManager.h
 *
 * Description	: 新闻列表管理器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/6, chenggk, Create the file
 ***************************************************************************************
 **/


#import <Foundation/Foundation.h>

@class NewsChannelObject;

@interface NewsListManager : NSObject

//获取单例对象
+ (NewsListManager*)shareInstance;

- (void)loadData:(NewsChannelObject*)channelObject;     ///< 加载对应区块（频道）内容

- (void)refreshData:(NewsChannelObject*)channelObject;  ///< 刷新对应区块（频道）内容

//获取对应新闻频道新闻列表
- (NSArray*)getNewsList:(int)regionId;

@end
