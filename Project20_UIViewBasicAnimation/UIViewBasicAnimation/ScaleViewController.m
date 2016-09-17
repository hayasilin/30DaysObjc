//
//  ScaleViewController.m
//  UIViewBasicAnimation
//
//  Created by Kuan-Wei Lin on 9/17/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ScaleViewController.h"

@interface ScaleViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.alpha = 0;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        self.imageView.transform = CGAffineTransformMakeScale(2, 2);
        self.imageView.alpha = 1;
        
    } completion:^(BOOL finished) {
    
    }];    
}

@end
