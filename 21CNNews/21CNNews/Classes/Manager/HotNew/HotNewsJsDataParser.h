//
//  HotNewsJsDataParser.h
//  Model
//
//  Created by chenggk on 13-4-13.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotNewsJsDataParser : NSObject

+ (NSArray*)parser:(NSData*)jsData;

@end
