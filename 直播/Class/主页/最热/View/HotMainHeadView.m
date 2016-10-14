//
//  HotMainHeadView.m
//  直播
//
//  Created by duoyi on 16/10/14.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "HotMainHeadView.h"
#import "SDCycleScrollView.h"

@interface HotMainHeadView ()<SDCycleScrollViewDelegate>

@end

@implementation HotMainHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}



- (void)reloadData:(NSArray *)array
{
    SDCycleScrollView *sycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.frame delegate:self placeholderImage:[UIImage imageNamed:@""]];
    sycleScrollView.imageURLStringsGroup = array;
    sycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    [self addSubview:sycleScrollView];
}

@end
