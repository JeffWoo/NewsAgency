
#import <UIKit/UIKit.h>

@interface TMQuiltViewCell : UIView

@property (nonatomic, readonly) NSString *reuseIdentifier;
@property (nonatomic, assign) BOOL selected;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
