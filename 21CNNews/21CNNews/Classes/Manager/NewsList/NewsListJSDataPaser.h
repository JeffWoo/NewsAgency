//
//  NewsListJSDataPaser.h
//  Model
//
//  Created by chenggk on 13-4-6.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsListJSDataPaser : NSObject

+ (NSArray*)parser:(NSData*)jsData;

@end
