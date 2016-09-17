//
//  ColorViewController.m
//  UIViewBasicAnimation
//
//  Created by Kuan-Wei Lin on 9/17/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ColorViewController.h"

@interface ColorViewController ()

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        self.backgroundView.backgroundColor = [UIColor blackColor];
        
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.label.textColor = [UIColor colorWithRed:0.959 green:9.937 blue:0.109 alpha:1];
        
    } completion:nil];    
}


@end
