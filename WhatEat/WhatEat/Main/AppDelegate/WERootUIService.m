//
//  WERootUIService.m
//  WhatEat
//
//  Created by 辛峰 on 2018/9/12.
//  Copyright © 2018年 WhatEat. All rights reserved.
//

#import "WERootUIService.h"
#import "WEBaseNavigationController.h"
#import "WEHomeController.h"

@implementation WERootUIService

WE_EXPORT_SERVICE(HCRootUIService)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    WEWindow *window = [[WEWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    application.delegate.window = window;

    WEHomeController *homeController = [[WEHomeController alloc] init];
    WEBaseNavigationController *rootNav = [[WEBaseNavigationController alloc] initWithRootViewController:homeController];
    window.rootViewController = rootNav;
    [window makeKeyAndVisible];
    
    return YES;
}

@end
