//
//  AppDelegate.m
//  直播
//
//  Created by duoyi on 16/10/11.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabbarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    BOOL _first;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    MainTabbarController *controller = [[MainTabbarController alloc] init];
    self.window.rootViewController = controller;

    return YES;
}



//- (void)applicationWillResignActive:(UIApplication *)application
//{
//    // 应用挂起 当有电话或者锁屏的时候会执行这个方法
//    NSLog(@"------------------------------- 挂起");
//}
//
//
//- (void)applicationDidEnterBackground:(UIApplication *)application
//{
//    // 应用将要进入后台
//    NSLog(@"------------------------------- 进入后台");
//}
//
//
//- (void)applicationWillEnterForeground:(UIApplication *)application
//{
//    // 应用将要进入前台
//    NSLog(@"------------------------------- 进入前台");
//}
//
//
//- (void)applicationDidBecomeActive:(UIApplication *)application
//{
//    // 应用将要复原
//    NSLog(@"------------------------------- 复原");
//}
//
//
//- (void)applicationWillTerminate:(UIApplication *)application
//{
//    // 应用程序终止
//    NSLog(@"-------------------------------- 终止");
//}


@end
