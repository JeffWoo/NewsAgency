//
//  ReviewListItem.h
//  Model
//
//  Created by chenggk on 13-4-6.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReviewListItem : NSObject

@property (nonatomic, readonly) int userId;
@property (nonatomic, readonly) NSString* userNickName;
@property (nonatomic, readonly) NSString* userIconUrl;
@property (nonatomic, readonly) NSString* content;


- (id)initWithUserId:(int)userId
        userNickName:(NSString*)userNickName
         userIconUrl:(NSString*)userIconUrl
             content:(NSString*)content;


+ reviewListItemUserId:(int)userId
          userNickName:(NSString*)userNickName
           userIconUrl:(NSString*)userIconUrl
               content:(NSString*)content;

@end
