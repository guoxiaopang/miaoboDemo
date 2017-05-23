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
@property (nonatomic, strong) UIButton *startLiveButton;
@property (nonatomic, strong) UIButton *cameraChangeButton;
@property (nonatomic, strong) UIButton *beautifulfaceButton;

@end

@implementation LFLivePreview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.stateLabel];
        [self addSubview:self.closeButton];
        [self addSubview:self.startLiveButton];
        [self addSubview:self.beautifulfaceButton];
        [self addSubview:self.cameraChangeButton];
        [self addLayout];
        self.session.captureDevicePosition = AVCaptureDevicePositionBack;
    }
    return self;
}

#pragma mark - 懒加载

- (UIButton *)beautifulfaceButton
{
    if (!_beautifulfaceButton)
    {
        _beautifulfaceButton = [[UIButton alloc] init];
        [_beautifulfaceButton setImage:[UIImage imageNamed:@"icon_beautifulface_19x19_"] forState:UIControlStateNormal];
        [_beautifulfaceButton sizeToFit];
        [_beautifulfaceButton addTarget:self action:@selector(beautifulface) forControlEvents:UIControlEventTouchUpInside];
    }
    return _beautifulfaceButton;
}

- (UIButton *)cameraChangeButton
{
    if (!_cameraChangeButton)
    {
        _cameraChangeButton = [[UIButton alloc] init];
        [_cameraChangeButton setImage:[UIImage imageNamed:@"camera_change_40x40_"] forState:UIControlStateNormal];
        [_cameraChangeButton sizeToFit];
        [_cameraChangeButton addTarget:self action:@selector(cameraChange) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraChangeButton;
}

- (UIButton *)startLiveButton
{
    if (!_startLiveButton)
    {
        _startLiveButton = [[UIButton alloc] init];
        [_startLiveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_startLiveButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_startLiveButton setTitle:@"开始直播" forState:UIControlStateNormal];
        [_startLiveButton setBackgroundColor:[UIColor colorWithRed:50 green:32 blue:245 alpha:1]];
        [_startLiveButton addTarget:self action:@selector(startLive) forControlEvents:UIControlEventTouchUpInside];
        _startLiveButton.layer.cornerRadius = 5;
    }
    return _startLiveButton;
}

- (LFLiveSession *)session
{
    if (!_session)
    {
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium3 landscape:NO]];
        _session.delegate = self;
        _session.showDebugInfo = YES;
        _session.preView = self;
        _session.running = YES;
        
         /**      发现大家有不会用横屏的请注意啦，横屏需要在ViewController  supportedInterfaceOrientations修改方向  默认竖屏  ****/
        /*两个版本的框架的方法,发现参数稍微有点不一样*/
        
        //    _session = [[LFLiveSession alloc]initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium3] liveType:LFLiveRTMP];
        
        /**    自己定制单声道  */
        /*
         LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
         audioConfiguration.numberOfChannels = 1;
         audioConfiguration.audioBitrate = LFLiveAudioBitRate_64Kbps;
         audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
         _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
         */
        
        /**    自己定制高质量音频96K */
        /*
         LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
         audioConfiguration.numberOfChannels = 2;
         audioConfiguration.audioBitrate = LFLiveAudioBitRate_96Kbps;
         audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
         _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
         */
        
        /**    自己定制高质量音频96K 分辨率设置为540*960 方向竖屏 */
        
        /*
         LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
         audioConfiguration.numberOfChannels = 2;
         audioConfiguration.audioBitrate = LFLiveAudioBitRate_96Kbps;
         audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
         
         LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
         videoConfiguration.videoSize = CGSizeMake(540, 960);
         videoConfiguration.videoBitRate = 800*1024;
         videoConfiguration.videoMaxBitRate = 1000*1024;
         videoConfiguration.videoMinBitRate = 500*1024;
         videoConfiguration.videoFrameRate = 24;
         videoConfiguration.videoMaxKeyframeInterval = 48;
         videoConfiguration.orientation = UIInterfaceOrientationPortrait;
         videoConfiguration.sessionPreset = LFCaptureSessionPreset540x960;
         
         _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration];
         */
        
        
        /**    自己定制高质量音频128K 分辨率设置为720*1280 方向竖屏 */
        
        /*
         LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
         audioConfiguration.numberOfChannels = 2;
         audioConfiguration.audioBitrate = LFLiveAudioBitRate_128Kbps;
         audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
         
         LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
         videoConfiguration.videoSize = CGSizeMake(720, 1280);
         videoConfiguration.videoBitRate = 800*1024;
         videoConfiguration.videoMaxBitRate = 1000*1024;
         videoConfiguration.videoMinBitRate = 500*1024;
         videoConfiguration.videoFrameRate = 15;
         videoConfiguration.videoMaxKeyframeInterval = 30;
         videoConfiguration.orientation = UIInterfaceOrientationPortrait;
         videoConfiguration.sessionPreset = LFCaptureSessionPreset720x1280;
         
         _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration];
         */
        
        
        /**    自己定制高质量音频128K 分辨率设置为720*1280 方向横屏  */
        
        /*
         LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
         audioConfiguration.numberOfChannels = 2;
         audioConfiguration.audioBitrate = LFLiveAudioBitRate_128Kbps;
         audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
         
         LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
         videoConfiguration.videoSize = CGSizeMake(1280, 720);
         videoConfiguration.videoBitRate = 800*1024;
         videoConfiguration.videoMaxBitRate = 1000*1024;
         videoConfiguration.videoMinBitRate = 500*1024;
         videoConfiguration.videoFrameRate = 15;
         videoConfiguration.videoMaxKeyframeInterval = 30;
         videoConfiguration.landscape = YES;
         videoConfiguration.sessionPreset = LFCaptureSessionPreset720x1280;
         
         _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration];
         */

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
- (void)cameraChange
{
    if (self.session.captureDevicePosition == AVCaptureDevicePositionBack)
    {
        self.session.captureDevicePosition = AVCaptureDevicePositionFront;
    }
    else
    {
        self.session.captureDevicePosition = AVCaptureDevicePositionBack;
    }
}

- (void)beautifulface
{
    [self.session setBeautyFace:!self.session.beautyFace];
}

- (void)startLive
{
    if ([self.startLiveButton.titleLabel.text isEqualToString:@"开始直播"])
    {
        LFLiveStreamInfo *stream = [[LFLiveStreamInfo alloc] init];
#warning 修改为你的服务器地址
        stream.url = @"rtmp://localh";
        [self.session startLive:stream];
        [_startLiveButton setTitle:@"结束直播" forState:UIControlStateNormal];
    }
    else
    {
        [_startLiveButton setTitle:@"开始直播" forState:UIControlStateNormal];
        [_session stopLive];
    }
}

- (void)addLayout
{
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(50));
        make.height.equalTo(@(30));
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(20);
    }];
    
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(20);
    }];
    
    [_startLiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.right.equalTo(self).offset(-30);
        make.bottom.equalTo(self).offset(-50);
    }];
    
    [_cameraChangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_closeButton.mas_bottom).offset(15);
        make.right.equalTo(_closeButton);
    }];
    
    [_beautifulfaceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cameraChangeButton.mas_bottom).offset(15);
        make.centerX.equalTo(_cameraChangeButton);
    }];
}

- (void)close
{
    if ([self.delegate respondsToSelector:@selector(LFLivePreviewColse:)])
    {
        [self.delegate LFLivePreviewColse:self];
    }
}

- (void)dealloc
{
    if (_session)
    {
        _session.delegate = nil;
        _session = nil;
    }
    NSLog(@"退出直播间");
}

#pragma mark - LFLiveSessionDelegate
/** live status changed will callback */
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange:(LFLiveState)state
{
    NSLog(@"liveStateDidChange: %ld", (unsigned long)state);
    switch (state)
    {
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
