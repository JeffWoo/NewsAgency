/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: ArticleContentManager.h
 *
 * Description	: 新闻正文管理器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/6, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ArticleContentManager : NSObject

//获取单例对象
+ (ArticleContentManager*)shareInstance;

//加载对应新闻
//服务器返回的图片大小需要由客户端指定
- (void)loadArticleContent:(int)articleId imageSize:(CGSize)imageSize;

@end
