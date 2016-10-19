//
//  HotViewController.m
//  直播
//
//  Created by duoyi on 16/10/13.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "HotViewController.h"
#import "Masonry.h"
#import "HotDataManager.h"
#import "HotMainHeadView.h"
#import "HotTableViewCell.h"
#import "ShowViewController.h"
#import "MJRefresh.h"
#import "MiaoboRefreshGifHeader.h"

@interface HotViewController ()<UITableViewDelegate, UITableViewDataSource, HotDataManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HotDataManager *dataManager;
@property (nonatomic, strong) HotMainHeadView *headView;

@end

static NSString *cellIdent = @"cell";
@implementation HotViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
   
    [self.dataManager requestAD:^(NSArray *array) {
        [self.headView reloadData:array];
    }];
    
    self.tableView.mj_header = [MiaoboRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
    [self.tableView.mj_header beginRefreshing];
   
}   

#pragma mark - 懒加载

- (HotMainHeadView *)headView
{
    if (!_headView)
    {
        _headView = [[HotMainHeadView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100)];
    }
    return _headView;
}

- (HotDataManager *)dataManager
{
    if (!_dataManager)
    {
        _dataManager = [[HotDataManager alloc] init];
        _dataManager.delegate = self;
    }
    return _dataManager;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.tabBarController.tabBar.frame) - 64);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.showsHorizontalScrollIndicator = NO;
        [_tableView registerClass:[HotTableViewCell class] forCellReuseIdentifier:cellIdent];
        _tableView.tableHeaderView = self.headView;
        _tableView.rowHeight = 460;
    }
    return _tableView;
}

#pragma mark - UITabBarDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataManager itemCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    ADModel *model = [self.dataManager modelWithIndex:indexPath.row];
    [cell reloadModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ShowViewController *controller = [[ShowViewController alloc] init];
    ADModel *model = [self.dataManager modelWithIndex:indexPath.row];
    [controller reloadModel:model];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark - HotDataManagerDelegate
- (void)hotDataManager:(HotDataManager *)manager listSuccess:(NSArray *)listItem
{
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if ([self.dataManager noMoreData])
    {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [self.tableView.mj_footer setHidden:YES];
    }
}

#pragma mark -Void
- (void)headRefresh
{
    [self.dataManager requestFirstList];
}

- (void)footRefresh
{
    [self.dataManager requestNextList];
}

@end
