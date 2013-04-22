
#import <Foundation/Foundation.h>

@class FMDatabaseQueue;

@interface DBManager : NSObject

@property (nonatomic, readonly) FMDatabaseQueue* db;

+ (DBManager*)shareIntance;

@end
