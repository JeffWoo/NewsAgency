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


- (void)initJob
{
    [[UserSerialNumManager shareInstance] checkUserSerialNum];
    [[SplashManager shareInstance] checkAndUpDataSplashImage];    
}

@end
