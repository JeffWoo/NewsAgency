//
//  UINewsChannelTableCell.m
//  Shell
//
//  Created by chenggk on 13-4-4.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "UINewsChannelTableCell.h"
#import "EGOImageView.h"

@interface UINewsChannelTableCell()

@property (nonatomic, retain) EGOImageView* eGoImageView;
@property (nonatomic, retain) UILabel* titleLabel;

@end


@implementation UINewsChannelTableCell



- (id)initWithStyle:(UITableViewCellStyle)style frame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.frame = frame;
        _eGoImageView = [[[EGOImageView alloc] initWithPlaceholderImage:nil] autorelease];
        _eGoImageView.frame = CGRectMake(4.0f, 4.0f, 36.0f, 36.0f);
        [self addSubview:_eGoImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, frame.size.width - 50, frame.size.height)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
    }
    return self;
}


- (void)dealloc
{
    [_titleLabel release];
    
    [_eGoImageView cancelImageLoad];
    [_eGoImageView release];
    
    [super dealloc];
}


- (void)setTitle:(NSString*)title
{
    self.titleLabel.text = title;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


- (void)setImageUrl:(NSString*)url
{
    UIImage* image = [[EGOImageLoader sharedImageLoader] imageForURL:[NSURL URLWithString:url] shouldLoadWithObserver:nil];
    if (image)
    {
        self.eGoImageView.image = image;
    }
    else
    {
        self.eGoImageView.imageURL = [NSURL URLWithString:url];
    }
}

@end
