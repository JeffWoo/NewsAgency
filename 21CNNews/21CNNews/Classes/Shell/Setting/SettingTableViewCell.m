//
//  SettingTableViewCell.m
//  Shell
//
//  Created by chenggk on 13-4-6.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "SettingTableViewCell.h"
#import "SettingCellObject.h"
@interface SettingTableViewCell()

@property (nonatomic, retain) UILabel* titleLabel;
@property (nonatomic, retain) UILabel* commentLabel;
@property (nonatomic, retain) UIImageView* rightImageView;

@end



@implementation SettingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
    }
    
    return self;
}


- (void)dealloc
{
    [_titleLabel release];
    [_commentLabel release];
    [_rightImageView release];
    
    [super dealloc];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setSettingCellObject:(SettingCellObject *)settingCellObject
{
    [self.titleLabel removeFromSuperview];
    [self.commentLabel removeFromSuperview];
    [self.rightImageView removeFromSuperview];
    
    CGFloat cellHeight = settingCellObject.isCanBeSelected ? 42 : 25;
    self.frame = CGRectMake(0, 0, self.frame.size.width, cellHeight);
    
    if (settingCellObject.comment)
    {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(9, 9, self.frame.size.width - 9, 12)];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.text = settingCellObject.title;
        [self addSubview:self.titleLabel];
        
        self.commentLabel = [[[UILabel alloc] initWithFrame:CGRectMake(9, 27, self.frame.size.width - 9, 9)] autorelease];
        self.commentLabel.font = [UIFont systemFontOfSize:9];
        self.commentLabel.text = settingCellObject.comment;    
        [self addSubview:self.commentLabel];
    }
    else
    {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(9, 0, self.frame.size.width, self.frame.size.height - 1)];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.text = settingCellObject.title;
        [self addSubview:self.titleLabel];
    }
    
    if (settingCellObject.isCanBeSelected)
    {
        
    }
    
    if (settingCellObject.isCanOpenOtherPage)
    {
        
    }
}

@end
