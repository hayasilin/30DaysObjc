//
//  NestedViewController.m
//  NestedScrollView
//
//  Created by Kuan-Wei Lin on 8/20/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "NestedViewController.h"
#import "ContainerScrollViewController.h"

@interface NestedViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *backgroundScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *foregroundScrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation NestedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.foregroundScrollView.delegate = self;
    
//    ContainerScrollViewController *containerScrollVC = [[ContainerScrollViewController alloc] initWithNibName:@"ContainerScrollViewController" bundle:nil];
//    
//    
//    
//    [self.containerView addSubview:containerScrollVC.view];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat foregroundHeight = self.foregroundScrollView.contentSize.height - CGRectGetHeight(self.foregroundScrollView.bounds);
    NSLog(@"foregroundHeight = %f", foregroundHeight);
    
    CGFloat percentageScroll = self.foregroundScrollView.contentOffset.y / foregroundHeight;
    NSLog(@"percentageScroll = %f", percentageScroll);
    
    CGFloat backgroundHeight = self.backgroundScrollView.contentSize.height - CGRectGetHeight(self.backgroundScrollView.bounds);
    NSLog(@"backgroundHeight = %f", backgroundHeight);
    
    //範例中沒有要*0.5，但是因為實際做出來時上下的scrollView會一起捲定，為了造成視差效果所以*0.5
    self.backgroundScrollView.contentOffset = CGPointMake(0, backgroundHeight * percentageScroll * 0.5);
}

@end
