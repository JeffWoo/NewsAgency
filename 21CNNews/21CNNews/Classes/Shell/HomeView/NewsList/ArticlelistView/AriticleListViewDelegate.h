//
//  AriticleListViewDelegate.h
//  Shell
//
//  Created by chenggk on 13-4-7.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#ifndef Shell_AriticleListViewDelegate_h
#define Shell_AriticleListViewDelegate_h



@protocol AriticleListViewDelegate <NSObject>

- (void)ariticleListCellDidSelect:(int)ariticleID;

@end

#endif
