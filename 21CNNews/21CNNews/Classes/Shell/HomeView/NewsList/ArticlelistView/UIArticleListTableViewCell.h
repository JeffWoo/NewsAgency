//
//  UIArticleListTableViewCell.h
//  Shell
//
//  Created by chenggk on 13-4-6.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsListItem;

@interface UIArticleListTableViewCell : UITableViewCell

- (void)setNewsListItem:(NewsListItem*)item;

@end
