//
//  MeHeadView.m
//  直播
//
//  Created by duoyi on 16/10/21.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "MeHeadView.h"
#import "Masonry.h"
#import "FollowView.h"

@interface MeHeadView()

@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UIImageView *imageView;

//头像
@property (nonatomic, strong) UIImageView *iconView;
//名字
@property (nonatomic, strong) UILabel *nameLabel;
//男孩图片
@property (nonatomic, strong) UIImageView *boyImageView;
@property (nonatomic, strong) UIImageView *levelImageView;

//进度条
@property (nonatomic, strong) UIView *progressView;
//IDX
@property (nonatomic, strong) UILabel *idLabel;

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) FollowView *followView;

@end

@implementation MeHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        [self addSubview:self.imageView];
       
        [self.imageView addSubview:self.effectView];
        [self.effectView addSubview:self.iconView];
        [self.effectView addSubview:self.nameLabel];
        [self.effectView addSubview:self.boyImageView];
        [self.effectView addSubview:self.levelImageView];
        [self.effectView addSubview:self.progressView];
        [self.effectView addSubview:self.idLabel];
        [self.effectView addSubview:self.contentLabel];
        [self.effectView addSubview:self.followView];
        [self addLayout];
    }
    return self;
}

#pragma mark - 懒加载
- (FollowView *)followView
{
    if (!_followView)
    {
        _followView = [[FollowView alloc] init];
    }
    return _followView;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"这个家伙很懒，什么都没写";
        _contentLabel.textColor = [UIColor whiteColor];
    }
    return _contentLabel;
}

- (UILabel *)idLabel
{
    if (!_idLabel)
    {
        _idLabel = [[UILabel alloc] init];
        _idLabel.text = @"IDX : 64279388";
        _idLabel.textColor = [UIColor whiteColor];
    }
    return _idLabel;
}
- (UIView *)progressView
{
    if (!_progressView)
    {
        _progressView = [[UIView alloc] init];
        _progressView.backgroundColor = [UIColor darkGrayColor];
        _progressView.layer.cornerRadius = 5;
        _progressView.clipsToBounds = YES;
    }
    return _progressView;
}

- (UIImageView *)levelImageView
{
    if (!_levelImageView)
    {
        _levelImageView = [[UIImageView alloc] init];
        _levelImageView.image = [UIImage imageNamed:@"girl_star5"];
        [_levelImageView sizeToFit];
    }
    return _levelImageView;
}

- (UIImageView *)boyImageView
{
    if (!_boyImageView)
    {
        _boyImageView = [[UIImageView alloc] init];
        _boyImageView.image = [UIImage imageNamed:@"search_boy"];
        [_boyImageView sizeToFit];
    }
    return _boyImageView;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"Leo宇";
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UIImageView *)iconView
{
    if (!_iconView)
    {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"kitty"];
        _iconView.layer.cornerRadius = 40;
        _iconView.clipsToBounds = YES;
    }
    return _iconView;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    }
    return _imageView;
}

- (UIVisualEffectView *)effectView
{
    if (!_effectView)
    {
        UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView= [[UIVisualEffectView alloc] initWithEffect:effect];
        
    }
    return _effectView;
}

- (void)addLayout
{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    
    [_effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(80));
        make.left.equalTo(self).offset(30);
        make.top.equalTo(self).offset(60);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).offset(20);
        make.top.equalTo(_iconView);
    }];
    
    [_boyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel);
        make.left.equalTo(_nameLabel.mas_right).offset(10);
    }];
    
    [_levelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_boyImageView);
        make.left.equalTo(_boyImageView.mas_right).offset(10);
    }];
    
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(10));
        make.width.equalTo(@(140));
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.left.equalTo(_nameLabel);
    }];
    
    [_idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_progressView.mas_bottom).offset(10);
        make.width.equalTo(@(140));
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_idLabel.mas_bottom).offset(10);
        make.right.equalTo(self);
    }];
    
    [_followView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(100));
    }];
}

@end
