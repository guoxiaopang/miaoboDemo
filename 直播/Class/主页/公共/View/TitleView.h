//
//  TitleView.h
//  直播
//
//  Created by duoyi on 16/10/13.
//  Copyright © 2016年 bt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TitleView;

@protocol TitleViewDelegate <NSObject>

- (void)titleView:(TitleView *)titleView click:(NSInteger)index;

@end

@interface TitleView : UIView

@property (nonatomic, weak) id<TitleViewDelegate> delegate;
- (void)firstSelected:(NSInteger)index;
- (void)select:(NSInteger)index;

@end
