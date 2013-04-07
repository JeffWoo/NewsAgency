//
//  SettingCellObject.h
//  Model
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingCellObject : NSObject

@property (nonatomic, readonly) NSString* title;
@property (nonatomic, readonly) NSString* comment;
@property (nonatomic, readonly) BOOL isWithCheckBox;
@property (nonatomic, readonly) BOOL isCanOpenOtherPage;
@property (nonatomic, readonly) BOOL isCanBeSelected;
@property (nonatomic, readonly) NSString* command;


+ (id)settingCellObjectWithTitle:(NSString*)title
                         comment:(NSString*)comment
                  isWithCheckBox:(BOOL)isWithCheckBox
              isCanOpenOtherPage:(BOOL)isCanOpenOtherPage
                 isCanBeSelected:(BOOL)isCanBeSelected
                         command:(NSString*)command;


@end
