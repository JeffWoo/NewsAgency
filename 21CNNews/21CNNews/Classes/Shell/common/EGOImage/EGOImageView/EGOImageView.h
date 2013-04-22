#import <UIKit/UIKit.h>
#import "EGOImageLoader.h"

@protocol EGOImageViewDelegate;
@interface EGOImageView : UIImageView<EGOImageLoaderObserver> {
@private
	NSURL* imageURL;
	UIImage* placeholderImage;
	id<EGOImageViewDelegate> delegate;
}

- (id)initWithPlaceholderImage:(UIImage*)anImage; // delegate:nil
- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<EGOImageViewDelegate>)aDelegate;

- (void)cancelImageLoad;

@property(nonatomic,retain) NSURL* imageURL;            ///< 图片url
@property(nonatomic,retain) UIImage* placeholderImage;  ///< 图片加载完成前的默认展现图片
@property(nonatomic,assign) id<EGOImageViewDelegate> delegate;
@end

@protocol EGOImageViewDelegate<NSObject>
@optional
//图片加载成功回调
- (void)imageViewLoadedImage:(EGOImageView*)imageView;

//图片加载失败回调
- (void)imageViewFailedToLoadImage:(EGOImageView*)imageView error:(NSError*)error;
@end