//
//  ThreePartyLoginView.m
//  直播
//
//  Created by duoyi on 16/10/12.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "ThreePartyLoginView.h"
#import "Masonry.h"

@interface ThreePartyLoginView ()

@property (nonatomic, strong) UIImageView *qqImageView;
@property (nonatomic, strong) UIImageView *sinaImageView;
@property (nonatomic, strong) UIImageView *wexinImageView;

@end

@implementation ThreePartyLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.qqImageView];
        [self addSubview:self.sinaImageView];
        [self addSubview:self.wexinImageView];
        [self addLayout];
    }
    return self;
}

#pragma mark - 懒加载
- (UIImageView *)qqImageView
{
    if (!_qqImageView)
    {
        _qqImageView = [[UIImageView alloc] init];
        _qqImageView.image = [UIImage imageNamed:@"qqloginicon_60x60"];
        _qqImageView.tag = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [_qqImageView addGestureRecognizer:tap];
        _qqImageView.userInteractionEnabled = YES;
        [_qqImageView sizeToFit];
    }
    return _qqImageView;
}

- (UIImageView *)sinaImageView
{
    if (!_sinaImageView)
    {
        _sinaImageView = [[UIImageView alloc] init];
        _sinaImageView.image = [UIImage imageNamed:@"wbLoginicon_60x60"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [_sinaImageView addGestureRecognizer:tap];
        _sinaImageView.tag = 1;
        _sinaImageView.userInteractionEnabled = YES;
        [_sinaImageView sizeToFit];
    }
    return _sinaImageView;
}

- (UIImageView *)wexinImageView
{
    if (!_wexinImageView)
    {
        _wexinImageView = [[UIImageView alloc] init];
        _wexinImageView.image = [UIImage imageNamed:@"wxloginicon_60x60"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [_sinaImageView addGestureRecognizer:tap];
        _wexinImageView.tag = 2;
        [_wexinImageView sizeToFit];
        _sinaImageView.userInteractionEnabled = YES;
    }
    return _wexinImageView;
}

#pragma mark - Void
- (void)addLayout
{
    [self.sinaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.qqImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_sinaImageView.mas_left).offset(-20);
        make.centerY.equalTo(self);
    }];
    
    [self.wexinImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sinaImageView.mas_right).offset(20);
        make.centerY.equalTo(self);
    }];
}

- (void)click:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(threePartyLoginView:click:)])
    {
        [self.delegate threePartyLoginView:self click:tap.view.tag];
    }
}

@end
