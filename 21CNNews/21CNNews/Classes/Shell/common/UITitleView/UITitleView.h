//
//  UITitleView.h
//  Shell
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITitleView : UIView

- (void)setTitleText:(NSString*)titleText;

- (void)setBgImage:(UIImage*)bgImage;

- (void)setLeftButtonImage:(UIImage*)image frame:(CGRect)frame;

- (void)setRightButtonImage:(UIImage*)image frame:(CGRect)frame;

- (void)addLeftButonTarget:(id)targer action:(SEL)selector forControlEvents:(UIControlEvents)events;

- (void)addRightButonTarget:(id)targer action:(SEL)selector forControlEvents:(UIControlEvents)events;

@end
