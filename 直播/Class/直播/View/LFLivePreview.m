//
//  LFLivePreview.m
//  直播
//
//  Created by duoyi on 16/10/18.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "LFLivePreview.h"
#import "Masonry.h"
#import <LFLiveKit.h>

@interface LFLivePreview()<LFLiveSessionDelegate>

@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) LFLiveSession *session;

@end

@implementation LFLivePreview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.statusLabel];
        [self addSubview:self.closeButton];
        [self addLayout];
    }
    return self;
}

#pragma mark - 懒加载
- (LFLiveSession *)session
{
    if (!_session)
    {
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium3 landscape:NO]];
        _session.delegate = self;
        _session.showDebugInfo = NO;
        _session.preView = self;
    }
    return _session;
}

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
- (UILabel *)stateLabel
{
    if (!_stateLabel)
    {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.font = [UIFont systemFontOfSize:12];
        _stateLabel.textColor = [UIColor whiteColor];
        _stateLabel.text = @"测试状态";
    }
    return _stateLabel;
}

#pragma mark -Void
- (void)addLayout
{
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(50));
        make.height.equalTo(@(30));
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
    }];
    
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(10);
    }];
}

- (void)close
{

}

#pragma mark - LFLiveSessionDelegate
/** live status changed will callback */
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange:(LFLiveState)state
{
    NSLog(@"liveStateDidChange: %ld", state);
    switch (state) {
        case LFLiveReady:
            _stateLabel.text = @"未连接";
            break;
        case LFLivePending:
            _stateLabel.text = @"连接中";
            break;
        case LFLiveStart:
            _stateLabel.text = @"已连接";
            break;
        case LFLiveError:
            _stateLabel.text = @"连接错误";
            break;
        case LFLiveStop:
            _stateLabel.text = @"未连接";
            break;
        default:
            break;
    }
}
/** live debug info callback */
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug *)debugInfo
{

}
/** callback socket errorcode */
- (void)liveSession:(nullable LFLiveSession *)session errorCode:(LFLiveSocketErrorCode)errorCode
{

}

@end
