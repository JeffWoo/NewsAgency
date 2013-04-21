/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: NewsChannelObject.m
 *
 * Description	: 新闻频道列表数据结构
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import "NewsChannelObject.h"

@implementation NewsChannelObject

+ (NewsChannelObject*)newsChannelObjectWithTitle:(NSString*)title
                                        regionId:(NSInteger)regionId
                                     articleType:(NewsChannelArticleType)articleType
                                     thumbImgUrl:(NSString*)thumbImgUrl
                                   isCurrentPage:(BOOL)isCurrentPage
{
    return [[[NewsChannelObject alloc] initWithWithTitle:title
                                                regionId:regionId
                                             articleType:articleType
                                             thumbImgUrl:thumbImgUrl
                                           isCurrentPage:isCurrentPage] autorelease];
}


- (id)initWithWithTitle:(NSString*)title
               regionId:(NSInteger)regionId
            articleType:(NewsChannelArticleType)articleType
            thumbImgUrl:(NSString*)thumbImgUrl
          isCurrentPage:(BOOL)isCurrentPage
{
    self = [super init];
    if (self)
    {
        _title = [title copy];
        _regionId = regionId;
        _articleType = articleType;
        _thumbImgUrl = [thumbImgUrl copy];
        _isCurrentPage = isCurrentPage;
    }
    
    return self;
}


- (void)dealloc
{
    [_title release];
    [_thumbImgUrl release];
    [super dealloc];
}

@end
