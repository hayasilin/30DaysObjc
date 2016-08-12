//
//  LogInViewController.h
//  loginAnimation
//
//  Created by Kuan-Wei Lin on 4/11/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *user;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pass;


- (IBAction)loginAction:(id)sender;
- (IBAction)backAction:(id)sender;

@end
