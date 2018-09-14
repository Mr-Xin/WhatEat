//
//  WENavigationView.h
//  HoldCoin
//
//  Created by 辛峰 on 2018/7/18.
//  Copyright © 2018年 随写. All rights reserved.
//

#import "WEBaseView.h"
#import "WEExpandButton.h"

@interface WENavigationView : WEBaseView

@property (nonatomic, weak) WEExpandButton *leftButton;
@property (nonatomic, weak) WEExpandButton *subLeftButton;
@property (nonatomic, weak) WEExpandButton *centerButton;
@property (nonatomic, weak) WEExpandButton *rightButton;
@property (nonatomic, weak) WEExpandButton *subRightButton;

#pragma mark -
#pragma mark - 左按钮
- (void)customLeftText:(NSString *)leftText;
- (void)customLeftText:(NSString *)leftText leftAction:(void(^)(void))leftAction;
- (void)customLeftImage:(NSString *)leftImageName leftAction:(void(^)(void))leftAction;
- (void)customLeftImage:(NSString *)leftImageName;
- (void)customLeftText:(NSString *)leftText leftImage:(NSString *)leftImageName;
- (void)customLeftText:(NSString *)leftText leftImage:(NSString *)leftImageName
            leftAction:(void(^)(void))leftAction;

#pragma mark -
#pragma mark - 次级 左按钮
- (void)customSubLeftText:(NSString *)subLeftText;
- (void)customSubLeftText:(NSString *)subLeftText subLeftAction:(void(^)(void))subLeftAction;
- (void)customSubLeftImage:(NSString *)subLeftImageName subLeftAction:(void(^)(void))subLeftAction;
- (void)customSubLeftImage:(NSString *)subLeftImageName;
- (void)customSubLeftText:(NSString *)subLeftText subLeftImage:(NSString *)subLeftImageName;
- (void)customSubLeftText:(NSString *)subLeftText subLeftImage:(NSString *)subLeftImageName
            subLeftAction:(void(^)(void))subLeftAction;

#pragma mark -
#pragma mark - 中间按钮
- (void)customCenterText:(NSString *)centerText;
- (void)customCenterText:(NSString *)centerText centerAction:(void(^)(void))centerAction;
- (void)customCenterImage:(NSString *)centerImageName centerAction:(void(^)(void))centerAction;
- (void)customCenterImage:(NSString *)centerImageName;
- (void)customCenterText:(NSString *)centerText centerImage:(NSString *)centerImageName;
- (void)customCenterText:(NSString *)centerText centerImage:(NSString *)centerImageName
            centerAction:(void(^)(void))centerAction;
- (void)customCenterView:(UIView *)centerView centerAction:(void (^)(void))centerAction;

#pragma mark -
#pragma mark - 右按钮
- (void)customRightText:(NSString *)rightText;
- (void)customRightText:(NSString *)rightText rightAction:(void(^)(void))rightAction;
- (void)customRightText:(NSString *)rightText textColor:(UIColor *)textColor rightImage:(NSString *)rightImageName rightAction:(void(^)(void))rightAction;
- (void)customRightImage:(NSString *)rightImageName rightAction:(void(^)(void))rightAction;
- (void)customRightImage:(NSString *)rightImageName;
- (void)customRightText:(NSString *)rightText rightImage:(NSString *)rightImageName;
- (void)customRightText:(NSString *)rightText rightImage:(NSString *)rightImageName
            rightAction:(void(^)(void))rightAction;

#pragma mark -
#pragma mark - 次级 右按钮
- (void)customSubRightText:(NSString *)subRightText;
- (void)customSubRightText:(NSString *)subRightText subRightAction:(void(^)(void))subRightAction;
- (void)customSubRightImage:(NSString *)subRightImageName subRightAction:(void(^)(void))subRightAction;
- (void)customSubRightImage:(NSString *)subRightImageName;
- (void)customSubRightText:(NSString *)subRightText subRightImage:(NSString *)subRightImageName;
- (void)customSubRightText:(NSString *)subRightText subRightImage:(NSString *)subRightImageName
            subRightAction:(void(^)(void))subRightAction;



@end
