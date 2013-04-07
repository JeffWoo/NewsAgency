//
//  SettingCellObject.m
//  Model
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "SettingCellObject.h"

@interface SettingCellObject()

- (id)initWithTitle:(NSString*)title
            comment:(NSString*)comment
     isWithCheckBox:(BOOL)isWithCheckBox
 isCanOpenOtherPage:(BOOL)isCanOpenOtherPage
    isCanBeSelected:(BOOL)isCanBeSelected
            command:(NSString*)command;

@end

@implementation SettingCellObject


- (id)initWithTitle:(NSString*)title
            comment:(NSString*)comment
     isWithCheckBox:(BOOL)isWithCheckBox
 isCanOpenOtherPage:(BOOL)isCanOpenOtherPage
    isCanBeSelected:(BOOL)isCanBeSelected
            command:(NSString*)command
{
    self = [super init];
    if (self)
    {
        _title = [title copy];
        _comment = [comment copy];
        _isWithCheckBox = isWithCheckBox;
        _isCanOpenOtherPage = isCanOpenOtherPage;
        _isCanBeSelected = isCanBeSelected;
        _command = [command copy];
    }
    
    return self;
}


+ (id)settingCellObjectWithTitle:(NSString*)title
                         comment:(NSString*)comment
                  isWithCheckBox:(BOOL)isWithCheckBox
              isCanOpenOtherPage:(BOOL)isCanOpenOtherPage
                 isCanBeSelected:(BOOL)isCanBeSelected
                         command:(NSString*)command
{
    return [[[SettingCellObject alloc] initWithTitle:title
                                            comment:comment
                                     isWithCheckBox:isWithCheckBox
                                 isCanOpenOtherPage:isCanOpenOtherPage
                                     isCanBeSelected:isCanBeSelected
                                             command:command] autorelease];
}


- (void)dealloc
{
    [_title release];
    [_comment release];
    [_command release];
    
    [super dealloc];
}


@end
