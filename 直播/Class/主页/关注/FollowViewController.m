//
//  FollowViewController.m
//  直播
//
//  Created by duoyi on 16/10/13.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "FollowViewController.h"
#import "Masonry.h"

@interface FollowViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation FollowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.label];
    [self addLayout];
}

#pragma mark -懒加载
- (UILabel *)label
{
    if (!_label)
    {
        _label = [[UILabel alloc] init];
        _label.text = @"您关注的主播还未开播";
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor grayColor];
    }
    return _label;
}
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_follow_250x247"]];
    }
    return _imageView;
}

#pragma mark - Void
- (void)addLayout
{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(250));
        make.height.equalTo(@(257));
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-80);
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(_imageView.mas_bottom).offset(20);
    }];
}

@end
