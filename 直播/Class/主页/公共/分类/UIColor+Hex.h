//
//  UIColor+Hex.h
//  直播
//
//  Created by duoyi on 16/10/13.
//  Copyright © 2016年 bt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHex:(NSInteger)color;
+ (UIColor *)colorWithHex:(NSInteger)color alpha:(CGFloat)alpha;

@end
