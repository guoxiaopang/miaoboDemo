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

@interface MeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MeDataManager *dataManager;

@end

static NSString *meIdent = @"meIdent";
@implementation MeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self addLayout];
}

#pragma mark - 懒加载
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
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:meIdent];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:meIdent];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
#pragma mark - Void
- (void)addLayout
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

@end
