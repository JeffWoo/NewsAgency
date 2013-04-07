//
//  NewsChannelObject.h
//  Model
//
//  Created by chenggk on 13-4-4.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum NewsChannelArticleType
{
	NewsChannelArticleTypeNormal = 0,
    NewsChannelArticleTypeImage = 1
}NewsChannelArticleType;



@interface NewsChannelObject : NSObject

@property (nonatomic, readonly) NSString* title;
@property (nonatomic, readonly) NSString* thumbImgUrl;
@property (nonatomic, readonly) NSInteger regionId;
@property (nonatomic, readonly) NewsChannelArticleType articleType;
@property (nonatomic, readonly) BOOL isCurrentPage;

+ (NewsChannelObject*)newsChannelObjectWithTitle:(NSString*)title
                                        regionId:(NSInteger)regionId
                                     articleType:(NewsChannelArticleType)articleType
                                     thumbImgUrl:(NSString*)thumbImgUrl
                                   isCurrentPage:(BOOL)isCurrentPage;

@end
