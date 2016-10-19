//
//  NewViewController.m
//  直播
//
//  Created by duoyi on 16/10/13.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "NewViewController.h"
#import "NewDataManager.h"
#import "NewCollectionViewCell.h"

@interface NewViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, NewDataManagerDelegate>

@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NewDataManager *manager;

@end

static NSString *newIdent = @"new";

@implementation NewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.manager requestFirstPage];
}

#pragma mark - 懒加载
- (NewDataManager *)manager
{
    if (!_manager)
    {
        _manager = [[NewDataManager alloc] init];
        _manager.delegate = self;
    }
    return _manager;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        CGFloat spaceing = 1.0f;
        // (宽度 - 间距) / 个数
        CGFloat width = (CGRectGetWidth(self.view.frame) - spaceing * 4) / 3;
        CGFloat height = width;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsMake(spaceing, spaceing, spaceing, spaceing);
        flowLayout.minimumLineSpacing = spaceing;
        flowLayout.minimumInteritemSpacing = spaceing;
        flowLayout.itemSize = CGSizeMake(width, height);
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[NewCollectionViewCell class] forCellWithReuseIdentifier:newIdent];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.manager count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:newIdent forIndexPath:indexPath];
    return cell;
}

#pragma mark - NewDataManagerDelegate
- (void)newDataManagerSuccess:(NewDataManager *) manager
{
    [self.collectionView reloadData];
}

- (void)newDataManagerFaild:(NewDataManager *) manager
{

}

@end
