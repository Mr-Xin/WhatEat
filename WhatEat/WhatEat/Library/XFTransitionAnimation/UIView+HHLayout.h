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

@interface UIView (HHLayout)

/**
 非约束方式
 */
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/**
 约束方式
 */

@property (nonatomic, assign, readonly) UIView * top_;
@property (nonatomic, assign, readonly) UIView * left_;
@property (nonatomic, assign, readonly) UIView * bott_;
@property (nonatomic, assign, readonly) UIView * righ_;
@property (nonatomic, assign, readonly) UIView * widt_;
@property (nonatomic, assign, readonly) UIView * heit_;
@property (nonatomic, assign, readonly) UIView * lead_;
@property (nonatomic, assign, readonly) UIView * trai_;
@property (nonatomic, assign, readonly) UIView * cent_;
@property (nonatomic, assign, readonly) UIView * centX;
@property (nonatomic, assign, readonly) UIView * centY;
@property (nonatomic, assign, readonly) UIView * size_;
@property (nonatomic, assign, readonly) UIView * (^equalTo)(UIView *);
@property (nonatomic, assign, readonly) UIView * (^constant)(CGFloat);
@property (nonatomic, assign, readonly) UIView * (^constList)(NSNumber *,...);//需要以nil结尾
@property (nonatomic, assign, readonly) UIView * (^offset)(CGFloat);
@property (nonatomic, assign, readonly) UIView * (^install)(void);


/**
 快速添加约束
 */
@property (nonatomic, assign, readonly) UIView * (^topLeft_)(CGRect);//左上距离父控件、宽高固定
@property (nonatomic, assign, readonly) UIView * (^topRight_)(CGRect);//右上距离父控件、宽高固定
@property (nonatomic, assign, readonly) UIView * (^bottomLeft_)(CGRect);//左下距离父控件、宽高固定
@property (nonatomic, assign, readonly) UIView * (^bottomRight_)(CGRect);//右上距离父控件、宽高固定
@property (nonatomic, assign, readonly) UIView * (^heightTop_)(CGRect);//左上右距离父控件、高度固定
@property (nonatomic, assign, readonly) UIView * (^heightBottom_)(CGRect);//左下右距离父控件、高度固定
@property (nonatomic, assign, readonly) UIView * (^insetFrame_)(CGRect);//约束四周边距,对应左上下右
@property (nonatomic, assign, readonly) UIView * (^around_)(void);//约束等于父视图

/**
 回调约束对象,可后期修改，做动画eg.
 */
@property (nonatomic, strong, readonly) NSLayoutConstraint * xf_topCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * xf_leftCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * xf_bottomCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * xf_rightCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * xf_widthCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * xf_heightCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * xf_leadingCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * xf_trailingCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * xf_centerXCS;
@property (nonatomic, strong, readonly) NSLayoutConstraint * xf_centerYCS;

@end