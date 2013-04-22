/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: SplashManager.h
 *
 * Description	: 启动画面管理器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>

@class UIImage;

@interface SplashManager : NSObject

//获取单例对象
+ (SplashManager*)shareInstance;

//检测并更新启动图片
- (void)checkAndUpDataSplashImage;

//获取启动图片
- (UIImage*)getSplashImage;

@end
