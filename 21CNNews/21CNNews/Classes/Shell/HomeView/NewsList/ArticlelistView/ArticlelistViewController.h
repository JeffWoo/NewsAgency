/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: ArticlelistViewController.h
 *
 * Description	: 普通新闻列表view controller
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import <UIKit/UIKit.h>
#import "AriticleListViewDelegate.h"

@class NewsChannelObject;

@interface ArticlelistViewController : UIViewController

@property (nonatomic, assign) id<AriticleListViewDelegate> delegate;

//在parentView中展现
- (void)showInViwe:(UIView*)parentView frame:(CGRect)frame;

//加载一个新闻频道
- (void)loadChannel:(NewsChannelObject*)channelObject;

@end
