/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: ImageLoder.h
 *
 * Description	: 图片加载器：负责加载一个图片，并将其保存到磁盘中
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>

@interface ImageLoder : NSObject

//加载一个图片，并将其保存到磁盘中
- (void)loadImage:(NSString*)imageURL toFile:(NSString*)filePath;

@end
