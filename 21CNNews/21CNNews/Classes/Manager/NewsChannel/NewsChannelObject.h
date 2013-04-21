/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: NewsChannelObject.h
 *
 * Description	: 新闻频道数据结构
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>

//新闻类型
typedef enum NewsChannelArticleType
{
	NewsChannelArticleTypeNormal = 0,   ///< 普通新闻类型
    NewsChannelArticleTypeImage = 1     ///< 图片新闻
}NewsChannelArticleType;



@interface NewsChannelObject : NSObject

@property (nonatomic, readonly) NSString* title;        ///< 频道标题
@property (nonatomic, readonly) NSString* thumbImgUrl;  ///< 频道图片对应url
@property (nonatomic, readonly) NSInteger regionId;     ///< 频道ID
@property (nonatomic, readonly) NewsChannelArticleType articleType;
@property (nonatomic, readonly) BOOL isCurrentPage;     ///< 是否默认频道

+ (NewsChannelObject*)newsChannelObjectWithTitle:(NSString*)title
                                        regionId:(NSInteger)regionId
                                     articleType:(NewsChannelArticleType)articleType
                                     thumbImgUrl:(NSString*)thumbImgUrl
                                   isCurrentPage:(BOOL)isCurrentPage;

@end
