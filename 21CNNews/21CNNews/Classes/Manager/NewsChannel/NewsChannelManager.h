/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: NewsChannelManager.h
 *
 * Description	: 新闻频道列表管理器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>
#import "NewChannelList.h"


@interface NewsChannelManager : NSObject

//获取单例对象
+ (NewsChannelManager*)shareInstance;

//获取频道列表
- (NewChannelList*)getNewChannelList;

//获取默认频道
- (NewsChannelObject*)getDefaultChannel;

@end
