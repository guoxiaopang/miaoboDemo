//
//  HotDataManager.m
//  直播
//
//  Created by duoyi on 16/10/14.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "HotDataManager.h"
#import "AFNetworking.h"
#import "YYModel.h"


@interface HotDataManager()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableArray *item;

@end

@implementation HotDataManager

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

// 请求广告
- (void)requestAD:(void (^)(NSArray *))success
{
    NSString *str = @"http://live.9158.com/Living/GetAD";
    [self.manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *result = responseObject;
        NSArray *data = result[@"data"];
        NSMutableArray *adItem = [NSMutableArray array];
        for (NSDictionary *dict in data)
        {
            ADModel *model = [ADModel yy_modelWithDictionary:dict];
            [adItem addObject:model.imageUrl];
        }
        if (adItem)
        {
            success(adItem);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
}

// 请求第一页
- (void)requestFirstList
{
    NSString *str = @"http://live.9158.com/Fans/GetHotLive?page=1";
    [self.manager GET:str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = responseObject;
        NSDictionary *data = result[@"data"];
        NSArray *listArray = data[@"list"];
        [self.item removeAllObjects];
        for (NSDictionary *dict in listArray)
        {
            ADModel *model = [ADModel yy_modelWithDictionary:dict];
            [self.item addObject:model];
        }
        
        if ([self.delegate respondsToSelector:@selector(hotDataManager:listSuccess:)])
        {
            [self.delegate hotDataManager:self listSuccess:self.item];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (NSInteger)itemCount
{
    return self.item.count;
}

- (ADModel *)modelWithIndex:(NSInteger)index
{
    if (index < self.item.count)
    {
        return self.item[index];
    }
    return nil;
}
@end
