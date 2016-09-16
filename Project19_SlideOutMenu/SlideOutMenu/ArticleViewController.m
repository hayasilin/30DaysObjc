//
//  ArticleViewController.m
//  SlideOutMenu
//
//  Created by Kuan-Wei Lin on 9/16/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ArticleViewController.h"

@interface ArticleViewController ()

@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Create gestureRecognizer
    UISwipeGestureRecognizer * swiperight= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swiperight];
    
    //Set the presenting animation style
    self.modalTransitionStyle   = UIModalTransitionStyleFlipHorizontal;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
