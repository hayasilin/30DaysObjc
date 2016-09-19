//
//  PRPSplashScreen.h
//  test
//
//  Created by Kuan-Wei Lin on 2/24/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRPSplashScreenDelegate.h"

@interface PRPSplashScreen : UIViewController

@property (nonatomic, retain) UIImage *splashImage;
@property (nonatomic, assign) BOOL showsStatusBarOnDismisal;
@property (nonatomic, assign) IBOutlet id <PRPSplashScreenDelegate> delegate;

- (void)hide;

@end
