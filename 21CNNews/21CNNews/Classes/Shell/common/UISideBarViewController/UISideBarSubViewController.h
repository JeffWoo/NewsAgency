//
//  UISideBarSubViewController.h
//  21CNNews
//
//  Created by chenggk on 13-4-4.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideBarViewSelectedDelegate.h"

@interface UISideBarSubViewController : UIViewController

@property (nonatomic, assign) id<SideBarViewSelectedDelegate> delegate;

- (void)didSubSideBarGoingToShow;

@end
