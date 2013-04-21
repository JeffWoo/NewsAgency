/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: NewsChannelJSDataParser.m
 *
 * Description	: 新闻频道列表协议解析器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import "NewsChannelJSDataParser.h"
#import "NewChannelList.h"
#import "JSONKit.h"

@implementation NewsChannelJSDataParser

+ (NewChannelList*)parser:(NSData*)jsData
{
    NewChannelList* list = [NewChannelList getNewChannelList];
    
    JSONDecoder *jd = [[[JSONDecoder alloc] init] autorelease];
    
    NSDictionary *jsRet = [jd objectWithData:jsData];
    
    NSDictionary* rows = [jsRet objectForKey:@"Rows"];
    
    NSInteger currentPageIndex = [(NSNumber*)[jsRet objectForKey:@"currentPage"] intValue];
    for (NSDictionary* row in rows)
    {
        int articleType = [(NSNumber*)[row objectForKey:@"articleType"] intValue];
        int regionId = [(NSNumber*)[row objectForKey:@"regionId"] intValue];
        NSString* thumbImgUrl = [row objectForKey:@"thumbImgUrl"];
        NSString* title = [row objectForKey:@"title"];
        
        BOOL isCurrentPage = NO;
        if ([list count] == currentPageIndex - 1)
        {
            isCurrentPage = YES;
        }
        
        NewsChannelObject* object = [NewsChannelObject newsChannelObjectWithTitle:title
                                                                         regionId:regionId
                                                                      articleType:(NewsChannelArticleType)articleType
                                                                      thumbImgUrl:thumbImgUrl
                                                                    isCurrentPage:isCurrentPage];
        [list insertNewsChannelObject:object];
    }
    
    return list;
}

@end
