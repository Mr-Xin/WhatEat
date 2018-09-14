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


#import "AnimationErectBegin.h"
#import "UIView+HHLayout.h"

@interface AnimationErectBegin()

@property (nonatomic, assign) BOOL isInteraction;

@end

@implementation AnimationErectBegin

+ (instancetype)animationIsInteraction:(BOOL)isSure
{
    AnimationErectBegin *erectBegin = [AnimationErectBegin new];
    erectBegin.isInteraction = isSure;
    return erectBegin;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [transitionContext.containerView addSubview:toView];
    toView.frame = transitionContext.containerView.bounds;
    toView.layer.anchorPoint = CGPointMake(0, 0.5);
    toView.layer.position = CGPointMake(toView.width, toView.height * 0.5);
    if (!self.isInteraction) {
        CATransform3D identity = CATransform3DIdentity;
        identity.m34 = -1.0 / 500.0;
        CATransform3D rotateTransform = CATransform3DRotate(identity, M_PI/3, 0, 1, 0);
        toView.layer.transform = rotateTransform;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        if (!self.isInteraction) {
            
            toView.layer.transform = CATransform3DIdentity;
        }
        toView.layer.position = CGPointMake(0, toView.height * 0.5);
    } completion:^(BOOL finished) {
        
        toView.layer.transform = CATransform3DIdentity;
        toView.layer.position = CGPointMake(toView.width*0.5, toView.height * 0.5);
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}


@end
