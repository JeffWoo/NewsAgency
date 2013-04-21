/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: SettingCellSelectedHandle.m
 *
 * Description	: 系统设置命令处理器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/
#import "SettingCellSelectedHandle.h"
#import "SettingCommandKey.h"
#import "SettingManager.h"
#import "NSNotificationCenterKeys.h"
#import "EGOCache.h"

@implementation SettingCellSelectedHandle

- (id)init
{
    self = [super init];
    if (self)
    {
        //监听系统设置项命令，当系统设置项被选中中，会发送出一个消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onOffLineDownLoad) name:__SettingCommanKey_OffLineDownLoad__ object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onClearCache) name:__SettingCommanKey_ClearCache__ object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNoneImageMode) name:__SettingCommanKey_NoneImageMode__ object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onApns) name:__SettingCommanKey_Apns__ object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNightMode) name:__SettingCommanKey_NightMode__ object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDownLoadNewVersion) name:__SettingCommanKey_DownLoadNewVersion__ object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onOperationgGuide) name:__SettingCommanKey_OperatingGuide__ object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserFeedBack) name:__SettingCommanKey_UserFeedBack__ object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAboutUs) name:__SettingCommanKey_AboutUs__ object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppRecommend) name:__SettingCommanKey_AppRecommend__ object:nil];
    }
    
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}


//离线阅读
- (void)onOffLineDownLoad
{
    SettingManager* manager = [SettingManager shareInstance];
    [manager setOfflineDownLoadOpen:![manager isOffLineDownLoadOpen]];
}

//清理缓存
- (void)onClearCache
{
    [[EGOCache globalCache] clearCache];
}

//无图模式
- (void)onNoneImageMode
{
    SettingManager* manager = [SettingManager shareInstance];
    [manager setNoneImageModeOpen:![manager isNoneImageMode]];        
}

//apns推送
- (void)onApns
{
    SettingManager* manager = [SettingManager shareInstance];
    [manager setApnsOpen:![manager isApnsOpen]];
}

//夜间模式
- (void)onNightMode
{
    SettingManager* manager = [SettingManager shareInstance];
    [manager setNightModeOpen:![manager isNightMode]];

    [[NSNotificationCenter defaultCenter] postNotificationName:DidThemeChanged object:self userInfo:nil];
}


- (void)onDownLoadNewVersion
{
    
}


- (void)onOperationgGuide
{
    
}


- (void)onUserFeedBack
{
    
}


- (void)onAboutUs
{
    
}


- (void)onAppRecommend
{
    
}


@end
