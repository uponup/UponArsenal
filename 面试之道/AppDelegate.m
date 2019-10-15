//
//  AppDelegate.m
//  面试之道
//
//  Created by 龙格 on 2019/1/3.
//  Copyright © 2019年 Paul Gao. All rights reserved.
//

#import "AppDelegate.h"
#import "AnimationController.h"
#import "JPWebController.h"
#import "WkWebViewController.h"
#import "CustomWebController.h"
#import "ThreadController.h"
#import "RunLoopController.h"
#import "NativeNotificationController.h"
#import "DesignModeController.h"
#import "LibController.h"
#import "CellReuseController.h"
#import "PrivatePodsController.h"
#import "RuntimeController.h"

#import <UserNotifications/UserNotifications.h>


@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
//    AnimationController *vc = [AnimationController new];
//    JPWebController *vc = [JPWebController new];
//    WkWebViewController *vc = [WkWebViewController new];
//    CustomWebController *vc = [CustomWebController new];
//    ThreadController *vc = [ThreadController new];
//    RunLoopController *vc = [RunLoopController new];
//    NativeNotificationController *vc = [NativeNotificationController new];
//    LibController *vc = [LibController new];
//    CellReuseController *vc = [CellReuseController new];
//    DesignModeController *vc = [DesignModeController new];
    RuntimeController *vc = [RuntimeController new];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    

#ifdef __IPHONE_10_0
    //iOS > 10
#else
    //iOS < 10
    NSDictionary *localDic = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    NSDictionary *remoteDic = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    NSLog(@"app已经完全退出");
    NSLog(@"remote: %@", remoteDic);
    NSLog(@"local: %@", localDic);
#endif
    
    return YES;
}
//iOS > 10
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSLog(@"willPresent：%@", notification);
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    NSLog(@"didReceive：%@", response);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
