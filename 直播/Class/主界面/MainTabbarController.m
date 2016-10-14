//
//  MainTabbarController.m
//  直播
//
//  Created by duoyi on 16/10/12.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "MainTabbarController.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "MeViewController.h"
#import "LiveViewController.h"
#import "AFNetworking.h"
#import "CustomNavigationController.h"

@interface MainTabbarController ()

@property (nonatomic, strong) AFNetworkReachabilityManager *manager;

@end

@implementation MainTabbarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;
    [self addController];
    [self login];
    [self.manager startMonitoring];
}

#pragma mark - 懒加载
- (AFNetworkReachabilityManager *)manager
{
    if (!_manager)
    {
        _manager = [AFNetworkReachabilityManager sharedManager];
        // 模拟器里面监测不出来
        __block NSString *tip;
        __weak id weakSelf = self;
        __block BOOL isFirstStatus = YES;
        [_manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status)
            {
                case AFNetworkReachabilityStatusUnknown:
                    tip = @"未知网络";
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    tip = @"网络不可达";
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    tip = @"wifi";
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    tip = @"流量";
                    break;
            }
            if(!isFirstStatus)
            {
                [weakSelf networkStatusChange:tip];
            }
            else
            {
                isFirstStatus = NO;
            }
        }];
    }
    return _manager;
}

#pragma mark - Void

- (void)login
{
    // 判断是否登陆成功
    if([self isLogin])
    {
        // 登陆
    }
    else
    {
        // 未登录
        LoginViewController *controller = [[LoginViewController alloc] init];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self presentViewController:controller animated:YES completion:nil];
        });
    }
}

- (void)addController
{
    [self addController:[[MainViewController alloc] init] title:nil imageName:@"toolbar_home" seletedImage:@"toolbar_home_sel"];
    [self addController:[[LiveViewController alloc] init] title:nil imageName:@"toolbar_live" seletedImage:nil];
    [self addController:[[MeViewController alloc] init] title:nil imageName:@"toolbar_me" seletedImage:@"toolbar_me_sel"];
}

- (BOOL)isLogin
{
    NSUserDefaults *login = [NSUserDefaults standardUserDefaults];
    BOOL isLogin = [login objectForKey:@"login"];
    return isLogin;
}

- (void)addController:(UIViewController *) controller title:(NSString *) title imageName:(NSString *)image seletedImage:(NSString *) seletedImage
{
    CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:controller];
    
    controller.tabBarItem.title = title;
    
    controller.tabBarItem.image = [UIImage imageNamed:image];
    
    controller.tabBarItem.selectedImage = [UIImage imageNamed:seletedImage];
    
    controller.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    [self addChildViewController:nav];
}

- (void)networkStatusChange:(NSString *)str
{
    if (str.length)
    {
        NSLog(@"-------------------------------------%@",str);
    }
}

@end
