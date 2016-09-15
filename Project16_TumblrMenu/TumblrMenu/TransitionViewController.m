//
//  TransitionViewController.m
//  TumblrMenu
//
//  Created by Kuan-Wei Lin on 9/15/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "TransitionViewController.h"

@interface TransitionViewController ()

@property (weak, nonatomic) IBOutlet UIView *blurView;

@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.alpha = 0;
    
    if (!UIAccessibilityIsReduceTransparencyEnabled())
    {
        self.view.backgroundColor = [UIColor clearColor];
        self.blurView.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.view.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.blurView addSubview:blurEffectView];
    }
    else
    {
        self.blurView.backgroundColor = [UIColor blackColor];
    }
    
    
    CGFloat topRowOffset = 300;
    CGFloat middleRowOffset = 150;
    CGFloat bottomRowOffset = 50;
    
    self.textButton.transform = [self offstage:-topRowOffset];
    self.textLabel.transform = [self offstage:-topRowOffset];
    self.quoteButton.transform = [self offstage:-middleRowOffset];
    self.quoteLabel.transform = [self offstage:-middleRowOffset];
    self.chatButton.transform = [self offstage:-bottomRowOffset];
    self.chatLabel.transform = [self offstage:-bottomRowOffset];
    self.photoButton.transform = [self offstage:topRowOffset];
    self.photoLabel.transform = [self offstage:topRowOffset];
    self.linkButton.transform = [self offstage:middleRowOffset];
    self.linkLabel.transform = [self offstage:middleRowOffset];
    self.audioButton.transform = [self offstage:bottomRowOffset];
    self.audioLabel.transform = [self offstage:bottomRowOffset];
    
    
    [self performSelector:@selector(onTransformAnimation) withObject:nil afterDelay:0.1];
}

- (CGAffineTransform)offstage:(CGFloat)amount
{
    return CGAffineTransformMakeTranslation(amount, 0);
}

- (void)onTransformAnimation
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.view.alpha = 1;
        
        self.textButton.transform = CGAffineTransformIdentity;
        self.textLabel.transform = CGAffineTransformIdentity;
        self.quoteButton.transform = CGAffineTransformIdentity;
        self.quoteLabel.transform = CGAffineTransformIdentity;
        self.chatButton.transform = CGAffineTransformIdentity;
        self.chatLabel.transform = CGAffineTransformIdentity;
        self.photoButton.transform = CGAffineTransformIdentity;
        self.photoLabel.transform = CGAffineTransformIdentity;
        self.linkButton.transform = CGAffineTransformIdentity;
        self.linkLabel.transform = CGAffineTransformIdentity;
        self.audioButton.transform = CGAffineTransformIdentity;
        self.audioLabel.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        
    }];
}

- (IBAction)unwindToVC:(id)sender {
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.view.alpha = 0;
        
        CGFloat topRowOffset = 300;
        CGFloat middleRowOffset = 150;
        CGFloat bottomRowOffset = 50;
        
        self.textButton.transform = [self offstage:-topRowOffset];
        self.textLabel.transform = [self offstage:-topRowOffset];
        self.quoteButton.transform = [self offstage:-middleRowOffset];
        self.quoteLabel.transform = [self offstage:-middleRowOffset];
        self.chatButton.transform = [self offstage:-bottomRowOffset];
        self.chatLabel.transform = [self offstage:-bottomRowOffset];
        self.photoButton.transform = [self offstage:topRowOffset];
        self.photoLabel.transform = [self offstage:topRowOffset];
        self.linkButton.transform = [self offstage:middleRowOffset];
        self.linkLabel.transform = [self offstage:middleRowOffset];
        self.audioButton.transform = [self offstage:bottomRowOffset];
        self.audioLabel.transform = [self offstage:bottomRowOffset];
        
    } completion:^(BOOL finished) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    
    
}



@end
