//
//  HotNewsManager.m
//  Model
//
//  Created by chenggk on 13-4-13.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "HotNewsManager.h"
#import "DBCommonHeader.h"
#import "LSURLDispatcher.h"
#import "UserSerialNumManager.h"
#import "HotNewsJsDataParser.h"
#import "HotNewsItem.h"
#import "HotNewsNotificationKeys.h"

@interface HotNewsManager()<LSURLDispatchDelegate>

@property (nonatomic, retain) NSMutableData* data;

@end

@implementation HotNewsManager

+ (HotNewsManager*)shareInstance
{
    static HotNewsManager* g_instance = nil;
    
    if (nil == g_instance)
    {
        @synchronized(@"HotNewsManager")
        {
            if (nil == g_instance)
            {
                g_instance = [[HotNewsManager alloc] init];
            }
        }
    }
    
    return g_instance;
}


- (void)dealloc
{
    [_data release];
    
    [super dealloc];
}


- (BOOL)checkAndCreateHotNewsTable
{
    __block BOOL bNeedToCreateTable = YES;
    [[DBManager shareIntance].db inDatabase:^(FMDatabase *db){
        
        FMResultSet* resultSet = [db executeQuery:@"SELECT count(*) FROM sqlite_master WHERE type='table' AND name='hot_news_table'"];
        while ([resultSet next])
        {
            int count = [resultSet intForColumnIndex:0];
            if (count > 0)
            {
                bNeedToCreateTable = NO;
            }
        }
        
        if (bNeedToCreateTable)
        {
            [db executeUpdate:@"CREATE TABLE hot_news_table (title text NOT NULL, articleUrl text NOT NULL)"];
        }
        
    }];
    
    return bNeedToCreateTable;
}


- (NSArray*)getHotNewsList
{
    __block NSMutableArray* list = [NSMutableArray arrayWithCapacity:10];
    [[DBManager shareIntance].db inDatabase:^(FMDatabase *db){
        
        NSString* sql = [NSString stringWithFormat:@"select * from hot_news_table"];
        FMResultSet* resultSet = [db executeQuery:sql];
        while ([resultSet next])
        {
            NSString *articleUrl = [resultSet stringForColumn:@"articleUrl"];
            NSString *title = [resultSet stringForColumn:@"title"];
            
            HotNewsItem* item = [HotNewsItem hotNewsItemWithTitle:title articleUrl:articleUrl];
            
            [list addObject:item];
        }
        
    }];
    
    if (0 == [list count])
    {          
        HotNewsItem* item1 = [HotNewsItem hotNewsItemWithTitle:@"今日一线" articleUrl:@"111"];
        [list addObject:item1];
                        
        HotNewsItem* item3 = [HotNewsItem hotNewsItemWithTitle:@"明日一线" articleUrl:@"111"];
        [list addObject:item3];
        
        HotNewsItem* item4 = [HotNewsItem hotNewsItemWithTitle:@"天河" articleUrl:@"111"];
        [list addObject:item4];
        
        HotNewsItem* item6 = [HotNewsItem hotNewsItemWithTitle:@"CCTV" articleUrl:@"111"];
        [list addObject:item6];
        
        HotNewsItem* item2 = [HotNewsItem hotNewsItemWithTitle:@"广东新闻联播" articleUrl:@"111"];
        [list addObject:item2];
        
        HotNewsItem* item8 = [HotNewsItem hotNewsItemWithTitle:@"广东" articleUrl:@"111"];
        [list addObject:item8];
        
        HotNewsItem* item7 = [HotNewsItem hotNewsItemWithTitle:@"广东新闻" articleUrl:@"111"];
        [list addObject:item7];
        
        HotNewsItem* item5 = [HotNewsItem hotNewsItemWithTitle:@"中华人民共和国" articleUrl:@"111"];
        [list addObject:item5];                        
        
        HotNewsItem* item9 = [HotNewsItem hotNewsItemWithTitle:@"广东22" articleUrl:@"111"];
        [list addObject:item9];
        
        HotNewsItem* item10 = [HotNewsItem hotNewsItemWithTitle:@"广东333" articleUrl:@"111"];
        [list addObject:item10];
    }
    
    return list;
}


- (void)checkAndUpDataHotNewList
{
    NSString* userSerialNum = [[UserSerialNumManager shareInstance] getUserSerialNum];

    NSString* urlStr = [NSString stringWithFormat:@"http://domain/api/client/v2/getHotSearchTagsList.do?userSerialNum=%@&accessToken=fewtewtew", userSerialNum];
    
    NSURL *url= [NSURL URLWithString:urlStr];
    NSURLRequest *req= [NSURLRequest requestWithURL:url];
    
    LSURLDispatchOperation *op= [[LSURLDispatcher sharedDispatcher] dispatchShortRequest:req delegate:self];
    
    [op start];
}


- (void)notifyHotNewsListChanged
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kHotNewsListChanged object:self userInfo:nil];
}


- (void)updataTable:(NSArray*)hotNewList
{
    [self checkAndCreateHotNewsTable];
    
    [[DBManager shareIntance].db inDatabase:^(FMDatabase *db){                        
        
        for (HotNewsItem* item in hotNewList)
        {
            
            BOOL bRet = [db executeUpdate:@"insert into hot_news_table values (?, ?)", item.title, item.articleUrl];
            if (!bRet)
            {
                assert(false);
            }
        }
                        
        [self performSelectorOnMainThread:@selector(notifyHotNewsListChanged) withObject:nil waitUntilDone:NO];
        
    }];
}


#pragma mark LSURLDispatchDelegate
- (void) dispatchOperation:(LSURLDispatchOperation *)operation didReceiveResponse:(NSURLResponse *)response
{
    self.data = [[[NSMutableData alloc] init] autorelease];
}


- (void) dispatchOperation:(LSURLDispatchOperation *)operation didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}


- (void) dispatchOperation:(LSURLDispatchOperation *)operation didFailWithError:(NSError *)error
{
    //    [self performSelectorOnMainThread:@selector(notifyNewsListLoadFailed) withObject:nil waitUntilDone:NO];
}


- (void) dispatchOperationDidFinish:(LSURLDispatchOperation *)operation
{
    if (!self.data)
    {
        return;
    }
    
    NSArray* hotNewList = [HotNewsJsDataParser parser:self.data];
    
    if (hotNewList)
    {
        [self updataTable:hotNewList];
    }
    
    self.data = nil;
}



- (void) dispatchOperationWillDestory:(LSURLDispatchOperation *)operation
{
    
}


@end
