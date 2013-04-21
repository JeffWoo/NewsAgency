//
//  AppDelegate.m
//  21CNNews
//
//  Created by chenggk on 13-4-3.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "AppDelegate.h"
#import "SplashViewController.h"
#import "ViewController.h"
#import "ShareSDK/ShareSDK.h"
#import <WXApi.h>
#import <QQApi/QQApi.h>
#import "UIImage+ResManager.h"


@interface AppDelegate()

@property (nonatomic, retain) SplashViewController* splashViewController;

@end

@implementation AppDelegate

- (void)dealloc
{
    [self removeSplashView];
    
    [_window release];
    [_viewController release];
    [super dealloc];
}


- (void)removeSplashView
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [_splashViewController.view removeFromSuperview];
    [_splashViewController release];
    _splashViewController = nil;
}

//初始化主程序
- (void)mainViewInit
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.viewController = [[[ViewController alloc] init] autorelease];
    self.window.rootViewController = self.viewController;
    
    [self.window addSubview:_splashViewController.view];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self performSelector:@selector(removeSplashView) withObject:nil afterDelay:1];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [UIImage loadNewMethod];
    
    [WXApi registerApp:@"wx6dd7a9b94f3dd72a"];
    [QQApi registerPluginWithId:@"QQ075BCD15"];
    [ShareSDK registerApp:@"520520test"];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    _splashViewController = [[SplashViewController alloc] init];    ///<  初始化启动画面
    self.window.rootViewController = _splashViewController;
    [self.window makeKeyAndVisible];
    
    
    [self performSelector:@selector(mainViewInit) withObject:nil afterDelay:0];        
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
