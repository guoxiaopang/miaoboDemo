//
//  LoginViewController.m
//  直播
//
//  Created by duoyi on 16/10/12.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "LoginViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "ThreePartyLoginView.h"
#import "Masonry.h"
#import "MBProgressHUD.h"

@interface LoginViewController ()<ThreePartyLoginViewDelegate>

@property (nonatomic, strong) IJKFFMoviePlayerController *player;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) ThreePartyLoginView *threeLogin;
@property (nonatomic, strong) UIButton *quickLogin;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 播放本地视频
    [self.view addSubview:self.imageView];
    [self.imageView addSubview:self.player.view];
    [UIView animateWithDuration:0.25 animations:^{
        self.player.view.alpha = 1;
    }];
    
    [self.player.view addSubview:self.threeLogin];
    [self.player.view addSubview:self.quickLogin];
    [self addLayout];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.player shutdown];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.player.view removeFromSuperview];
    self.player = nil;
}

#pragma mark - 懒加载

- (UIButton *)quickLogin
{
    if (!_quickLogin)
    {
        _quickLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        [_quickLogin setTitle:@"快速登陆" forState:UIControlStateNormal];
        [_quickLogin setTitle:@"快速登陆" forState:UIControlStateHighlighted];
        _quickLogin.layer.borderWidth = 1;
        _quickLogin.layer.cornerRadius = 2;
        _quickLogin.layer.borderColor = [UIColor yellowColor].CGColor;
        [_quickLogin setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [_quickLogin addTarget:self action:@selector(loginSuccess) forControlEvents:UIControlEventTouchUpInside];
    }
    return _quickLogin;
}

- (ThreePartyLoginView *)threeLogin
{
    if (!_threeLogin)
    {
        _threeLogin = [[ThreePartyLoginView alloc] init];
        _threeLogin.delegate = self;
    }
    return _threeLogin;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _imageView.image = [UIImage imageNamed:@"LaunchImage"];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (IJKFFMoviePlayerController *)player
{
    if (!_player)
    {
        NSString *name = arc4random_uniform(10) % 2 ? @"login_video" : @"loginmovie";
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"mp4"];
        NSURL *url = [NSURL fileURLWithPath:path];
        _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
        [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
        _player.shouldAutoplay = YES;
        _player.view.frame = self.view.frame;
        _player.view.alpha = 0;
        _player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [_player prepareToPlay];
        // 添加通知
        [self observer];
    }
    return _player;
}

#pragma mark - Void

- (void)observer
{
    // 监听是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:nil];
    // 播放状态改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];
    // 加载状态改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadingChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];
}

- (void)didFinish
{
    // 播放完成后继续播放
    [self.player play];
}

- (void)stateDidChange
{
    //    IJKMPMoviePlaybackStateStopped,        停止
    //    IJKMPMoviePlaybackStatePlaying,        正在播放
    //    IJKMPMoviePlaybackStatePaused,         暂停
    //    IJKMPMoviePlaybackStateInterrupted,    打断
    //    IJKMPMoviePlaybackStateSeekingForward, 快进
    //    IJKMPMoviePlaybackStateSeekingBackward 快退
    switch (self.player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"停止");
            break;
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"正在播放");
            break;
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"暂停");
            break;
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"打断");
            break;
        case IJKMPMoviePlaybackStateSeekingForward:
            NSLog(@"快进");
            break;
        case IJKMPMoviePlaybackStateSeekingBackward:
            NSLog(@"快退");
            break;
        default:
            break;
    }
}

- (void)loadingChange
{
    NSLog(@"加载状态改变");
}

- (void)addLayout
{
    [_threeLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(60));
        make.bottom.equalTo(self.view).offset(-100);
    }];
    
    [_quickLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.player.view).offset(20);
        make.right.equalTo(self.player.view).offset(-20);
        make.top.equalTo(_threeLogin.mas_bottom).offset(20);
        make.height.equalTo(@(44));
    }];
}

#pragma mark - ThreePartyLoginViewDelegate
- (void)threePartyLoginView:(ThreePartyLoginView *)view click:(NSInteger)index
{
    [self loginSuccess];
}

- (void)loginSuccess
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.player.view animated:YES];
    hud.label.text = @"登陆成功";
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
    
    NSUserDefaults *login = [NSUserDefaults standardUserDefaults];
    [login setValue:@(YES) forKey:@"login"];

}

@end
