//
//  EWBaseController.h
//  WhatEat
//
//  Created by 辛峰 on 2018/9/13.
//  Copyright © 2018年 WhatEat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationStyle.h"
#import "WERouterManager.h"
#import "WEBaseNavigationController.h"

@protocol HCViewControllerTransationDelegate <NSObject>
    
@optional
- (void)disAppearWithAnimate:(BOOL)animated complete:(void (^)(void))complete;
- (void)appearWithAnimate:(BOOL)animated complete:(void (^)(void))complete;
    
@end

@interface WEBaseController : UIViewController

@property (nonatomic, weak) WEBaseNavigationController *customNavigationController;
    
- (void)pushVC:(UIViewController *)dst animated:(BOOL)animated;
- (void)popToVc:(UIViewController *)currentVc animated:(BOOL)animation;
- (void)popVcAnimated:(BOOL)animated;
- (void)popToRootVcAnimated:(BOOL)animation;
    
    /// >>> 自定义 present 事件
- (void)presentVC:(UIViewController *)dst animated:(BOOL)animated completion:(void (^)(void))completion;
    /// >>> present 带动画
- (void)presentVC:(UIViewController *)toVc animationStyle:(AnimationStyle)animationStyle completion:(void (^)(void))completion;
    /// >>> 如果present带动画， dismiss也带动画
- (void)dismissVCWithAnimation:(BOOL)animated completion:(void(^)(void))completion;

    
@end
