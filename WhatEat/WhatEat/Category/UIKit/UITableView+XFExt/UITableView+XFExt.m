//
//  UITableView+XFExt.m
//  HoldCoin
//
//  Created by 辛峰 on 2018/9/8.
//  Copyright © 2018年 随写. All rights reserved.
//

#import "UITableView+XFExt.h"

@implementation UITableView (XFExt)

- (void)reloadSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    [self reloadSections:indexSet withRowAnimation:animation];
}

@end
