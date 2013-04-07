//
//  SplashManager.m
//  Model
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "SplashManager.h"
#import "LSThreadPool.h"
#import "LSURLDispatcher.h"
#import "LSURLDispatchOperation.h"
#import "iPhoneTools.h"
#import "LSURLDispatchDelegate.h"
#import "JSONKit.h"
#import "ImageLoder.h"
#import <UIKit/UIKit.h>

#define __SplashManager_SplashImage_Expire_Time__       @"__SplashManager_SplashImage_Expire_Time__"
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


- (NSString*)getSplashImagePath
{
    return [NSString stringWithFormat:@"%@/spalsh/Default.png", [iPhoneTools documentPath]];
}


- (BOOL)isHasSplashImage
{
    NSString* splashImagePath = [self getSplashImagePath];
    
    BOOL bRet = [iPhoneTools isFileExists:splashImagePath];
    if (bRet)
    {
        NSDate* expireTime = [[NSUserDefaults standardUserDefaults] objectForKey:__SplashManager_SplashImage_Expire_Time__];
        bRet = (expireTime == [expireTime laterDate:[NSDate date]]);
    }
    
    return bRet;
}


- (void)checkAndUpDataSplashImage
{
    NSURL *url= [NSURL URLWithString:@"http://k.21cn.com/cloundapp/api/getSplashImages.do?accessToken=fewtewtew&userSerialNum=qewq"];
    NSURLRequest *req= [NSURLRequest requestWithURL:url];
    
    LSURLDispatchOperation *op= [[LSURLDispatcher sharedDispatcher] dispatchShortRequest:req delegate:self];
    
    [op start];
}


- (UIImage* )getSplashImage
{
    if ([self isHasSplashImage])
    {
        return [UIImage imageWithContentsOfFile:[self getSplashImagePath]];
    }
    
    return [UIImage imageNamed:@"Default.png"];
}


- (void)dealResult:(NSData*)jsData
{
    JSONDecoder *jd = [[[JSONDecoder alloc] init] autorelease];
    
    NSDictionary *jsRet = [jd objectWithData:jsData];
    
    NSString* imageURL = [jsRet objectForKey:@"imgSrc"];
    NSString* expireTime = [jsRet objectForKey:@"expireTime"];
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *expireData = nil;
//    NSDate *expireData = [dateFormatter dateFromString:expireTime];
//    if (!expireTime)
    {
        expireData = [NSDate distantFuture];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:expireData forKey:__SplashManager_SplashImage_Expire_Time__];
    
    
    NSString* oldImageUrl = [[NSUserDefaults standardUserDefaults] objectForKey:__SplashManager_SplashImage_URL__];
    
    if (!(oldImageUrl && [oldImageUrl isEqualToString:imageURL]))
    {
        [[NSUserDefaults standardUserDefaults] setObject:imageURL forKey:__SplashManager_SplashImage_URL__];
        [self.imageLoader loadImage:imageURL toFile:[self getSplashImagePath]];
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
