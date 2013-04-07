//
//  UINewsChannelTitleView.m
//  Shell
//
//  Created by chenggk on 13-4-4.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "UINewsChannelTitleView.h"
#import "NSNotificationCenterKeys.h"

@interface UINewsChannelTitleView ()

@property (nonatomic, retain) UILabel* titleLabel;
@property (nonatomic, retain) UIButton* addButton;
@property (nonatomic, retain) UIButton* settingButton;

@end

@implementation UINewsChannelTitleView

#pragma mark init & dealloc
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor brownColor];
        
        [self createTitleLabelIfNeed];
        [self createAddButtonIfNeed];
        [self createSettingButtonIfNeed];
    }
    
    return self;
}


- (void)dealloc
{
    [_addButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [_addButton release];
    
    [_settingButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [_settingButton release];
    
    [super dealloc];
}


- (void)createTitleLabelIfNeed
{
    if (self.titleLabel)
    {
        return;
    }
    
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.frame.size.width - 30, self.frame.size.height)] autorelease];
    self.titleLabel.text = @"21CN新闻";
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.titleLabel];
}



- (void)createAddButtonIfNeed
{
    if (self.addButton)
    {
        return;
    }
    
    self.addButton = [[[UIButton alloc] initWithFrame:CGRectMake(150, 20, 28, 28)] autorelease];
    self.addButton.backgroundColor = [UIColor blueColor];
    
    
    [self addSubview:self.addButton];
}


- (void)createSettingButtonIfNeed
{
    if (self.settingButton)
    {
        return;
    }
    
    self.settingButton = [[[UIButton alloc] initWithFrame:CGRectMake(200, 20, 28, 28)] autorelease];
    self.settingButton.backgroundColor = [UIColor yellowColor];
    [self.settingButton addTarget:self action:@selector(settingButtonclicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.settingButton];
}


- (void)settingButtonclicked
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ShowSettingViewNotification object:self userInfo:nil];
}

@end
