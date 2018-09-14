//
//  WENavigationView.m
//  HoldCoin
//
//  Created by 辛峰 on 2018/7/18.
//  Copyright © 2018年 随写. All rights reserved.
//

#import "WENavigationView.h"

static const CGFloat kMargin = 15.f;

@implementation WENavigationView

#pragma mark -
#pragma mark - Left Button
- (void)customLeftText:(NSString *)leftText {
    [self customLeftText:leftText leftImage:nil];
}

- (void)customLeftText:(NSString *)leftText leftAction:(void(^)(void))leftAction {
    [self customLeftText:leftText leftImage:nil leftAction:leftAction];
}

- (void)customLeftImage:(NSString *)leftImageName leftAction:(void(^)(void))leftAction {
    [self customLeftText:nil leftImage:leftImageName leftAction:leftAction];
}

- (void)customLeftImage:(NSString *)leftImageName {
    [self customLeftText:nil leftImage:leftImageName];
}

- (void)customLeftText:(NSString *)leftText leftImage:(NSString *)leftImageName {
    [self customLeftText:leftText leftImage:leftImageName leftAction:nil];
}

- (void)customLeftText:(NSString *)leftText leftImage:(NSString *)leftImageName
            leftAction:(void(^)(void))leftAction {
    [_leftButton setTitle:leftText forState:UIControlStateNormal];
    if (leftImageName.length > 0) {
        [_leftButton setImage:[UIImage imageNamed:leftImageName] forState:UIControlStateNormal];
    }
    
    if (leftAction) {
        [_leftButton xf_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
        [_leftButton xf_addEventHandler:^(id sender) {
            leftAction();
        } forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark -
#pragma mark - subLeft button
- (void)customSubLeftText:(NSString *)subLeftText {
    [self customSubLeftText:subLeftText subLeftImage:nil];
}

- (void)customSubLeftText:(NSString *)subLeftText subLeftAction:(void(^)(void))subLeftAction {
    [self customSubLeftText:subLeftText subLeftImage:nil subLeftAction:subLeftAction];
}

- (void)customSubLeftImage:(NSString *)subLeftImageName subLeftAction:(void(^)(void))subLeftAction {
    [self customLeftText:nil leftImage:subLeftImageName leftAction:subLeftAction];
}

- (void)customSubLeftImage:(NSString *)subLeftImageName {
    [self customLeftText:nil leftImage:subLeftImageName];
}

- (void)customSubLeftText:(NSString *)subLeftText subLeftImage:(NSString *)subLeftImageName {
    [self customLeftText:subLeftText leftImage:subLeftImageName leftAction:nil];
}

- (void)customSubLeftText:(NSString *)subLeftText subLeftImage:(NSString *)subLeftImageName
            subLeftAction:(void(^)(void))subLeftAction {
    [_subLeftButton setTitle:subLeftText forState:UIControlStateNormal];
    if (subLeftImageName.length > 0) {
        [_subLeftButton setImage:[UIImage imageNamed:subLeftImageName] forState:UIControlStateNormal];
    }
    
    if (subLeftAction) {
        [_subLeftButton xf_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
        [_subLeftButton xf_addEventHandler:^(id sender) {
            subLeftAction();
        } forControlEvents:UIControlEventTouchUpInside];
    }
}


#pragma mark -
#pragma mark - Center Butotn
- (void)customCenterText:(NSString *)centerText {
    [self customCenterText:centerText centerImage:nil];
}

- (void)customCenterText:(NSString *)centerText centerAction:(void(^)(void))centerAction {
    [self customCenterText:centerText centerImage:nil centerAction:centerAction];
}

- (void)customCenterImage:(NSString *)centerImageName centerAction:(void(^)(void))centerAction {
    [self customCenterText:nil centerImage:centerImageName centerAction:centerAction];
}

- (void)customCenterImage:(NSString *)centerImageName {
    [self customCenterText:nil centerImage:centerImageName];
}

- (void)customCenterText:(NSString *)centerText centerImage:(NSString *)centerImageName {
    [self customCenterText:centerText centerImage:centerImageName centerAction:nil];
}

- (void)customCenterText:(NSString *)centerText centerImage:(NSString *)centerImageName
            centerAction:(void(^)(void))centerAction {
    [_centerButton setTitle:centerText forState:UIControlStateNormal];
    if (centerImageName.length > 0) {
        [_centerButton setImage:[UIImage imageNamed:centerImageName] forState:UIControlStateNormal];
        [_centerButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, -3)];
        [_centerButton setImageEdgeInsets:UIEdgeInsetsMake(0, -3, 0, 3)];
    }

    if (centerAction) {
        [_centerButton xf_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
        [_centerButton xf_addEventHandler:^(id sender) {
            centerAction();
        } forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)customCenterView:(UIView *)centerView centerAction:(void (^)(void))centerAction{
    [_centerButton setTitle:@"" forState:UIControlStateNormal];
    [_centerButton setImage:nil forState:UIControlStateNormal];
    [_centerButton addSubview:centerView];
    centerView.userInteractionEnabled = false;
    [centerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(centerView.width);
        make.height.mas_equalTo(centerView.height);
    }];
    
    if (centerAction) {
        [_centerButton xf_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
        [_centerButton xf_addEventHandler:^(id sender) {
            centerAction();
        } forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark -
#pragma mark - Right Butotn
- (void)customRightText:(NSString *)rightText {
    [self customRightText:rightText rightImage:nil];
}

- (void)customRightText:(NSString *)rightText rightAction:(void(^)(void))rightAction {
    [self customRightText:rightText rightImage:nil rightAction:rightAction];
}

- (void)customRightText:(NSString *)rightText textColor:(UIColor *)textColor rightImage:(NSString *)rightImageName rightAction:(void (^)(void))rightAction{
    [self customRightText:rightText rightImage:rightImageName rightAction:rightAction];
    [self.rightButton setTitleColor:textColor forState:(UIControlStateNormal)];
}

- (void)customRightImage:(NSString *)rightImageName rightAction:(void(^)(void))rightAction {
    [self customRightText:nil rightImage:rightImageName rightAction:rightAction];
}

- (void)customRightImage:(NSString *)rightImageName {
    [self customRightText:nil rightImage:rightImageName];
}

- (void)customRightText:(NSString *)rightText rightImage:(NSString *)rightImageName {
    [self customRightText:rightText rightImage:rightImageName rightAction:nil];
}

- (void)customRightText:(NSString *)rightText rightImage:(NSString *)rightImageName
            rightAction:(void(^)(void))rightAction {
    [_rightButton setTitle:rightText forState:UIControlStateNormal];
    if (rightImageName.length > 0) {
        [_rightButton setImage:[UIImage imageNamed:rightImageName] forState:UIControlStateNormal];
    }
    
    if (rightAction) {
        [_rightButton xf_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
        [_rightButton xf_addEventHandler:^(id sender) {
            rightAction();
        } forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark -
#pragma mark - SubRight Button
- (void)customSubRightText:(NSString *)subRightText {
    [self customSubRightText:subRightText subRightImage:nil];
}

- (void)customSubRightText:(NSString *)subRightText subRightAction:(void(^)(void))subRightAction {
    [self customSubRightText:subRightText subRightImage:nil subRightAction:subRightAction];
}

- (void)customSubRightImage:(NSString *)subRightImageName subRightAction:(void(^)(void))subRightAction {
    [self customSubRightText:nil subRightImage:subRightImageName subRightAction:subRightAction];
}

- (void)customSubRightImage:(NSString *)subRightImageName {
    [self customSubRightText:nil subRightImage:subRightImageName];
}

- (void)customSubRightText:(NSString *)subRightText subRightImage:(NSString *)subRightImageName {
    [self customSubRightText:subRightText subRightImage:subRightImageName subRightAction:nil];
}

- (void)customSubRightText:(NSString *)subRightText subRightImage:(NSString *)subRightImageName
            subRightAction:(void(^)(void))subRightAction {
    [_subRightButton setTitle:subRightText forState:UIControlStateNormal];
    if (subRightImageName.length > 0) {
        [_subRightButton setImage:[UIImage imageNamed:subRightImageName] forState:UIControlStateNormal];
    }
    
    if (subRightAction) {
        [_subRightButton xf_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
        [_subRightButton xf_addEventHandler:^(id sender) {
            subRightAction();
        } forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark -
#pragma mark - Init Method
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    WEExpandButton *backButton = [WEExpandButton buttonWithType:UIButtonTypeCustom];
    backButton.backgroundColor = [UIColor clearColor];
    backButton.frame = self.bounds;
    [self addSubview:backButton];
    
    WEExpandButton *leftButton = [WEExpandButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitleColor:WEColor(34, 34, 34) forState:UIControlStateNormal];
    leftButton.titleLabel.font = kWERegularFontSize(14);
    leftButton.rangeInsets = UIEdgeInsetsMake(10, 5, 10, 5);
    [self addSubview:leftButton];
    _leftButton = leftButton;
    
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(kWEStatusBarHeight);
        make.bottom.mas_equalTo(0);
    }];
    
    WEExpandButton *subLeftButton = [WEExpandButton buttonWithType:UIButtonTypeCustom];
    [subLeftButton setTitleColor:WEColor(34, 34, 34) forState:UIControlStateNormal];
    subLeftButton.titleLabel.font = kWERegularFontSize(14);
    subLeftButton.rangeInsets = UIEdgeInsetsMake(10, 5, 10, 5);
    [self addSubview:subLeftButton];
    _subLeftButton = subLeftButton;
    
    [_subLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftButton.mas_right).offset(kMargin);
        make.top.mas_equalTo(kWEStatusBarHeight);
        make.bottom.mas_equalTo(0);
    }];
    
    WEExpandButton *centerButton = [WEExpandButton buttonWithType:UIButtonTypeCustom];
    [centerButton setTitleColor:WEColor(34, 34, 34) forState:UIControlStateNormal];
    centerButton.titleLabel.font = kWERegularFontSize(16);
    centerButton.rangeInsets = UIEdgeInsetsMake(10, 5, 10, 5);
    [self addSubview:centerButton];
    _centerButton = centerButton;
    
    [_centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(kWEStatusBarHeight);
        make.bottom.mas_equalTo(0);
    }];
    
    WEExpandButton *rightButton = [WEExpandButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitleColor:WEColor(34, 34, 34) forState:UIControlStateNormal];
    rightButton.titleLabel.font = kWERegularFontSize(14);
    rightButton.rangeInsets = UIEdgeInsetsMake(10, 5, 10, 5);
    [self addSubview:rightButton];
    _rightButton = rightButton;
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kMargin);
        make.top.mas_equalTo(kWEStatusBarHeight);
        make.bottom.mas_equalTo(0);
    }];
    
    WEExpandButton *subRightButton = [WEExpandButton buttonWithType:UIButtonTypeCustom];
    [subRightButton setTitleColor:WEColor(34, 34, 34) forState:UIControlStateNormal];
    subRightButton.titleLabel.font = kWERegularFontSize(14);
    subRightButton.rangeInsets = UIEdgeInsetsMake(10, 5, 10, 5);
    [self addSubview:subRightButton];
    _subRightButton = subRightButton;
    
    [_subRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rightButton.mas_left).offset(-kMargin);
        make.top.mas_equalTo(kWEStatusBarHeight);
        make.bottom.mas_equalTo(0);
    }];
}

@end
