
#import "DbFileManager.h"

#define k_DB_NAME @"21CNDB.sqlite"


@implementation DbFileManager

+ (NSString *)documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)dbFilePath
{
    NSString *dbFileName = k_DB_NAME;
    NSString *documentsDirectory = [DbFileManager documentPath];
    
    NSString *dbFilePath =
    [documentsDirectory stringByAppendingPathComponent:dbFileName];    
    
    return dbFilePath;
}


+ (NSString*)dbName
{
    return k_DB_NAME;
}

@end
