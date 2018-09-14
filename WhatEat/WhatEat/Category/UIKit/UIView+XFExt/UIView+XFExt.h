





#import <UIKit/UIKit.h>

@interface UIView (XFExt)

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;

#pragma mark -
#pragma mark - 截屏
- (nullable NSData *)snapshotPDF;
- (nullable UIImage *)snapshotImage;
- (nullable UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

#pragma mark -
#pragma mark - 设置阴影
- (void)setLayerShadow:(nullable UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

#pragma mark -
#pragma mark - 移除所有子视图
- (void)removeAllSubviews;

#pragma mark -
#pragma mark - 获取当前view的控制器
@property (nullable, nonatomic, readonly) UIViewController *viewController;

#pragma mark -
#pragma mark - 点坐标转换
- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view;
- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(nullable UIView *)view;

#pragma mark -
#pragma mark - 范围坐标转换
- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;
- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view;

@end
