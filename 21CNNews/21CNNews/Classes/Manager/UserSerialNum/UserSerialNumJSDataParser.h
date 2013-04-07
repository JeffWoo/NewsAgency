//
//  UserSerialNumJSDataParser.h
//  Model
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSerialNumJSDataParser : NSObject

+ (NSString*)parser:(NSData*)jsData;

@end
