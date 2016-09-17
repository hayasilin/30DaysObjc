//
//  OpacityViewController.m
//  UIViewBasicAnimation
//
//  Created by Kuan-Wei Lin on 9/17/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "OpacityViewController.h"

@interface OpacityViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation OpacityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIView animateWithDuration:2 animations:^{
        self.imageView.alpha = 0;
    }];
}



@end
