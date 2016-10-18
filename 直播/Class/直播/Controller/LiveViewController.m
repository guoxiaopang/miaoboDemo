//
//  LiveViewController.m
//  直播
//
//  Created by duoyi on 16/10/12.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "LiveViewController.h"
#import "LFLivePreview.h"

@interface LiveViewController ()

@property (nonatomic, strong) LFLivePreview *livePreview;

@end

@implementation LiveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.livePreview];
}

#pragma mark - 懒加载
- (LFLivePreview *)livePreview
{
    if (!_livePreview)
    {
        _livePreview = [[LFLivePreview alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _livePreview;
}



@end
