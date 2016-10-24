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
        [self addLayout];
    }
    return self;
}

#pragma mark - 懒加载
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
    
}

@end
