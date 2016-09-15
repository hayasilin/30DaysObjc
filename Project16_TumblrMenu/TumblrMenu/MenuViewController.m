//
//  MenuViewController.m
//  TumblrMenu
//
//  Created by Kuan-Wei Lin on 9/15/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTransitionManager.h"

@interface MenuViewController ()

@property (strong, nonatomic)MenuTransitionManager *transitionManager;

@end

@implementation MenuViewController

- (void)awakeFromNib{
    self.transitionManager = [[MenuTransitionManager alloc] init];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.transitioningDelegate = self.transitionManager;
}

- (IBAction)unwindSegue:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
