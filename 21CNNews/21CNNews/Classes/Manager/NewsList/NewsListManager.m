#import "NewsListManager.h"
#import "LSThreadPool.h"
#import "LSURLDispatcher.h"
#import "LSURLDispatchOperation.h"
#import "LSURLDispatchDelegate.h"
#import "NewsListItem.h"
#import "ReviewListItem.h"
#import "NewsListJSDataPaser.h"
#import "DBCommonHeader.h"
#import "NewListNotificationKeys.h"
#import "UserSerialNumManager.h"
#import "NewsChannelObject.h"
#import "SettingManager.h"

@interface NewsListManager()<LSURLDispatchDelegate>

@property (nonatomic, retain) NSMutableData* data;

@end


@implementation NewsListManager

+ (NewsListManager*)shareInstance
{
    static NewsListManager* g_instance = nil;
    
    if (nil == g_instance)
    {
        @synchronized(@"NewsListManager")
        {
            if (nil == g_instance)
            {
                g_instance = [[NewsListManager alloc] init];
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



- (void)checkNewsListTable
{
    [[DBManager shareIntance].db inDatabase:^(FMDatabase *db){
        
        FMResultSet* resultSet = [db executeQuery:@"SELECT count(*) FROM sqlite_master WHERE type='table' AND name='news_list_table'"];
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
            [db executeUpdate:@"CREATE TABLE news_list_table (pageNo integer NOT NULL,  articleId integer NOT NULL, articleUrl text, publishTime text, regionId integer NOT NULL, sourceId integer, sourceName text, summary text, thumbImgUrl text, title text, topTime text, isHot bool, isRecommend bool, isSpecial bool, reviewNum integer, showBigPic bool, reviewUserId integer, reviewUserNickName text, reviewUserIconUrl text, reviewContent text)"];           
        }
        
    }];
    
}



- (int)getMaxPageIndex:(int)regionID
{
    __block int pageIndex = 1;
    [[DBManager shareIntance].db inDatabase:^(FMDatabase *db){
        NSString* sql = [NSString stringWithFormat:@"SELECT max(pageNo) FROM news_list_table where regionId=%d", regionID];
        FMResultSet* resultSet = [db executeQuery:sql];
        while ([resultSet next])
        {
            pageIndex = [resultSet intForColumnIndex:0];
        }                
    }];
    
    return pageIndex;
}


- (int)getArtiCleTypeNum:(NewsChannelArticleType)type
{
    int ret = 11;
    switch (type)
    {
        case NewsChannelArticleTypeNormal:
        {
            ret = 11;
        }
            break;
        
        case NewsChannelArticleTypeImage:
        {
            ret = 12;
        }
            break;
            
        default:
            break;
    }
    
    return ret;
}


- (void)loadPage:(int)pageIndex channel:(NewsChannelObject*)channelObject
{
    NSString* userSerialNum = [[UserSerialNumManager shareInstance] getUserSerialNum];
    BOOL bHasImg = ![SettingManager shareInstance].isNoneImageMode;
    int articleType = [self getArtiCleTypeNum:channelObject.articleType];
    NSString* urlStr = [NSString stringWithFormat:@"http://auto.21cn.com/api/client/v2/getRegionArticleList.do?regionId=%d&pageNo=%d&pageSize=10&picSize=s98x72&hasImg=%d&articleType=%d&userSerialNumber=%@", channelObject.regionId, pageIndex, bHasImg, articleType, userSerialNum];
    
    NSURL* url = [NSURL URLWithString:urlStr];
    NSURLRequest *req= [NSURLRequest requestWithURL:url];
    
    LSURLDispatchOperation *op= [[LSURLDispatcher sharedDispatcher] dispatchShortRequest:req delegate:self];
    
    [op start];
}


- (void)loadData:(NewsChannelObject*)channelObject    ///< 加载对应区块（频道）内容
{
    int nextPageIndex = [self getMaxPageIndex:channelObject.regionId] + 1;
    [self loadPage:nextPageIndex channel:channelObject];
}


- (void)refreshData:(NewsChannelObject*)channelObject  ///< 刷新对应区块（频道）内容
{        
    [self loadPage:1 channel:channelObject];
}


- (void)clear:(int)regionId
{
    [[DBManager shareIntance].db inDatabase:^(FMDatabase *db){
        
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM news_list_table WHERE regionId=%d", regionId];
        [db executeUpdate:sql];
        
    }];
}


- (void)notifyNewsListChanged:(NSNumber*)regionId
{
    NSDictionary *userInfo = [[[NSDictionary alloc] initWithObjectsAndKeys:regionId, kParam_ChannelRegionId, nil] autorelease];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNewListLoadFinish object:self userInfo:userInfo];
}


- (void)notifyNewsListLoadFailed
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNewListLoadFailed object:self userInfo:nil];
}


- (void)updataTable:(NSArray*)list
{
    if ([list count] <= 0)
    {
        return;
    }
    
    NewsListItem* firstItem = [list objectAtIndex:0];
    if (firstItem.pageNo == 1)  ///< 第一页，说明是全部刷新，则需要清除表中对应区域的旧数据
    {
        [self clear:firstItem.regionId];
    }
    
    [self checkNewsListTable];
    
    [[DBManager shareIntance].db inDatabase:^(FMDatabase *db){
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];                         
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        int regionId = 0;
        
        for (NewsListItem* item in list)
        {
            ReviewListItem* reviewListItem = nil;
            if ([item.reviewList count] > 0)
            {
                reviewListItem = [item.reviewList objectAtIndex:0];
            }
            
            regionId = item.regionId;
            
            BOOL bRet = [db executeUpdate:@"insert into news_list_table values (?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                         [NSNumber numberWithInt:item.pageNo],
                         [NSNumber numberWithInt:item.articleId],
                         item.articleUrl,
                         [dateFormatter stringFromDate:item.publishTime],
                         [NSNumber numberWithInt:item.regionId],
                         [NSNumber numberWithInt:item.sourceId],
                         item.sourceName,
                         item.summary,
                         item.thumbImgUrl,
                         item.title,
                         [dateFormatter stringFromDate:item.topTime],
                         [NSNumber numberWithBool:item.isHot],
                         [NSNumber numberWithBool:item.isRecommend],
                         [NSNumber numberWithBool:item.isSpecial],
                         [NSNumber numberWithInt:item.reviewNum],
                         [NSNumber numberWithBool:item.showBigPic],
                         [NSNumber numberWithInt:reviewListItem.userId],
                         reviewListItem.userNickName,
                         reviewListItem.userIconUrl,
                         reviewListItem.content
                         ];
            if (!bRet)
            {
                assert(false);
            }
        }
        
        [dateFormatter release];
        
       
        [self performSelectorOnMainThread:@selector(notifyNewsListChanged:) withObject:[NSNumber numberWithInt:regionId] waitUntilDone:NO];
        
    }];
}


- (NSArray*)getNewsList:(int)regionId
{    
    __block NSMutableArray* list = [NSMutableArray arrayWithCapacity:20];
    [[DBManager shareIntance].db inDatabase:^(FMDatabase *db){
        
        NSString* sql = [NSString stringWithFormat:@"select * from news_list_table WHERE regionId=%d", regionId];
        FMResultSet* resultSet = [db executeQuery:sql];
        while ([resultSet next])
        {                       
            int pageNo = [resultSet intForColumn:@"pageNo"];
            int articleId = [resultSet intForColumn:@"articleId"];
            NSString *articleUrl = [resultSet stringForColumn:@"articleUrl"];
            NSString *publishTime = [resultSet stringForColumn:@"publishTime"];
            int sourceId = [resultSet intForColumn:@"sourceId"];
            NSString *sourceName = [resultSet stringForColumn:@"sourceName"];
            NSString *summary = [resultSet stringForColumn:@"summary"];
            NSString *thumbImgUrl = [resultSet stringForColumn:@"thumbImgUrl"];
            NSString *title = [resultSet stringForColumn:@"title"];
            NSString *topTime = [resultSet stringForColumn:@"topTime"];
            BOOL isHot = [resultSet boolForColumn:@"isHot"];
            BOOL isRecommend = [resultSet boolForColumn:@"isRecommend"];
            BOOL isSpecial = [resultSet boolForColumn:@"isSpecial"];
            int reviewNum = [resultSet intForColumn:@"reviewNum"];
            BOOL showBigPic = [resultSet boolForColumn:@"showBigPic"];
            
            int reviewUserId = [resultSet intForColumn:@"reviewUserId"];
            NSString *reviewUserNickName = [resultSet stringForColumn:@"reviewUserNickName"];
            NSString *reviewUserIconUrl = [resultSet stringForColumn:@"reviewUserIconUrl"];
            NSString *reviewContent = [resultSet stringForColumn:@"reviewContent"];
            ReviewListItem* reviewListtem = [ReviewListItem reviewListItemUserId:reviewUserId
                                                                    userNickName:reviewUserNickName
                                                                     userIconUrl:reviewUserIconUrl
                                                                         content:reviewContent];
            NSArray* reviewList = [NSArray arrayWithObject:reviewListtem];
            
            NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

            NewsListItem* item = [NewsListItem newsListItemWithArticleId:articleId
                                                              articleUrl:articleUrl
                                                             publishTime:[dateFormatter dateFromString:publishTime]
                                                                regionId:regionId
                                                                sourceId:sourceId
                                                              sourceName:sourceName
                                                                 summary:summary
                                                             thumbImgUrl:thumbImgUrl
                                                                   title:title
                                                                 topTime:[dateFormatter dateFromString:topTime]
                                                                   isHot:isHot
                                                             isRecommend:isRecommend
                                                               isSpecial:isSpecial
                                                               reviewNum:reviewNum
                                                              showBigPic:showBigPic
                                                              reviewList:reviewList
                                                                  pageNo:pageNo];
            [list addObject:item];            
        }
        
    }];
    
    return list;
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
    [self performSelectorOnMainThread:@selector(notifyNewsListLoadFailed) withObject:nil waitUntilDone:NO];
}


- (void) dispatchOperationDidFinish:(LSURLDispatchOperation *)operation
{
    if (!self.data)
    {
        return;
    }
    
//    const char* buf = (const char*)[self.data bytes];
//    NSData* newData = [NSData dataWithBytes:buf+13 length:strlen(buf) - 19];
//    NSArray* list = [NewsListJSDataPaser parser:newData];
    
    NSArray* list = [NewsListJSDataPaser parser:self.data];
    
    [self updataTable:list];
    
    self.data = nil;
}


- (void)dispatchOperationWillDestoryEx
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNewListLoadFinish object:self userInfo:nil];
}


- (void) dispatchOperationWillDestory:(LSURLDispatchOperation *)operation
{
    [self performSelectorOnMainThread:@selector(dispatchOperationWillDestoryEx) withObject:nil waitUntilDone:NO];    
}

@end
