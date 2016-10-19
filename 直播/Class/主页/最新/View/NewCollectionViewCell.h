//
//  NewCollectionViewCell.h
//  直播
//
//  Created by duoyi on 16/10/19.
//  Copyright © 2016年 bt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveUser.h"

@interface NewCollectionViewCell : UICollectionViewCell

- (void)reloadWithModel:(LiveUser *)model;

@end
