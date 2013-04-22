
#import "DBManager.h"
#import "DbFileManager.h"
#import "FMDatabaseQueue.h"

@interface DBManager()

@end


@implementation DBManager

#pragma mark init & mark
+ (DBManager*)shareIntance
{
    static DBManager* g_instance = nil;
    
    if (nil == g_instance)
    {
        @synchronized(@"DBManager")
        {
            if (nil == g_instance)
            {
                g_instance = [[DBManager alloc] init];
            }
        }
    }
    
    return g_instance;
}



- (id)init
{
    self = [super init];
    if (self)
    {
        _db = [[FMDatabaseQueue databaseQueueWithPath:[DbFileManager dbFilePath]] retain];
    }
    
    return self;
}


- (void)dealloc
{
    [_db release];
    [super dealloc];
}


@end
