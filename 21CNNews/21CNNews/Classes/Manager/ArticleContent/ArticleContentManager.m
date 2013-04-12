//
//  ArticleContentObject.m
//  Model
//
//  Created by chenggk on 13-4-7.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "ArticleContentManager.h"
#import "LSThreadPool.h"
#import "LSURLDispatcher.h"
#import "LSURLDispatchOperation.h"
#import "LSURLDispatchDelegate.h"
#import "DBCommonHeader.h"
#import "ServicerCommonKey.h"
#import "UserSerialNumManager.h"
#import "ArticleContentJSDataParser.h"
#import "ArticleContentObject.h"
#import "ArticleContentNotifyKey.h"

@interface ArticleContentManager()<LSURLDispatchDelegate>

@property (nonatomic, retain) NSMutableData* data;

@end


@implementation ArticleContentManager

+ (ArticleContentManager*)shareInstance
{
    static ArticleContentManager* g_instance = nil;
    
    if (nil == g_instance)
    {
        @synchronized(@"ArticleContentManager")
        {
            if (nil == g_instance)
            {
                g_instance = [[ArticleContentManager alloc] init];
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


- (void)checkArticleContentTable
{
    [[DBManager shareIntance].db inDatabase:^(FMDatabase *db){
        
        FMResultSet* resultSet = [db executeQuery:@"SELECT count(*) FROM sqlite_master WHERE type='table' AND name='article_content_table'"];
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
            [db executeUpdate:@"CREATE TABLE article_content_table (articleId integer NOT NULL PRIMARY KEY, articleType integer, content text, createTime text, leaderette text, originalLink text, publishTime text, sourceStatus integer, title text, topTime text, sourceName text, summary text)"];
        }
        
    }];
    
}


- (void)loadArticleContent:(int)articleId imageSize:(CGSize)imageSize
{
    NSString* userSerialNum = [[UserSerialNumManager shareInstance] getUserSerialNum];
    
    NSString* urlStr = [NSString stringWithFormat:@"http://auto.21cn.com/api/client/v2/getArticleContent.do?articleId=%d&picSize=m350&userSerialNumber=%@", articleId, userSerialNum];
    
    NSURL* url = [NSURL URLWithString:urlStr];
    NSURLRequest *req= [NSURLRequest requestWithURL:url];
    
    LSURLDispatchOperation *op= [[LSURLDispatcher sharedDispatcher] dispatchShortRequest:req delegate:self];
    
    [op start];
}


- (void)notifyArticleContentUpdate:(ArticleContentObject*)object
{
//    UIWebView* webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    [webview loadHTMLString:object.content baseURL:nil];
//    [[[UIApplication sharedApplication] keyWindow] addSubview:webview];
    
    
    NSDictionary *userInfo = [[[NSDictionary alloc] initWithObjectsAndKeys:object, kParam_ArticleObject, nil] autorelease];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyArticleContentUpdate object:self userInfo:userInfo];
}


- (void)updataTable:(ArticleContentObject*)object
{
    if (!object)
    {
        return;
    }
    
    [self checkArticleContentTable];
                
    [[DBManager shareIntance].db inDatabase:^(FMDatabase *db){
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        [db executeUpdate:@"insert into article_content_table values (?,?,?,?,?,?,?,?,?,?,?,?)",
                         [NSNumber numberWithInt:object.articleId],
                         [NSNumber numberWithInt:object.articleType],
                         object.content,
                         [dateFormatter stringFromDate:object.createTime],
                         object.leaderette,
                         object.originalLink,
                         [dateFormatter stringFromDate:object.publishTime],
                         [NSNumber numberWithBool:object.sourceStatus],
                         object.title,
                         [dateFormatter stringFromDate:object.topTime],
                         object.sourceName,
                         object.summary
                         ];

        
        [dateFormatter release];
                    
        [self performSelectorOnMainThread:@selector(notifyArticleContentUpdate:) withObject:object waitUntilDone:NO];
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
    
    ArticleContentObject* object = [ArticleContentJSDataParser parser:self.data];
        
    [self updataTable:object];
    
    self.data = nil;
}



- (void) dispatchOperationWillDestory:(LSURLDispatchOperation *)operation
{
    
}


@end
