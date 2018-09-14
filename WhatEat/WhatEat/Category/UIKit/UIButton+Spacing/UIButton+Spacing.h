//
//  UIButton+Spacing.h
//  hotbody
//
//  Created by Belle on 2016/10/27.
//  Copyright © 2016年 Beijing Fitcare inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BLButtonEdgeInsetsStyle) {
    BLButtonEdgeInsetsStyleTop, // image在上，label在下
    BLButtonEdgeInsetsStyleLeft, // image在左，label在右
    BLButtonEdgeInsetsStyleBottom, // image在下，label在上
    BLButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (Spacing)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(BLButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
