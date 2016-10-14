//
//  HotTableViewCell.m
//  直播
//
//  Created by duoyi on 16/10/14.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "HotTableViewCell.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+RadiuImageView.h"
#import "UILabel+MoreColorText.h"

@interface HotTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *levelImageView;
@property (nonatomic, strong) UILabel *playCount;
@property (nonatomic, strong) UIImageView *gpsImageView;
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UIImageView *picImageView;

@end

@implementation HotTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.playCount];
        [self.contentView addSubview:self.levelImageView];
        [self.contentView addSubview:self.gpsImageView];
        [self.contentView addSubview:self.cityLabel];
        [self.contentView addSubview:self.picImageView];
        
        [self addLayout];
    }
    return self;
}

#pragma mark - 懒加载

- (UIImageView *)picImageView
{
    if (!_picImageView)
    {
        _picImageView = [[UIImageView alloc] init];
    }
    return _picImageView;
}

- (UILabel *)cityLabel
{
    if (!_cityLabel)
    {
        _cityLabel = [[UILabel alloc] init];
        _cityLabel.font = [UIFont systemFontOfSize:11];
    }
    return _cityLabel;
}

- (UIImageView *)gpsImageView
{
    if (!_gpsImageView)
    {
        _gpsImageView = [[UIImageView alloc] init];
        _gpsImageView.image = [UIImage imageNamed:@"home_location_8x8"];
    }
    return _gpsImageView;
}

- (UIImageView *)levelImageView
{
    if (!_levelImageView)
    {
        _levelImageView = [[UIImageView alloc] init];
    }
    return _levelImageView;
}

- (UILabel *)playCount
{
    if (!_playCount)
    {
        _playCount = [[UILabel alloc] init];
        _playCount.font = [UIFont systemFontOfSize:13];
    }
    return _playCount;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:13];
    }
    return _nameLabel;
}

- (UIImageView *)iconView
{
    if (!_iconView)
    {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

#pragma mark - Void
- (void)addLayout
{
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(5);
        make.width.height.equalTo(@(40));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).offset(10);
        make.top.equalTo(_iconView);
       // make.width.equalTo(@(200));
        make.height.equalTo(@(20));
    }];
    
    [_playCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_iconView);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [_levelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(10);
        make.top.equalTo(_nameLabel);
        make.width.equalTo(@(40));
        make.height.equalTo(@(19));
    }];
    
    [_gpsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(8));
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).offset(5);
    }];
    
    [_cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(50));
        make.left.equalTo(_gpsImageView.mas_right).offset(5);
        make.top.equalTo(_gpsImageView);
    }];
    
    [_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView);
        make.height.equalTo(@(400));
        make.top.equalTo(_iconView.mas_bottom).offset(10);
    }];
}

- (void)reloadModel:(ADModel *)model
{
#warning 设置圆角图片这里可以优化
    [self.iconView setCircleImage:model.smallpic];
    self.nameLabel.text = model.myname;
    [self.nameLabel sizeToFit];
    
    if (model.starlevel == 0)
    {
        _levelImageView.image = [UIImage imageNamed:@"flag_new_33x17_"];
    }
    else
    {
        _levelImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"girl_star%ld_40x19", model.starlevel]];
    }

    self.playCount.text = [NSString stringWithFormat:@"13245人在看"];
    [self.playCount sizeToFit];
    [_playCount setAttributeLabelWithtextColorPairs:@[@{@"13245": [UIColor redColor]}]];
    
    self.cityLabel.text = model.gps;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.bigpic] placeholderImage:[UIImage imageNamed:@"flag_new_33x17_"]];
}

@end
