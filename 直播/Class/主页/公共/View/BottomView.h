//
//  BottomView.h
//  直播
//
//  Created by duoyi on 16/10/17.
//  Copyright © 2016年 bt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BottomView;

@protocol BottomViewDelegate <NSObject>

- (void)bottomViewClick:(BottomView *)view;

@end

@interface BottomView : UIView

@property (nonatomic, weak)id<BottomViewDelegate> delegate;

@end
