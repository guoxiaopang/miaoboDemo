//
//  MeHeadView.m
//  直播
//
//  Created by duoyi on 16/10/21.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "MeHeadView.h"
#import "Masonry.h"

@interface MeHeadView()

@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MeHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        [self addSubview:self.imageView];
       
       // self.backgroundColor = [UIColor redColor];
        [self.imageView addSubview:self.effectView];
         [self addLayout];
    }
    return self;
}

#pragma mark - 懒加载

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"effectBgLevel_30"]];
        [_imageView sizeToFit];
    }
    return _imageView;
}
- (UIVisualEffectView *)effectView
{
    if (!_effectView)
    {
        UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView= [[UIVisualEffectView alloc] initWithEffect:effect];
        
    }
    return _effectView;
}

- (void)addLayout
{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
    }];
    
    [_effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
}

@end
