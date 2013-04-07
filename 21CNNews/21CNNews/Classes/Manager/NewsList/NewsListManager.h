


#import <Foundation/Foundation.h>

@class NewsChannelObject;

@interface NewsListManager : NSObject

+ (NewsListManager*)shareInstance;

- (void)loadData:(NewsChannelObject*)channelObject;     ///< 加载对应区块（频道）内容

- (void)refreshData:(NewsChannelObject*)channelObject;  ///< 刷新对应区块（频道）内容

- (NSArray*)getNewsList:(int)regionId;

@end
