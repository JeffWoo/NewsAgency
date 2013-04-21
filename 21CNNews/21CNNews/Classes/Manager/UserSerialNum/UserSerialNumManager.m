/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: UserSerialNumManager.m
 *
 * Description	: app序列号管理器，主要进行app序列号的更新获取及管理工作
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import "UserSerialNumManager.h"
#import "ServicerDefine.h"
#import "DBCommonHeader.h"
#import "ServicerCommonKey.h"
#import "iPhoneTools.h"
#import "LSURLDispatcher.h"
#import "UserSerialNumJSDataParser.h"
#import "UserSerialNumNotificationKeys.h"

@interface UserSerialNumManager()

@property (nonatomic, retain) NSMutableData* data;

@end



@implementation UserSerialNumManager

@synthesize userSerialNum = _userSerialNum;

+ (UserSerialNumManager*)shareInstance
{
    static UserSerialNumManager* g_instance = nil;
    
    if (nil == g_instance)
    {
        @synchronized(@"UserSerialNumManager")
        {
            if (nil == g_instance)
            {
                g_instance = [[UserSerialNumManager alloc] init];
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
        
    }
    
    return self;
}


- (void)dealloc
{
    [_userSerialNum release];
    [_data release];
    
    [super dealloc];
}


- (void)checkUserSerialNum  ///< 检测并更新app序列号
{
    if (![self checkAndCreateUserSerialNumTable])
    {
        return;
    }
    
    NSString* imei = [iPhoneTools getIMEI];
    NSString* urlStr = [NSString stringWithFormat:@"%@%@&imeiCode=%@&imsiCode=%@", UserSerialNumServicerUrl, IOSAPPID, imei, imei];
    
    NSURL *url= [NSURL URLWithString:urlStr];
    NSURLRequest *req= [NSURLRequest requestWithURL:url];
    
    LSURLDispatchOperation *op= [[LSURLDispatcher sharedDispatcher] dispatchShortRequest:req delegate:self];    ///< 建立一个http请求，该任务将在子线程执行，具体操作逻辑，均封装于LSURLDispatchOperation内部
    
    [op start]; ///< 启动任务
}


///< 检测是否创建app序列号所对应的数据库表格
- (BOOL)checkAndCreateUserSerialNumTable
{
    __block BOOL bNeedToCreateTable = YES;
    [[DBManager shareIntance].db inDatabase:^(FMDatabase *db){
        
        FMResultSet* resultSet = [db executeQuery:@"SELECT count(*) FROM sqlite_master WHERE type='table' AND name='user_serial_num_table'"];        
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
            [db executeUpdate:@"CREATE TABLE user_serial_num_table (userSerialNum text NOT NULL PRIMARY KEY)"];
        }
        
    }];
    
    return bNeedToCreateTable;
}


//获取app序列号
- (NSString*)getUserSerialNum
{
    if (!_userSerialNum)
    {
        __block NSString* serialNum = nil;
        [[DBManager shareIntance].db inDatabase:^(FMDatabase *db){
            
            FMResultSet* resultSet = [db executeQuery:@"select * from user_serial_num_table"];
            while ([resultSet next])
            {
                serialNum = [resultSet stringForColumn:@"userSerialNum"];
                break;
            }            
        }];
        
        @synchronized(self)
        {
            [_userSerialNum release];
            _userSerialNum = [serialNum copy];
        }
    }
    
    return _userSerialNum;
}


//更新app序列号
- (void)updataUserSerialNum:(NSString*)userSerialNum
{
    @synchronized(self)
    {
        [_userSerialNum release];
        _userSerialNum = [userSerialNum copy];
    }
    
    [[DBManager shareIntance].db inDatabase:^(FMDatabase *db){
        
        BOOL bRet = [db executeUpdate:@"insert into user_serial_num_table values (?)", userSerialNum];
        if (!bRet)
        {
            assert(false);
        }
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserSerialNumDidChanged object:self userInfo:nil];
}


#pragma mark LSURLDispatchDelegate
//注意：以下回调均发生在子线程
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


//成功接收到网络回调
- (void) dispatchOperationDidFinish:(LSURLDispatchOperation *)operation
{
    NSString* userSerialNum = [UserSerialNumJSDataParser parser:self.data]; ///< 解析json数据，获取app序列号
    if (userSerialNum)
    {
        [self performSelectorOnMainThread:@selector(updataUserSerialNum:) withObject:userSerialNum waitUntilDone:NO];   ///< 主线程更新app序列号
    }
    
    self.data = nil;
}


- (void) dispatchOperationWillDestory:(LSURLDispatchOperation *)operation
{
    
}

@end
