/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: NewsChannelManager.m
 *
 * Description	: 新闻频道列表管理器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

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
        [self updata];  ///< 启动时进行一次频道列表检测更新操作
    }
    
    return self;
}


- (void)dealloc
{
    [_data release];
    [super dealloc];
}


//更新频道列表
- (void)updata
{
    NSURL *url= [NSURL URLWithString:@"http://auto.21cn.com/api/client/v2/getSubscribeList.do?accessToken=fewtewtew&userSerialNum=qewq"];
    NSURLRequest *req= [NSURLRequest requestWithURL:url];
    
    LSURLDispatchOperation *op= [[LSURLDispatcher sharedDispatcher] dispatchShortRequest:req delegate:self];    ///< 建立一个http请求
    
    [op start];
}


//检测频道列表对应数据库表格是否存在，如不存在，则创建一个
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
        }
        
    }];
        
}


//从FMResultSet中获取一个频道数据
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


//获取默认频道
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


//获取频道列表
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


//通知外部监听对象：频道列表已经更新完毕
- (void)notifyNewsChannelChanged
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidNewsChannelListUpdata object:self userInfo:nil];
}


//更新频道列表数据库表格内容
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


//成功接收到服务器返回json数据
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
