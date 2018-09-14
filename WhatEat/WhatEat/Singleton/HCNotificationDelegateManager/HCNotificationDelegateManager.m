//
//  HCNotificationDelegateManager.m
//  HoldCoin
//
//  Created by 辛峰 on 2018/7/20.
//  Copyright © 2018年 随写. All rights reserved.
//

#import "HCNotificationDelegateManager.h"

@implementation HCNotificationDelegateManager

static HCNotificationDelegateManager *_instance = nil;

- (void)addNotificationDelegate:(HCNotificationDelegate *)delegate target:(id)target {
    if (!self.notificationDict) {
        self.notificationDict = [[NSMutableDictionary alloc] initWithCapacity:1];
    }
    
    NSMutableDictionary *tempDict;
    if ([self.notificationDict objectForKey:NSStringFromClass([target class])]) {
        tempDict = [self.notificationDict objectForKey:NSStringFromClass([target class])];
    } else {
        tempDict = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    
    [tempDict setValue:delegate forKey:delegate.notificationKey];
    
    [self.notificationDict setValue:tempDict forKey:NSStringFromClass([target class])];
}

- (void)removeNotificationDelegateWithTarget:(id)target {
    [self.notificationDict removeObjectForKey:NSStringFromClass([target class])];
}

- (void)removeNotificationDelegateWithKey:(NSString *)keyName target:(id)target {
    NSMutableDictionary *tempDict = [self.notificationDict objectForKey:NSStringFromClass([target class])];
    [tempDict removeObjectForKey:keyName];
    
    [self.notificationDict setValue:tempDict forKey:NSStringFromClass([target class])];
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
            _instance.notificationDict = [NSMutableDictionary dictionaryWithCapacity:1];
        }
    });
    return _instance;
}

- (id)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
        _instance.notificationDict = [NSMutableDictionary dictionaryWithCapacity:1];
    });
    return _instance;
}

+ (HCNotificationDelegateManager *)sharedInstance {
    return [[self alloc] init];
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

@end
