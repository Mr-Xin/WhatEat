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


#ifndef AnimationStyle_h
#define AnimationStyle_h

typedef enum : NSUInteger {
    /// >>> 无状态
    AnimationStyleNone = 0,
    /// >>> present Circle
    AnimationStyleCircle,//for present
    /// >>> present BackScale
    AnimationStyleBackScale,//for present
    /// >>> present Erect
    AnimationStyleErect,//common
    /// >>> present Tilted
    AnimationStyleTilted,//common
    /// >>> push Scale
    AnimationStyleScale,//for push
    /// >>> push Back
    AnimationStyleBack,//for push
    /// >>> push Cube
    AnimationStyleCube,//for push
    /// >>> push SuckEffect
    AnimationStyleSuckEffect,//for push
    /// >>> push OglFlip
    AnimationStyleOglFlip,//for push
    /// >>> push RippleEffect
    AnimationStyleRippleEffect,//for push
    /// >>> push PageCurl
    AnimationStylePageCurl,//for push
    /// >>> push CameralIrisHollowOpen
    AnimationStyleCameralIrisHollowOpen,//for push
    /// >>> 没有动画
    AnimationStyleNoAnimation,
} AnimationStyle;

#endif /* AnimationStyle_h */
