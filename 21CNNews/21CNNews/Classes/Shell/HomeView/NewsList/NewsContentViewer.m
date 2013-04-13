//
//  NewsContentViewer.m
//  Shell
//
//  Created by chenggk on 13-4-7.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "NewsContentViewer.h"
#import "ArticleContentObject.h"
#import "UITitleView.h"
#import "ResManager.h"
#import "ArticleContentNotifyKey.h"
#import "ArticleContentManager.h"

@interface NewsContentViewer ()

@property (nonatomic, retain) UITitleView* titleView;
@property (nonatomic, retain) ArticleContentObject* articleContentObject;
@property (nonatomic, retain) UIWebView* webview;

@end


@implementation NewsContentViewer

- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didArticleContentUpdate:) name:kNotifyArticleContentUpdate object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_titleView addLeftButonTarget:self action:nil forControlEvents:UIControlEventAllEvents];
    [_titleView addRightButonTarget:self action:nil forControlEvents:UIControlEventAllEvents];
    [_titleView release];
    _titleView = nil;
    
    [_webview release];
    
    [_articleContentObject release];
    
    [super dealloc];
}


- (void)createTitleViewIfNeed
{
    if (self.titleView)
    {
        return;
    }
    
    _titleView = [[UITitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 48)];
    _titleView.backgroundColor = [UIColor yellowColor];

    [_titleView setLeftButtonImage:resGetImage(@"blueArrow.png") frame:CGRectMake(0, 0, 60, 44)];
    [_titleView addLeftButonTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];    

    [self.view addSubview:_titleView];
}


- (void)createWebViewIfNeed
{
    if (self.webview)
    {
        return;
    }
    
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0,
                                                           _titleView.frame.size.height,
                                                           self.view.frame.size.width,
                                                           self.view.frame.size.height - _titleView.frame.size.height)];
    [self.view addSubview:_webview];
}



- (void)showInUIViewController:(UIViewController*)parentViewController articleID:(int)articleID;
{
    [self createTitleViewIfNeed];
    [self createWebViewIfNeed];
    
    [[ArticleContentManager shareInstance] loadArticleContent:articleID imageSize:CGSizeMake(100, 100)];
    
    [self retain];
    [parentViewController presentViewController:self animated:YES completion:nil];
}


- (void)leftButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:^()
     {
         [self release];
     }];
}


- (void)didArticleContentUpdate:(NSNotification*)notification
{
    ArticleContentObject* object = [notification.userInfo objectForKey:kParam_ArticleObject];
    if (object)
    {
        [self.webview loadHTMLString:object.content baseURL:nil];
    }
}

@end
