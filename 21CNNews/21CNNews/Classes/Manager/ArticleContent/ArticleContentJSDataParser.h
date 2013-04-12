//
//  ArticleContentJSDataParser.h
//  Model
//
//  Created by chenggk on 13-4-7.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ArticleContentObject;

@interface ArticleContentJSDataParser : NSObject

+ (ArticleContentObject*)parser:(NSData*)jsData;

@end
