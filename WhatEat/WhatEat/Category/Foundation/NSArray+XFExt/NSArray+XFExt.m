//
//  NSArray+XFExt.m
//  HoldCoin
//
//  Created by 辛峰 on 2018/9/8.
//  Copyright © 2018年 随写. All rights reserved.
//

#import "NSArray+XFExt.h"

@implementation NSArray (XFExt)

- (id)objectOrNilAtIndex:(NSUInteger)index {
    return index < self.count ? self[index] : nil;
}

@end
