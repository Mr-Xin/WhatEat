//
//  NSObject+XFExt.m
//  HoldCoin
//
//  Created by 辛峰 on 2018/7/19.
//  Copyright © 2018年 随写. All rights reserved.
//

#import "NSObject+XFExt.h"
#include <pthread.h>
#import "HCNotificationDelegateManager.h"

@implementation NSObject (XFExt)

+ (NSString *)className {
    return NSStringFromClass(self);
}

- (NSString *)className {
    return [NSString stringWithUTF8String:class_getName([self class])];
}

- (void)addObserverWithName:(nullable NSNotificationName)aName
          completionHandler:(nullable void (^)(NSNotification * _Nonnull note))completionHandler {
    HCNotificationDelegate *delegate = [[HCNotificationDelegate alloc] init];
    [delegate setCompletionHandler:completionHandler keyName:aName];
    
    [[HCNotificationDelegateManager sharedInstance] addNotificationDelegate:delegate target:self];
}

#pragma mark -
#pragma mark - 通知发送
- (void)postNotificationOnMainThread:(NSNotification *)notification {
    if (pthread_main_np()) return [self postNotification:notification];
    [self postNotificationOnMainThread:notification waitUntilDone:NO];
}

- (void)postNotificationOnMainThread:(NSNotification *)notification waitUntilDone:(BOOL)wait {
    if (pthread_main_np()) return [self postNotification:notification];
    [[self class] performSelectorOnMainThread:@selector(xf_postNotification:) withObject:notification waitUntilDone:wait];
}

- (void)postNotificationOnMainThreadWithName:(NSString *_Nullable)name {
    if (pthread_main_np()) return [self postNotificationName:name object:nil userInfo:nil];
    [self postNotificationOnMainThreadWithName:name object:nil userInfo:nil waitUntilDone:NO];
}

- (void)postNotificationOnMainThreadWithName:(NSString *)name object:(id)object {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:nil];
    [self postNotificationOnMainThreadWithName:name object:object userInfo:nil waitUntilDone:NO];
}

- (void)postNotificationOnMainThreadWithName:(NSString *_Nullable)name
                                    userInfo:(nullable NSDictionary *)userInfo {
    if (pthread_main_np()) return [self postNotificationName:name object:nil userInfo:userInfo];
    [self postNotificationOnMainThreadWithName:name object:nil userInfo:userInfo waitUntilDone:NO];
}

- (void)postNotificationOnMainThreadWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:userInfo];
    [self postNotificationOnMainThreadWithName:name object:object userInfo:userInfo waitUntilDone:NO];
}

- (void)postNotificationOnMainThreadWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo waitUntilDone:(BOOL)wait {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:userInfo];
    NSMutableDictionary *info = [[NSMutableDictionary allocWithZone:nil] initWithCapacity:3];
    if (name) [info setObject:name forKey:@"name"];
    if (object) [info setObject:object forKey:@"object"];
    if (userInfo) [info setObject:userInfo forKey:@"userInfo"];
    [[self class] performSelectorOnMainThread:@selector(xf_postNotificationName:) withObject:info waitUntilDone:wait];
}

- (void)postNotification:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)postNotificationName:(NSNotificationName)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject userInfo:aUserInfo];
}

+ (void)xf_postNotification:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

+ (void)xf_postNotificationName:(NSDictionary *)info {
    NSString *name = [info objectForKey:@"name"];
    id object = [info objectForKey:@"object"];
    NSDictionary *userInfo = [info objectForKey:@"userInfo"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}

#pragma mark -
#pragma mark - 移除
- (void)removeNotificationObserver {
    [[HCNotificationDelegateManager sharedInstance] removeNotificationDelegateWithTarget:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)removeNotificationObserverWithName:(nullable NSNotificationName)aName object:(nullable id)anObject {
    [[HCNotificationDelegateManager sharedInstance] removeNotificationDelegateWithKey:aName target:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:aName object:anObject];
}

- (void)setNotificationDict:(NSMutableDictionary *)notificationDict {
    objc_setAssociatedObject(self, @"notificationDictKey", notificationDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)notificationDict {
    return objc_getAssociatedObject(self, @"notificationDictKey");
}

@end
