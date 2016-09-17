//
//  PositionViewController.m
//  UIViewBasicAnimation
//
//  Created by Kuan-Wei Lin on 9/17/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "PositionViewController.h"

@interface PositionViewController ()

@property (weak, nonatomic) IBOutlet UIView *leftEyeView;
@property (weak, nonatomic) IBOutlet UIView *rightEyeView;
@property (weak, nonatomic) IBOutlet UIView *mouseView;

@end

@implementation PositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [UIView animateWithDuration:0.8 delay:0.2 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.leftEyeView.center = CGPointMake(self.view.bounds.size.width - self.leftEyeView.center.x, self.leftEyeView.center.y + 30);
        self.rightEyeView.center = CGPointMake(self.view.bounds.size.width -  self.rightEyeView.center.x, self.rightEyeView.center.y + 30);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.8 delay:0.2 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [self setHeight:180];
            CGPoint center = self.mouseView.center;
            center.y = self.view.bounds.size.height - self.mouseView.center.y;
            self.mouseView.center = center;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.mouseView.frame;
    frame.size.height = height;
    self.mouseView.frame = frame;
}


@end
