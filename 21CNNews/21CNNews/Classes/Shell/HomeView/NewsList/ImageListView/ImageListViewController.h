//
//  ImageListViewController.h
//  Shell
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsChannelObject;

@interface ImageListViewController : UIViewController

- (void)showInViwe:(UIView*)parentView frame:(CGRect)frame;

- (void)loadChannel:(NewsChannelObject*)channelObject;

@end
