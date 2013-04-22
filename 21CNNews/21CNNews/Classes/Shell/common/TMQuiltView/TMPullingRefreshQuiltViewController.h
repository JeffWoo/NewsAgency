#import <UIKit/UIKit.h>
#import "TMQuiltViewController.h"
#import "TMPullingRefreshQuiltViewDelegate.h"

@interface TMPullingRefreshQuiltViewController : TMQuiltViewController

@property (nonatomic, assign) id<TMPullingRefreshQuiltViewDelegate> delegate;
@property (nonatomic, assign) id<TMPullingRefreshQuiltViewDataDelegate> dataSource;

@property (nonatomic, retain) UIView* headerView;
@property (nonatomic, retain) UIView* footView;

- (void)setLoadFinish;

- (void)reloadData;

- (void)launchRefreshing;

@end
