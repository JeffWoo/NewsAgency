//
//  iPhoneTools.m
//  Model
//
//  Created by chenggk on 13-4-5.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "iPhoneTools.h"
#import <UIKit/UIKit.h>
#include <sys/sysctl.h>
#include <mach/mach.h>
#include <mach/mach_init.h>
#include <mach/task.h>
#include <mach/task_info.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <uuid/uuid.h>
#include <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>
#import <dirent.h>
#import <sys/stat.h>
#import <sys/types.h>

const char * getiPhoneMac() {
	
	int                    mib[6];
	size_t                len;
	char                *buf;
	unsigned char        *ptr;
	struct if_msghdr    *ifm;
	struct sockaddr_dl    *sdl;
	
	mib[0] = CTL_NET;
	mib[1] = AF_ROUTE;
	mib[2] = 0;
	mib[3] = AF_LINK;
	mib[4] = NET_RT_IFLIST;
	
	if ((mib[5] = if_nametoindex("en0")) == 0) {
		printf("Error: if_nametoindex error/n");
		return NULL;
	}
	
	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 1/n");
		return NULL;
	}
	
	if ((buf = (char*)malloc(len)) == NULL) {
		printf("Could not allocate memory. error!/n");
		return NULL;
	}
	
	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        free(buf);
		printf("Error: sysctl, take 2");
		return NULL;
	}
	
	ifm = (struct if_msghdr *)buf;
	sdl = (struct sockaddr_dl *)(ifm + 1);
	ptr = (unsigned char *)LLADDR(sdl);
	NSString *outstring = [[NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)] uppercaseString];
	free(buf);
	return [outstring UTF8String];
}


const char * getMD5(const char * str) {
	
    unsigned char result[16];
    CC_MD5( str, strlen(str), result );
    return [[[NSString stringWithFormat:
              @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
              result[0], result[1], result[2], result[3],
              result[4], result[5], result[6], result[7],
              result[8], result[9], result[10], result[11],
              result[12], result[13], result[14], result[15]
              ] lowercaseString] UTF8String];
}

char* getIMEI(char* buffer)
{
	if(buffer == NULL)
	{
		return NULL;
	}
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    SEL sel = sel_registerName("uniqueIdentifier");
    NSString *str = nil;
    
    if ([[UIDevice currentDevice] respondsToSelector:sel])
    {
        str = [[UIDevice currentDevice] performSelector:sel];
    }
    
	if (str == nil || [str compare:@""] == NSOrderedSame || str.length<20)
	{
		const char * iPhoneMac = getiPhoneMac();
		if (iPhoneMac)
		{
			strcpy(buffer, getMD5(iPhoneMac));
		}
		else
		{
			strcpy(buffer, "UCWEB_IPHONE_DEFAULT_IMEI");
		}
        
	}
	else
	{
		strcpy(buffer,[str UTF8String]);
	}
	[ pool release ];  
	return buffer;	
}



@implementation iPhoneTools

+ (NSString*)getIMEI
{
    char buffer[128] = {0};
    getIMEI(buffer);
    
    return [NSString stringWithUTF8String:buffer];
}


+ (NSString *)documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}


+ (BOOL)isFileExists:(NSString*)filePath
{
	return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}


+ (bool)isDirExists:(NSString*)dirPath
{
    if(!dirPath)
    {
        return false;
    }
    
	DIR* dir;
	dir= opendir([dirPath UTF8String]);
	if(dir == NULL)
	{
		return false;
	}
	closedir(dir);
	return true;
}

+ (bool)createDir:(NSString*)dir
{
	return [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
}


+ (bool)createDirIfNoExists:(NSString*)dir
{
    if ([self isDirExists:dir])
    {
        return NO;
    }
    
    return [self createDir:dir];
}


+ (NSString*)getCacheSize
{
    //TODO:
    return @"......";
}


+ (NSString*)getCurrentVersion
{
    return @"v1.3版本";
}

@end
