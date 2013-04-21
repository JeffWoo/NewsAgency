/*
 **************************************************************************************
 * Copyright (C) 2005-2011 UC Mobile Limited. All Rights Reserved
 * File			: UserSerialNumJSDataParser.h
 *
 * Description	: app序列号协议解析器
 *
 * Author		: ioscoder
 *
 * History		: Creation, 2013/4/5, chenggk, Create the file
 ***************************************************************************************
 **/

#import <Foundation/Foundation.h>

@interface UserSerialNumJSDataParser : NSObject

+ (NSString*)parser:(NSData*)jsData;    ///< 根据服务器返回的json数据，解析出app序列号

@end
