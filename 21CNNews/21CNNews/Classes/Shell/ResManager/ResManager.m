
#import "ResManager.h"
#import "SettingManager.h"
#import "UIImage+ResManager.h"
/*
 日间图片：均放在day目录下
 夜间图片：均放在night目录下
 高分辨率图片：需以“2x.png”结尾命名，如:a2x.png
 低分辨率图片：需以“.png”结尾命名，如：a.png
 一个例子：
    如界面需增加一张图片，假设UI提供了日夜间模式下高分辨率及低分辨率四张图片，具体可如下操作：
    1、将日夜间模式下两张高分辨率图片都命名为text2x.png，两张低分辨率都命名为text2x.png，并将图片分别放置于day及night目录下，
    2、使用时，可如下编码：
        UIImage* testImg = resGetImage(@"test.png");
       则底层模块会自动根据当前是日间模式还是夜间模式，当前机器是高分辨率屏幕还是低分辨率屏幕自动选择相应图片
 */

UIImage* resGetImage(NSString* shotName)
{
    NSString* imagePath = nil;
    if ([SettingManager shareInstance].isNightMode) ///< 如果开启了夜间模式，则选取夜间模式文件夹下图片，否则，则选取日间模式下图片
    {
        imagePath = [NSString stringWithFormat:@"night/%@", shotName];
    }
    else
    {
        imagePath = [NSString stringWithFormat:@"day/%@", shotName];
    }
    
    //注意：UIImage+ResManager.h中钩住了imageNamed函数，会根据当前屏幕分辨率自动选择高分辨率/低分辨率图片
    return [UIImage imageNamed:imagePath];
}