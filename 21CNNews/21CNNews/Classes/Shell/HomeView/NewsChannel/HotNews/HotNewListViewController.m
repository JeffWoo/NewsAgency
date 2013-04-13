//
//  HotNewListViewController.m
//  Shell
//
//  Created by chenggk on 13-4-13.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "HotNewListViewController.h"
#import "HotNewsManager.h"
#import "HotNewsNotificationKeys.h"
#import "HotNewsButton.h"

@interface HotNewListViewController ()

@property (nonatomic, retain) UIScrollView* scrollView;
@property (nonatomic, retain) NSArray* hotNewList;
@property (nonatomic, retain) NSMutableArray* hotNewsButtonList;

@end

@implementation HotNewListViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didHotNewsListChanged) name:kHotNewsListChanged object:nil];
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_scrollView];
        
        self.view.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}


- (void)dealloc
{
    [self releaseHotNewsButton];
    [_hotNewsButtonList release];
    
    [_scrollView release];
    [_hotNewList release];
    [super dealloc];
}


- (void)releaseHotNewsButton
{
    for (HotNewsButton* button in self.hotNewsButtonList)
    {
        [button removeTarget:self action:nil forControlEvents:UIControlEventAllEvents];
        [button removeFromSuperview];
    }
    
    [self.hotNewsButtonList removeAllObjects];
}


- (void)layout
{
    [self releaseHotNewsButton];
    self.hotNewList = [[HotNewsManager shareInstance] getHotNewsList];
    
    int originX = 15;
    int originY = 10;
    for (HotNewsItem* item in self.hotNewList)
    {
        HotNewsButton* button = [[[HotNewsButton alloc] initWithFrame:CGRectMake(originX, originY, 320, 25)] autorelease];
        [button setHotNewsItem:item];
        [self.scrollView addSubview:button];
        originX += (button.frame.size.width + 18);
        if (originX >= 275)
        {
            originX = 15;
            originY += (button.frame.size.height + 10);
            
            button.frame = CGRectMake(originX, originY, button.frame.size.width, button.frame.size.height);
            originX += (button.frame.size.width + 18);
            if (originX >= 275)
            {
                originX = 15;
                originY += (button.frame.size.height + 10);
            }
        }
        
    }
    
    originY += (15 + 25);
    if (originY > self.scrollView.frame.size.height)
    {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, originY);
    }
    else
    {
        self.scrollView.contentSize = self.scrollView.frame.size;
    }
}


- (void)showInView:(UIView*)superView frame:(CGRect)frame
{
    self.view.frame = frame;
    self.view.backgroundColor = [UIColor clearColor];
    [superView addSubview:self.view];
    
    self.scrollView.frame = self.view.bounds;
    [self.view addSubview:self.scrollView];
        
    [self layout];
}


- (void)didHotNewsListChanged
{
    [self layout];
}

@end
