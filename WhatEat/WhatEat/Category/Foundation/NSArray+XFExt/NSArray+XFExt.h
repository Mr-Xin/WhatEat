//
//  NSArray+XFExt.h
//  HoldCoin
//
//  Created by 辛峰 on 2018/9/8.
//  Copyright © 2018年 随写. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (XFExt)

/**
 Returns the object located at index, or return nil when out of bounds.
 It's similar to `objectAtIndex:`, but it never throw exception.
 
 @param index The object located at index.
 */
- (nullable id)objectOrNilAtIndex:(NSUInteger)index;

@end
