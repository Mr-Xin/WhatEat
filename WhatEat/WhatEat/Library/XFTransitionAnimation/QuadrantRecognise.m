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


#import "QuadrantRecognise.h"

typedef enum : NSUInteger {
    QuadrantStyleNone,
    QuadrantStyleFirst,
    QuadrantStyleSecond,
    QuadrantStyleThird,
    QuadrantStyleFourth,
} QuadrantStyle;


@implementation QuadrantRecognise

+ (CGFloat)recogniseWithPoint:(CGPoint)touchPoint
{
    QuadrantStyle style = QuadrantStyleNone;
    if (touchPoint.x>=[UIScreen mainScreen].bounds.size.width/2) {
        
        if (touchPoint.y>=[UIScreen mainScreen].bounds.size.height/2) {
            
            style = QuadrantStyleFourth;
        }else{
            style = QuadrantStyleFirst;
        }
    }else{
        if (touchPoint.y>=[UIScreen mainScreen].bounds.size.height/2) {
            
            style = QuadrantStyleThird;
        }else{
            style = QuadrantStyleSecond;
        }
    }
    CGFloat radius = 0;
    switch (style) {
        case QuadrantStyleFirst:
            radius =  sqrt(touchPoint.x * touchPoint.x  + ([UIScreen mainScreen].bounds.size.height-touchPoint.y) * ([UIScreen mainScreen].bounds.size.height-touchPoint.y));
            break;
            
        case QuadrantStyleSecond:
            radius =  sqrt(([UIScreen mainScreen].bounds.size.width - touchPoint.x) * ([UIScreen mainScreen].bounds.size.width - touchPoint.x)  + ([UIScreen mainScreen].bounds.size.height-touchPoint.y) * ([UIScreen mainScreen].bounds.size.height-touchPoint.y));
            break;
            
        case QuadrantStyleThird:
            radius =  sqrt(([UIScreen mainScreen].bounds.size.width - touchPoint.x) * ([UIScreen mainScreen].bounds.size.width - touchPoint.x)  + touchPoint.y * touchPoint.y);
            break;
            
        case QuadrantStyleFourth:
            radius =  sqrt(touchPoint.x * touchPoint.x  + touchPoint.y * touchPoint.y);
            break;
            
        default:
            break;
    }
    return radius;
}

@end
