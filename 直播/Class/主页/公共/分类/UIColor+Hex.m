//
//  UIColor+Hex.m
//  直播
//
//  Created by duoyi on 16/10/13.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "UIColor+Hex.h"
#import <Foundation/Foundation.h>

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(NSInteger)color
{
    return [self colorWithHex:color alpha:1];
}

+ (UIColor *)colorWithHex:(NSInteger)color alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((color & 0XFF0000)>>16)/255.0 green:((color & 0X00FF00) >>8)/255.0 blue:(color & 0X0000FF)/255.0 alpha:alpha];
}

@end
