//
//  ViewController.m
//  SnapChatMenu
//
//  Created by Kuan-Wei Lin on 8/13/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"
#import "LeftView.h"
#import "RightView.h"
#import "CameraView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    LeftView *leftView = [[LeftView alloc] initWithNibName:@"LeftView" bundle:nil];
    CameraView *centerView = [[CameraView alloc] initWithNibName:@"CameraView" bundle:nil];
    RightView *rightView = [[RightView alloc] initWithNibName:@"RightView" bundle:nil];
    
    [self addChildViewController:leftView];
    [self.scrollView addSubview:leftView.view];
    [leftView didMoveToParentViewController:self];
    
    [self addChildViewController:rightView];
    [self.scrollView addSubview:rightView.view];
    [rightView didMoveToParentViewController:self];
    
    [self addChildViewController:centerView];
    [self.scrollView addSubview:centerView.view];
    [centerView didMoveToParentViewController:self];
    
    CGRect centerViewFrame = centerView.view.frame;
    centerViewFrame.origin.x = self.view.frame.size.width;
    centerView.view.frame = centerViewFrame;
    
    CGRect rightViewFrame = rightView.view.frame;
    rightViewFrame.origin.x = 2 * self.view.frame.size.width;
    rightView.view.frame = rightViewFrame;
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 3, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
