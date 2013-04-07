//
//  ReviewListItem.m
//  Model
//
//  Created by chenggk on 13-4-6.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

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
