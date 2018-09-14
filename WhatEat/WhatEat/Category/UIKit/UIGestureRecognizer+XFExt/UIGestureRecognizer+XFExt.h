





#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (XFExt)

- (instancetype)initWithActionBlock:(void (^)(id sender))block;

- (void)addActionBlock:(void (^)(id sender))block;

- (void)removeAllActionBlocks;


@end
