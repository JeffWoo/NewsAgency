/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: SplashManager.m
 *
 * Description	: 启动画面管理器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import "SplashManager.h"
#import "LSThreadPool.h"
#import "LSURLDispatcher.h"
#import "LSURLDispatchOperation.h"
#import "iPhoneTools.h"
#import "LSURLDispatchDelegate.h"
#import "JSONKit.h"
#import "ImageLoder.h"
#import <UIKit/UIKit.h>

//启动图片过期时间
#define __SplashManager_SplashImage_Expire_Time__       @"__SplashManager_SplashImage_Expire_Time__"

//启动图片对应url
#define __SplashManager_SplashImage_URL__               @"__SplashManager_SplashImage_URL__"

@interface SplashManager()<LSURLDispatchDelegate>

@property (nonatomic, retain) NSMutableData* data;
@property (nonatomic, retain) ImageLoder* imageLoader;

@end



@implementation SplashManager

+ (SplashManager*)shareInstance
{
    static SplashManager* g_instance = nil;
    
    if (nil == g_instance)
    {
        @synchronized(@"SplashManager")
        {
            if (nil == g_instance)
            {
                g_instance = [[SplashManager alloc] init];
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
        _imageLoader = [[ImageLoder alloc] init];
    }
    
    return self;
}


- (void)dealloc
{
    [_imageLoader release];
    
    [_data release];
    [super dealloc];
}


//获取启动图片
- (NSString*)getSplashImagePath
{
    return [NSString stringWithFormat:@"%@/spalsh/Default.png", [iPhoneTools documentPath]];
}


//检测启动图片是否存在
- (BOOL)isHasSplashImage
{
    NSString* splashImagePath = [self getSplashImagePath];
    
    BOOL bRet = [iPhoneTools isFileExists:splashImagePath]; ///< 启动图片是否存在
    if (bRet)
    {
        NSDate* expireTime = [[NSUserDefaults standardUserDefaults] objectForKey:__SplashManager_SplashImage_Expire_Time__];
        bRet = (expireTime == [expireTime laterDate:[NSDate date]]);    ///< 检测启动图片是否超过可展现时间
    }
    
    return bRet;
}

//检测并更新启动图片
- (void)checkAndUpDataSplashImage
{
    NSURL *url= [NSURL URLWithString:@"http://k.21cn.com/cloundapp/api/getSplashImages.do?accessToken=fewtewtew&userSerialNum=qewq"];
    NSURLRequest *req= [NSURLRequest requestWithURL:url];
    
    LSURLDispatchOperation *op= [[LSURLDispatcher sharedDispatcher] dispatchShortRequest:req delegate:self];
    
    [op start];
}


//获取启动图片
- (UIImage* )getSplashImage
{
    if ([self isHasSplashImage])
    {
        return [UIImage imageWithContentsOfFile:[self getSplashImagePath]];
    }
    
    //如果不存在服务器下发的可用图片，则使用默认启动图片
    return [UIImage imageNamed:@"Default.png"];
}


//处理服务器返回的json数据
- (void)dealResult:(NSData*)jsData
{
    JSONDecoder *jd = [[[JSONDecoder alloc] init] autorelease];
    
    NSDictionary *jsRet = [jd objectWithData:jsData];
    
    NSString* imageURL = [jsRet objectForKey:@"imgSrc"];        ///< 获取图片url
    NSString* expireTime = [jsRet objectForKey:@"expireTime"];  ///< 获取过期时间
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSDate *expireData = nil;
    @try
    {
        expireData = [dateFormatter dateFromString:expireTime];
    }@catch (NSException * e)
    {
        expireData = nil;
    }
    
    if (!expireTime)    ///< 如果服务器返回的过期时间不符合协议标准或者不存在，则认为该启动图片当天过期
    {
        expireData = [NSDate date];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:expireData forKey:__SplashManager_SplashImage_Expire_Time__];  ///< 记录过期时间
    
    
    NSString* oldImageUrl = [[NSUserDefaults standardUserDefaults] objectForKey:__SplashManager_SplashImage_URL__]; ///< 获取久启动图片url
    
    if (!(oldImageUrl && [oldImageUrl isEqualToString:imageURL]))   ///< 图片url是否发生变化
    {
        [[NSUserDefaults standardUserDefaults] setObject:imageURL forKey:__SplashManager_SplashImage_URL__];    ///< 记录新的启动图片url
        [self.imageLoader loadImage:imageURL toFile:[self getSplashImagePath]]; ///< 加载启动图片
    }
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
    [self performSelectorOnMainThread:@selector(dealResult:) withObject:self.data waitUntilDone:YES];
            
    self.data = nil;
}


- (void) dispatchOperationWillDestory:(LSURLDispatchOperation *)operation
{
    
}

@end
