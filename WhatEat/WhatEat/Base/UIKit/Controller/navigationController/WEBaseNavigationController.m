//
//  WEBaseNavigationController.m
//  WhatEat
//
//  Created by 辛峰 on 2018/9/12.
//  Copyright © 2018年 WhatEat. All rights reserved.
//

#import "WEBaseNavigationController.h"
#import "UIViewController+HHTransition.h"
#import "WEController.h"

@interface WEBaseNavigationController ()

@end

@implementation WEBaseNavigationController


#pragma mark -
#pragma mark - Public Method
- (void)pushViewController:(UIViewController *)viewController animatedStyle:(AnimationStyle)animatedStyle {
    [self analysisPushVC:(WEController *)viewController animationStyle:animatedStyle];
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
}
    
#pragma mark -
#pragma mark - Privare Method
- (void)analysisPushVC:(WEController *)toVc animationStyle:(AnimationStyle)animationStyle {
    if (animationStyle == AnimationStyleErect) {
        [self xf_pushErectViewController:toVc];
    } else if (animationStyle == AnimationStyleTilted) {
        [self xf_pushTiltViewController:toVc];
    } else if (animationStyle == AnimationStyleScale) {
        [self xf_pushScaleViewController:toVc];
    } else if (animationStyle == AnimationStyleBack) {
        [self xf_pushBackViewController:toVc];
    } else if (animationStyle == AnimationStyleCube) {
        [self xf_pushViewController:toVc style:AnimationStyleCube];
    } else if (animationStyle == AnimationStyleSuckEffect) {
        [self xf_pushViewController:toVc style:AnimationStyleSuckEffect];
    } else if (animationStyle == AnimationStyleOglFlip) {
        [self xf_pushViewController:toVc style:AnimationStyleOglFlip];
    } else if (animationStyle == AnimationStyleRippleEffect) {
        [self xf_pushViewController:toVc style:AnimationStyleRippleEffect];
    } else if (animationStyle == AnimationStylePageCurl) {
        [self xf_pushViewController:toVc style:AnimationStylePageCurl];
    } else if (animationStyle == AnimationStyleCameralIrisHollowOpen) {
        [self xf_pushViewController:toVc style:AnimationStyleCameralIrisHollowOpen];
    } else if (animationStyle == AnimationStyleNone) {
        [self xf_pushViewController:toVc style:AnimationStyleNone];
    }
}
    
- (UIView *)xf_transitionAnimationView//need to override
    {
        return [UIButton new];
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
