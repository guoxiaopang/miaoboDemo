//
//  UIImageView+RadiuImageView.h
//  直播
//
//  Created by duoyi on 16/10/14.
//  Copyright © 2016年 bt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (RadiuImageView)

- (void)setCircleImage:(NSString *)imageUrl withPlaceholderImage:(NSString *)placeholderImageName;
- (void)setCircleImage:(NSString *)imageUrl;

@end
