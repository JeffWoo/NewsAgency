
//针对数据库文件的封装类
#import <Foundation/Foundation.h>

@interface DbFileManager : NSObject

+ (NSString *)dbFilePath;   ///< 获取数据库所在路径

+ (NSString*)dbName;        ///< 获取数据库名称

@end
