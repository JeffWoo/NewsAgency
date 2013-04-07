//
//  UITitleView.m
//  Shell
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "UITitleView.h"

@interface UITitleView()

@property (nonatomic, retain) UIButton* leftButton;
@property (nonatomic, retain) UILabel* titleLabel;
@property (nonatomic, retain) UIButton* rightButton;

@end


@implementation UITitleView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return self;
}


- (void)dealloc
{
    [_leftButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [_leftButton release];
    _leftButton = nil;
    
    [_rightButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [_rightButton release];
    _rightButton = nil;
    
    [_titleLabel release];
    _titleLabel = nil;
    
    [super dealloc];
}


- (void)setTitleText:(NSString*)titleText
{
    self.titleLabel.text = titleText;
}


- (void)setLeftButtonImage:(UIImage*)image
{
    if (!self.leftButton)
    {
        self.leftButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, self.frame.size.height)] autorelease];
        self.leftButton.backgroundColor = [UIColor clearColor];
        self.leftButton.highlighted = YES;
        [self addSubview:self.leftButton];
    }
    
    [self.leftButton setImage:image forState:UIControlStateNormal];
}


- (void)setRightButtonImage:(UIImage*)image
{
    if (!self.rightButton)
    {
        self.rightButton = [[[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 0, 60, self.frame.size.height)] autorelease];
        self.rightButton.backgroundColor = [UIColor clearColor];
        self.rightButton.highlighted = YES;
        [self addSubview:self.rightButton];
    }
    
    [self.rightButton setImage:image forState:UIControlStateNormal];
}


- (void)addLeftButonTarget:(id)targer action:(SEL)selector forControlEvents:(UIControlEvents)events
{
    [self.leftButton addTarget:targer action:selector forControlEvents:events];
}


- (void)addRightButonTarget:(id)targer action:(SEL)selector forControlEvents:(UIControlEvents)events
{
    [self.rightButton addTarget:targer action:selector forControlEvents:events];
}

@end
