/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: AriticleListViewDelegate.h
 *
 * Description	: 普通新闻列表view controller delegate回调通知
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#ifndef Shell_AriticleListViewDelegate_h
#define Shell_AriticleListViewDelegate_h



@protocol AriticleListViewDelegate <NSObject>

//新闻列表项被选中回调通知
- (void)ariticleListCellDidSelect:(int)ariticleID;

@end

#endif
