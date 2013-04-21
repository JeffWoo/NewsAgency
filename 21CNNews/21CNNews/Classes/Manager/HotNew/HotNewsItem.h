/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: HotNewsItem.h
 *
 * Description	: 热点新闻结构
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/13, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>

@interface HotNewsItem : NSObject

@property (nonatomic, readonly) NSString* title;        ///< 标题
@property (nonatomic, readonly) NSString* articleUrl;   ///< 热点新闻列表服务器请求url

+ (HotNewsItem*)hotNewsItemWithTitle:(NSString*)title articleUrl:(NSString*)articleUrl;

@end
