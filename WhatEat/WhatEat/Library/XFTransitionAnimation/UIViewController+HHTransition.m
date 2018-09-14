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

#import "UIViewController+HHTransition.h"
#import "VCTransitionDelegate.h"
#import <objc/runtime.h>


static char * const transitionDelegateKey = "transitionDelegateKey";
static char * const animationStyleKey     = "animationStyleKey";

@interface UIViewController ()

@property (nonatomic, strong) VCTransitionDelegate *transitionDelegate;

@end


@implementation UIViewController (HHPresent)

+ (void)load
{
    Class class = [self class];
    
    SEL originalSelector = @selector(dismissViewControllerAnimated:completion:);
    SEL swizzledSelector = @selector(xf_dismissViewControllerAnimated:completion:);

    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)setAnimationStyle:(AnimationStyle)animationStyle
{
    objc_setAssociatedObject(self, animationStyleKey, @(animationStyle), OBJC_ASSOCIATION_ASSIGN);
}
- (AnimationStyle)animationStyle
{
    return [objc_getAssociatedObject(self, animationStyleKey) integerValue];
}

- (void)setTransitionDelegate:(VCTransitionDelegate *)transitionDelegate
{
    objc_setAssociatedObject(self, transitionDelegateKey, transitionDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (VCTransitionDelegate *)transitionDelegate
{
    return objc_getAssociatedObject(self, transitionDelegateKey);
}

- (void)xf_presentBackScaleVC:(UIViewController *)controller height:(CGFloat)height completion:(void (^)(void))completion
{
    [self xf_presentVC:controller type:AnimationStyleBackScale height:height point:CGPointZero completion:completion];
}
- (void)xf_presentCircleVC:(UIViewController *)controller point:(CGPoint)point completion:(void (^)(void))completion
{
    [self xf_presentVC:controller type:AnimationStyleCircle height:0 point:point completion:completion];
}
- (void)xf_presentErectVC:(UIViewController * _Nonnull)controller completion:(void (^)(void))completion
{
    [self xf_presentVC:controller type:AnimationStyleErect height:0 point:CGPointZero completion:completion];
}
- (void)xf_presentTiltedVC:(UIViewController * _Nonnull)controller completion:(void (^ __nullable)(void))completion
{
    [self xf_presentVC:controller type:AnimationStyleTilted height:0 point:CGPointZero completion:completion];
}
- (void)xf_presentVC:(UIViewController *)controller type:(AnimationStyle)style height:(CGFloat)height point:(CGPoint)point completion:(void (^)(void))completion
{
    self.transitionDelegate = [VCTransitionDelegate shareInstance];
    self.transitionDelegate.height = height;
    self.transitionDelegate.touchPoint = point;
    controller.animationStyle = style;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.transitioningDelegate = self.transitionDelegate;
    
    [self presentViewController:controller animated:YES completion:completion];
}
- (void)xf_dismissWithPoint:(CGPoint)point completion:(void (^)(void))completion
{
    VCTransitionDelegate *transitionDelegate = self.transitioningDelegate;
    transitionDelegate.touchPoint = point;
    
    [self dismissViewControllerAnimated:YES completion:completion];
}
- (void)xf_dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    if (!animated) {
        [self.presentingViewController resetInitialInfo];
    }
    [self xf_dismissViewControllerAnimated:animated completion:completion];
}
- (void)resetInitialInfo
{
    if (CGPointEqualToPoint(self.view.layer.anchorPoint, CGPointMake(0.5, 0.5))) {
        return;
    }
    self.view.alpha = 1;
    [self.view.layer setTransform:CATransform3DIdentity];
    self.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.view.layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}
- (UIView *)xf_transitionAnimationView{
    return nil;
}
@end


#import "VCInteractionDelegate.h"

static char * const interactionDelegateKey = "interactionDelegateKey";

@interface UINavigationController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) VCInteractionDelegate *interactionDelegate;

@end

@implementation UINavigationController (HHPush)

- (void)setInteractionDelegate:(VCInteractionDelegate *)interactionDelegate
{
    objc_setAssociatedObject(self, interactionDelegateKey, interactionDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (VCInteractionDelegate *)interactionDelegate
{
    return objc_getAssociatedObject(self, interactionDelegateKey);
}

- (void)xf_pushScaleViewController:(UIViewController *)viewController
{
     [self xf_pushViewController:viewController style:AnimationStyleScale];
}
- (void)xf_pushTiltViewController:(UIViewController *)viewController
{
    [self xf_pushViewController:viewController style:AnimationStyleTilted];
}
- (void)xf_pushErectViewController:(UIViewController *)viewController
{
    [self xf_pushViewController:viewController style:AnimationStyleErect];
}
- (void)xf_pushBackViewController:(UIViewController *)viewController
{
    [self xf_pushViewController:viewController style:AnimationStyleBack];
}

- (void)xf_pushViewController:(UIViewController *)viewController style:(AnimationStyle)style
{
    self.interactionDelegate = [VCInteractionDelegate shareInstance];
    self.interactionDelegate.navigation = self;
    viewController.animationStyle = style;
    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self.interactionDelegate action:NSSelectorFromString(@"edgePanAction:")];
    edgePan.edges = UIRectEdgeLeft;
    [viewController.view addGestureRecognizer:edgePan];
    if (self.delegate != self.interactionDelegate) {
        
        self.interactionDelegate.delegate = self.delegate?:nil;
        self.delegate = self.interactionDelegate;
    }
    if ([self isKindOfClass:[WEBaseNavigationController class]]) {
        [self pushViewController:viewController animated:YES];
    } else {
        [customNavigationController customPushViewController:viewController animated:YES];
    }
}

@end

@implementation customNavigationController

+ (void)customPushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    customNavigationController *custom = [[customNavigationController alloc] init];
    [custom pushViewController:viewController animated:YES];
}

@end
