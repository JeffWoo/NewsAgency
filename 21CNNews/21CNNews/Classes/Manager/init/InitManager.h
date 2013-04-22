/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: InitManager.h
 *
 * Description	: 初始化管理器，model需要进行的初始化工作，均在这里完成
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/


#import <Foundation/Foundation.h>

@interface InitManager : NSObject

+ (InitManager*)shareInstance;

//初始化工作
- (void)initJob;

@end
