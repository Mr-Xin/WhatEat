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


#import "AnimationTransitionEnd.h"

@interface AnimationTransitionEnd()<CAAnimationDelegate>

@property (nonatomic, assign) AnimationStyle style;
@property (nonatomic, strong) id<UIViewControllerContextTransitioning>transitionContext;

@end

@implementation AnimationTransitionEnd

+ (instancetype)animationStyle:(AnimationStyle)style
{
    AnimationTransitionEnd *animation = [AnimationTransitionEnd new];
    animation.style = style;
    return animation;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.frame = transitionContext.containerView.bounds;
    [transitionContext.containerView addSubview:toView];
    
    self.transitionContext = transitionContext;
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    switch (_style) {
        case AnimationStyleCube:{
            animation.type = @"cube";
            animation.subtype = kCATransitionFromLeft;
        }
            break;
        case AnimationStyleSuckEffect:{
            animation.type = @"suckEffect";
        }
            break;
        case AnimationStyleOglFlip:{
            animation.type = @"oglFlip";
            animation.subtype = kCATransitionFromRight;
        }
            break;
        case AnimationStyleRippleEffect:{
            animation.type = @"rippleEffect";
        }
            break;
        case AnimationStylePageCurl:{
            animation.type = @"pageCurl";
            animation.subtype = kCATransitionFromLeft;
        }
            break;
        case AnimationStyleCameralIrisHollowOpen:{
            animation.type = @"cameralIrisHollowOpen";
        }
            break;
        default:
            break;
    }
    
    [transitionContext.containerView.layer addAnimation:animation forKey:@"AnimationTransitionEnd"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    flag?[self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled]:nil;
}


@end
