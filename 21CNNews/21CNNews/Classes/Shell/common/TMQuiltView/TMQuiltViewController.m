
#import "TMQuiltViewController.h"

#import "TMQuiltView.h"
#import "TMQuiltViewCell.h"

@interface TMQuiltViewController () <TMQuiltViewDataSource, TMQuiltViewDelegate>

@end

@implementation TMQuiltViewController

@synthesize quiltView = _quiltView;

- (void)dealloc {
    [_quiltView release], _quiltView = nil;
    
    [super dealloc];
}

- (void)loadView {
    _quiltView = [[TMQuiltView alloc] initWithFrame:CGRectZero];
    _quiltView.delegate = self;
    _quiltView.dataSource = self;
    _quiltView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view = _quiltView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.quiltView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.quiltView = nil;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self.quiltView reloadData];
}

#pragma mark - TMQuiltViewDataSource

- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)quiltView {
    return 0;
}

- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath {
    TMQuiltViewCell *cell = [self.quiltView dequeueReusableCellWithReuseIdentifier:nil];
    if (!cell) {
        cell = [[[TMQuiltViewCell alloc] initWithReuseIdentifier:nil] autorelease];
    }
    return cell;
}

@end
