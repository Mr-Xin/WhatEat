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


#import "AnimationTiltBegin.h"

@implementation AnimationTiltBegin

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.frame = transitionContext.containerView.bounds;
    
    toView.layer.anchorPoint = CGPointMake(0.5, 1.5);
    toView.layer.position = CGPointMake(toView.bounds.size.width * 0.5, toView.bounds.size.height * 1.5);
    [transitionContext.containerView addSubview:toView];
    toView.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    [UIView animateWithDuration:0.3 animations:^{
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.position = CGPointMake(toView.bounds.size.width * 0.5, toView.bounds.size.height * 0.5);
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
