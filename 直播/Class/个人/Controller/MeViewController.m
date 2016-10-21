//
//  MeViewController.m
//  直播
//
//  Created by duoyi on 16/10/12.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "MeViewController.h"
#import "Masonry.h"
#import "MeDataManager.h"
#import "MeTableViewCell.h"
#import "MeModel.h"
#import "MeHeadView.h"

@interface MeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MeDataManager *dataManager;
@property (nonatomic, strong) MeHeadView *headView;

@end

static NSString *meIdent = @"meIdent";
@implementation MeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self addLayout];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (UIRectEdge)edgesForExtendedLayout
{
    // 起点坐标从0开始
    return UIRectEdgeNone;
}

#pragma mark - 懒加载
- (MeHeadView *)headView
{
    if (!_headView)
    {
        _headView = [[MeHeadView alloc] init];
        _headView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 300);
    }
    return _headView;
}

- (MeDataManager *)dataManager
{
    if (!_dataManager)
    {
        _dataManager = [[MeDataManager alloc] init];
    }
    return _dataManager;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MeTableViewCell class] forCellReuseIdentifier:meIdent];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.headView;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataManager rowWithIndexPath:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:meIdent];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    MeModel *model = [self.dataManager modelWithIndexPath:indexPath];
    [cell reloadModel:model];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 35.0f;
    }
    return 0;
}

#pragma mark - Void
- (void)addLayout
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
}

@end
