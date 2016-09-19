//
//  PRPSplashScreenDelegate.h
//  test
//
//  Created by Kuan-Wei Lin on 2/24/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PRPSplashScreen.h"

@protocol PRPSplashScreenDelegate <NSObject>

@optional
- (void)splashScreenDidAppear: (PRPSplashScreen *)splashScreen;
- (void)splashScreenWillDisappear: (PRPSplashScreen *)splashScreen;
- (void)splashScreenDidDisappear: (PRPSplashScreen *)splashScreen;


@end

