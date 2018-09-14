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


#import "AnimationBackBegin.h"
#import "UIView+HHLayout.h"

@implementation AnimationBackBegin

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.frame = transitionContext.containerView.bounds;
    [transitionContext.containerView addSubview:toView];
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    toView.x = toView.width;
    [UIView animateWithDuration:0.3 animations:^{
        toView.x = 0;
        fromView.transform = CGAffineTransformMakeScale(0.93, 0.93);
    } completion:^(BOOL finished) {
        toView.x = 0;
        fromView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}


@end
