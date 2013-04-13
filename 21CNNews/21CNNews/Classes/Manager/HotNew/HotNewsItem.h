//
//  HotNewsItem.h
//  Model
//
//  Created by chenggk on 13-4-13.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotNewsItem : NSObject

@property (nonatomic, readonly) NSString* title;
@property (nonatomic, readonly) NSString* articleUrl;

+ (HotNewsItem*)hotNewsItemWithTitle:(NSString*)title articleUrl:(NSString*)articleUrl;

@end
