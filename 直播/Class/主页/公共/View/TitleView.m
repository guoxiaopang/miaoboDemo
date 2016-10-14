//
//  TitleView.m
//  直播
//
//  Created by duoyi on 16/10/13.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "TitleView.h"
#import "Masonry.h"
#import "UIColor+Hex.h"

@interface TitleView ()

@property (nonatomic, strong) UIButton *newButton;
@property (nonatomic, strong) UIButton *hotButton;
@property (nonatomic, strong) UIButton *followButton;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation TitleView
{
    UIButton *_selectButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.hotButton];
        [self addSubview:self.newButton];
        [self addSubview:self.followButton];
        [self addSubview:self.lineView];
        
        [self addLayout];
    }
    return self;
}

#pragma mark -懒加载
- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc] init];
    }
    return _lineView;
}

- (NSMutableArray *)buttonArray
{
    if (!_buttonArray)
    {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (UIButton *)followButton
{
    if (!_followButton)
    {
        _followButton = [[UIButton alloc] init];
        [_followButton setTitle:@"关注" forState:UIControlStateNormal];
        [_followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_followButton setTitleColor:[UIColor colorWithHex:0XEED5D2] forState:UIControlStateSelected];
        _followButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_followButton sizeToFit];
        _followButton.tag = 2;
        [_followButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:_followButton];
    }
    return _followButton;
}

- (UIButton *)hotButton
{
    if (!_hotButton)
    {
        _hotButton = [[UIButton alloc] init];
        [_hotButton setTitle:@"最热" forState:UIControlStateNormal];
        [_hotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_hotButton setTitleColor:[UIColor colorWithHex:0XEED5D2] forState:UIControlStateSelected];
        _hotButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_hotButton sizeToFit];
        _hotButton.tag = 0;
        [_hotButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:_hotButton];
    }
    return _hotButton;
}
- (UIButton *)newButton
{
    if (!_newButton)
    {
        _newButton = [[UIButton alloc] init];
        [_newButton setTitle:@"最新" forState:UIControlStateNormal];
        [_newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_newButton setTitleColor:[UIColor colorWithHex:0XEED5D2] forState:UIControlStateSelected];
        _newButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_newButton sizeToFit];
        _newButton.tag = 1;
        [_newButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:_newButton];
    }
    return _newButton;
}

- (void)addLayout
{
    [_newButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [_hotButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(_newButton.mas_left).offset(-40);
    }];
    
    [_followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_newButton.mas_right).offset(40);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_newButton);
    }];
}

- (void)click:(UIButton *)button
{
    _selectButton.selected = NO;
    button.selected = YES;
    _selectButton = button;
    
    if ([self.delegate respondsToSelector:@selector(titleView:click:)])
    {
        [self.delegate titleView:self click:button.tag];
    }
}

- (void)firstSelected:(NSInteger)index
{
    if (index > self.buttonArray.count - 1)
    {
        return;
    }
    UIButton *button = self.buttonArray[index];
    [self click:button];
}

- (void)select:(NSInteger)index
{
    [self firstSelected:index];
}

@end
