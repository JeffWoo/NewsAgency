
#import "ResManager.h"
#import "SettingManager.h"
#import "UIImage+ResManager.h"


UIImage* resGetImage(NSString* shotName)
{
    NSString* imagePath = nil;
    if ([SettingManager shareInstance].isNightMode)
    {
        imagePath = [NSString stringWithFormat:@"night/%@", shotName];
    }
    else
    {
        imagePath = [NSString stringWithFormat:@"day/%@", shotName];
    }
    
    return [UIImage imageNamed:imagePath];
}