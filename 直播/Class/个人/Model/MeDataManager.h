//
//  MeDataManager.h
//  直播
//
//  Created by duoyi on 16/10/20.
//  Copyright © 2016年 bt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MeModel.h"

@interface MeDataManager : NSObject

//返回每组多少个
- (NSInteger)rowWithIndexPath:(NSIndexPath *)indexPath;
- (MeModel *)modelWithIndexPath:(NSIndexPath *)indexPath;

@end
