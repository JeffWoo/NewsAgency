/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: ImageLoder.m
 *
 * Description	: 图片加载器：负责加载一个图片，并将其保存到磁盘中
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import "ImageLoder.h"
#import "LSThreadPool.h"
#import "LSURLDispatcher.h"
#import "LSURLDispatchOperation.h"
#import "LSURLDispatchDelegate.h"
#import "iPhoneTools.h"

@interface ImageLoder()<LSURLDispatchDelegate>

@property (nonatomic, retain) NSMutableData* data;
@property (nonatomic, retain) NSString* imagePath;

@end


@implementation ImageLoder

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
    [_data release];
    [_imagePath release];
    
    [super dealloc];
}


- (void)loadImage:(NSString*)imageURL toFile:(NSString*)filePath
{
    self.imagePath = filePath;
    [iPhoneTools createDirIfNoExists:[filePath stringByDeletingLastPathComponent]]; ///< 如果对应路径不存在，则创建一个
    
    NSURL *url= [NSURL URLWithString:imageURL];
    NSURLRequest *req= [NSURLRequest requestWithURL:url];
    
    LSURLDispatchOperation *op= [[LSURLDispatcher sharedDispatcher] dispatchShortRequest:req delegate:self];    ///< 建立http请求
    
    [op start];        
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
    [self.data writeToFile:self.imagePath atomically:YES];  ///< 将图片数据写入磁盘中
    
    self.data = nil;
}


- (void) dispatchOperationWillDestory:(LSURLDispatchOperation *)operation
{
    
}

@end
