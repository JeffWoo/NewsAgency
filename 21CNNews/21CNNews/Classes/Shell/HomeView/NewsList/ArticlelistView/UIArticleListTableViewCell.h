/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: UIArticleListTableViewCell.h
 *
 * Description	: 普通新闻列表table view cell
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import <UIKit/UIKit.h>

@class NewsListItem;

@interface UIArticleListTableViewCell : UITableViewCell

- (void)setNewsListItem:(NewsListItem*)item;

@end
