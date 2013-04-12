//
//  ArticleContentManager.h
//  Model
//
//  Created by chenggk on 13-4-7.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ArticleContentManager : NSObject

+ (ArticleContentManager*)shareInstance;

- (void)loadArticleContent:(int)articleId imageSize:(CGSize)imageSize;

@end
