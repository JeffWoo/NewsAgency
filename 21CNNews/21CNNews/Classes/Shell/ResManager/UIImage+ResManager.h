//
//  UIImage+ResManager.h
//  Shell
//
//  Created by chenggk on 13-4-13.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage(ResManager)

+ (void) loadNewMethod;

- (id )initWithContentsOfFile_custom:(NSString *)path;

+ (UIImage *)imageNamed_custom:(NSString *)name;

@end



@implementation UIImage(ResManager)

+ (void) loadNewMethod
{
	Class klass = objc_getClass("UIImage");
	method_exchangeImplementations(
								   class_getInstanceMethod(klass,@selector(initWithContentsOfFile:)),
								   class_getInstanceMethod(klass,@selector(initWithContentsOfFile_custom:))
								   );
	method_exchangeImplementations(
								   class_getClassMethod(klass,@selector(imageNamed:)),
								   class_getClassMethod(klass,@selector(imageNamed_custom:))
								   );
}

- (id )initWithContentsOfFile_custom:(NSString *)path
{
	UIScreen* screen = [UIScreen mainScreen];
	if([screen respondsToSelector:@selector(scale)]&&([screen scale]==2.0 )&&([self respondsToSelector:@selector(initWithCGImage:scale:orientation:)]))
	{
		NSString* namePath;
		namePath = [[path stringByDeletingLastPathComponent] stringByAppendingPathComponent:
					[NSString stringWithFormat:@"%@@2x.%@",[[path lastPathComponent] stringByDeletingPathExtension],[path pathExtension]]];
		
		if([[NSFileManager defaultManager] fileExistsAtPath:namePath])
		{
			NSData* imageData = [[NSData alloc] initWithContentsOfFile:namePath];
			UIImage* origImage = [[UIImage alloc] initWithData:imageData];
			[imageData release];
			
			UIImage* hiDefImage = [self initWithCGImage:origImage.CGImage scale:[screen scale] orientation:UIImageOrientationUp];
			[origImage release];
            
			return hiDefImage;
		}
	}
	
	return [self initWithContentsOfFile_custom:path];
}


+ (UIImage *)imageNamed_custom:(NSString *)name
{
	UIScreen* screen = [UIScreen mainScreen];
	if([screen respondsToSelector:@selector(scale)]&&([screen scale]==2.0 ))
	{
		NSString* newPath;
		newPath = [NSString stringWithFormat:@"%@@2x.%@",[name stringByDeletingPathExtension], [name pathExtension]];
		return [UIImage imageNamed_custom:newPath] ;
	}
	else
	{
		return [UIImage imageNamed_custom:name];
	}
    
}

@end