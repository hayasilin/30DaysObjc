//
//  RotationViewController.m
//  UIViewBasicAnimation
//
//  Created by Kuan-Wei Lin on 9/17/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "RotationViewController.h"

@interface RotationViewController ()


@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation RotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self spin];
}

- (void)spin
{
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.label.transform = CGAffineTransformRotate(self.label.transform, M_PI);
        
        
    } completion:^(BOOL finished) {
        
        [self spin];
        
    }];
}



@end
