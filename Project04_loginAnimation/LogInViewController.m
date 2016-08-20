//
//  LogInViewController.m
//  loginAnimation
//
//  Created by Kuan-Wei Lin on 4/11/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.usernameTextfield.layer.cornerRadius = 5;
    self.passwordTextfield.layer.cornerRadius = 5;
    self.loginButton.layer.cornerRadius = 5;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.5 delay:0.00 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGFloat marginX = -(self.view.bounds.size.width);
        NSLog(@"marginX = %f", marginX);
        
        [self.view layoutIfNeeded];
        
        /*self.centerAlignUsername.constant += self.view.bounds.width
         print("\(self.centerAlignUsername.constant)");
         self.view.layoutIfNeeded()*/
        
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.5 delay:0.10 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGFloat marginX = self.passwordTextfield.frame.origin.x;
        marginX = -(self.view.bounds.size.width);
        
        [self.view layoutIfNeeded];
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.20 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.loginButton.alpha = 1;
    } completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {
    
    CGRect bounds = self.loginButton.bounds;
    
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.loginButton.bounds = CGRectMake(bounds.origin.x - 20, bounds.origin.y, bounds.size.width + 60, bounds.size.height);
        self.loginButton.enabled = NO;
        
    } completion:nil];
    
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
