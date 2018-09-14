//
//  WEBaseAppDelegate.h
//  WhatEat
//
//  Created by 辛峰 on 2018/9/12.
//  Copyright © 2018年 WhatEat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "WEWindow.h"
#import "WEAppServiceManager.h"

@interface WEBaseAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) WEWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

@end
