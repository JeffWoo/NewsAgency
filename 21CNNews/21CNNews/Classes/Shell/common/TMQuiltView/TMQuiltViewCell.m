
#import "TMQuiltViewCell.h"

@implementation TMQuiltViewCell

@synthesize reuseIdentifier = _reuseIdentifier;
@synthesize selected = _selected;

- (void)dealloc {
    [_reuseIdentifier release], _reuseIdentifier = nil;
    
    [super dealloc];
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super init];
    if (self) {
        _reuseIdentifier = [reuseIdentifier retain];
    }
    return self;
}

@end
