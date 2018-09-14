//
//  UITableView+XFExt.h
//  HoldCoin
//
//  Created by 辛峰 on 2018/9/8.
//  Copyright © 2018年 随写. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (XFExt)

/**
 Reloads the specified section using a given animation effect.
 
 @param section    An index identifying the section to reload.
 
 @param animation  A constant that indicates how the reloading is to be animated,
 for example, fade out or slide out from the bottom. The
 animation constant affects the direction in which both the
 old and the new section rows slide. For example, if the
 animation constant is UITableViewRowAnimationRight, the old
 rows slide out to the right and the new cells slide in from the right.
 */
- (void)reloadSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

@end
