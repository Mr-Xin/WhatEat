//
//                       _oo0oo_
//                      o8888888o
//                      88" . "88
//                      (| -_- |)
//                      0\  =  /0
//                    ___/`---'\___
//                  .' \\|     |// '.
//                 / \\|||  :  |||// \
//                / _||||| -:- |||||- \
//               |   | \\\  -  /// |   |
//               | \_|  ''\---/''  |_/ |
//               \  .-\__  '-'  ___/-. /
//             ___'. .'  /--.--\  `. .'___
//          ."" '<  `.___\_<|>_/___.' >' "".
//         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
//         \  \ `_.   \_ __\ /__ _/   .-` /  /
//     =====`-.____`.___ \_____/___.-`___.-'=====
//                       `=---='
//
//
//     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//               佛祖保佑         永无BUG
//


#import "UIView+HHLayout.h"
#import <objc/runtime.h>

static char * const topConstraintKey        = "topConstraintKey";
static char * const leftConstraintKey       = "leftConstraintKey";
static char * const bottomConstraintKey     = "bottomConstraintKey";
static char * const rightConstraintKey      = "rigthConstraintKey";
static char * const widthConstraintKey      = "widthConstraintKey";
static char * const heightConstraintKey     = "heightConstraintKey";
static char * const leadingConstraintKey    = "leadingConstraintKey";
static char * const trailingConstraintKey   = "trailingConstraintKey";
static char * const centerXConstraintKey    = "centerXConstraintKey";
static char * const centerYConstraintKey    = "centerYConstraintKey";
static char * const layoutArrayMKey         = "layoutArrayMKey";
static char * const equalToArrayMKey        = "equalToArrayMKey";
static char * const offsetArrayMKey         = "offsetArrayMKey";
static char * const relativeViewKey         = "relativeViewKey";

@interface UIView ()

@property (nonatomic, strong) NSLayoutConstraint *xf_topCS;
@property (nonatomic, strong) NSLayoutConstraint *xf_leftCS;
@property (nonatomic, strong) NSLayoutConstraint *xf_bottomCS;
@property (nonatomic, strong) NSLayoutConstraint *xf_rightCS;
@property (nonatomic, strong) NSLayoutConstraint *xf_widthCS;
@property (nonatomic, strong) NSLayoutConstraint *xf_heightCS;
@property (nonatomic, strong) NSLayoutConstraint *xf_leadingCS;
@property (nonatomic, strong) NSLayoutConstraint *xf_trailingCS;
@property (nonatomic, strong) NSLayoutConstraint *xf_centerXCS;
@property (nonatomic, strong) NSLayoutConstraint *xf_centerYCS;

@property (nonatomic, strong) NSMutableArray <NSNumber *>*layoutArrayM;
@property (nonatomic, strong) NSMutableArray <NSNumber *>*equalToArrayM;
@property (nonatomic, strong) NSMutableArray <NSNumber *>*offsetArrayM;
@property (nonatomic, weak)   UIView *relativeView;

@end

@implementation UIView (HHLayout)

- (void)setX:(CGFloat)x
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = x;
    self.frame = tempFrame;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = y;
    self.frame = tempFrame;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}
- (void)setWidth:(CGFloat)width
{
    CGRect tempFrame = self.frame;
    tempFrame.size.width = width;
    self.frame = tempFrame;
}
- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect tempFrame = self.frame;
    tempFrame.size.height = height;
    self.frame = tempFrame;
}
- (CGFloat)height
{
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size
{
    return self.frame.size;
}
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin
{
    return self.frame.origin;
}
- (void)setMaxX:(CGFloat)maxX
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = maxX - self.width;
    self.frame = tempFrame;
}

- (CGFloat)maxX
{
    return self.x+self.width;
}

- (void)setMaxY:(CGFloat)maxY
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = maxY - self.height;
    self.frame = tempFrame;
}
- (CGFloat)maxY
{
    return self.y+self.height;
}
- (CGFloat)centerX
{
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint centerPoint = self.center;
    centerPoint.x = centerX;
    self.center = centerPoint;
}
-(CGFloat)centerY
{
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint centerPoint = self.center;
    centerPoint.y = centerY;
    self.center = centerPoint;
}


- (void)setRelativeView:(UIView *)relativeView
{
    objc_setAssociatedObject(self, relativeViewKey, relativeView, OBJC_ASSOCIATION_ASSIGN);
}
- (UIView *)relativeView
{
    return objc_getAssociatedObject(self, relativeViewKey);
}
- (void)setOffsetArrayM:(NSMutableArray<NSNumber *> *)offsetArrayM
{
    objc_setAssociatedObject(self, offsetArrayMKey, offsetArrayM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray<NSNumber *> *)offsetArrayM
{
   NSMutableArray *offsetArrayM = objc_getAssociatedObject(self, offsetArrayMKey);
    if (offsetArrayM) {
        return offsetArrayM;
    }
    offsetArrayM = [NSMutableArray array];
    self.offsetArrayM = offsetArrayM;
    return offsetArrayM;
}
- (void)setLayoutArrayM:(NSMutableArray<NSNumber *> *)layoutArrayM
{
    objc_setAssociatedObject(self, layoutArrayMKey, layoutArrayM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray<NSNumber *> *)layoutArrayM
{
    NSMutableArray *layoutArrayM = objc_getAssociatedObject(self, layoutArrayMKey);
    if (layoutArrayM) {
        return layoutArrayM;
    }
    layoutArrayM = [NSMutableArray array];
    self.layoutArrayM = layoutArrayM;
    return layoutArrayM;
}
- (void)setEqualToArrayM:(NSMutableArray<NSNumber *> *)equalToArrayM
{
    objc_setAssociatedObject(self, equalToArrayMKey, equalToArrayM, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray<NSNumber *> *)equalToArrayM
{
    NSMutableArray *equalToArrayM = objc_getAssociatedObject(self, equalToArrayMKey);
    if (equalToArrayM) {
        return equalToArrayM;
    }
    equalToArrayM = [NSMutableArray array];
    self.equalToArrayM = equalToArrayM;
    return equalToArrayM;
}
- (void)setxf_topCS:(NSLayoutConstraint *)xf_topCS
{
    objc_setAssociatedObject(self, topConstraintKey, xf_topCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)xf_topCS
{
    return objc_getAssociatedObject(self, topConstraintKey);
}
- (void)setxf_leftCS:(NSLayoutConstraint *)xf_leftCS
{
    objc_setAssociatedObject(self, leftConstraintKey, xf_leftCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)xf_leftCS
{
    return objc_getAssociatedObject(self, leftConstraintKey);
}
- (void)setxf_bottomCS:(NSLayoutConstraint *)xf_bottomCS
{
    objc_setAssociatedObject(self, bottomConstraintKey, xf_bottomCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)xf_bottomCS
{
    return objc_getAssociatedObject(self, bottomConstraintKey);
}
- (void)setxf_rightCS:(NSLayoutConstraint *)xf_rightCS
{
    objc_setAssociatedObject(self, rightConstraintKey, xf_rightCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)xf_rightCS
{
    return objc_getAssociatedObject(self, rightConstraintKey);
}
- (void)setxf_widthCS:(NSLayoutConstraint *)xf_widthCS
{
    objc_setAssociatedObject(self, widthConstraintKey, xf_widthCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)xf_widthCS
{
    return objc_getAssociatedObject(self, widthConstraintKey);
}
- (void)setxf_heightCS:(NSLayoutConstraint *)xf_heightCS
{
    objc_setAssociatedObject(self, heightConstraintKey, xf_heightCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)xf_heightCS
{
    return objc_getAssociatedObject(self, heightConstraintKey);
}
- (void)setxf_leadingCS:(NSLayoutConstraint *)xf_leadingCS
{
    objc_setAssociatedObject(self, leadingConstraintKey, xf_leadingCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)xf_leadingCS
{
     return objc_getAssociatedObject(self, leadingConstraintKey);
}
- (void)setxf_trailingCS:(NSLayoutConstraint *)xf_trailingCS
{
     objc_setAssociatedObject(self, trailingConstraintKey, xf_trailingCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)xf_trailingCS
{
    return objc_getAssociatedObject(self, trailingConstraintKey);
}
- (void)setxf_centerXCS:(NSLayoutConstraint *)xf_centerXCS
{
    objc_setAssociatedObject(self, centerXConstraintKey, xf_centerXCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)xf_centerXCS
{
    return objc_getAssociatedObject(self, centerXConstraintKey);
}
- (void)setxf_centerYCS:(NSLayoutConstraint *)xf_centerYCS
{
    objc_setAssociatedObject(self, centerYConstraintKey, xf_centerYCS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)xf_centerYCS
{
    return objc_getAssociatedObject(self, centerYConstraintKey);
}

- (UIView *)top_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeTop)]) {
        
        [self.layoutArrayM addObject:@(NSLayoutAttributeTop)];
    }
    return self;
}
- (UIView *)left_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeLeft)]) {
        
        [self.layoutArrayM addObject:@(NSLayoutAttributeLeft)];
    }
    return self;
}
- (UIView *)bott_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeBottom)]) {
            [self.layoutArrayM addObject:@(NSLayoutAttributeBottom)];
    }
    return self;
}
- (UIView *)righ_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeRight)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeRight)];
    }
    return self;
}
- (UIView *)widt_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeWidth)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeWidth)];
    }
    return self;
}
- (UIView *)heit_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeHeight)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeHeight)];
    }
    return self;
}
- (UIView *)lead_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeLeading)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeLeading)];
    }
    return self;
}
- (UIView *)trai_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeTrailing)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeTrailing)];
    }
    return self;
}
- (UIView *)cent_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeCenterX)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeCenterX)];
    }
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeCenterY)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeCenterY)];
    }
    return self;
}
- (UIView *)centX
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeCenterX)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeCenterX)];
    }
    return self;
}
- (UIView *)centY
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeCenterY)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeCenterY)];
    }
    return self;
}
- (UIView *)size_
{
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeWidth)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeWidth)];
    }
    if (![self.layoutArrayM containsObject:@(NSLayoutAttributeHeight)]) {
        [self.layoutArrayM addObject:@(NSLayoutAttributeHeight)];
    }
    return self;
}

- (UIView *(^)(UIView *))equalTo
{
    return ^UIView *(UIView *view){
        self.relativeView = view;
        return self;
    };
}

- (UIView *(^)(CGFloat))constant
{
    return ^UIView *(CGFloat equal){
        
        [self.equalToArrayM addObject:@(equal)];
        return self;
    };
}

- (UIView *(^)(NSNumber *, ...))constList
{
    return ^UIView *(NSNumber *first,...){
        va_list args;
        va_start(args, first);
        for (NSNumber *constant = first; constant!=nil&&[constant isKindOfClass:[NSNumber class]]; constant = va_arg(args, NSNumber *)) {
            [self.equalToArrayM addObject:constant];
        }
        va_end(args);
        return self;
    };
}

- (UIView *(^)(CGFloat))offset
{
    return ^UIView *(CGFloat offset){
        
        [self.offsetArrayM addObject:@(offset)];
        return self;
    };
}

- (UIView *(^)(CGRect))topLeft_
{
    return ^UIView *(CGRect rect){
        self.top_.left_.widt_.heit_.
        constant(rect.origin.y).constant(rect.origin.x).
        constant(rect.size.width).constant(rect.size.height).
        install();
        return self;
    };
}
- (UIView *(^)(CGRect))topRight_
{
    return ^UIView *(CGRect rect){
        self.top_.righ_.widt_.heit_.
        constant(rect.origin.y).constant(-rect.origin.x).
        constant(rect.size.width).constant(rect.size.height).
        install();
        return self;
    };
}

- (UIView *(^)(CGRect))bottomLeft_
{
    return ^UIView *(CGRect rect){
        self.bott_.left_.widt_.heit_.
        constant(-rect.origin.y).constant(rect.origin.x).
        constant(rect.size.width).constant(rect.size.height).
        install();
        return self;
    };
}
- (UIView *(^)(CGRect))bottomRight_
{
    return ^UIView *(CGRect rect){
        self.bott_.righ_.widt_.heit_.
        constant(-rect.origin.y).constant(-rect.origin.x).
        constant(rect.size.width).constant(rect.size.height).
        install();
        return self;
    };
}
- (UIView *(^)(CGRect))heightTop_
{
    return ^UIView *(CGRect rect){
        self.top_.left_.heit_.righ_.
        constant(rect.origin.y).constant(rect.origin.x).
        constant(rect.size.height).constant(-rect.size.width).
        install();
        return self;
    };
}
- (UIView *(^)(CGRect))heightBottom_
{
    return ^UIView *(CGRect rect){
        self.bott_.left_.heit_.righ_.
        constant(rect.origin.y).constant(rect.origin.x).
        constant(rect.size.height).constant(-rect.size.width).
        install();
        return self;
    };
}
- (UIView *(^)(CGRect))insetFrame_
{
    return ^UIView *(CGRect rect){
        self.top_.left_.bott_.righ_.
        constant(rect.origin.y).constant(rect.origin.x).
        constant(-rect.size.width).constant(-rect.size.height).
        install();
        return self;
    };
}
- (UIView *(^)(void))around_
{
    return ^UIView *(){
        self.left_.top_.bott_.righ_.mas_equalTo(self.superview).install();
        return self;
    };
}

- (UIView *(^)(void))install
{
    return ^UIView *(){
        [self installAllConstraint];
        [self resetInitialInfo];
        return self;
    };
}

- (void)resetInitialInfo
{
    [self.equalToArrayM removeAllObjects];
    [self.offsetArrayM removeAllObjects];
    [self.layoutArrayM removeAllObjects];
    if (self.relativeView) {
        [self.relativeView.equalToArrayM removeAllObjects];
        [self.relativeView.offsetArrayM removeAllObjects];
        [self.relativeView.layoutArrayM removeAllObjects];
        self.relativeView.layoutArrayM = nil;
        self.relativeView.offsetArrayM = nil;
        self.relativeView.equalToArrayM = nil;
        self.relativeView = nil;
    }
}

- (void)installAllConstraint
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    if (self.relativeView) {
        int index = -1;
        for (int i = 0; i<self.layoutArrayM.count; i++) {
            NSInteger relative = self.relativeView.layoutArrayM.count>i?self.relativeView.layoutArrayM[i].integerValue:self.layoutArrayM[i].integerValue;
            CGFloat constant = self.offsetArrayM.count>i?[self countConstant:i index:&index]:index==-1?self.equalToArrayM.count>i?self.equalToArrayM[i].floatValue:0.0f:self.equalToArrayM.count>=i-index?self.equalToArrayM[i-index-1].floatValue:0.0f;
            [self readyDeploy:self.layoutArrayM[i].integerValue relative:relative view:self.relativeView equalTo:constant];
        }
    }else if (self.equalToArrayM.count) {
        for (int i = 0; i<self.layoutArrayM.count; i++) {
            CGFloat constant = self.equalToArrayM.count>i?self.equalToArrayM[i].floatValue:self.equalToArrayM.lastObject.floatValue;
            [self readyDeploy:self.layoutArrayM[i].integerValue relative:self.layoutArrayM[i].integerValue view:nil equalTo:constant];
        }
    }
}
- (CGFloat)countConstant:(int)i index:(int *)index
{
    *index = i;
    return self.offsetArrayM[i].floatValue;
}

- (void)readyDeploy:(NSInteger)source relative:(NSInteger)relative view:(UIView *)view equalTo:(CGFloat)constant
{
    switch (source) {
        case NSLayoutAttributeLeft:
        {
            if(self.xf_leftCS){[self.superview removeConstraint:self.xf_leftCS];}
            self.xf_leftCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:(NSLayoutRelationEqual) toItem:view?:self.superview attribute:relative multiplier:1.0 constant:constant];
            [self.superview addConstraint:self.xf_leftCS];
        }
            break;
        case NSLayoutAttributeRight:
        {
            if(self.xf_rightCS){[self.superview removeConstraint:self.xf_rightCS];}
            self.xf_rightCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:(NSLayoutRelationEqual) toItem:view?:self.superview attribute:relative multiplier:1.0 constant:constant];
            [self.superview addConstraint:self.xf_rightCS];
        }
            break;
        case NSLayoutAttributeTop:
        {
            if(self.xf_topCS){[self.superview removeConstraint:self.xf_topCS];}
            self.xf_topCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:(NSLayoutRelationEqual) toItem:view?:self.superview attribute:relative multiplier:1.0 constant:constant];
            [self.superview addConstraint:self.xf_topCS];
        }
            break;
        case NSLayoutAttributeBottom:
        {
            if(self.xf_bottomCS){[self.superview removeConstraint:self.xf_bottomCS];}
            self.xf_bottomCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:(NSLayoutRelationEqual) toItem:view?:self.superview attribute:relative multiplier:1.0 constant:constant];
            [self.superview addConstraint:self.xf_bottomCS];
        }
            break;
        case NSLayoutAttributeLeading:
        {
            if(self.xf_leadingCS){[self.superview removeConstraint:self.xf_leadingCS];}
            self.xf_leadingCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:(NSLayoutRelationEqual) toItem:view?:self.superview attribute:relative multiplier:1.0 constant:constant];
            [self.superview addConstraint:self.xf_leadingCS];
        }
            break;
        case NSLayoutAttributeTrailing:
        {
            if(self.xf_trailingCS){[self.superview removeConstraint:self.xf_trailingCS];}
            self.xf_trailingCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:(NSLayoutRelationEqual) toItem:view?:self.superview attribute:relative multiplier:1.0 constant:constant];
            [self.superview addConstraint:self.xf_trailingCS];
        }
            break;
        case NSLayoutAttributeWidth:
        {
            if(self.xf_widthCS){[self.equalToArrayM.count&&constant?self:view?self.superview:self removeConstraint:self.xf_widthCS];}
            self.xf_widthCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:(NSLayoutRelationEqual) toItem:self.equalToArrayM.count&&constant?nil:view?:nil attribute:relative multiplier:1.0 constant:constant];
            [self.equalToArrayM.count&&constant?self:view?self.superview:self addConstraint:self.xf_widthCS];
        }
            break;
        case NSLayoutAttributeHeight:
        {
            if(self.xf_heightCS){[self.equalToArrayM.count&&constant?self:view?self.superview:self removeConstraint:self.xf_heightCS];}
            self.xf_heightCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:(NSLayoutRelationEqual) toItem:self.equalToArrayM.count&&constant?nil:view?:nil attribute:relative multiplier:1.0 constant:constant];
            [self.equalToArrayM.count&&constant?self:view?self.superview:self addConstraint:self.xf_heightCS];
        }
            break;
        case NSLayoutAttributeCenterX:
        {
            if(self.xf_centerXCS){[self.superview removeConstraint:self.xf_centerXCS];}
            self.xf_centerXCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:(NSLayoutRelationEqual) toItem:view attribute:relative multiplier:1.0 constant:constant];
            [self.superview addConstraint:self.xf_centerXCS];
        }
            break;
        case NSLayoutAttributeCenterY:
        {
            if(self.xf_centerYCS){[self.superview removeConstraint:self.xf_centerYCS];}
            self.xf_centerYCS = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:(NSLayoutRelationEqual) toItem:view attribute:relative multiplier:1.0 constant:constant];
            [self.superview addConstraint:self.xf_centerYCS];
        }
            break;
            
        default:
            break;
    }
}

@end
