/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: HotNewsJsDataParser.h
 *
 * Description	: 热点新闻json数据解析器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/13, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>

@interface HotNewsJsDataParser : NSObject

+ (NSArray*)parser:(NSData*)jsData;

@end
