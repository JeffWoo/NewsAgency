//
//  UserSerialNumManager.m
//  Model
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

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


- (void)checkUserSerialNum
{
    if (![self checkAndCreateUserSerialNumTable])
    {
        return;
    }
    
    NSString* imei = [iPhoneTools getIMEI];
    NSString* urlStr = [NSString stringWithFormat:@"%@%@&imeiCode=%@&imsiCode=%@", UserSerialNumServicerUrl, IOSAPPID, imei, imei];
    
    NSURL *url= [NSURL URLWithString:urlStr];
    NSURLRequest *req= [NSURLRequest requestWithURL:url];
    
    LSURLDispatchOperation *op= [[LSURLDispatcher sharedDispatcher] dispatchShortRequest:req delegate:self];
    
    [op start];
}



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
    NSString* userSerialNum = [UserSerialNumJSDataParser parser:self.data];
    if (userSerialNum)
    {
        [self performSelectorOnMainThread:@selector(updataUserSerialNum:) withObject:userSerialNum waitUntilDone:NO];
    }
    
    self.data = nil;
}


- (void) dispatchOperationWillDestory:(LSURLDispatchOperation *)operation
{
    
}

@end
