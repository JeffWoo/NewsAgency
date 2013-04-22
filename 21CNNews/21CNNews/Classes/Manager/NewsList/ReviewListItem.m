/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: NewsListCommonDef.m
 *
 * Description	: 新闻评论数据结构
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/6, chenggk, Create the file
 ***************************************************************************************
 **/

#import "ReviewListItem.h"

@implementation ReviewListItem

- (id)initWithUserId:(int)userId userNickName:(NSString*)userNickName userIconUrl:(NSString*)userIconUrl content:(NSString*)content
{
    self = [super init];
    if (self)
    {
        _userId = userId;
        _userNickName = [userNickName copy];
        _userIconUrl = [userIconUrl copy];
        _content = [content copy];
    }
    
    return self;
}


+ reviewListItemUserId:(int)userId userNickName:(NSString*)userNickName userIconUrl:(NSString*)userIconUrl content:(NSString*)content
{
    return [[[ReviewListItem alloc] initWithUserId:userId userNickName:userNickName userIconUrl:userIconUrl content:content] autorelease];
}


- (void)dealloc
{
    [_userNickName release];
    [_userIconUrl release];
    [_content release];
    
    [super dealloc];
}

@end
