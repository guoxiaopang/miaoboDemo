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
#import "UIDevice+SLExtension.h"
#import "NSObject+HUD.h"
#import <AVFoundation/AVFoundation.h>
#import "LiveViewController.h"

@interface MainTabbarController ()<UITabBarControllerDelegate>

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
    self.delegate = self;
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

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    if ([tabBarController.childViewControllers indexOfObject:viewController] == tabBarController.childViewControllers.count-2) {
        // 判断是否是模拟器
        if ([[UIDevice deviceVersion] isEqualToString:@"iPhone Simulator"]) {
            [self showInfo:@"请用真机进行测试, 此模块不支持模拟器测试"];
            return NO;
        }
        
        // 判断是否有摄像头
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [self showInfo:@"您的设备没有摄像头或者相关的驱动, 不能进行直播"];
            return NO;
        }
        
        // 判断是否有摄像头权限
        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
            [self showInfo:@"app需要访问您的摄像头。\n请启用摄像头-设置/隐私/摄像头"];
            return NO;
        }
        
        // 开启麦克风权限
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    return YES;
                }
                else {
                    [self showInfo:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"];
                    return NO;
                }
            }];
        }
        
        LiveViewController *showTimeVc = [[LiveViewController alloc] init];
        [self presentViewController:showTimeVc animated:YES completion:nil];
        return NO;
    }
    return YES;
}


@end
