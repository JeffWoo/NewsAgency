//
//  NewsChannelJSDataParser.h
//  Model
//
//  Created by chenggk on 13-4-4.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewChannelList;

@interface NewsChannelJSDataParser : NSObject

+ (NewChannelList*)parser:(NSData*)jsData;

@end
