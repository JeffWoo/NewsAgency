/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: UserSerialNumJSDataParser.m
 *
 * Description	: app序列号协议解析器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import "UserSerialNumJSDataParser.h"
#import "JSONKit.h"

@implementation UserSerialNumJSDataParser

+ (NSString*)parser:(NSData*)jsData
{
    JSONDecoder *jd = [[[JSONDecoder alloc] init] autorelease];
    
    NSDictionary *jsRet = [jd objectWithData:jsData];  
    
    return (NSString*)[jsRet objectForKey:@"userSerialNum"];
}

@end
