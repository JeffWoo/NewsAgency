//
//  UINewsChannelTitleView.m
//  Shell
//
//  Created by chenggk on 13-4-4.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "UINewsChannelTitleView.h"
#import "NSNotificationCenterKeys.h"
#import "ResManager.h"

@interface UINewsChannelTitleView ()

@property (nonatomic, retain) UIImageView* bgImageView;
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
        [self createBgViewIfNeed];
        [self createAddButtonIfNeed];
        [self createSettingButtonIfNeed];
    }
    
    return self;
}


- (void)dealloc
{
    [_bgImageView release];
    
    [_addButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [_addButton release];
    
    [_settingButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [_settingButton release];
    
    [super dealloc];
}


- (void)createBgViewIfNeed
{
    if (self.bgImageView)
    {
        return;
    }
    
    self.bgImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, self.frame.size.height)] autorelease];
    self.bgImageView.image = resGetImage(@"home/left/leftNavBgImage.png");
    [self addSubview:self.bgImageView];
}


- (void)createAddButtonIfNeed
{
    if (self.addButton)
    {
        return;
    }
    
    self.addButton = [[[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 85, 12, 20, 20)] autorelease];
    [self.addButton setImage:resGetImage(@"home/left/addButton.png") forState:UIControlStateNormal];
    
    [self addSubview:self.addButton];
}


- (void)createSettingButtonIfNeed
{
    if (self.settingButton)
    {
        return;
    }
    
    self.settingButton = [[[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 35, 12, 20, 20)] autorelease];
    [self.settingButton setImage:resGetImage(@"home/left/settingButton.png") forState:UIControlStateNormal];    
    [self.settingButton addTarget:self action:@selector(settingButtonclicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.settingButton];
}


- (void)settingButtonclicked
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ShowSettingViewNotification object:self userInfo:nil];
}

@end
