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

+ (NSString*)getCacheSize;

+ (NSString*)getCurrentVersion;

+ (uint64_t)fileSizeOnDisk:(NSString*)path;

@end
