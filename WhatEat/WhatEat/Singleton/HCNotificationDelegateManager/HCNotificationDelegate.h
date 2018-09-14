//
//  HCNotificationDelegate.h
//  HoldCoin
//
//  Created by 辛峰 on 2018/7/20.
//  Copyright © 2018年 随写. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCNotificationDelegate : NSObject

@property (nonatomic, copy) void(^completionHandler)(NSNotification *note);
@property (nonatomic, copy) NSString *notificationKey;

- (void)setCompletionHandler:(void(^)(NSNotification *note))completionHandler keyName:(NSString *)keyName;

@end
