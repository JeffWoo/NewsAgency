
#import <UIKit/UIKit.h>
#import "TMQuiltViewCell.h"

@class EGOImageView;

@interface TMPhotoQuiltViewCell : TMQuiltViewCell

@property (nonatomic, retain) EGOImageView *photoView;
@property (nonatomic, retain) UILabel *titleLabel;

@end
