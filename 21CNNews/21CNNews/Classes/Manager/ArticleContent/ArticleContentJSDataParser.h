/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: ArticleContentJSDataParser.h
 *
 * Description	: 新闻正文json数据解析器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/6, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>

@class ArticleContentObject;

@interface ArticleContentJSDataParser : NSObject

+ (ArticleContentObject*)parser:(NSData*)jsData;

@end
