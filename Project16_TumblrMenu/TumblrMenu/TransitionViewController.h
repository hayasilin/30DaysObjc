//
//  TransitionViewController.h
//  TumblrMenu
//
//  Created by Kuan-Wei Lin on 9/15/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransitionViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *textButton;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (weak, nonatomic) IBOutlet UILabel *photoLabel;

@property (weak, nonatomic) IBOutlet UIButton *quoteButton;
@property (weak, nonatomic) IBOutlet UILabel *quoteLabel;

@property (weak, nonatomic) IBOutlet UIButton *linkButton;
@property (weak, nonatomic) IBOutlet UILabel *linkLabel;

@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (weak, nonatomic) IBOutlet UILabel *chatLabel;

@property (weak, nonatomic) IBOutlet UIButton *audioButton;
@property (weak, nonatomic) IBOutlet UILabel *audioLabel;


@end
