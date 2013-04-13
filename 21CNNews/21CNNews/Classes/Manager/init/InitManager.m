//
//  InitManager.m
//  Model
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

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


- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUserSerialNumDidChanged) name:kUserSerialNumDidChanged object:nil];
        [[UserSerialNumManager shareInstance] checkUserSerialNum];
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
    [[SplashManager shareInstance] checkAndUpDataSplashImage];
    [[HotNewsManager shareInstance] checkAndUpDataHotNewList];
}


- (void)didUserSerialNumDidChanged
{
    [self initJob];
}

@end
