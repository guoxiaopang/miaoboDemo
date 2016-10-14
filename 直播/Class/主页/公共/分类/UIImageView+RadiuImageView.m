//
//  UIImageView+RadiuImageView.m
//  直播
//
//  Created by duoyi on 16/10/14.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "UIImageView+RadiuImageView.h"
#import "UIImage+Radiu.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (RadiuImageView)

- (void)setCircleImage:(NSString *)imageUrl withPlaceholderImage:(NSString *)placeholderImageName
{
    NSString *cacheURL = [imageUrl stringByAppendingString:@"cache"];
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheURL];
    if (cacheImage)
    {
        self.image = cacheImage;
        return;
    }
    UIImage * placeholderImage = [UIImage imageNamed:placeholderImageName];
    [self sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        UIImage *tmp = image ? [image circleImage]:[placeholderImage circleImage];
        // 缓存圆角图片
        [[SDImageCache sharedImageCache] storeImage:tmp forKey:cacheURL];
        // 删除原来的图片
        [[SDImageCache sharedImageCache] removeImageForKey:imageUrl];
        self.image = tmp;
    }];
}
- (void)setCircleImage:(NSString *)imageUrl
{
    [self setCircleImage:imageUrl withPlaceholderImage:nil];
}


@end
