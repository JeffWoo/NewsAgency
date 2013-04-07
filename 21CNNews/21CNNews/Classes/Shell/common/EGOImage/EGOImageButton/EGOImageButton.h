
#import <UIKit/UIKit.h>
#import "EGOImageLoader.h"

@protocol EGOImageButtonDelegate;
@interface EGOImageButton : UIButton<EGOImageLoaderObserver> {
@private
	NSURL* imageURL;
	UIImage* placeholderImage;
	id<EGOImageButtonDelegate> delegate;
}

- (id)initWithPlaceholderImage:(UIImage*)anImage; // delegate:nil
- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<EGOImageButtonDelegate>)aDelegate;

- (void)cancelImageLoad;

@property(nonatomic,retain) NSURL* imageURL;
@property(nonatomic,retain) UIImage* placeholderImage;
@property(nonatomic,assign) id<EGOImageButtonDelegate> delegate;
@end

@protocol EGOImageButtonDelegate<NSObject>
@optional
- (void)imageButtonLoadedImage:(EGOImageButton*)imageButton;
- (void)imageButtonFailedToLoadImage:(EGOImageButton*)imageButton error:(NSError*)error;
@end