//
//  AppDelegate.m
//  3DTouch
//
//  Created by Kuan-Wei Lin on 9/16/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "AppDelegate.h"
#import "RunViewController.h"
#import "ScanViewController.h"
#import "SwitchWifiViewController.h"

typedef enum ShortcutIdentifier: NSInteger {
    First,
    Second,
    Third,
} ShortcutIdentifier;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)handleShortCutItem:(UIApplicationShortcutItem *)shortcutItem
{
    NSLog(@"type = %@", shortcutItem.type);
    NSString *str = [[NSBundle mainBundle] bundleIdentifier];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *vc;
    
    if ([shortcutItem.type isEqualToString:[NSString stringWithFormat:@"%@.First", str]])
    {
        NSLog(@"run");
        vc = (RunViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RunVC"];
        
    }
    if ([shortcutItem.type isEqualToString:[NSString stringWithFormat:@"%@.Second", str]])
    {
        NSLog(@"scan");
        vc = (ScanViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ScanVC"];
    }
    
    if ([shortcutItem.type isEqualToString:[NSString stringWithFormat:@"%@Q.Third", str]])
    {
        NSLog(@"wifi");
        vc = (SwitchWifiViewController *)[storyboard instantiateViewControllerWithIdentifier:@"WiFiVC"];
    }
    
    // Display the selected view controller
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    BOOL handledShortCutItem = [self handleShortCutItem:shortcutItem];
    completionHandler(handledShortCutItem);
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
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
