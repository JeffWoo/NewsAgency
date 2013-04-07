
#import "SettingCellSelectedHandle.h"
#import "SettingCommandKey.h"
#import "SettingManager.h"
#import "NSNotificationCenterKeys.h"

@implementation SettingCellSelectedHandle

- (id)init
{
    self = [super init];
    if (self)
    {
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
    [super dealloc];
}



- (void)onOffLineDownLoad
{
    SettingManager* manager = [SettingManager shareInstance];
    [manager setOfflineDownLoadOpen:![manager isOffLineDownLoadOpen]];
}


- (void)onClearCache
{
    
}


- (void)onNoneImageMode
{
    SettingManager* manager = [SettingManager shareInstance];
    [manager setNoneImageModeOpen:![manager isNoneImageMode]];        
}


- (void)onApns
{
    SettingManager* manager = [SettingManager shareInstance];
    [manager setApnsOpen:![manager isApnsOpen]];
}


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