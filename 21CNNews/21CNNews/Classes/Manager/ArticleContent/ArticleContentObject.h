/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: ArticleContentObject.h
 *
 * Description	: 新闻正文结构体，对应服务器返回的json结构
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/6, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>


@interface ArticleContentObject : NSObject

@property (nonatomic, readonly) int articleId;          ///< 新闻ID
@property (nonatomic, readonly) int articleType;        ///< 新闻类型
@property (nonatomic, readonly) NSString* articleUrl;   ///< 新闻对应url
@property (nonatomic, readonly) NSString* content;      ///< 新闻正文内容
@property (nonatomic, readonly) NSDate* createTime;     ///< 新闻创建时间
@property (nonatomic, readonly) NSString* leaderette;
@property (nonatomic, readonly) NSString* originalLink;
@property (nonatomic, readonly) NSDate* publishTime;    ///< 新闻发布时间
@property (nonatomic, readonly) int sourceStatus;
@property (nonatomic, readonly) NSString* title;        ///< 标题
@property (nonatomic, readonly) NSDate* topTime;        ///< 置顶时间
@property (nonatomic, readonly) NSString* sourceName;   
@property (nonatomic, readonly) NSString* summary;


- (id)initWithArticleId:(int)articleId
            articleType:(int)articleType
             articleUrl:(NSString*)articleUrl
                content:(NSString*)content
             createTime:(NSDate*)createTime
             leaderette:(NSString*)leaderette
           originalLink:(NSString*)originalLink
            publishTime:(NSDate*)publishTime
           sourceStatus:(int)sourceStatus
                  title:(NSString*)title
                topTime:(NSDate*)topTime
             sourceName:(NSString*)sourceName
                summary:(NSString*)summary;



+ (ArticleContentObject*)articleContentObjectWithArticleId:(int)articleId
                                               articleType:(int)articleType
                                                articleUrl:(NSString*)articleUrl
                                                   content:(NSString*)content
                                                createTime:(NSDate*)createTime
                                                leaderette:(NSString*)leaderette
                                              originalLink:(NSString*)originalLink
                                               publishTime:(NSDate*)publishTime
                                              sourceStatus:(int)sourceStatus
                                                     title:(NSString*)title
                                                   topTime:(NSDate*)topTime
                                                sourceName:(NSString*)sourceName
                                                   summary:(NSString*)summary;


@end
