//
//  MainViewController.m
//  TumblrMenu
//
//  Created by Kuan-Wei Lin on 9/15/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation MainViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
}

- (CGAffineTransform)offstage:(CGFloat)amount
{
    return CGAffineTransformMakeTranslation(amount, 0);
}

@end
