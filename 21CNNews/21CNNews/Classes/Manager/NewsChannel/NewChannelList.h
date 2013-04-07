//
//  NewChannelList.h
//  Model
//
//  Created by chenggk on 13-4-4.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsChannelObject.h"

@interface NewChannelList : NSObject

@property (nonatomic, readonly) NSInteger currentPageIndex;

+ (NewChannelList*)getNewChannelList;

- (int)count;

- (BOOL)insertNewsChannelObject:(NewsChannelObject*)object;

- (NewsChannelObject*)getNewsChannelObject:(NSInteger)index;

@end
