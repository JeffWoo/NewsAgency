//
//  NewsListJSDataPaser.m
//  Model
//
//  Created by chenggk on 13-4-6.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "NewsListJSDataPaser.h"
#import "ReviewListItem.h"
#import "NewsListItem.h"
#import "JSONKit.h"


@implementation NewsListJSDataPaser

+ (NSArray*)parser:(NSData*)jsData
{
    JSONDecoder *jd = [[[JSONDecoder alloc] init] autorelease];
    
    NSDictionary *jsRet = [jd objectWithData:jsData];
    
    int Total = [(NSNumber*)[jsRet objectForKey:@"Total"] intValue];
    if (Total <= 0)
    {
        return nil;
    }
    
    NSMutableArray* list = [NSMutableArray arrayWithCapacity:Total];
    
    int currentPage = [(NSNumber*)[jsRet objectForKey:@"currentPage"] intValue];
    NSDictionary* rows = [jsRet objectForKey:@"Rows"];
    for (NSDictionary* row in rows)
    {
        int articleId = [(NSNumber*)[row objectForKey:@"articleId"] intValue];
        
        NSString* articleUrl = [row objectForKey:@"articleUrl"];
        
        NSString* publishTimeStr = [row objectForKey:@"publishTime"];
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *publishTime = [dateFormatter dateFromString:publishTimeStr];
        
        int regionId = [(NSNumber*)[row objectForKey:@"regionId"] intValue];
        
        int sourceId = [(NSNumber*)[row objectForKey:@"sourceId"] intValue];
        
        NSString* sourceName = [row objectForKey:@"sourceName"];
        
        NSString* summary = [row objectForKey:@"summary"];
        
        NSString* thumbImgUrl = [row objectForKey:@"thumbImgUrl"];
        
        NSString* title = [row objectForKey:@"title"];
        
        NSString* topTimeStr = [row objectForKey:@"topTime"];
        NSDate *topTime = [dateFormatter dateFromString:topTimeStr];
        
        BOOL isHot = [(NSNumber*)[row objectForKey:@"isHot "] boolValue];
        
        BOOL isRecommend = [(NSNumber*)[row objectForKey:@"isRecommend "] boolValue];
        
        BOOL isSpecial = [(NSNumber*)[row objectForKey:@"isSpecial "] boolValue];
        
        int reviewNum = [(NSNumber*)[row objectForKey:@"reviewNum"] intValue];
        
        BOOL showBigPic = [(NSNumber*)[row objectForKey:@"showBigPic "] boolValue];
        
        NSArray* reviewArray = [row objectForKey:@"reviewList"];
        NSMutableArray* reviewList = [NSMutableArray arrayWithCapacity:1];
        for (NSDictionary* review in reviewArray)
        {
            int userId = [(NSNumber*)[review objectForKey:@"userId"] intValue];
            NSString* userNickName = [review objectForKey:@"userNickName"];
            NSString* userIconUrl = [review objectForKey:@"userIconUrl"];
            NSString* content = [review objectForKey:@"content"];
            
            [reviewList addObject:[ReviewListItem reviewListItemUserId:userId userNickName:userNickName userIconUrl:userIconUrl content:content]];
        }
        
        NewsListItem* item = [NewsListItem newsListItemWithArticleId:articleId
                                                          articleUrl:articleUrl
                                                         publishTime:publishTime
                                                            regionId:regionId
                                                            sourceId:sourceId
                                                          sourceName:sourceName
                                                             summary:summary
                                                         thumbImgUrl:thumbImgUrl
                                                               title:title
                                                             topTime:topTime
                                                               isHot:isHot
                                                         isRecommend:isRecommend
                                                           isSpecial:isSpecial
                                                           reviewNum:reviewNum
                                                          showBigPic:showBigPic
                                                          reviewList:reviewList
                                                              pageNo:currentPage];
        
        [list addObject:item];
    }
    
    return list;
    
}

@end
