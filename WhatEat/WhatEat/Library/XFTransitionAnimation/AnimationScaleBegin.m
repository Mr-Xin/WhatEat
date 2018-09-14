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


#import "AnimationScaleBegin.h"
#import "UIViewController+HHTransition.h"
#import "UIView+HHLayout.h"

@implementation AnimationScaleBegin

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (![self responseToSel:@[fromVC,toVC]]) {
        [transitionContext completeTransition:YES];
        return;
    }
    UIColor *containerViewColor = [transitionContext containerView].backgroundColor;
    [transitionContext containerView].backgroundColor = [UIColor whiteColor];
    [[transitionContext containerView] addSubview:toVC.view];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    UIView *sourceView = [fromVC xf_transitionAnimationView];
    UIView *destinationView = [toVC xf_transitionAnimationView];
    if (!sourceView || !destinationView) {
        [transitionContext completeTransition:YES];
        return;
    }
    CGPoint sourcePoint = [sourceView convertPoint:CGPointZero toView:nil];
    CGPoint destinationPoint = [destinationView convertPoint:CGPointZero toView:nil];
    
    UIView *snapShot = [sourceView snapshotViewAfterScreenUpdates:NO];
    [[transitionContext containerView] addSubview:snapShot];
    snapShot.origin = sourcePoint;
    CGFloat heightScale = destinationView.height/sourceView.height;
    CGFloat widthScale = destinationView.width/sourceView.width;
    
    CGRect originFrame = fromView.frame;
    toView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        
        snapShot.transform =  CGAffineTransformMakeScale(widthScale,heightScale);
        snapShot.origin = destinationPoint;
        fromView.alpha = 0;
        fromView.transform = snapShot.transform;
        fromView.origin = CGPointMake((destinationPoint.x - sourcePoint.x)*widthScale, (destinationPoint.y - sourcePoint.y)*heightScale);
        
    } completion:^(BOOL finished) {
        [transitionContext containerView].backgroundColor = containerViewColor;
        [snapShot removeFromSuperview];
        toView.hidden = NO;
        fromView.alpha = 1;
        fromView.transform = CGAffineTransformIdentity;
        fromView.frame = originFrame;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (BOOL)responseToSel:(NSArray <UIViewController *>*)array
{
    if (!array.count) {
        return NO;
    }
    for (UIViewController *vc in array) {
        if (![vc respondsToSelector:@selector(xf_transitionAnimationView)]) {
            return NO;
        }
    }
    return YES;
}

@end
