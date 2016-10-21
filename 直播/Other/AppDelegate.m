//
//  AppDelegate.m
//  直播
//
//  Created by duoyi on 16/10/11.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabbarController.h"
#import "YYFPSLabel.h"

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
    
#if defined(DEBUG)||defined(_DEBUG)
    YYFPSLabel *label = [YYFPSLabel new];
    label.frame = CGRectMake(200, 200, 50, 30);
    [label sizeToFit];
    [self.window addSubview:label];
#endif


    return YES;
}


@end
