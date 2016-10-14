//
//  UILabel+MoreColorText.m
//  直播
//
//  Created by duoyi on 16/10/14.
//  Copyright © 2016年 bt. All rights reserved.
//

#import "UILabel+MoreColorText.h"
#import "UIColor+Hex.h"

@implementation UILabel (MoreColorText)

-(void)setAttributeLabelWithtextColorPairs:(NSArray*)colorTextPairs
{
    //获取Label的带属性字符串
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSString *text = self.text;
    NSRange oriRange = NSMakeRange(0, 0), changedRange = NSMakeRange(0, 0);
    for (NSDictionary *textColorDic in colorTextPairs)
    {
        //计算要修改的textRange
        NSRange textRange = [text rangeOfString:textColorDic.allKeys.firstObject];
        NSUInteger location = (oriRange.location + oriRange.length) + textRange.location;
        changedRange = NSMakeRange(location, textRange.length);
        //修改指定范围的textColor
        UIColor *curColor = nil;
        if ([textColorDic.allValues.firstObject isKindOfClass:[UIColor class]])
        {
            curColor = textColorDic.allValues.firstObject;
        }
        else
        {
            curColor = [UIColor redColor];// 这里被我写死了
        }
        [attrStr addAttribute:NSForegroundColorAttributeName value:curColor range:changedRange];
        //将修改的range改为旧的Range
        oriRange = changedRange;
        //从匹配字符串的结尾开始截取剩下的字符串
        if (textRange.location != NSNotFound &&
            self.text.length > (textRange.location + textRange.length)) {
            text = [text substringFromIndex:textRange.location + textRange.length];
        }
    }
    //将修改好的AttributedString赋值给Label
    self.attributedText = attrStr;
}


@end
