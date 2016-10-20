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
        _rightLabel.textColor = [UIColor redColor];
    }
    return _rightLabel;
}

#pragma mark - Void
- (void)addLayout
{
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self.mas_left).offset(25);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(50);
        make.width.equalTo(@(200));
        make.centerY.equalTo(self);
    }];
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(10);
    }];
}

- (void)reloadModel:(MeModel *)model
{
    _iconView.image = [UIImage imageNamed:model.imageStr];
    [_iconView sizeToFit];
    
    _nameLabel.text = model.name;
    if (model.redName)
    {
        _nameLabel.textColor = [UIColor redColor];
    }
}

@end
