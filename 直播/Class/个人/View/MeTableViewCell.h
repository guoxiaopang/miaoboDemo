//
//  MeTableViewCell.h
//  直播
//
//  Created by duoyi on 16/10/20.
//  Copyright © 2016年 bt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeModel.h"

@interface MeTableViewCell : UITableViewCell

- (void)reloadModel:(MeModel *)model;

@end
