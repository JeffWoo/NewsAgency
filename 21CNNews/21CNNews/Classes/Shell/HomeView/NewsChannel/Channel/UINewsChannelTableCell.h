//
//  UINewsChannelTableCell.h
//  Shell
//
//  Created by chenggk on 13-4-4.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINewsChannelTableCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style frame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setImageUrl:(NSString*)url;

- (void)setTitle:(NSString*)title;

@end
