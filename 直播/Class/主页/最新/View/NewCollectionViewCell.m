//
//  NewCollectionViewCell.m
//  直播
//
//  Created by duoyi on 16/10/19.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "NewCollectionViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface NewCollectionViewCell()

@property (nonatomic, strong) UIImageView *gpsImageView;
@property (nonatomic, strong) UILabel *gpsLabel;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *newimageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation NewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.backgroundImageView];
        [self.backgroundImageView addSubview:self.gpsImageView];
        [self.backgroundImageView addSubview:self.gpsLabel];
        [self.backgroundImageView addSubview:self.newimageView];
        [self.backgroundImageView addSubview:self.nameLabel];
        [self addLayout];
    }
    return self;
}

#pragma mark - Void
- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:13];
    }
    return _nameLabel;
}

- (UIImageView *)newimageView
{
    if (!_newimageView)
    {
        _newimageView = [[UIImageView alloc] init];
        _newimageView.image = [UIImage imageNamed:@"flag_new_33x17_"];
    }
    return _newimageView;
}

- (UILabel *)gpsLabel
{
    if (!_gpsLabel)
    {
        _gpsLabel = [[UILabel alloc] init];
        _gpsLabel.font = [UIFont systemFontOfSize:11];
        _gpsLabel.textColor = [UIColor whiteColor];
    }
    return _gpsLabel;
}

- (void)addLayout
{
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.top.equalTo(self);
    }];
    
    [_gpsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(10);
        make.width.height.equalTo(@(8));
    }];
    
    [_gpsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_gpsImageView.mas_right).offset(6);
        make.centerY.equalTo(_gpsImageView);
        make.right.equalTo(self).offset(-10);
    }];
    
    [_newimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(33));
        make.height.equalTo(@(17));
        make.centerY.equalTo(_gpsLabel);
        make.right.equalTo(self).offset(-10);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(self);
        make.bottom.equalTo(self).offset(-5);
    }];
}

- (void)reloadWithModel:(LiveUser *)model
{
    NSString *str = model.photo;
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
    
    self.gpsLabel.text = model.position;
    self.nameLabel.text = model.nickname;
}

#pragma mark - 懒加载
- (UIImageView *)gpsImageView
{
    if (!_gpsImageView)
    {
        _gpsImageView = [[UIImageView alloc] init];
        _gpsImageView.image = [UIImage imageNamed:@"location_white_8x9_"];
    }
    return _gpsImageView;
}
- (UIView *)backgroundImageView
{
    if (!_backgroundImageView)
    {
        _backgroundImageView = [[UIImageView alloc] init];
    }
    return _backgroundImageView;
}

@end
