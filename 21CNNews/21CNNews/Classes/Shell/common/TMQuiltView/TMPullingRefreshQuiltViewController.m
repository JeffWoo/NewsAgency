//
//  TMQuiltView
//
//  Created by Bruno Virlet on 7/20/12.
//
//  Copyright (c) 2012 1000memories

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
//  and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR 
//  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
//  DEALINGS IN THE SOFTWARE.
//


#import "TMPullingRefreshQuiltViewController.h"

#import "TMPhotoQuiltViewCell.h"


@interface TMPullingRefreshQuiltViewController ()

@property (nonatomic, readwrite) BOOL upRefreshing;
@property (nonatomic, readwrite) BOOL downRefreshing;

@end

@implementation TMPullingRefreshQuiltViewController

- (id)init
{
    self = [super init];
    if (self)
    {

    }
    
    return self;
}


- (void)dealloc
{
    [_headerView release];
    [_footView release];

    [super dealloc];
}


#pragma mark - UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.quiltView.backgroundColor = [UIColor blackColor];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


- (void)caculateHeaderViewAndFootViewPosition:(UIScrollView*)scrollView
{
    CGFloat yOffSet = scrollView.contentOffset.y;
    if (yOffSet < 0 && !self.upRefreshing)
    {
        CGRect frame = _headerView.frame;
        frame.origin = CGPointMake(0, -frame.size.height);
        _headerView.frame = frame;
        [self.quiltView addSubview:_headerView];
    }
    
    int height = scrollView.contentSize.height;
    if (yOffSet + scrollView.frame.size.height > height && !self.downRefreshing)
    {
        CGRect frame = _footView.frame;
        frame.origin = CGPointMake(0, height);
        _footView.frame = frame;
        [self.quiltView addSubview:_footView];
    }
}


- (void)setLoadFinish
{
    _upRefreshing = NO;
    _downRefreshing = NO;
    [_headerView removeFromSuperview];
    [_footView removeFromSuperview];
    if (self.quiltView.contentInset.bottom == _footView.frame.size.height)
    {
        CGPoint offset = self.quiltView.contentOffset;
        offset.y += _footView.frame.size.height;
        [self.quiltView setContentOffset:offset];        
    }
    
    self.quiltView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}


- (void)setUpRefreshing:(BOOL)upRefreshing
{
    _upRefreshing = upRefreshing;
    if (_upRefreshing)
    {
        if ([self.dataSource respondsToSelector:@selector(quiltViewUpRefresh:)])
        {
            [self.dataSource quiltViewUpRefresh:self.quiltView];
        }
    }
}

- (void)setDownRefreshing:(BOOL)downRefreshing
{
    _downRefreshing = downRefreshing;
    if (_downRefreshing)
    {
        if ([self.dataSource respondsToSelector:@selector(quiltViewDownRefresh:)])
        {
            [self.dataSource quiltViewDownRefresh:self.quiltView];
        }
    }
}


- (void)launchRefreshing
{
    self.quiltView.contentOffset = CGPointZero;
    self.quiltView.contentInset = UIEdgeInsetsMake(_headerView.frame.size.height, 0, 0, 0);
    [self.quiltView addSubview:_headerView];
}


- (void)reloadData
{
    [self.quiltView reloadData];
}

#pragma mark - QuiltViewControllerDataSource


- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(quiltView:didSelectCellAtIndexPath:)])
    {
        [self.dataSource quiltView:quiltView didSelectCellAtIndexPath:indexPath];
    }
}


- (CGFloat)quiltViewMargin:(TMQuiltView *)quilView marginType:(TMQuiltViewMarginType)marginType
{
    if ([self.dataSource respondsToSelector:@selector(quiltViewMargin:marginType:)])
    {
        return [self.dataSource quiltViewMargin:quilView marginType:marginType];
    }
    
    return 0;
}


- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(quiltView:heightForCellAtIndexPath:)])
    {
        return [self.dataSource quiltView:quiltView heightForCellAtIndexPath:indexPath];
    }
    
    return 0;
}


- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)TMQuiltView
{
    if ([self.dataSource respondsToSelector:@selector(quiltViewNumberOfColumns:)])
    {
        return [self.dataSource quiltViewNumberOfColumns:TMQuiltView];
    }
    
    return 0;
}


#pragma mark - TMQuiltViewDelegate
- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)quiltView
{
    if ([self.delegate respondsToSelector:@selector(quiltViewNumberOfCells:)])
    {
        return [self.delegate quiltViewNumberOfCells:quiltView];
    }
    
    return 0;
}


- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(quiltView:cellAtIndexPath:)])
    {
        return [self.delegate quiltView:quiltView cellAtIndexPath:indexPath];
    }
    
    return nil;
}


#pragma mark UIScrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self caculateHeaderViewAndFootViewPosition:scrollView];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self caculateHeaderViewAndFootViewPosition:scrollView];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self caculateHeaderViewAndFootViewPosition:scrollView];
    
    CGFloat yOffSet = scrollView.contentOffset.y;
    if (yOffSet < 0 && !self.upRefreshing)
    {
        if (yOffSet < -_headerView.frame.size.height / 2)
        {
            self.upRefreshing = YES;
            scrollView.contentInset = UIEdgeInsetsMake(_headerView.frame.size.height, 0, 0, 0);
        }
        else
        {
            [_headerView removeFromSuperview];
        }
    }
    
    int height = scrollView.contentSize.height;
    if (yOffSet + scrollView.frame.size.height > height && !self.downRefreshing)
    {
        if (yOffSet + scrollView.frame.size.height - height > _headerView.frame.size.height / 2)
        {
            self.downRefreshing = YES;
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, _footView.frame.size.height, 0);
        }
        else
        {
            [_footView removeFromSuperview];
        }
    }
}


@end
