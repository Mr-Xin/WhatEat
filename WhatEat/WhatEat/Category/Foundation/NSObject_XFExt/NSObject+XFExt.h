//
//  NSObject+XFExt.h
//  HoldCoin
//
//  Created by 辛峰 on 2018/7/19.
//  Copyright © 2018年 随写. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XFExt)

/**
 Returns the class name in NSString.
 */
+ (NSString *_Nonnull)className;

/**
 Returns the class name in NSString.
 
 @discussion Apple has implemented this method in NSObject(NSLayoutConstraintCallsThis),
 but did not make it public.
 */
- (NSString *_Nonnull)className;

#pragma mark -
#pragma mark - 添加
- (void)addObserverWithName:(nullable NSNotificationName)aName
          completionHandler:(nullable void (^)(NSNotification * _Nonnull note))completionHandler;

#pragma mark -
#pragma mark - 发送通知
- (void)postNotificationOnMainThread:(NSNotification *_Nullable)notification;

- (void)postNotificationOnMainThread:(NSNotification *_Nullable)notification
                       waitUntilDone:(BOOL)wait;

- (void)postNotificationOnMainThreadWithName:(NSString *_Nullable)name;
- (void)postNotificationOnMainThreadWithName:(NSString *_Nullable)name
                                      object:(nullable id)object;
- (void)postNotificationOnMainThreadWithName:(NSString *_Nullable)name
                                      userInfo:(nullable NSDictionary *)userInfo;

- (void)postNotificationOnMainThreadWithName:(NSString *_Nullable)name
                                      object:(nullable id)object
                                    userInfo:(nullable NSDictionary *)userInfo;

- (void)postNotificationOnMainThreadWithName:(NSString *_Nullable)name
                                      object:(nullable id)object
                                    userInfo:(nullable NSDictionary *)userInfo
                               waitUntilDone:(BOOL)wait;
#pragma mark -
#pragma mark - 移除
- (void)removeNotificationObserver;
- (void)removeNotificationObserverWithName:(nullable NSNotificationName)aName object:(nullable id)anObject;
@end
