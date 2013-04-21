/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: NewsListCommonDef.h
 *
 * Description	: 新闻评论数据结构
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/6, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>

@interface ReviewListItem : NSObject

@property (nonatomic, readonly) int userId;             ///< 用户id
@property (nonatomic, readonly) NSString* userNickName; ///< 用户名
@property (nonatomic, readonly) NSString* userIconUrl;  ///< 用户头像url
@property (nonatomic, readonly) NSString* content;      ///< 评论内容


- (id)initWithUserId:(int)userId
        userNickName:(NSString*)userNickName
         userIconUrl:(NSString*)userIconUrl
             content:(NSString*)content;


+ reviewListItemUserId:(int)userId
          userNickName:(NSString*)userNickName
           userIconUrl:(NSString*)userIconUrl
               content:(NSString*)content;

@end
