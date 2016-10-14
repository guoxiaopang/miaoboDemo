//
//  ThreePartyLoginView.h
//  直播
//
//  Created by duoyi on 16/10/12.
//  Copyright © 2016年 bt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ThreePartyLoginView;

@protocol ThreePartyLoginViewDelegate <NSObject>

- (void)threePartyLoginView:(ThreePartyLoginView *)view click:(NSInteger)index;

@end

@interface ThreePartyLoginView : UIView

@property (nonatomic, weak)id<ThreePartyLoginViewDelegate> delegate;

@end
