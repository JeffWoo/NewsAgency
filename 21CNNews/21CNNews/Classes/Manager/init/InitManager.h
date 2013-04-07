//
//  InitManager.h
//  Model
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InitManager : NSObject

+ (InitManager*)shareInstance;

- (void)initJob;

@end
