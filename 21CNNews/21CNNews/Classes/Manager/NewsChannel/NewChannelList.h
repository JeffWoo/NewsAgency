/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: NewChannelList.h
 *
 * Description	: 新闻频道列表数据结构
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>
#import "NewsChannelObject.h"

@interface NewChannelList : NSObject

@property (nonatomic, readonly) NSInteger currentPageIndex;

//便捷构造函数
+ (NewChannelList*)getNewChannelList;

//获取频道个数
- (int)count;

//添加一个频道
- (BOOL)insertNewsChannelObject:(NewsChannelObject*)object;

//获取对应频道，index为该频道在于频道列表中的位置
- (NewsChannelObject*)getNewsChannelObject:(NSInteger)index;

@end
