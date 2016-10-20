//
//  MainViewController.m
//  直播
//
//  Created by duoyi on 16/10/12.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "MainViewController.h"
#import "TitleView.h"
#import "Masonry.h"
#import "HotViewController.h"
#import "NewViewController.h"
#import "FollowViewController.h"
#import "WebViewController.h"

@interface MainViewController ()<TitleViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) TitleView *titleView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_15x14"] style:UIBarButtonItemStylePlain target:self action:@selector(left)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"head_crown_24x24"] style:UIBarButtonItemStylePlain target:self action:@selector(right)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.navigationItem.titleView = self.titleView;
    [_titleView firstSelected:0];
    
    [self.view addSubview:self.scrollView];
    
    [self addLayout];
    
    [self addController];
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * 3, 0);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (TitleView *)titleView
{
    if (!_titleView)
    {
        _titleView = [[TitleView alloc]initWithFrame:CGRectMake(45, 0, CGRectGetWidth(self.view.frame) - 90, 44)];
        _titleView.delegate = self;
    }
    return _titleView;
}

#pragma mark - Void

- (void)addController
{
    HotViewController *hotController = [[HotViewController alloc] init];
    [self addChildViewController:hotController];
    [self.scrollView addSubview:hotController.view];
    
    NewViewController *newController = [[NewViewController alloc] init];
    [self addChildViewController:newController];
    [self.scrollView addSubview:newController.view];
    newController.view.frame = CGRectMake(CGRectGetWidth(self.view.frame), 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    
    FollowViewController *followController = [[FollowViewController alloc] init];
    [self addChildViewController:followController];
    [self.scrollView addSubview:followController.view];
    followController.view.frame = CGRectMake(CGRectGetWidth(self.view.frame) * 2, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}

- (void)left
{
    NSLog(@"搜索");
}

- (void)right
{
    WebViewController *controller = [[WebViewController alloc] initWithUrlStr:@"http://live.9158.com/Rank/WeekRank?Random=10"];
    controller.navigationItem.title = @"排行";
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)titleView:(TitleView *)titleView click:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.view.frame) * index, 0) animated:YES];
}

- (void)addLayout
{

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //1.计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;

    //2.获取对应子控制器 并显示
    [self.titleView select:index];

}
@end
