//
//  NewDataManager.m
//  直播
//
//  Created by duoyi on 16/10/19.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "NewDataManager.h"
#import "AFNetworking.h"
#import "YYModel.h"

@interface NewDataManager()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableArray *item;

@end

@implementation NewDataManager
{
    NSUInteger _page;
    NSInteger _counts;
}

- (void)requestFirstPage
{
    NSString *str = @"http://live.9158.com/Room/GetNewRoomOnline?page=1";
    [self.manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *data = responseObject[@"data"];
        _counts = [data[@"totalPage"] integerValue];
        NSArray *list = data[@"list"];
        if (list.count)
        {
            [self.item removeAllObjects];
        }
        _page = 1;
        for (NSDictionary *dict in list)
        {
            LiveUser *model = [LiveUser yy_modelWithDictionary:dict];
            [self.item addObject:model];
        }
        [self success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
        [self faild];
    }];
}

- (void)requestNextPage
{
    _page++;
    NSString *str = [NSString stringWithFormat:@"http://live.9158.com/Room/GetNewRoomOnline?page=%ld", _page];
    [self.manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *data = responseObject[@"data"];
        NSArray *list = data[@"list"];
        _counts = [data[@"totalPage"] integerValue];
        
        for (NSDictionary *dict in list)
        {
            LiveUser *model = [LiveUser yy_modelWithDictionary:dict];
            [self.item addObject:model];
        }
        [self success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"next失败");
        [self faild];
        _page--;
    }];
}

#pragma mark - 懒加载
- (NSMutableArray *)item
{
    if (!_item)
    {
        _item = [NSMutableArray array];
    }
    return _item;
}
- (AFHTTPSessionManager *)manager
{
    if (!_manager)
    {
        _manager = [[AFHTTPSessionManager alloc] init];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    return _manager;
}

#pragma mark - Void
- (NSInteger)count
{
    return self.item.count;
}

- (LiveUser *)modelWithIndex:(NSInteger)index
{
    if (index < self.item.count)
    {
        return self.item[index];
    }
    return nil;
}

- (void)success
{
    if ([self.delegate respondsToSelector:@selector(newDataManagerSuccess:)])
    {
        [self.delegate newDataManagerSuccess:self];
    }
}

- (void)faild
{
    if ([self.delegate respondsToSelector:@selector(newDataManagerFaild:)])
    {
        [self.delegate newDataManagerFaild:self];
    }
}

- (BOOL)noMoreData
{
    return _counts == _page;
}

@end
