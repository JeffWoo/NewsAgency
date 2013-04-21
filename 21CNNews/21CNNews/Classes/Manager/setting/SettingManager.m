/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: SettingManager.m
 *
 * Description	: 系统设置管理器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import "SettingManager.h"
#import "SettingKey.h"
#import "SettingCellObject.h"
#import "SettingCommandKey.h"
#import "iPhoneTools.h"
#import <UIKit/UIKit.h>

@implementation SettingManager


+ (SettingManager*)shareInstance
{
    static SettingManager* g_instance = nil;
    
    if (nil == g_instance)
    {
        @synchronized(@"SettingManager")
        {
            if (nil == g_instance)
            {
                g_instance = [[SettingManager alloc] init];
            }
        }
    }
    
    return g_instance;
}


- (id)init
{
    self = [super init];
    if (self)
    {
        [self checkAndInitSetting];
    }
    
    return self;
}


- (void)dealloc
{
    [super dealloc];
}


- (void)checkAndInitSetting
{
    NSObject* testObject = [[NSUserDefaults standardUserDefaults] objectForKey:__Setting_TestFirstOpenObject__];
    if (!testObject)
    {
        testObject = [[[NSObject alloc] init] autorelease];
        [[NSUserDefaults standardUserDefaults] setObject:testObject forKey:__Setting_TestFirstOpenObject__];
        
        [self setNightModeOpen:NO];
        [self setNoneImageModeOpen:NO];
        [self setOfflineDownLoadOpen:YES];
        [self setApnsOpen:YES];
    }
    
}


#pragma mark getter
- (BOOL)isOffLineDownLoadOpen
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:__Setting_IsOffLineDownLoadOpen__];
}


- (BOOL)isNoneImageMode
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:__Setting_IsNoneImageMode__];
}


- (BOOL)isApnsOpen
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:__Setting_IsApnsOpen__];
}


- (BOOL)isNightMode
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:__Setting_IsNightMode__];
}


- (NSArray*)getSettingData
{
    NSMutableArray* settingData = [NSMutableArray arrayWithCapacity:12];
    
    [settingData addObject:[SettingCellObject settingCellObjectWithTitle:@"系统设置"
                                                                 comment:nil
                                                          isWithCheckBox:NO
                                                      isCanOpenOtherPage:NO
                                                         isCanBeSelected:NO
                                                                 command:nil]];
    
    [settingData addObject:[SettingCellObject settingCellObjectWithTitle:@"离线下载"
                                                                      comment:@"WIFI环境下提前下载新闻供您在无网络环境下阅读"
                                                               isWithCheckBox:YES
                                                           isCanOpenOtherPage:NO
                                                              isCanBeSelected:YES
                                                                 command:__SettingCommanKey_OffLineDownLoad__]];
    
    [settingData addObject:[SettingCellObject settingCellObjectWithTitle:@"清除缓存"
                                                                 comment:[iPhoneTools getCacheSize]
                                                          isWithCheckBox:NO
                                                      isCanOpenOtherPage:NO
                                                         isCanBeSelected:YES
                                                                 command:__SettingCommanKey_ClearCache__]];
    
    [settingData addObject:[SettingCellObject settingCellObjectWithTitle:@"文字模式"
                                                                 comment:@"不显示图片，节省流量"
                                                          isWithCheckBox:YES
                                                      isCanOpenOtherPage:NO
                                                         isCanBeSelected:YES
                                                                 command:__SettingCommanKey_NoneImageMode__]];
    
    [settingData addObject:[SettingCellObject settingCellObjectWithTitle:@"要闻提示"
                                                                 comment:nil
                                                          isWithCheckBox:YES
                                                      isCanOpenOtherPage:NO
                                                         isCanBeSelected:YES
                                                                 command:__SettingCommanKey_Apns__]];
    
    [settingData addObject:[SettingCellObject settingCellObjectWithTitle:@"夜间模式"
                                                                 comment:nil
                                                          isWithCheckBox:YES
                                                      isCanOpenOtherPage:NO
                                                         isCanBeSelected:YES
                                                                 command:__SettingCommanKey_NightMode__]];
    
    [settingData addObject:[SettingCellObject settingCellObjectWithTitle:@"下载新版本"
                                                                 comment:[NSString stringWithFormat:@"当前版本：%@", [iPhoneTools getCurrentVersion]]
                                                          isWithCheckBox:NO
                                                      isCanOpenOtherPage:NO
                                                         isCanBeSelected:YES
                                                                 command:__SettingCommanKey_DownLoadNewVersion__]];
    
    [settingData addObject:[SettingCellObject settingCellObjectWithTitle:@"其他"
                                                                 comment:nil
                                                          isWithCheckBox:NO
                                                      isCanOpenOtherPage:NO
                                                         isCanBeSelected:NO
                                                                 command:nil]];
    
    [settingData addObject:[SettingCellObject settingCellObjectWithTitle:@"使用指南"
                                                                 comment:nil
                                                          isWithCheckBox:NO
                                                      isCanOpenOtherPage:YES
                                                         isCanBeSelected:YES
                                                                 command:__SettingCommanKey_OperatingGuide__]];
    
    [settingData addObject:[SettingCellObject settingCellObjectWithTitle:@"用户反馈"
                                                                 comment:nil
                                                          isWithCheckBox:NO
                                                      isCanOpenOtherPage:YES
                                                         isCanBeSelected:YES
                                                                 command:__SettingCommanKey_UserFeedBack__]];
    
    [settingData addObject:[SettingCellObject settingCellObjectWithTitle:@"关于我们"
                                                                 comment:nil
                                                          isWithCheckBox:NO
                                                      isCanOpenOtherPage:YES
                                                         isCanBeSelected:YES
                                                                 command:__SettingCommanKey_AboutUs__]];
    
    [settingData addObject:[SettingCellObject settingCellObjectWithTitle:@"应用推荐"
                                                                 comment:nil
                                                          isWithCheckBox:NO
                                                      isCanOpenOtherPage:YES
                                                         isCanBeSelected:YES
                                                                 command:__SettingCommanKey_AppRecommend__]];
    
    return settingData;
}


#pragma mark setter
- (void)setOfflineDownLoadOpen:(BOOL)bOpen
{
    [[NSUserDefaults standardUserDefaults] setBool:bOpen forKey:__Setting_IsOffLineDownLoadOpen__];
}


- (void)setNoneImageModeOpen:(BOOL)bOpen
{
    [[NSUserDefaults standardUserDefaults] setBool:bOpen forKey:__Setting_IsNoneImageMode__];
}


- (void)setApnsOpen:(BOOL)bOpen
{
    [[NSUserDefaults standardUserDefaults] setBool:bOpen forKey:__Setting_IsApnsOpen__];
}


- (void)setNightModeOpen:(BOOL)bOpen
{
    [[NSUserDefaults standardUserDefaults] setBool:bOpen forKey:__Setting_IsNightMode__];
}





@end
