//
//  AppDelegate.m
//  playLocalVideo
//
//  Created by Kuan-Wei Lin on 4/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "AppDelegate.h"
#import "VideoListTableViewController.h"

@interface AppDelegate ()

@property (strong, nonatomic) UINavigationController *navi;
@property (strong, nonatomic) VideoListTableViewController *videoVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    self.navi = [[UINavigationController alloc] init];
    [self.window addSubview:[self.navi view]];
    
    if (!self.videoVC) {
        VideoListTableViewController *videoViewController = [[VideoListTableViewController alloc] initWithNibName:@"VideoListTableViewController" bundle:nil];
        self.videoVC = videoViewController;
    }
    
    [self.navi pushViewController:self.videoVC animated:YES];
    self.window.rootViewController = self.navi;
    [self.window makeKeyAndVisible];
    
    //self.navi.navigationBar.backgroundColor = [UIColor blackColor];
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTranslucent:YES];
    //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1.0], NSForegroundColorAttributeName, [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    
    //將status bar顏色改為亮色
    [self.navi.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    return YES;
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
