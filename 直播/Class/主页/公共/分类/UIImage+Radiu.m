//
//  UIImage+Radiu.m
//  直播
//
//  Created by duoyi on 16/10/14.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "UIImage+Radiu.h"

@implementation UIImage (Radiu)

- (UIImage *)circleImage
{
    //1.开启图片图形上下文:注意设置透明度为非透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    //2.开启图形上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //3.绘制圆形区域(此处根据宽度来设置)
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.width);
    CGContextAddEllipseInRect(ref, rect);
    //4.裁剪绘图区域
    CGContextClip(ref);
    
    //5.绘制图片
    [self drawInRect:rect];
    
    //6.获取图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //7.关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
