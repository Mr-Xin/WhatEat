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


#import <UIKit/UIKit.h>
#import "UIView+HHLayout.h"
#import "AnimationStyle.h"
#import "WEBaseNavigationController.h"

@interface UIViewController (HHPresent)

@property (nonatomic, assign) AnimationStyle animationStyle;

/**
 背部缩隐式

 @param controller 控制器
 @param height 控制器高度
 @param completion 回调函数
 */
- (void)xf_presentBackScaleVC:(UIViewController * _Nonnull)controller height:(CGFloat)height completion:(void (^ __nullable)(void))completion;

/**
 圆形放大式
 
 @param controller 控制器
 @param point 触摸点
 @param completion 回调函数
 */
- (void)xf_presentCircleVC:(UIViewController * _Nonnull)controller point:(CGPoint)point completion:(void (^ __nullable)(void))completion;

/**
 旋转样式
 
 @param controller 控制器
 @param completion 回调函数
 */
- (void)xf_presentTiltedVC:(UIViewController * _Nonnull)controller completion:(void (^ __nullable)(void))completion;

/**
 垂直折叠式
 
 @param controller 控制器
 @param completion 回调函数
 */
- (void)xf_presentErectVC:(UIViewController * _Nonnull)controller completion:(void (^ __nullable)(void))completion;

/**
 圆形放大式自定义结束触摸点

 @param point 触摸点
 @param completion 回调函数
 */
- (void)xf_dismissWithPoint:(CGPoint)point completion:(void (^ __nullable)(void))completion;

/**
 pushScale转场控制器重写
 
 @return 转场视图
 */
- (UIView *_Nonnull)xf_transitionAnimationView;//need to override

@end


@interface UINavigationController (HHPush)

/**
 CATransitin转场动画
 
 @param viewController 转场控制器
 @param style 转场类型
 */
- (void)xf_pushViewController:(UIViewController * _Nonnull)viewController style:(AnimationStyle)style;

/**
 连续转场动画，需要实现方法`xf_transitionAnimationView`传递视图
 
 @param viewController 转场控制器
 */
- (void)xf_pushScaleViewController:(UIViewController * _Nonnull)viewController;

/**
 倾斜转场动画

 @param viewController 转场控制器
 */
- (void)xf_pushTiltViewController:(UIViewController * _Nonnull)viewController;

/**
 垂直转场动画
 
 @param viewController 转场控制器
 */
- (void)xf_pushErectViewController:(UIViewController * _Nonnull)viewController;

/**
 缩放转场动画
 
 @param viewController 转场控制器
 */
- (void)xf_pushBackViewController:(UIViewController * _Nonnull)viewController;


@end

@interface customNavigationController : UINavigationController

+ (void)customPushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
