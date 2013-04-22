/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: NewsContentViewer.h
 *
 * Description	: 新闻正文展现view
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/4, chenggk, Create the file
 ***************************************************************************************
 **/

#import <UIKit/UIKit.h>


@interface NewsContentViewer : UIViewController

//在parentViewController展现
- (void)showInUIViewController:(UIViewController*)parentViewController articleID:(int)articleID;

@end
