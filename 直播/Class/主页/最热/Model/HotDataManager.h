//
//  HotDataManager.h
//  直播
//
//  Created by duoyi on 16/10/14.
//  Copyright © 2016年 bt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADModel.h"

@class HotDataManager;
@protocol HotDataManagerDelegate <NSObject>

- (void)hotDataManager:(HotDataManager *)manager listSuccess:(NSArray *)listItem;

@end

@interface HotDataManager : NSObject

@property (nonatomic, weak) id<HotDataManagerDelegate> delegate;
- (void)requestAD:(void (^)(NSArray * array))success;
- (void)requestFirstList;
- (void)requestNextList;
- (NSInteger)itemCount;
- (ADModel *)modelWithIndex:(NSInteger)index;
- (BOOL)noMoreData;

@end
