//
//  MeTableViewCell.m
//  直播
//
//  Created by duoyi on 16/10/20.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "MeTableViewCell.h"
#import "Masonry.h"

@interface MeTableViewCell()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation MeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self addSubview:self.iconView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.rightLabel];
        [self addLayout];
    }
    return self;
}

#pragma mark - 懒加载
- (UIImageView *)iconView
{
    if (!_iconView)
    {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] init];
    }
    return _nameLabel;
}

- (UILabel *)rightLabel
{
    if (!_rightLabel)
    {
        _rightLabel = [[UILabel alloc] init];
    }
    return _rightLabel;
}

#pragma mark - Void
- (void)addLayout
{
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(@(10));
    }];
}

@end
