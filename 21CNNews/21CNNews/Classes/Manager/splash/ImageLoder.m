//
//  ImageLoder.m
//  Model
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

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
    [iPhoneTools createDirIfNoExists:[filePath stringByDeletingLastPathComponent]];
    
    NSURL *url= [NSURL URLWithString:imageURL];
    NSURLRequest *req= [NSURLRequest requestWithURL:url];
    
    LSURLDispatchOperation *op= [[LSURLDispatcher sharedDispatcher] dispatchShortRequest:req delegate:self];
    
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
    [self.data writeToFile:self.imagePath atomically:YES];
    
    self.data = nil;
}


- (void) dispatchOperationWillDestory:(LSURLDispatchOperation *)operation
{
    
}

@end
