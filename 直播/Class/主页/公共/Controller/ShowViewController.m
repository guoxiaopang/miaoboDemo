//
//  ShowViewController.m
//  直播
//
//  Created by duoyi on 16/10/17.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "ShowViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface ShowViewController ()

@property (nonatomic, strong) IJKFFMoviePlayerController *player;

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
}

@end
