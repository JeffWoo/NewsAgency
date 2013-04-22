/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: SettingViewController.h
 *
 * Description	: 系统设置view controller
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController

//将系统设置界面展现在parentViewController上
- (void)showInUIViewController:(UIViewController*)parentViewController;

@end
