//
//  NewsListItem.h
//  Model
//
//  Created by chenggk on 13-4-6.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsListItem : NSObject

@property (nonatomic, readonly) int articleId;
@property (nonatomic, readonly) NSString* articleUrl;
@property (nonatomic, readonly) NSDate* publishTime;
@property (nonatomic, readonly) int regionId;
@property (nonatomic, readonly) int sourceId;
@property (nonatomic, readonly) NSString* sourceName;
@property (nonatomic, readonly) NSString* summary;
@property (nonatomic, readonly) NSString* thumbImgUrl;
@property (nonatomic, readonly) NSString* title;
@property (nonatomic, readonly) NSDate* topTime;
@property (nonatomic, readonly) BOOL isHot;
@property (nonatomic, readonly) BOOL isRecommend;
@property (nonatomic, readonly) BOOL isSpecial;
@property (nonatomic, readonly) int reviewNum;
@property (nonatomic, readonly) BOOL showBigPic;
@property (nonatomic, readonly) NSArray* reviewList;
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
