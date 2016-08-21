//
//  NewViewController.m
//  AnimatedSplash
//
//  Created by Kuan-Wei Lin on 8/21/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()




@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = [UIImage imageNamed:@"screen"];
    
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
