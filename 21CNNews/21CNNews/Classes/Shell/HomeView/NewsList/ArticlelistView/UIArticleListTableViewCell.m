//
//  UIArticleListTableViewCell.m
//  Shell
//
//  Created by chenggk on 13-4-6.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "UIArticleListTableViewCell.h"
#import "EGOImageView.h"
#import "NewsListItem.h"

@interface UIArticleListTableViewCell()

@property (nonatomic, retain) EGOImageView* eGoImageView;
@property (nonatomic, retain) NewsListItem* newsListItem;
@property (nonatomic, retain) UILabel* titleLebel;
@property (nonatomic, retain) UILabel* sourceNameLabel;

@end


@implementation UIArticleListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {

    }
    return self;
}


- (void)dealloc
{
    [_eGoImageView cancelImageLoad];
    [_eGoImageView release];

    [_newsListItem release];
    
    [_titleLebel release];
    
    [_sourceNameLabel release];
    
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setNewsListItem:(NewsListItem*)item
{
    if (!item || self.newsListItem == item)
    {
        return;
    }
    
    if (item.thumbImgUrl)
    {
        if (!self.eGoImageView)
        {
            self.eGoImageView = [[[EGOImageView alloc] initWithPlaceholderImage:nil] autorelease];
            [self addSubview:self.eGoImageView];
        }
        
        self.eGoImageView.imageURL = [NSURL URLWithString:item.thumbImgUrl];
        self.eGoImageView.hidden = NO;
        self.eGoImageView.frame = CGRectMake(12, 12, 98, 72);
    }

    
    if (item.title)
    {
        if (!self.titleLebel)
        {
            self.titleLebel = [[UILabel alloc] initWithFrame:CGRectZero];
            self.titleLebel.backgroundColor = [UIColor clearColor];
            self.titleLebel.font = [UIFont systemFontOfSize:18];
            [self.titleLebel setLineBreakMode:UILineBreakModeWordWrap];
            [self.titleLebel setNumberOfLines:0];
            [self addSubview:self.titleLebel];
        }
        
        CGFloat contentWidth = self.eGoImageView.hidden ? self.frame.size.width : self.frame.size.width - self.eGoImageView.frame.size.width - 20;
        CGSize size = [item.title sizeWithFont:self.titleLebel.font constrainedToSize:CGSizeMake(contentWidth, 100) lineBreakMode:UILineBreakModeWordWrap];
        
        CGFloat originX = self.eGoImageView.hidden ? 0 : self.eGoImageView.frame.size.width + 20;
        CGRect frame = CGRectMake(originX, 12, size.width, size.height);
        self.titleLebel.frame = frame;
        self.titleLebel.text = item.title;
    }
    
    if (item.sourceName)
    {
        if (!self.sourceNameLabel)
        {
            self.sourceNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            self.sourceNameLabel.backgroundColor = [UIColor clearColor];
            self.sourceNameLabel.font = [UIFont systemFontOfSize:12];
            [self.sourceNameLabel setLineBreakMode:UILineBreakModeMiddleTruncation];
            [self.sourceNameLabel setNumberOfLines:1];
            [self addSubview:self.sourceNameLabel];
        }
        
        
        CGFloat originX = self.titleLebel.frame.origin.x;
        CGFloat originY = self.frame.size.height - 29;
        CGRect frame = CGRectMake(originX, originY, 100, 20);
        self.sourceNameLabel.frame = frame;
        self.sourceNameLabel.text = item.sourceName;
    }
}


@end
