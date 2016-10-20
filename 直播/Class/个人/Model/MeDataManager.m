//
//  MeDataManager.m
//  直播
//
//  Created by duoyi on 16/10/20.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "MeDataManager.h"
#import "MeModel.h"

@interface MeDataManager()

@property (nonatomic, strong) NSMutableArray *item;

@end

@implementation MeDataManager

- (NSMutableArray *)item
{
    if (!_item)
    {
        _item = [NSMutableArray array];
        
        MeModel *model1 = [[MeModel alloc] init];
        model1.imageStr = @"my_coin";
        model1.name = @"我的喵币";
        model1.rightTitle = @"1245枚";
        
        MeModel *model2 = [[MeModel alloc] init];
        model2.imageStr = @"live_manager";
        model2.name = @"直播间管理";
        
        MeModel *model3 = [[MeModel alloc] init];
        model3.imageStr = @"box";
        model3.name = @"号外！做任务赢礼包~";
        model3.rightImageStr = @"task_image_gold";
        model3.redName = YES;
        
        MeModel *model4 = [[MeModel alloc] init];
        model4.imageStr = @"income";
        model4.name = @"我的收益";
        
        MeModel *model5 = [[MeModel alloc] init];
        model5.imageStr = @"game_center";
        model5.name = @"游戏中心";
        
        MeModel *model6 = [[MeModel alloc] init];
        model6.imageStr = @"sinashow";
        model6.name = @"微钱进理财";
        
        MeModel *model7 = [[MeModel alloc] init];
        model7.imageStr = @"setting";
        model7.name = @"设置";
        
        [_item addObjectsFromArray:@[@[model1, model2, model3],
                                     @[model4, model5, model6],
                                     @[model7]]];
    }
    return _item;
}

- (MeModel *)modelWithIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section < self.item.count)
    {
        NSArray *array = self.item[section];
        if (indexPath.row < array.count)
        {
            return array[indexPath.row];
        }
        
    }
    return nil;
}

- (NSInteger)rowWithIndexPath:(NSInteger)section
{
    if (section < self.item.count)
    {
        NSArray *array = self.item[section];
        return array.count;
    }
    return 0;
}

@end
