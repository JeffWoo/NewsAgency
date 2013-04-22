/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: InitManager.m
 *
 * Description	: 初始化管理器，model需要进行的初始化工作，均在这里完成
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import "InitManager.h"
#import "UserSerialNumManager.h"
#import "SplashManager.h"
#import "HotNewsManager.h"
#import "UserSerialNumNotificationKeys.h"

@implementation InitManager

+ (InitManager*)shareInstance
{
    static InitManager* g_instance = nil;
    
    if (nil == g_instance)
    {
        @synchronized(@"InitManager")
        {
            if (nil == g_instance)
            {
                g_instance = [[InitManager alloc] init];
            }
        }
    }
    
    return g_instance;
}


//初始化工作
- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUserSerialNumDidChanged) name:kUserSerialNumDidChanged object:nil];
        [[UserSerialNumManager shareInstance] checkUserSerialNum];  ///< 检测并获取app序列号
    }
    
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}


- (void)initJob
{    
    [[SplashManager shareInstance] checkAndUpDataSplashImage];  ///< 检测并更新启动画面
    [[HotNewsManager shareInstance] checkAndUpDataHotNewList];  ///< 检测并更新新闻频道列表
}


- (void)didUserSerialNumDidChanged
{
    [self initJob];     ///< 只有获取到app序列号之后，才进行其他任务初始化，因为所以与服务器的交互，均需要依赖与app序列号
}

@end
