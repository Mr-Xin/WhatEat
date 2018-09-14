//
//  WEAppServiceManager.h
//  WhatEat
//
//  Created by 辛峰 on 2018/9/12.
//  Copyright © 2018年 WhatEat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define WE_EXPORT_SERVICE(name) \
+ (void)load {[[WEAppServiceManager sharedManager] registerService:[self new]];} \
- (NSString *)serviceName { return @#name; }

NS_ASSUME_NONNULL_BEGIN

@protocol WEAppService <UIApplicationDelegate>

@required

- (NSString *)serviceName;

@end

@interface WEAppServiceManager : NSObject

+ (instancetype)sharedManager;

- (void)registerService:(id<WEAppService>)service;

- (BOOL)proxyCanResponseToSelector:(SEL)aSelector;
- (void)proxyForwardInvocation:(NSInvocation *)anInvocation;

@end

NS_ASSUME_NONNULL_END
