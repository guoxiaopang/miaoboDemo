//
//  MeHeadView.m
//  直播
//
//  Created by duoyi on 16/10/21.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "MeHeadView.h"
#import "Masonry.h"

@interface MeHeadView()

@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UIImageView *imageView;

//头像
@property (nonatomic, strong) UIImageView *iconView;
//名字
@property (nonatomic, strong) UILabel *nameLabel;

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
         [self addLayout];
    }
    return self;
}

#pragma mark - 懒加载
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
}

@end
