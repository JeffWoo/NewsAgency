/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: ArticleContentJSDataParser.m
 *
 * Description	: 新闻正文json数据解析器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/6, chenggk, Create the file
 ***************************************************************************************
 **/

#import "ArticleContentJSDataParser.h"
#import "ArticleContentObject.h"
#import "JSONKit.h"

@implementation ArticleContentJSDataParser

+ (ArticleContentObject*)parser:(NSData*)jsData
{
    JSONDecoder *jd = [[[JSONDecoder alloc] init] autorelease];
    
    NSDictionary *jsRet = [jd objectWithData:jsData];
    
    int articleType = [(NSNumber*)[jsRet objectForKey:@"articleType"] intValue];
    NSString* articleUrl = [jsRet objectForKey:@"articleUrl"];
    NSString* content = [jsRet objectForKey:@"content"];
    NSString* createTime = [jsRet objectForKey:@"createTime"];
    int articleId = [(NSNumber*)[jsRet objectForKey:@"id"] intValue];
    NSString* leaderette = [jsRet objectForKey:@"leaderette"];
    NSString* originalLink = [jsRet objectForKey:@"originalLink"];
    NSString* publishTime = [jsRet objectForKey:@"publishTime"];
    int sourceStatus = [(NSNumber*)[jsRet objectForKey:@"sourceStatus"] intValue];
    NSString* title = [jsRet objectForKey:@"title"];
    NSString* topTime = [jsRet objectForKey:@"topTime"];
    NSString* sourceName = [jsRet objectForKey:@"sourceName"];
    NSString* summary = [jsRet objectForKey:@"summary"];

    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [ArticleContentObject articleContentObjectWithArticleId:articleId
                                                       articleType:articleType
                                                        articleUrl:articleUrl
                                                           content:content
                                                        createTime:[dateFormatter dateFromString:createTime]
                                                        leaderette:leaderette
                                                      originalLink:originalLink
                                                       publishTime:[dateFormatter dateFromString:publishTime]
                                                      sourceStatus:sourceStatus
                                                             title:title
                                                           topTime:[dateFormatter dateFromString:topTime]
                                                        sourceName:sourceName
                                                           summary:summary];
}

@end
