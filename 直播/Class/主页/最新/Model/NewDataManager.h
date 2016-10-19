//
//  NewDataManager.h
//  直播
//
//  Created by duoyi on 16/10/19.
//  Copyright © 2016年 bt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LiveUser.h"

@class NewDataManager;
@protocol NewDataManagerDelegate <NSObject>

- (void)newDataManagerSuccess:(NewDataManager *) manager;
- (void)newDataManagerFaild:(NewDataManager *) manager;

@end

@interface NewDataManager : NSObject

@property (nonatomic, weak) id<NewDataManagerDelegate> delegate;

- (void)requestFirstPage;
- (void)requestNextPage;

- (NSInteger) count;
- (LiveUser*) modelWithIndex:(NSInteger)index;
- (BOOL)noMoreData;

@end
