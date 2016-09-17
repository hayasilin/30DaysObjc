//
//  SecondViewController.m
//  TabBar
//
//  Created by Kuan-Wei Lin on 9/17/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.imageView.alpha = 0;
    self.imageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self animateView];
}

- (void)animateView
{
    [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        self.imageView.transform = CGAffineTransformMakeScale(1, 1);
        self.imageView.alpha = 1;
        
    } completion:nil];

}

@end
