//
//  HCNotificationDelegate.m
//  HoldCoin
//
//  Created by 辛峰 on 2018/7/20.
//  Copyright © 2018年 随写. All rights reserved.
//

#import "HCNotificationDelegate.h"

@implementation HCNotificationDelegate

- (void)setCompletionHandler:(void(^)(NSNotification *note))completionHandler keyName:(NSString *)keyName {
    _notificationKey = [NSString stringWithFormat:@"NotificationDelegate_%@",keyName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(blockActionHelper:) name:keyName object:nil];
    
    objc_setAssociatedObject(self, &_notificationKey, completionHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)blockActionHelper:(NSNotification *)note {
    _completionHandler = objc_getAssociatedObject(self, &_notificationKey);
    
    if (_completionHandler) {
        _completionHandler(note);
    }
}

@end
