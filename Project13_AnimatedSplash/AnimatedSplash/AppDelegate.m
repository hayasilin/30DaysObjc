//
//  AppDelegate.m
//  AnimatedSplash
//
//  Created by Kuan-Wei Lin on 8/21/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "AppDelegate.h"
#import "NewViewController.h"

@interface AppDelegate ()

@property (nonatomic) CALayer *mask;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NewViewController *viewController = [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
    self.window.rootViewController = viewController;
    
//    UIImageView *kImageView = [[UIImageView alloc] initWithFrame:self.window.frame];
//    kImageView.image = [UIImage imageNamed:@"screen"];
//    [viewController.view addSubview:kImageView];
    
    self.mask = [[CALayer alloc] init];
    self.mask.contents = [UIImage imageNamed:@"twitter"];
    self.mask.contentsGravity = kCAGravityResizeAspect;
    self.mask.bounds = CGRectMake(0, 0, 100, 81);
    self.mask.anchorPoint = CGPointMake(0.5, 0.5);
    self.mask.position = CGPointMake(viewController.imageView.frame.size.width / 2, viewController.imageView.frame.size.height / 2);
    viewController.imageView.layer.mask = self.mask;
    self.imageView = viewController.imageView;
    
    [self animateMask];
    
    self.window.backgroundColor = [UIColor colorWithRed:0.117 green:0.631 blue:0.949 alpha:1];
    
    [self.window makeKeyAndVisible];
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    return YES;
}

- (void)animateMask{
    
    CAKeyframeAnimation *keyFrameAnimateion = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    keyFrameAnimateion.delegate = self;
    keyFrameAnimateion.duration = 0.6;
    keyFrameAnimateion.beginTime = CACurrentMediaTime() + 0.5;
    keyFrameAnimateion.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    NSValue *initalBounds = [NSValue valueWithCGRect:self.mask.bounds];
    NSValue *secondBounds = [NSValue valueWithCGRect:CGRectMake(0, 0, 90, 73)];
    NSValue *finalBounds = [NSValue valueWithCGRect:CGRectMake(0, 0, 1600, 1300)];
    keyFrameAnimateion.values = @[initalBounds, secondBounds, finalBounds];
    keyFrameAnimateion.keyTimes = @[@0, @0.3, @1];
    [self.mask addAnimation:keyFrameAnimateion forKey:@"bounds"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.imageView.layer.mask = nil;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
