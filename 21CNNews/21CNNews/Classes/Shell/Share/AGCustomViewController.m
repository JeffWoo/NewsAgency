//
//  AGCustomViewController.m
//  AGShareSDKDemo
//
//  Created by 冯 鸿杰 on 13-3-5.
//  Copyright (c) 2013年 vimfung. All rights reserved.
//

#import "AGCustomViewController.h"
#import "AGCustomShareViewController.h"
#import <AGCommon/UIDevice+Common.h>
#import <AGCommon/UIImage+Common.h>
#import <AGCommon/UINavigationBar+Common.h>
#import "IIViewDeckController.h"
#import <AGCommon/UIView+Common.h>
#define BUNDLE_NAME @"Resource"
#define CONTENT @"ShareSDK不仅集成简单、支持如QQ好友、微信、新浪微博、腾讯微博等所有社交平台，而且还有强大的统计分析管理后台，实时了解用户、信息流、回流率、传播效应等数据，详情见官网http://sharesdk.cn @ShareSDK"

@implementation AGCustomViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        // Custom initialization
        UIButton *leftBtn = [[[UIButton alloc] init] autorelease];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"PublishEx/NavigationButtonBG.png" bundleName:BUNDLE_NAME]
                           forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"LeftSideViewIcon.png"] forState:UIControlStateNormal];
        leftBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
        [leftBtn addTarget:self action:@selector(leftButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftBtn] autorelease];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"自定义分享" forState:UIControlStateNormal];
    [button sizeToFit];
    button.frame = CGRectMake(5.0, 5.0, self.view.width - 10, 60);
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [button addTarget:self action:@selector(buttonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button2 setTitle:@"自定义菜单分享" forState:UIControlStateNormal];
    [button2 sizeToFit];
    button2.frame = CGRectMake(5.0, 70.0, self.view.width - 10, 60);
    button2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [button2 addTarget:self action:@selector(button2ClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self layoutView:self.interfaceOrientation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

-(BOOL)shouldAutorotate
{
    //iOS6下旋屏方法
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    //iOS6下旋屏方法
    return UIInterfaceOrientationMaskAll;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self layoutView:toInterfaceOrientation];
}

- (void)layoutPortrait
{
    UIButton *btn = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    btn.frame = CGRectMake(btn.left, btn.top, 55.0, 32.0);
    [btn setBackgroundImage:[UIImage imageNamed:@"PublishEx/NavigationButtonBG.png"
                                     bundleName:BUNDLE_NAME]
                   forState:UIControlStateNormal];
    
    if ([UIDevice currentDevice].isPad)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"PublishEx_iPad/NavigationBarBG.png" bundleName:BUNDLE_NAME]];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"PublishEx/NavigationBarBG.png" bundleName:BUNDLE_NAME]];
    }
}

- (void)layoutLandscape
{
    if (![UIDevice currentDevice].isPad)
    {
        //iPhone
        UIButton *btn = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
        btn.frame = CGRectMake(btn.left, btn.top, 48.0, 24.0);
        [btn setBackgroundImage:[UIImage imageNamed:@"PublishEx_Landscape/NavigationButtonBG.png"
                                         bundleName:BUNDLE_NAME]
                       forState:UIControlStateNormal];
        
        if ([[UIDevice currentDevice] isPhone5])
        {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"PublishEx_Landscape/NavigationBarBG-568h.png"
                                                                                 bundleName:BUNDLE_NAME]];
        }
        else
        {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"PublishEx_Landscape/NavigationBarBG.png"
                                                                                 bundleName:BUNDLE_NAME]];
        }
    }
    else
    {
        UIButton *btn = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
        btn.frame = CGRectMake(btn.left, btn.top, 55.0, 32.0);
        [btn setBackgroundImage:[UIImage imageNamed:@"PublishEx_Landscape/NavigationButtonBG.png"
                                         bundleName:BUNDLE_NAME]
                       forState:UIControlStateNormal];
        
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"PublishEx_iPad_Landscape/NavigationBarBG.png" bundleName:BUNDLE_NAME]];
    }
}

- (void)layoutView:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        [self layoutLandscape];
    }
    else
    {
        [self layoutPortrait];
    }
}

- (void)buttonClickHandler:(id)sender
{
    AGCustomShareViewController *vc = [[[AGCustomShareViewController alloc] initWithImage:[UIImage imageNamed:@"sharesdk_img.jpg"] content:CONTENT] autorelease];
    UINavigationController *naVC = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    
    if ([UIDevice currentDevice].isPad)
    {
        naVC.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [self presentModalViewController:naVC animated:YES];
}

- (void)button2ClickHandler:(id)sender
{
    UIImage *shareImage = [UIImage imageNamed:@"sharesdk_img.jpg"];
    id<ISSPublishContent> publishContent = [ShareSDK publishContent:CONTENT
                                                     defaultContent:nil
                                                        imageObject:[ShareSDK jpegImage:shareImage quality:0.8 fileName:nil]];
    //定制人人网分享
    [publishContent addRenRenUnitWithName:@"Hello 人人网"
                              description:@"这是一条测试信息"
                                      url:INHERIT_VALUE
                                  message:INHERIT_VALUE
                              imageObject:INHERIT_VALUE
                                  caption:nil];
    
    //定制QQ空间分享
    [publishContent addQQSpaceUnitWithTitle:INHERIT_VALUE
                                        url:INHERIT_VALUE
                                    comment:INHERIT_VALUE
                                    summary:@"Hello QQ空间"
                                imageObject:INHERIT_VALUE
                                       type:INHERIT_VALUE
                                    playUrl:INHERIT_VALUE
                                  syncWeibo:INHERIT_VALUE];
    
    //定制微信好友内容
    [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE
                                         content:@"Hello 微信好友!"
                                           title:INHERIT_VALUE
                                             url:INHERIT_VALUE
                                           image:INHERIT_VALUE
                                    imageQuality:INHERIT_VALUE
                                    musicFileUrl:INHERIT_VALUE
                                         extInfo:INHERIT_VALUE
                                        fileData:INHERIT_VALUE];
    
    //定制微信朋友圈内容
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeMusic]
                                          content:@"Hello 微信朋友圈!"
                                            title:INHERIT_VALUE
                                              url:@"http://y.qq.com/i/song.html#p=7B22736F6E675F4E616D65223A22E4BDA0E4B88DE698AFE79C9FE6ADA3E79A84E5BFABE4B990222C22736F6E675F5761704C69766555524C223A22687474703A2F2F74736D7573696332342E74632E71712E636F6D2F586B303051563558484A645574315070536F4B7458796931667443755A68646C2F316F5A4465637734356375386355672B474B304964794E6A3770633447524A574C48795333383D2F3634363232332E6D34613F7569643D32333230303738313038266469723D423226663D312663743D3026636869643D222C22736F6E675F5769666955524C223A22687474703A2F2F73747265616D31382E71716D757369632E71712E636F6D2F33303634363232332E6D7033222C226E657454797065223A2277696669222C22736F6E675F416C62756D223A22E5889BE980A0EFBC9AE5B08FE5B7A8E89B8B444E414C495645EFBC81E6BC94E594B1E4BC9AE5889BE7BAAAE5BD95E99FB3222C22736F6E675F4944223A3634363232332C22736F6E675F54797065223A312C22736F6E675F53696E676572223A22E4BA94E69C88E5A4A9222C22736F6E675F576170446F776E4C6F616455524C223A22687474703A2F2F74736D757369633132382E74632E71712E636F6D2F586C464E4D31354C5569396961495674593739786D436534456B5275696879366A702F674B65356E4D6E684178494C73484D6C6A307849634A454B394568572F4E3978464B316368316F37636848323568413D3D2F33303634363232332E6D70333F7569643D32333230303738313038266469723D423226663D302663743D3026636869643D2673747265616D5F706F733D38227D"
                                            image:INHERIT_VALUE
                                     imageQuality:INHERIT_VALUE
                                     musicFileUrl:@"http://mp3.mwap8.com/destdir/Music/2009/20090601/ZuiXuanMinZuFeng20090601119.mp3"
                                          extInfo:nil
                                         fileData:nil];
    
    //定制QQ分享内容
    [publishContent addQQUnitWithType:INHERIT_VALUE
                              content:@"Hello QQ!"
                                title:INHERIT_VALUE
                                  url:INHERIT_VALUE
                                image:INHERIT_VALUE
                         imageQuality:INHERIT_VALUE];
    
    //定制邮件分享内容
    [publishContent addMailUnitWithSubject:INHERIT_VALUE
                                   content:@"<a href='http://sharesdk.cn'>Hello Mail</a>"
                                    isHTML:[NSNumber numberWithBool:YES]
                               attachments:INHERIT_VALUE];
    
    //定制短信分享内容
    [publishContent addSMSUnitWithContent:@"Hello SMS!"];
    
    //定制有道云笔记分享内容
    [publishContent addYouDaoNoteUnitWithContent:INHERIT_VALUE
                                           title:@"ShareSDK分享"
                                          author:@"ShareSDK"
                                          source:@"http://www.sharesdk.cn"
                                     attachments:INHERIT_VALUE];
    
    id clickHandler = ^{
        AGCustomShareViewController *vc = [[[AGCustomShareViewController alloc] initWithImage:shareImage content:CONTENT] autorelease];
        UINavigationController *naVC = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
        
        if ([UIDevice currentDevice].isPad)
        {
            naVC.modalPresentationStyle = UIModalPresentationFormSheet;
        }
        
        [self presentModalViewController:naVC animated:YES];
    };
    
    
    [ShareSDK showShareActionSheet:self
                     iPadContainer:[ShareSDK iPadShareContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp]
                         shareList:[ShareSDK customShareListWithType:
                                    [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeSinaWeibo]
                                                                       icon:[ShareSDK getClientIconWithType:ShareTypeSinaWeibo]
                                                               clickHandler:clickHandler],
                                    [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeTencentWeibo]
                                                                       icon:[ShareSDK getClientIconWithType:ShareTypeTencentWeibo]
                                                               clickHandler:clickHandler],
                                    SHARE_TYPE_NUMBER(ShareTypeSMS),
                                    [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeQQSpace]
                                                                       icon:[ShareSDK getClientIconWithType:ShareTypeQQSpace]
                                                               clickHandler:clickHandler],
                                    SHARE_TYPE_NUMBER(ShareTypeWeixiSession),
                                    SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),
                                    SHARE_TYPE_NUMBER(ShareTypeQQ),
                                    [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeFacebook]
                                                                       icon:[ShareSDK getClientIconWithType:ShareTypeFacebook]
                                                               clickHandler:clickHandler],
                                    [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeTwitter]
                                                                       icon:[ShareSDK getClientIconWithType:ShareTypeTwitter]
                                                               clickHandler:clickHandler],
                                    [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeRenren]
                                                                       icon:[ShareSDK getClientIconWithType:ShareTypeRenren]
                                                               clickHandler:clickHandler],
                                    [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeKaixin]
                                                                       icon:[ShareSDK getClientIconWithType:ShareTypeKaixin]
                                                               clickHandler:clickHandler],
                                    SHARE_TYPE_NUMBER(ShareTypeMail),
                                    SHARE_TYPE_NUMBER(ShareTypeAirPrint),
                                    SHARE_TYPE_NUMBER(ShareTypeCopy),
                                    [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeSohuWeibo]
                                                                       icon:[ShareSDK getClientIconWithType:ShareTypeSohuWeibo]
                                                               clickHandler:clickHandler],
                                    [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareType163Weibo]
                                                                       icon:[ShareSDK getClientIconWithType:ShareType163Weibo]
                                                               clickHandler:clickHandler],
                                    [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeDouBan]
                                                                       icon:[ShareSDK getClientIconWithType:ShareTypeDouBan]
                                                               clickHandler:clickHandler],
                                    [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeInstapaper]
                                                                       icon:[ShareSDK getClientIconWithType:ShareTypeInstapaper]
                                                               clickHandler:clickHandler],
                                    [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeYouDaoNote]
                                                                       icon:[ShareSDK getClientIconWithType:ShareTypeYouDaoNote]
                                                               clickHandler:clickHandler],
                                    nil]
                           content:publishContent
                     statusBarTips:YES
                        convertUrl:YES
                       authOptions:nil
                  shareViewOptions:nil
                            result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(@"发表成功");
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSLog(@"发布失败!error code == %d, error code == %@", [error errorCode], [error errorDescription]);
                                }
                            }];
}

- (void)leftButtonClickHandler:(id)sender
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

@end
