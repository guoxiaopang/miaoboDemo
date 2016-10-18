//
//  LFLivePreview.m
//  直播
//
//  Created by duoyi on 16/10/18.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "LFLivePreview.h"
#import "Masonry.h"

@interface LFLivePreview()

@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation LFLivePreview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.statusLabel];
        
        [self addLayout];
    }
    return self;
}

#pragma mark - 懒加载
- (UIButton *)closeButton
{
    if (!_closeButton)
    {
        _closeButton = [[UIButton alloc] init];
        [_closeButton setImage:[UIImage imageNamed:@"talk_close_40x40_"] forState:UIControlStateNormal];
        [_closeButton sizeToFit];
        [_closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}
- (UILabel *)statusLabel
{
    if (!_statusLabel)
    {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.font = [UIFont systemFontOfSize:12];
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.text = @"测试状态";
    }
    return _statusLabel;
}

#pragma mark -Void
- (void)addLayout
{
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(50));
        make.height.equalTo(@(30));
        make.left.equalTo(self).offset(10);
    }];
}

- (void)close
{

}

@end
