//
//  SettingManager.h
//  Model
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingCellObject.h"

@interface SettingManager : NSObject

+ (SettingManager*)shareInstance;

#pragma mark getter
- (BOOL)isOffLineDownLoadOpen;

- (BOOL)isNoneImageMode;

- (BOOL)isApnsOpen;

- (BOOL)isNightMode;

- (NSArray*)getSettingData;

#pragma mark setter
- (void)setOfflineDownLoadOpen:(BOOL)bOpen;

- (void)setNoneImageModeOpen:(BOOL)bOpen;

- (void)setApnsOpen:(BOOL)bOpen;

- (void)setNightModeOpen:(BOOL)bOpen;



@end
