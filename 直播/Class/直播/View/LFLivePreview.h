//
//  LFLivePreview.h
//  直播
//
//  Created by duoyi on 16/10/18.
//  Copyright © 2016年 bt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LFLivePreview;

@protocol LFLivePreviewDelegate <NSObject>

- (void)LFLivePreviewColse:(LFLivePreview *)view;

@end

@interface LFLivePreview : UIView

@property (nonatomic, weak)id<LFLivePreviewDelegate> delegate;

@end
