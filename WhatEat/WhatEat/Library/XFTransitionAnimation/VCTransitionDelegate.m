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
#import "AnimationFadeBegin.h"
#import "AnimationFadeEnd.h"
#import "AnimationWaveBegin.h"
#import "AnimationWaveEnd.h"
#import "AnimationErectBegin.h"
#import "AnimationErectEnd.h"
#import "AnimationTiltBegin.h"
#import "AnimationTildEnd.h"

@implementation VCTransitionDelegate

+ (instancetype)shareInstance
{
    static VCTransitionDelegate *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [VCTransitionDelegate new];
    });
    return _instance;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    id<UIViewControllerAnimatedTransitioning> objc = nil;
    switch (presented.animationStyle) {
        case AnimationStyleBackScale:
            objc = [AnimationFadeBegin animationHeight:_height];
            break;
        case AnimationStyleCircle:
            objc = [AnimationWaveBegin animationOrigin:_touchPoint];
            break;
        case AnimationStyleErect:
            objc = [AnimationErectBegin animationIsInteraction:NO];
            break;
        case AnimationStyleTilted:
            objc = [AnimationTiltBegin new];
            break;
        default:
            break;
    }
    return objc;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    id<UIViewControllerAnimatedTransitioning> objc = nil;
    switch (dismissed.animationStyle) {
        case AnimationStyleBackScale:
            objc = [AnimationFadeEnd animationHeight:_height];
            break;
        case AnimationStyleCircle:
            objc = [AnimationWaveEnd animationOrigin:_touchPoint];
            break;
        case AnimationStyleErect:
            objc = [AnimationErectEnd new];
            break;
        case AnimationStyleTilted:
            objc = [AnimationTildEnd new];
            break;
        default:
            break;
    }
    return objc;
}

@end
