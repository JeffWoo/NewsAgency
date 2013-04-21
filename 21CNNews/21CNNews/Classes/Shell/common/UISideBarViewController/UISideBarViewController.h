/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: UISideBarViewController.h
 *
 * Description	: 主页三屏基础控件
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/4, chenggk, Create the file
 ***************************************************************************************
 **/

#import <UIKit/UIKit.h>
#import "UISideBarSubViewController.h"


@interface UISideBarViewController : UIViewController<SideBarViewSelectedDelegate>

@property (nonatomic, retain) UISideBarSubViewController* leftSideBarViewController;    ///< 左屏
@property (nonatomic, retain) UISideBarSubViewController* rightSideBarViewController;   ///< 右屏
@property (nonatomic, retain) UISideBarSubViewController* contentViewController;        ///< 中间屏

@property (nonatomic, readwrite) CGFloat contentOffset;     ///< 滑到左右屏时，中间屏可见宽度

- (void)didRotateFromInterfaceOrientation;  ///< 旋屏，目前无需使用该函数

@end
