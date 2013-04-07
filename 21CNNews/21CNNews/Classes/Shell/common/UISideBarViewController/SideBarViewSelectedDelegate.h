//
//  SideBarViewSelectedDelegate.h
//  21CNNews
//
//  Created by chenggk on 13-4-4.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#ifndef __21CNNews_SideBarViewSelectedDelegate_h
#define __21CNNews_SideBarViewSelectedDelegate_h

@class UISideBarViewController;

@protocol SideBarViewSelectedDelegate <NSObject>

- (void)notifyGoToMid:(UIViewController *)controller;

- (void)notifyGoToLeft:(UIViewController *)controller;

- (void)notifyGoToRight:(UIViewController *)controller;

@end


#endif
