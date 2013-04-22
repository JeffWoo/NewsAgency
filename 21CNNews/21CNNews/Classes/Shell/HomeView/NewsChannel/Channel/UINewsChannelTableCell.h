/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: UINewsChannelTableCell.h
 *
 * Description	: 新闻频道table view cell
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/4, chenggk, Create the file
 ***************************************************************************************
 **/

#import <UIKit/UIKit.h>

@interface UINewsChannelTableCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style frame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setImageUrl:(NSString*)url;

- (void)setTitle:(NSString*)title;

@end
