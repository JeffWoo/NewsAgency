//
//  NewsChannelObject.m
//  Model
//
//  Created by chenggk on 13-4-4.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

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
