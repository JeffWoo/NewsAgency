//
//  HotNewsItem.m
//  Model
//
//  Created by chenggk on 13-4-13.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "HotNewsItem.h"

@implementation HotNewsItem


- (id)initWithTitle:(NSString*)title articleUrl:(NSString*)articleUrl
{
    self = [super init];
    if (self)
    {
        _title = [title copy];
        _articleUrl = [articleUrl copy];
    }
    
    return self;
}


+ (HotNewsItem*)hotNewsItemWithTitle:(NSString*)title articleUrl:(NSString*)articleUrl
{
    return [[[HotNewsItem alloc] initWithTitle:title articleUrl:articleUrl] autorelease];
}


- (void)dealloc
{
    [_title release];
    [_articleUrl release];
    
    [super dealloc];
}

@end
