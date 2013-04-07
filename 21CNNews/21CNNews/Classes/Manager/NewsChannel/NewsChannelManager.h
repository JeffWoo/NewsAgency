//
//  NewsChannelManager.h
//  Model
//
//  Created by chenggk on 13-4-4.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewChannelList.h"


@interface NewsChannelManager : NSObject

+ (NewsChannelManager*)shareInstance;

- (NewChannelList*)getNewChannelList;

- (NewsChannelObject*)getDefaultChannel;

@end
