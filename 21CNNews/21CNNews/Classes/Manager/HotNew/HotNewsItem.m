/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: HotNewsItem.mm
 *
 * Description	: 热地新闻结构
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/13, chenggk, Create the file
 ***************************************************************************************
 **/

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
