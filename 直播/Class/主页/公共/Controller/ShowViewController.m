//
//  ShowViewController.m
//  直播
//
//  Created by duoyi on 16/10/17.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "ShowViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "BottomView.h"
#import "Masonry.h"

@interface ShowViewController ()<BottomViewDelegate>

@property (nonatomic, strong) IJKFFMoviePlayerController *player;
@property (nonatomic, strong) BottomView *bottomView;

@end

@implementation ShowViewController
{
    NSString *_url;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.player shutdown];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.player.view removeFromSuperview];
    self.player = nil;
}

#pragma mark - 懒加载

- (BottomView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[BottomView alloc] init];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

- (IJKFFMoviePlayerController *)player
{
    if (!_player)
    {
        IJKFFOptions *options = [IJKFFOptions optionsByDefault];
        _player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:_url withOptions:options];
        _player.view.frame = [UIScreen mainScreen].bounds;
        _player.scalingMode = IJKMPMovieScalingModeAspectFill;
        [_player prepareToPlay];
    }
    return _player;
}
#pragma mark - Void

- (void)reloadModel:(ADModel *)model
{
    _url = model.flv;
    [self.view addSubview:self.player.view];
    [self.player.view addSubview:self.bottomView];
     [self addLayout];
    
    // 开始来访动画
    [self.emitterLayer setHidden:NO];
}

- (void)addLayout
{
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-10);
        make.height.equalTo(@(40));
    }];
}

#pragma mark - BottomViewDelegate
- (void)bottomViewClick:(BottomView *)view
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
