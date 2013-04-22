/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: NewsListCommonDef.h
 *
 * Description	: 新闻数据结构，对应服务器返回的json数据
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/6, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>

@interface NewsListItem : NSObject

@property (nonatomic, readonly) int articleId;          ///< 新闻id
@property (nonatomic, readonly) NSString* articleUrl;   ///< 新闻内容对应url
@property (nonatomic, readonly) NSDate* publishTime;    ///< 发表时间
@property (nonatomic, readonly) int regionId;           ///< 该新闻所对应的新闻频道
@property (nonatomic, readonly) int sourceId;
@property (nonatomic, readonly) NSString* sourceName;
@property (nonatomic, readonly) NSString* summary;      ///< 新闻正文简述
@property (nonatomic, readonly) NSString* thumbImgUrl;  ///< 新闻图片url
@property (nonatomic, readonly) NSString* title;        ///< 新闻标题
@property (nonatomic, readonly) NSDate* topTime;        ///< 置顶时间
@property (nonatomic, readonly) BOOL isHot;             ///< 是否hot新闻
@property (nonatomic, readonly) BOOL isRecommend;
@property (nonatomic, readonly) BOOL isSpecial;
@property (nonatomic, readonly) int reviewNum;          ///< 评论个数
@property (nonatomic, readonly) BOOL showBigPic;        ///< 是否展现大图新闻
@property (nonatomic, readonly) NSArray* reviewList;    ///< 评论列表
@property (nonatomic, readonly) int pageNo;



- (id)initWithArticleId:(int)articleId
             articleUrl:(NSString*)articleUrl
            publishTime:(NSDate*)publishTime
               regionId:(int)regionId
               sourceId:(int)sourceId
             sourceName:(NSString*)sourceName
                summary:(NSString*)summary
            thumbImgUrl:(NSString*)thumbImgUrl
                  title:(NSString*)title
                topTime:(NSDate*)topTime
                  isHot:(BOOL)isHot
            isRecommend:(BOOL)isRecommend
              isSpecial:(BOOL)isSpecial
              reviewNum:(int)reviewNum
             showBigPic:(BOOL)showBigPic
             reviewList:(NSArray*)reviewList
                 pageNo:(int)pageNo;


+ (NewsListItem*)newsListItemWithArticleId:(int)articleId
                                articleUrl:(NSString*)articleUrl
                               publishTime:(NSDate*)publishTime
                                  regionId:(int)regionId
                                  sourceId:(int)sourceId
                                sourceName:(NSString*)sourceName
                                   summary:(NSString*)summary
                               thumbImgUrl:(NSString*)thumbImgUrl
                                     title:(NSString*)title
                                   topTime:(NSDate*)topTime
                                     isHot:(BOOL)isHot
                               isRecommend:(BOOL)isRecommend
                                 isSpecial:(BOOL)isSpecial
                                 reviewNum:(int)reviewNum
                                showBigPic:(BOOL)showBigPic
                                reviewList:(NSArray*)reviewList
                                    pageNo:(int)pageNo;


@end
