/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: UINewsChannelTitleView.m
 *
 * Description	: 新闻频道标题栏
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/4, chenggk, Create the file
 ***************************************************************************************
 **/

#import "UINewsChannelTitleView.h"
#import "NSNotificationCenterKeys.h"
#import "ResManager.h"

@interface UINewsChannelTitleView ()

@property (nonatomic, retain) UIImageView* bgImageView;     ///< 背景
@property (nonatomic, retain) UIButton* addButton;          ///< 添加按钮
@property (nonatomic, retain) UIButton* settingButton;      ///< 设置按钮

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


//设置按钮响应函数
- (void)settingButtonclicked
{
    //发送系统设置按钮被按下消息，该消息最终将被MainFrameViewController接收，并弹出系统设置界面
    [[NSNotificationCenter defaultCenter] postNotificationName:ShowSettingViewNotification object:self userInfo:nil];
}

@end
