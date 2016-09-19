//
//  PRPSplashScreen.m
//  test
//
//  Created by Kuan-Wei Lin on 2/24/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "PRPSplashScreen.h"

@interface PRPSplashScreen ()

@end

@implementation PRPSplashScreen


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:self.splashImage];
    iv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    iv.contentMode = UIViewContentModeCenter;
    self.view = iv;
    
}

- (UIImage *)splashImage{
    if (self.splashImage == nil) {
        self.splashImage = [UIImage imageNamed:@"Default.png"];
    }
    return self.splashImage;
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
