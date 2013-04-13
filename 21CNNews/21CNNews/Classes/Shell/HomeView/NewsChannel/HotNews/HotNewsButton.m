//
//  HotNewsButton.m
//  Shell
//
//  Created by chenggk on 13-4-13.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

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
        
    CGSize size = [item.title sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(320, self.frame.size.height) lineBreakMode:NSLineBreakByTruncatingTail];
    CGRect frame = self.frame;
    size.width += 18;
    frame.size.width = size.width;
    self.frame = frame;
    [self setTitle:item.title forState:UIControlStateNormal];
}

@end
