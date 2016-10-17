//
//  BottomView.m
//  直播
//
//  Created by duoyi on 16/10/17.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "BottomView.h"

@interface BottomView()

@property (nonatomic, strong) UIImageView *chat1ImageView;
@property (nonatomic, strong) UIImageView *chat2ImageView;
@property (nonatomic, strong) UIImageView *giftImageView;
@property (nonatomic, strong) UIImageView *cupImageView;
@property (nonatomic, strong) UIImageView *shareImageView;
@property (nonatomic, strong) UIImageView *closeImageView;
@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation BottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.chat1ImageView];
        [self addSubview:self.chat2ImageView];
        [self addSubview:self.giftImageView];
        [self addSubview:self.cupImageView];
        [self addSubview:self.shareImageView];
        [self addSubview:self.closeImageView];
        [self.array addObjectsFromArray:@[_chat1ImageView, _chat2ImageView, _giftImageView, _cupImageView, _shareImageView, _closeImageView]];
        [self addFrame];
    }
    return self;
}

#pragma mark - 懒加载
- (NSMutableArray *)array
{
    if (!_array)
    {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (UIImageView *)chat1ImageView
{
    if (!_chat1ImageView)
    {
        _chat1ImageView = [[UIImageView alloc] init];
        _chat1ImageView.image = [UIImage imageNamed:@"talk_public_40x40_"];
    }
    return _chat1ImageView;
}

- (UIImageView *)chat2ImageView
{
    if (!_chat2ImageView)
    {
        _chat2ImageView = [[UIImageView alloc] init];
        _chat2ImageView.image = [UIImage imageNamed:@"talk_private_40x40_"];
    }
    return _chat2ImageView;
}


- (UIImageView *)giftImageView
{
    if (!_giftImageView)
    {
        _giftImageView = [[UIImageView alloc] init];
        _giftImageView.image = [UIImage imageNamed:@"talk_sendgift_40x40_"];
    }
    return _giftImageView;
}


- (UIImageView *)cupImageView
{
    if (!_cupImageView)
    {
        _cupImageView = [[UIImageView alloc] init];
        _cupImageView.image = [UIImage imageNamed:@"talk_rank_40x40_"];
    }
    return _cupImageView;
}

- (UIImageView *)shareImageView
{
    if (!_shareImageView)
    {
        _shareImageView = [[UIImageView alloc] init];
        _shareImageView.image = [UIImage imageNamed:@"talk_share_40x40_"];
    }
    return _shareImageView;
}

- (UIImageView *)closeImageView
{
    if (!_closeImageView)
    {
        _closeImageView = [[UIImageView alloc] init];
        _closeImageView.image = [UIImage imageNamed:@"talk_close_40x40_"];
    }
    return _closeImageView;
}

#pragma mark - Void
- (void)addFrame
{
    CGFloat bianju = (CGRectGetWidth([UIScreen mainScreen].bounds) - (40 * 6)) / 7;
    for (int i = 0; i < 6; i++)
    {
        UIView *view = self.array[i];
        view.frame = CGRectMake(bianju * ( i + 1) + 40 * i, 0, 40, 40);
    }
}

@end
