/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: SettingCellObject.h
 *
 * Description	: 系统设置项数据结构
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>

@interface SettingCellObject : NSObject

@property (nonatomic, readonly) NSString* title;            ///< 设置项标题
@property (nonatomic, readonly) NSString* comment;          ///< 设置项说明
@property (nonatomic, readonly) BOOL isWithCheckBox;        ///< 是否带有check box
@property (nonatomic, readonly) BOOL isCanOpenOtherPage;    ///< 该设置项选中时是否打开新的界面
@property (nonatomic, readonly) BOOL isCanBeSelected;       ///< 是否可选中
@property (nonatomic, readonly) NSString* command;          ///< 设置想命令


+ (id)settingCellObjectWithTitle:(NSString*)title
                         comment:(NSString*)comment
                  isWithCheckBox:(BOOL)isWithCheckBox
              isCanOpenOtherPage:(BOOL)isCanOpenOtherPage
                 isCanBeSelected:(BOOL)isCanBeSelected
                         command:(NSString*)command;


@end
