//
//  iPhoneTools.h
//  Model
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iPhoneTools : NSObject

+ (NSString*)getIMEI;

+ (NSString *)documentPath;

+ (NSString *)cachePath;

+ (BOOL)isFileExists:(NSString*)filePath;

+ (bool)isDirExists:(NSString*)dirPath;

+ (bool)createDir:(NSString*)dir;

+ (bool)createDirIfNoExists:(NSString*)dir;

//获取新闻客户端cache，注意：目前仅计算了图片cache
+ (NSString*)getCacheSize;

//获取客户端版本号
+ (NSString*)getCurrentVersion;

//获取对应路径所占磁盘空间大小
+ (uint64_t)fileSizeOnDisk:(NSString*)path;

@end
