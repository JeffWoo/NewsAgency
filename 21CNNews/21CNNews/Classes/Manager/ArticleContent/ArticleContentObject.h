//
//  ArticleContentObject.h
//  Model
//
//  Created by chenggk on 13-4-7.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ArticleContentObject : NSObject

@property (nonatomic, readonly) int articleId;
@property (nonatomic, readonly) int articleType;
@property (nonatomic, readonly) NSString* articleUrl;
@property (nonatomic, readonly) NSString* content;
@property (nonatomic, readonly) NSDate* createTime;
@property (nonatomic, readonly) NSString* leaderette;
@property (nonatomic, readonly) NSString* originalLink;
@property (nonatomic, readonly) NSDate* publishTime;
@property (nonatomic, readonly) int sourceStatus;
@property (nonatomic, readonly) NSString* title;
@property (nonatomic, readonly) NSDate* topTime;
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
