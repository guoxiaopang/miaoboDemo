//
//  LiveViewController.m
//  直播
//
//  Created by duoyi on 16/10/12.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "LiveViewController.h"
#import "LFLivePreview.h"

@interface LiveViewController ()<LFLivePreviewDelegate>

@property (nonatomic, strong) LFLivePreview *livePreview;

@end

@implementation LiveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:self.livePreview atIndex:0];
}

#pragma mark - 懒加载
- (LFLivePreview *)livePreview
{
    if (!_livePreview)
    {
        _livePreview = [[LFLivePreview alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _livePreview.delegate = self;
    }
    return _livePreview;
}

#pragma mark - LFLivePreviewDelegate
- (void)LFLivePreviewColse:(LFLivePreview *)view
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
