//
//  LSURLDispatchOperation.h
//  Lightstreamer Thread Pool Library
//
//  Created by Gianluca Bertani on 03/09/12.
//  Copyright (c) 2012-2013 Weswit srl. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions
//  are met:
//
//  * Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//  * Neither the name of Weswit srl nor the names of its contributors
//    may be used to endorse or promote products derived from this software
//    without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.
//

#import <Foundation/Foundation.h>
#import "LSURLDispatchDelegate.h"


@class LSURLDispatcherThread;
@class LSInvocation;

@interface LSURLDispatchOperation : NSObject {
	NSURLRequest *_request;
	NSString *_endPoint;
	id <LSURLDispatchDelegate> _delegate;
	BOOL _gathedData;
	BOOL _isLong;

	LSURLDispatcherThread *_thread;
	NSURLConnection *_connection;
	NSCondition *_waitForCompletion;
	
	NSURLResponse *_response;
	NSError *_error;
	NSMutableData *_data;
}


#pragma mark -
#pragma mark Initialization
//构造函数：建立一个http请求对象
- (id) initWithURLRequest:(NSURLRequest *)request endPoint:(NSString *)endPoint delegate:(id <LSURLDispatchDelegate>)delegate gatherData:(BOOL)gatherData isLong:(BOOL)isLong;


#pragma mark -
#pragma mark Execution

- (void) start;             ///< 启动http请求
- (void) waitForCompletion; ///< 等待请求完成
- (void) cancel;            ///< 取消请求


#pragma mark -
#pragma mark Properties

@property (nonatomic, readonly) NSURLRequest *request;
@property (nonatomic, readonly) NSString *endPoint;
@property (nonatomic, readonly) BOOL isLong;

@property (nonatomic, readonly) LSURLDispatcherThread *thread;

@property (nonatomic, readonly) NSURLResponse *response;
@property (nonatomic, readonly) NSError *error;
@property (nonatomic, readonly) NSData *data;


@end
