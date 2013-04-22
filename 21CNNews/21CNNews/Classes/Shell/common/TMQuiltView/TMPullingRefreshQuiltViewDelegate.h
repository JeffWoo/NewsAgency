
#ifndef Shell_TMPullingRefreshQuiltViewDelegate_h
#define Shell_TMPullingRefreshQuiltViewDelegate_h

@class TMQuiltViewCell;
#import "TMQuiltView.h"

@protocol TMPullingRefreshQuiltViewDelegate <NSObject>

- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView;

- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath*)indexPath;

@end


@protocol TMPullingRefreshQuiltViewDataDelegate <NSObject>

@optional

- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath;

- (void)quiltViewUpRefresh:(TMQuiltView *)quiltView;

- (void)quiltViewDownRefresh:(TMQuiltView *)quiltView;

// Must return a number of column greater than 0. Otherwise a default value is used.
- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView;

// Must return margins for all the possible values of TMQuiltViewMarginType. Otherwise a default value is used.
- (CGFloat)quiltViewMargin:(TMQuiltView *)quilView marginType:(TMQuiltViewMarginType)marginType;

// Must return the height of the requested cell
- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath;


@end

#endif
