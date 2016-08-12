//
//  HomeViewController.m
//  loginAnimation
//
//  Created by Kuan-Wei Lin on 4/11/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "HomeViewController.h"
#import "LogInViewController.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.signUpButton.layer.cornerRadius = 5;
    self.logInButton.layer.cornerRadius = 5;
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    [self.signUpButton addTarget:self action:@selector(goNext:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)goNext: (id)sender{
    LogInViewController *loginViewController = [[LogInViewController alloc] init];
    [self presentViewController:loginViewController animated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
