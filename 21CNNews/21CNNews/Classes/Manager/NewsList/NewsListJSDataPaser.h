/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: NewsListJSDataPaser.h
 *
 * Description	: 新闻列表json数据解析器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/6, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>

@interface NewsListJSDataPaser : NSObject

+ (NSArray*)parser:(NSData*)jsData;

@end
