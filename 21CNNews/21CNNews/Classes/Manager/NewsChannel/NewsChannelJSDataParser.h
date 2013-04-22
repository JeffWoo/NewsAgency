/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: NewsChannelJSDataParser.h
 *
 * Description	: 新闻频道列表协议解析器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>
@class NewChannelList;

@interface NewsChannelJSDataParser : NSObject

+ (NewChannelList*)parser:(NSData*)jsData;

@end
