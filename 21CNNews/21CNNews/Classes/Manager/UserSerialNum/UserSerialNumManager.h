/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: UserSerialNumManager.h
 *
 * Description	: app序列号管理器，主要进行app序列号的更新获取及管理工作
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>
#import "LSURLDispatchDelegate.h"

@interface UserSerialNumManager : NSObject<LSURLDispatchDelegate>

@property (nonatomic, readonly, getter = getUserSerialNum) NSString* userSerialNum;

+ (UserSerialNumManager*)shareInstance;

- (void)checkUserSerialNum; ///< 检测并更新app序列号

@end
