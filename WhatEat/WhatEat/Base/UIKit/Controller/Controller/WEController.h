//
//  WEController.h
//  WhatEat
//
//  Created by 辛峰 on 2018/9/13.
//  Copyright © 2018年 WhatEat. All rights reserved.
//

#import "WEBaseController.h"
#import "WENavigationView.h"

@interface WEController : WEBaseController

@property (nonatomic, weak) WENavigationView *navigationView;
    
/// >>> 获取当前类名
+ (NSString *)getCurrentClassName;
    
/// >>> 更新当前皮肤
- (void)updateSkinMode;
    
/// >>> 自定义方法
- (void)setupBaseData;
- (void)setupLayout;
- (void)setupNavigationBar;
- (void)setupNotification;
    
    /// >>> Router Init
+ (id)routerCreateControllerInstance:(NSDictionary *)params;
    
@end
