//
//  UserSerialNumJSDataParser.m
//  Model
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

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
