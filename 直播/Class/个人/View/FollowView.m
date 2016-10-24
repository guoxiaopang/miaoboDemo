//
//  FollowView.m
//  直播
//
//  Created by duoyi on 16/10/21.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "FollowView.h"
#import "Masonry.h"

@interface FollowView()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *line2View;
@property (nonatomic, strong) UIView *line3View;
@property (nonatomic, strong) UILabel *followNumLabel;
@property (nonatomic, strong) UILabel *fansNumLabel;
@property (nonatomic, strong) UILabel *liveNumLabel;
@property (nonatomic, strong) UILabel *followLabel;
@property (nonatomic, strong) UILabel *fansLabel;
@property (nonatomic, strong) UILabel *liveLabel;

@end

@implementation FollowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.lineView];
        [self addSubview:self.line2View];
        [self addSubview:self.line3View];
        [self addSubview:self.followNumLabel];
        [self addSubview:self.fansNumLabel];
        [self addSubview:self.liveNumLabel];
        [self addSubview:self.followLabel];
        [self addSubview:self.fansLabel];
        [self addSubview:self.liveLabel];
        [self addLayout];
    }
    return self;
}

#pragma mark - 懒加载
- (UILabel *)liveLabel
{
    if (!_liveLabel)
    {
        _liveLabel = [[UILabel alloc] init];
        _liveLabel.text = @"直播时长(小时)";
        _liveLabel.textAlignment = NSTextAlignmentCenter;
        _liveLabel.textColor = [UIColor whiteColor];
    }
    return _liveLabel;
}

- (UILabel *)fansLabel
{
    if (!_fansLabel)
    {
        _fansLabel = [[UILabel alloc] init];
        _fansLabel.text = @"粉丝";
        _fansLabel.textAlignment = NSTextAlignmentCenter;
        _fansLabel.textColor = [UIColor whiteColor];
    }
    return _fansLabel;
}

- (UILabel *)followLabel
{
    if (!_followLabel)
    {
        _followLabel = [[UILabel alloc] init];
        _followLabel.text = @"关注";
        _followLabel.textAlignment = NSTextAlignmentCenter;
        _followLabel.textColor = [UIColor whiteColor];
    }
    return _followLabel;
}

- (UILabel *)liveNumLabel
{
    if (!_liveNumLabel)
    {
        _liveNumLabel = [[UILabel alloc] init];
        _liveNumLabel.text = @"233.5";
        _liveNumLabel.textAlignment = NSTextAlignmentCenter;
        _liveNumLabel.textColor = [UIColor whiteColor];
    }
    return _liveNumLabel;
}

- (UILabel *)fansNumLabel
{
    if (!_fansNumLabel)
    {
        _fansNumLabel = [[UILabel alloc] init];
        _fansNumLabel.text = @"6823";
        _fansNumLabel.textAlignment = NSTextAlignmentCenter;
        _fansNumLabel.textColor = [UIColor whiteColor];
    }
    return _fansNumLabel;
}

- (UILabel *)followNumLabel
{
    if (!_followNumLabel)
    {
        _followNumLabel = [[UILabel alloc] init];
        _followNumLabel.text = @"1.3W";
        _followNumLabel.textAlignment = NSTextAlignmentCenter;
        _followNumLabel.textColor = [UIColor whiteColor];
    }
    return _followNumLabel;
}

- (UIView *)line2View
{
    if (!_line2View)
    {
        _line2View = [[UIView alloc] init];
        _line2View.backgroundColor = [UIColor whiteColor];
        _line2View.alpha = 0.5;
    }
    return _line2View;
}

- (UIView *)line3View
{
    if (!_line3View)
    {
        _line3View = [[UIView alloc] init];
        _line3View.backgroundColor = [UIColor whiteColor];
        _line3View.alpha = 0.5;
    }
    return _line3View;
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc] init];
        _lineView.alpha = 0.5;
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    return _lineView;
}

#pragma mark -Void
- (void)addLayout
{
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.height.equalTo(@(0.5));
        make.top.equalTo(self);
    }];
    
    [_line2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(0.5));
        make.top.equalTo(self).offset(20);
        make.bottom.equalTo(self).offset(-20);
        make.centerX.equalTo(self).multipliedBy(2.0 / 3);
    }];
    
    [_line3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(0.5));
        make.top.equalTo(self).offset(20);
        make.bottom.equalTo(self).offset(-20);
        make.centerX.equalTo(self).multipliedBy(4.0 / 3);
    }];
    
    [_followNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(1.0 / 3);
        make.top.equalTo(self).offset(30);
        make.left.equalTo(self);
    }];
    
    [_fansNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(1.0 / 3);
        make.top.equalTo(self).offset(30);
        make.left.equalTo(_followNumLabel.mas_right);
    }];
    
    
    [_liveNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(1.0 / 3);
        make.top.equalTo(self).offset(30);
        make.left.equalTo(_fansNumLabel.mas_right);
    }];
    
    [_followLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(1.0 / 3);
        make.top.equalTo(_followNumLabel.mas_bottom).offset(5);
        make.left.equalTo(self);
    }];
    
    [_fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(1.0 / 3);
        make.top.equalTo(_fansNumLabel.mas_bottom).offset(5);
        make.left.equalTo(_followLabel.mas_right);
    }];
    
    [_liveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(1.0 / 3);
        make.top.equalTo(_liveNumLabel.mas_bottom).offset(5);
        make.left.equalTo(_fansLabel.mas_right);
    }];
}

@end
