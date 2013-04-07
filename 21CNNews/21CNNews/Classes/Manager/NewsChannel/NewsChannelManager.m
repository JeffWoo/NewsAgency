//
//  NewsChannelManager.m
//  Model
//
//  Created by chenggk on 13-4-4.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "NewsChannelManager.h"
#import "DBCommonHeader.h"
#import "LSThreadPool.h"
#import "LSURLDispatcher.h"
#import "LSURLDispatchOperation.h"
#import "NewsChannelJSDataParser.h"
#import "NewChannelNotificationKeys.h"
#import "LSURLDispatchDelegate.h"

@interface NewsChannelManager()<LSURLDispatchDelegate>

@property (nonatomic, retain) NSMutableData* data;

@end

@implementation NewsChannelManager

#pragma mark init & mark
+ (NewsChannelManager*)shareInstance
{
    static NewsChannelManager* g_instance = nil;
    
    if (nil == g_instance)
    {
        @synchronized(@"NewsChannelManager")
        {
            if (nil == g_instance)
            {
                g_instance = [[NewsChannelManager alloc] init];
            }
        }
    }
    
    return g_instance;
}


- (id)init
{
    self = [super init];
    if (self)
    {
        [self updata];
    }
    
    return self;
}


- (void)dealloc
{
    [_data release];
    [super dealloc];
}


- (void)updata
{
    NSURL *url= [NSURL URLWithString:@"http://auto.21cn.com/api/client/v2/getSubscribeList.do?accessToken=fewtewtew&userSerialNum=qewq"];
    NSURLRequest *req= [NSURLRequest requestWithURL:url];
    
    LSURLDispatchOperation *op= [[LSURLDispatcher sharedDispatcher] dispatchShortRequest:req delegate:self];
    
    [op start];
}


- (void)checkNewsChannelTable
{
    [[DBManager shareIntance].db inDatabase:^(FMDatabase *db){
        
        FMResultSet* resultSet = [db executeQuery:@"SELECT count(*) FROM sqlite_master WHERE type='table' AND name='news_channel_table'"];
        BOOL bNeedToCreateTable = YES;
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
            [db executeUpdate:@"CREATE TABLE news_channel_table (regionId integer NOT NULL PRIMARY KEY, articleType integer NOT NULL, title text NOT NULL, thumbImgUrl text NOT NULL, isCurrentPage bool NOT NULL)"];
            /*
            [db executeUpdate:@"insert into news_channel_table values (?,?,?,?)", [NSNumber numberWithInt:501], [NSNumber numberWithInt:0], @"头条", [NSNumber numberWithInt:0]];
            [db executeUpdate:@"insert into news_channel_table values (?,?,?,?)", [NSNumber numberWithInt:502], [NSNumber numberWithInt:0], @"时事", [NSNumber numberWithInt:0]];
            [db executeUpdate:@"insert into news_channel_table values (?,?,?,?)", [NSNumber numberWithInt:503], [NSNumber numberWithInt:0], @"社会", [NSNumber numberWithInt:0]];
            [db executeUpdate:@"insert into news_channel_table values (?,?,?,?)", [NSNumber numberWithInt:504], [NSNumber numberWithInt:0], @"娱乐", [NSNumber numberWithInt:0]];
            [db executeUpdate:@"insert into news_channel_table values (?,?,?,?)", [NSNumber numberWithInt:505], [NSNumber numberWithInt:0], @"体育", [NSNumber numberWithInt:0]];
            [db executeUpdate:@"insert into news_channel_table values (?,?,?,?)", [NSNumber numberWithInt:506], [NSNumber numberWithInt:0], @"财经", [NSNumber numberWithInt:0]];
            [db executeUpdate:@"insert into news_channel_table values (?,?,?,?)", [NSNumber numberWithInt:507], [NSNumber numberWithInt:0], @"军事", [NSNumber numberWithInt:0]];
            [db executeUpdate:@"insert into news_channel_table values (?,?,?,?)", [NSNumber numberWithInt:508], [NSNumber numberWithInt:0], @"科技", [NSNumber numberWithInt:0]];
            [db executeUpdate:@"insert into news_channel_table values (?,?,?,?)", [NSNumber numberWithInt:509], [NSNumber numberWithInt:0], @"笑话", [NSNumber numberWithInt:0]];
             */
        }
        
    }];
        
}



- (NewsChannelObject*)getCurObjectFromResultSet:(FMResultSet*)resultSet
{
    NSString *title = [resultSet stringForColumn:@"title"];
    NSString *thumbImgUrl = [resultSet stringForColumn:@"thumbImgUrl"];
    int regionId = [resultSet intForColumn:@"regionId"];
    BOOL isCurrentPage = [resultSet boolForColumn:@"isCurrentPage"];
    NewsChannelArticleType articleType = [resultSet intForColumn:@"articleType"];
    
    return  [NewsChannelObject newsChannelObjectWithTitle:title
                                                 regionId:regionId
                                              articleType:articleType
                                              thumbImgUrl:thumbImgUrl
                                            isCurrentPage:isCurrentPage];
}


- (NewsChannelObject*)getDefaultChannel
{
    __block NewsChannelObject* object = nil;
    
    [[DBManager shareIntance].db inDatabase:^(FMDatabase *db){
        
        FMResultSet* resultSet = [db executeQuery:@"SELECT * FROM news_channel_table where isCurrentPage=1"];
        while ([resultSet next])
        {            
            object = [self getCurObjectFromResultSet:resultSet];
        }
        
        if (!object)
        {
            FMResultSet* resultSet = [db executeQuery:@"SELECT * FROM news_channel_table"];
            while ([resultSet next])
            {
                object = [self getCurObjectFromResultSet:resultSet];
                break;
            }
        }
    }];
    
    return object;
}


- (NewChannelList*)getNewChannelList
{
    [self checkNewsChannelTable];
    
    __block NewChannelList* list = [NewChannelList getNewChannelList];;
    [[DBManager shareIntance].db inDatabase:^(FMDatabase *db){
        
        FMResultSet* resultSet = [db executeQuery:@"select * from news_channel_table"];
        while ([resultSet next]) {            
            NewsChannelObject* object = [self getCurObjectFromResultSet:resultSet];;
            [list insertNewsChannelObject:object];
        }
        
    }];
    
    return list;
}


- (void)notifyNewsChannelChanged
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidNewsChannelListUpdata object:self userInfo:nil];
}


- (void)updataTable:(NewChannelList*)list
{
    [[DBManager shareIntance].db inDatabase:^(FMDatabase *db){
                
//        [db executeUpdate:@"DELETE FROM news_channel_table"];
        
        int count = [list count];
        for (int i = 0; i < count; ++i)
        {
            NewsChannelObject* object = [list getNewsChannelObject:i];
            [db executeUpdate:@"insert into news_channel_table values (?,?,?,?,?)",
                                                                        [NSNumber numberWithInt:object.regionId],
                                                                        [NSNumber numberWithInt:object.articleType],
                                                                        object.title,
                                                                        object.thumbImgUrl,
                                                                        [NSNumber numberWithBool:object.isCurrentPage]];
        }
        
        [db commit];
        
        [self performSelectorOnMainThread:@selector(notifyNewsChannelChanged) withObject:nil waitUntilDone:NO];

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
    
}


- (void) dispatchOperationDidFinish:(LSURLDispatchOperation *)operation 
{
    NewChannelList* list = [NewsChannelJSDataParser parser:self.data];
    
    [self updataTable:list];
    
    self.data = nil;
}


- (void) dispatchOperationWillDestory:(LSURLDispatchOperation *)operation
{
    
}


@end
