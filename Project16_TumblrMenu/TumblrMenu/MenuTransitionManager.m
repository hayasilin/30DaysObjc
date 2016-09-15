//
//  MenuTransitionManager.m
//  TumblrMenu
//
//  Created by Kuan-Wei Lin on 9/15/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "MenuTransitionManager.h"
#import "MenuViewController.h"

@interface MenuTransitionManager () 

@property (nonatomic) BOOL presenting;

@end

@implementation MenuTransitionManager

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *container = [transitionContext containerView];
    
    UIViewController *fromScreen = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toScreen = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //bottomViewController不一定需要實做，可有可無
    UIViewController *bottomViewController = self.presenting ? fromScreen : toScreen;
    
    MenuViewController *menuVC = self.presenting ? (MenuViewController *)toScreen : (MenuViewController *)fromScreen;
    
    UIView *bottomView = bottomViewController.view;
    UIView *menuView = menuVC.view;
    
    if (self.presenting) {
        [self offStageMenuController:menuVC];
    }
    
    [container addSubview:bottomView];
    [container addSubview:menuView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
        
        if (self.presenting)
        {
            [self onStageMenuController:menuVC];
        }
        else
        {
            [self offStageMenuController:menuVC];
        }
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
        [[UIApplication sharedApplication].keyWindow addSubview:toScreen.view];
    }];
}

- (CGAffineTransform)offstage:(CGFloat)amount
{
    return CGAffineTransformMakeTranslation(amount, 0);
}

- (void)offStageMenuController:(MenuViewController *)menuViewController
{
    
    menuViewController.view.alpha = 0;
    
    CGFloat topRowOffset = 300;
    CGFloat middleRowOffset = 150;
    CGFloat bottomRowOffset = 50;
    
    menuViewController.textButton.transform = [self offstage:-topRowOffset];
    menuViewController.textLabel.transform = [self offstage:-topRowOffset];
    menuViewController.quoteButton.transform = [self offstage:-middleRowOffset];
    menuViewController.quoteLabel.transform = [self offstage:-middleRowOffset];
    menuViewController.chatButton.transform = [self offstage:-bottomRowOffset];
    menuViewController.chatLabel.transform = [self offstage:-bottomRowOffset];
    menuViewController.photoButton.transform = [self offstage:topRowOffset];
    menuViewController.photoLabel.transform = [self offstage:topRowOffset];
    menuViewController.linkButton.transform = [self offstage:middleRowOffset];
    menuViewController.linkLabel.transform = [self offstage:middleRowOffset];
    menuViewController.audioButton.transform = [self offstage:bottomRowOffset];
    menuViewController.audioLabel.transform = [self offstage:bottomRowOffset];
}

- (void)onStageMenuController:(MenuViewController *)menuViewController
{
    menuViewController.view.alpha = 1;
    
    menuViewController.textButton.transform = CGAffineTransformIdentity;
    menuViewController.textLabel.transform = CGAffineTransformIdentity;
    menuViewController.quoteButton.transform = CGAffineTransformIdentity;
    menuViewController.quoteLabel.transform = CGAffineTransformIdentity;
    menuViewController.chatButton.transform = CGAffineTransformIdentity;
    menuViewController.chatLabel.transform = CGAffineTransformIdentity;
    menuViewController.photoButton.transform = CGAffineTransformIdentity;
    menuViewController.photoLabel.transform = CGAffineTransformIdentity;
    menuViewController.linkButton.transform = CGAffineTransformIdentity;
    menuViewController.linkLabel.transform = CGAffineTransformIdentity;
    menuViewController.audioButton.transform = CGAffineTransformIdentity;
    menuViewController.audioLabel.transform = CGAffineTransformIdentity;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.presenting = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.presenting = NO;
    return self;
}

@end
