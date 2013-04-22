//
//  UISideBarViewController.m
//  21CNNews
//
//  Created by chenggk on 13-4-4.
//  Copyright (c) 2013年 21cn. All rights reserved.
//

#import "UISideBarViewController.h"

#define kContentOffset              (self.view.frame.size.width - _contentOffset)
#define kContentMinOffset           30
#define kMoveAnimationDuration      0.3f


typedef enum _SideBarShowDirection
{
    SideBarShowDirectionNone = 0,
    SideBarShowDirectionLeft = 1,
    SideBarShowDirectionRight = 2
}SideBarShowDirection;


@interface UISideBarViewController ()

@property (nonatomic, retain) UIPanGestureRecognizer* panGestureReconginzer;
@property (nonatomic, retain) UITapGestureRecognizer* tapGestureRecognizer;
@property (nonatomic, readwrite) CGFloat currentTranslate;
@property (nonatomic, readwrite) BOOL sideBarShowing;
@property (nonatomic, readwrite) SideBarShowDirection currentDirection;

@end

@implementation UISideBarViewController


- (id)init
{
    self = [super init];
    if (self)
    {
        _panGestureReconginzer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panInContentView:)];
        _tapGestureRecognizer = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(tapOnContentView:)];
        
        _currentDirection = SideBarShowDirectionNone;
        
        _contentOffset = kContentMinOffset;
        
        self.view.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}


- (void)dealloc
{
    [_leftSideBarViewController release];
    [_rightSideBarViewController release];
    
    [_contentViewController.view removeGestureRecognizer:_tapGestureRecognizer];
    [_contentViewController.view removeGestureRecognizer:_panGestureReconginzer];
    [_contentViewController release];
    
    [_tapGestureRecognizer removeTarget:NULL action:NULL];
    [_tapGestureRecognizer release];
    
    [_panGestureReconginzer removeTarget:NULL action:NULL];
    [_panGestureReconginzer release];
    
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)setContentViewController:(UISideBarSubViewController *)contentViewController
{
    [_contentViewController.view removeGestureRecognizer:_tapGestureRecognizer];
    [_contentViewController.view removeGestureRecognizer:_panGestureReconginzer];
    [_contentViewController release];
    
    _contentViewController = [contentViewController retain];
    
//    [_contentViewController.view addGestureRecognizer:_tapGestureRecognizer];
    [_contentViewController.view addGestureRecognizer:_panGestureReconginzer];
    
    [self.view addSubview:_contentViewController.view];
}


- (void)insertLeftOrRightView:(UIView*)view
{
    if (_contentViewController.view.superview == self.view)
    {
        [self.view insertSubview:view belowSubview:_contentViewController.view];
    }
    else
    {
        [self.view addSubview:view];
    }
}


- (void)setRightSideBarViewController:(UISideBarSubViewController *)rightSideBarViewController
{
    [_rightSideBarViewController.view removeFromSuperview];
    [_rightSideBarViewController release];
    _rightSideBarViewController = [rightSideBarViewController retain];
    
    [self insertLeftOrRightView:_rightSideBarViewController.view];
}


- (void)setLeftSideBarViewController:(UISideBarSubViewController *)leftSideBarViewController
{
    [_leftSideBarViewController.view removeFromSuperview];
    [_leftSideBarViewController release];
    _leftSideBarViewController = [leftSideBarViewController retain];
    [self insertLeftOrRightView:_leftSideBarViewController.view];
}


- (void)goToNewDiection:(SideBarShowDirection)direction forceChanged:(BOOL)bForce
{
    if (!bForce && self.currentDirection == direction)
    {
        return;
    }
    
    switch (self.currentDirection)
    {
        case SideBarShowDirectionNone:
        {
            self.contentViewController.view.transform  = CGAffineTransformIdentity;
            [self.contentViewController didSubSideBarGoingToShow];
            [self.contentViewController.view removeGestureRecognizer:_tapGestureRecognizer];
        }
            break;
        case SideBarShowDirectionLeft:
        {
            self.contentViewController.view.transform  = CGAffineTransformMakeTranslation(kContentOffset, 0);
            [self.leftSideBarViewController didSubSideBarGoingToShow];
            [self.view insertSubview:self.leftSideBarViewController.view aboveSubview:self.rightSideBarViewController.view];
            [_contentViewController.view addGestureRecognizer:_tapGestureRecognizer];
        }
            break;
        case SideBarShowDirectionRight:
        {
            self.contentViewController.view.transform  = CGAffineTransformMakeTranslation(-kContentOffset, 0);
            [self.rightSideBarViewController didSubSideBarGoingToShow];
            [self.view insertSubview:self.rightSideBarViewController.view aboveSubview:self.leftSideBarViewController.view];
            [_contentViewController.view addGestureRecognizer:_tapGestureRecognizer];
        }
            break;
        default:
            break;
    }
}


#pragma animation
- (void)moveAnimationWithDirection:(SideBarShowDirection)direction duration:(float)duration
{
    self.currentDirection = direction;
    void (^animations)(void) = ^{
		[self goToNewDiection:self.currentDirection forceChanged:YES];
	};
    
    void (^complete)(BOOL) = ^(BOOL finished) {
        self.contentViewController.view.userInteractionEnabled = YES;
        
        if (direction == SideBarShowDirectionNone)
        {            
            if (_tapGestureRecognizer)
            {
                [self.contentViewController.view removeGestureRecognizer:_tapGestureRecognizer];

            }
            
            _sideBarShowing = NO;
        }
        else
        {
            [self.contentViewController.view addGestureRecognizer:_tapGestureRecognizer];
            _sideBarShowing = YES;
        }
        
        _currentTranslate = self.contentViewController.view.transform.tx;
	};
    
    self.contentViewController.view.userInteractionEnabled = NO;

    [UIView animateWithDuration:duration animations:animations completion:complete];
}


#pragma mark UIPanGestureRecognizer delegate
- (void)panInContentView:(UIPanGestureRecognizer *)panGestureReconginzer
{
	if (panGestureReconginzer.state == UIGestureRecognizerStateChanged)
    {
        CGFloat translation = [panGestureReconginzer translationInView:self.contentViewController.view].x;
        self.contentViewController.view.transform = CGAffineTransformMakeTranslation(translation + _currentTranslate, 0);
        if (translation + _currentTranslate > 0)
        {
            [self.view insertSubview:self.leftSideBarViewController.view aboveSubview:self.rightSideBarViewController.view];
        }
        else
        {
            [self.view insertSubview:self.rightSideBarViewController.view aboveSubview:self.leftSideBarViewController.view];
        }        
	}
    else if (panGestureReconginzer.state == UIGestureRecognizerStateEnded)
    {
		_currentTranslate = self.contentViewController.view.transform.tx;

        if (!_sideBarShowing)
        {
            if (fabs(_currentTranslate) < kContentMinOffset)
            {
                [self moveAnimationWithDirection:SideBarShowDirectionNone duration:kMoveAnimationDuration];
            }
            else if(_currentTranslate > kContentMinOffset)
            {
                [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:kMoveAnimationDuration];
            }
            else
            {
                [self moveAnimationWithDirection:SideBarShowDirectionRight duration:kMoveAnimationDuration];
            }
        }
        else
        {
            if (fabs(_currentTranslate) < kContentOffset - kContentMinOffset)
            {
                [self moveAnimationWithDirection:SideBarShowDirectionNone duration:kMoveAnimationDuration];                
            }
            else if(_currentTranslate > kContentOffset - kContentMinOffset)
            {                
                [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:kMoveAnimationDuration];
                
            }else
            {
                [self moveAnimationWithDirection:SideBarShowDirectionRight duration:kMoveAnimationDuration];
            }
        }
	}
}

#pragma mark UITapGestureRecognizer delegate
- (void)tapOnContentView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:kMoveAnimationDuration];
}


#pragma mark SideBarViewSelectedDelegate
- (void)notifyGoToMid:(UIViewController *)controller
{
    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:kMoveAnimationDuration];
}


- (void)notifyGoToLeft:(UIViewController *)controller
{
    if (_currentDirection == SideBarShowDirectionLeft)
    {
        [self moveAnimationWithDirection:SideBarShowDirectionNone duration:kMoveAnimationDuration];
    }
    else
    {
        [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:kMoveAnimationDuration];
    }
}


- (void)notifyGoToRight:(UIViewController *)controller
{
    if (_currentDirection == SideBarShowDirectionRight)
    {
        [self moveAnimationWithDirection:SideBarShowDirectionNone duration:kMoveAnimationDuration];
    }
    else
    {
        [self moveAnimationWithDirection:SideBarShowDirectionRight duration:kMoveAnimationDuration];
    }
}


- (void)didRotateFromInterfaceOrientation
{
    self.contentViewController.view.transform = CGAffineTransformIdentity;
    self.leftSideBarViewController.view.transform = CGAffineTransformIdentity;
    self.rightSideBarViewController.view.transform = CGAffineTransformIdentity;
    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.contentViewController.view.frame = frame;
    self.rightSideBarViewController.view.frame = frame;
    self.leftSideBarViewController.view.frame = frame;
    
    [self goToNewDiection:self.currentDirection forceChanged:YES];
}

@end
