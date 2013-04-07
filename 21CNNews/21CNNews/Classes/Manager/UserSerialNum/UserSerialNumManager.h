//
//  UserSerialNumManager.h
//  Model
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSURLDispatchDelegate.h"

@interface UserSerialNumManager : NSObject<LSURLDispatchDelegate>

@property (nonatomic, readonly, getter = getUserSerialNum) NSString* userSerialNum;

+ (UserSerialNumManager*)shareInstance;

- (void)checkUserSerialNum;

@end
