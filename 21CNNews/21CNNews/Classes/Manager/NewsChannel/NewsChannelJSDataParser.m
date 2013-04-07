//
//  NewsChannelJSDataParser.m
//  Model
//
//  Created by chenggk on 13-4-4.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

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
