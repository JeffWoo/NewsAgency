/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: HotNewsJsDataParser.m
 *
 * Description	: 热点新闻json数据解析器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/13, chenggk, Create the file
 ***************************************************************************************
 **/

#import "HotNewsJsDataParser.h"
#import "HotNewsItem.h"
#import "JSONKit.h"

@implementation HotNewsJsDataParser

+ (NSArray*)parser:(NSData*)jsData
{
    JSONDecoder *jd = [[[JSONDecoder alloc] init] autorelease];
    
    NSDictionary *jsRet = [jd objectWithData:jsData];
    
    int count = [(NSNumber*)[jsRet objectForKey:@"Total"] intValue];
    if (count <= 0)
    {
        return nil;
    }
    
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:count];
    
    NSDictionary* rows = [jsRet objectForKey:@"Rows"];
    
    for (NSDictionary* row in rows)
    {
        NSString* title = [row objectForKey:@"title"];
        NSString* articleUrl = [row objectForKey:@"articleUrl"];
        
        HotNewsItem* item = [HotNewsItem hotNewsItemWithTitle:title articleUrl:articleUrl];
        [array addObject:item];
    }
    
    return array;    
}

@end
