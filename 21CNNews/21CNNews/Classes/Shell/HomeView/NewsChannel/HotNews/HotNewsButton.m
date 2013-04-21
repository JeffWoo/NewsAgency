/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: HotNewsButton.m
 *
 * Description	: 热点新闻项按钮
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/13, chenggk, Create the file
 ***************************************************************************************
 **/

#import "HotNewsButton.h"
#import "HotNewsItem.h"

@interface HotNewsButton()

@property (nonatomic, retain) HotNewsItem* item;

@end

@implementation HotNewsButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:0x2A / 255.0f green:0x2E / 255.0f blue:0x35 / 255.0f alpha:1];
        self.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    }
    return self;
}


- (void)dealloc
{
    [_item release];
    [super dealloc];
}


- (void)setHotNewsItem:(HotNewsItem*)item
{
    self.item = item;
    
    //计算实际文字展现大小
    CGSize size = [item.title sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(320, self.frame.size.height) lineBreakMode:NSLineBreakByTruncatingTail];
    CGRect frame = self.frame;
    
    size.width += 18; //文字左右边距各为9px，共18px
    frame.size.width = size.width;
    self.frame = frame;
    [self setTitle:item.title forState:UIControlStateNormal];
}

@end
