//
//  NSDate+XFExt.m
//  HoldCoin
//
//  Created by 辛峰 on 2018/9/8.
//  Copyright © 2018年 随写. All rights reserved.
//

#import "NSDate+XFExt.h"

@implementation NSDate (XFExt)

- (NSString *)stringWithCNFormat{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyy年MM月dd日 HH:mm";
    });
    return [formatter stringFromDate:self];
}

@end
