/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: HotNewsButton.h
 *
 * Description	: 热点新闻项按钮
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/13, chenggk, Create the file
 ***************************************************************************************
 **/

#import <UIKit/UIKit.h>

@class HotNewsItem;

@interface HotNewsButton : UIButton

- (void)setHotNewsItem:(HotNewsItem*)item;

@end
