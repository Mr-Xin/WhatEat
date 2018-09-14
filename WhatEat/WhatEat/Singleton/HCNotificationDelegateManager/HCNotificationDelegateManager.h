//
//  HCNotificationDelegateManager.h
//  HoldCoin
//
//  Created by 辛峰 on 2018/7/20.
//  Copyright © 2018年 随写. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCNotificationDelegate.h"

@interface HCNotificationDelegateManager : NSObject

@property (nonatomic, strong) NSMutableDictionary *notificationDict;

+ (HCNotificationDelegateManager *)sharedInstance;

- (void)addNotificationDelegate:(HCNotificationDelegate *)delegate target:(id)target;
- (void)removeNotificationDelegateWithTarget:(id)target;
- (void)removeNotificationDelegateWithKey:(NSString *)keyName target:(id)target;

@end
