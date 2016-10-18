//
//  NSObject+HUD.m
//  直播
//
//  Created by duoyi on 16/10/18.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "NSObject+HUD.h"
#import <UIKit/UIKit.h>

@implementation NSObject (HUD)

- (void)showInfo:(NSString *)info
{
    if ([self isKindOfClass:[UIViewController class]] || [self isKindOfClass:[UIView class]]) {
        [[[UIAlertView alloc] initWithTitle:@"喵播" message:info delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
}

@end
