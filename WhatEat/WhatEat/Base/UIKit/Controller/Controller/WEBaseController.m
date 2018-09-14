//
//  EWBaseController.m
//  WhatEat
//
//  Created by 辛峰 on 2018/9/13.
//  Copyright © 2018年 WhatEat. All rights reserved.
//

#import "WEBaseController.h"
#import "UIViewController+HHTransition.h"

@interface WEBaseController ()

@end

@implementation WEBaseController


#pragma mark -
#pragma mark - Public Method
    
- (void)pushVC:(UIViewController *)dst animated:(BOOL)animated {
    if (!dst) {
        return;
    }
    
    [self.navigationController pushViewController:dst animated:animated];
}
    
- (void)popToVc:(UIViewController *)currentVc animated:(BOOL)animation {
    NSArray *childs = self.navigationController.viewControllers;
    if ([childs containsObject:currentVc]) {
        [self removeNotificationObserver];
        [self.navigationController popToViewController:currentVc animated:animation];
    }
}
    
- (void)popVcAnimated:(BOOL)animated {
    [self removeNotificationObserver];
    if(self.navigationController) {
        [self.navigationController popViewControllerAnimated:animated];
    } else {
        [self dismissViewControllerAnimated:animated completion:nil];
    }
}
    
- (void)popToRootVcAnimated:(BOOL)animation {
    [self removeNotificationObserver];
    [self.navigationController popToRootViewControllerAnimated:animation];
}
    
    /// >>> 自定义 present 事件
- (void)presentVC:(UIViewController *)dst animated:(BOOL)animated completion:(void (^)(void))completion {
    [self presentVC:dst animationStyle:AnimationStyleNoAnimation completion:completion];
}
    
    /// >>> present 带动画
- (void)presentVC:(UIViewController *)toVc animationStyle:(AnimationStyle)animationStyle completion:(void (^)(void))completion {
    [self analysisPresentVC:toVc animationStyle:animationStyle completion:completion];
}
    /// >>> 如果present带动画， dismiss也带动画
- (void)dismissVCWithAnimation:(BOOL)animated completion:(void(^)(void))completion {
    [self dismissViewControllerAnimated:animated completion:completion];
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /// >>> 隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
    
#pragma mark -
#pragma mark - Private Method
- (void)analysisPresentVC:(UIViewController *)toVc animationStyle:(AnimationStyle)animationStyle completion:(void (^)(void))completion {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if (animationStyle == AnimationStyleCircle) {
        [self xf_presentCircleVC:toVc point:CGPointMake(screenWidth / 2, screenHeight / 2) completion:completion];
    } else if (animationStyle == AnimationStyleBackScale) {
        [self xf_presentBackScaleVC:toVc height:screenHeight - 80 completion:completion];
    } else if (animationStyle == AnimationStyleErect) {
        [self xf_presentErectVC:toVc completion:completion];
    } else if (animationStyle == AnimationStyleTilted) {
        [self xf_presentTiltedVC:toVc completion:completion];
    } else if (animationStyle == AnimationStyleNone) {
        [self presentViewController:toVc animated:YES completion:completion];
    }
}
    
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
