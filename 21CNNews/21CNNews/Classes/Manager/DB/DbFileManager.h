
//针对数据库文件的封装类
#import <Foundation/Foundation.h>

@interface DbFileManager : NSObject

+ (NSString *)dbFilePath;

+ (NSString*)dbName;

@end
