//
//  WEBaseNavigationController.h
//  WhatEat
//
//  Created by 辛峰 on 2018/9/12.
//  Copyright © 2018年 WhatEat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationStyle.h"

@interface WEBaseNavigationController : UINavigationController

- (void)pushViewController:(UIViewController *)viewController animatedStyle:(AnimationStyle)animatedStyle;
    
@end
