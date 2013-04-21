/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: UINewsChannelTableCell.m
 *
 * Description	: 新闻频道table view cell
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/4, chenggk, Create the file
 ***************************************************************************************
 **/

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
        _eGoImageView.frame = CGRectMake(12.0f, 10.0f, 24.0f, 24.0f);
        [self addSubview:_eGoImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, frame.size.width - 50, 44)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
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
