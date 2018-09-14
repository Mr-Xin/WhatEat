//
//  HCDefine.h
//  hotbody
//
//  Created by Belle on 16/5/11.
//  Copyright © 2016年 Beijing Fitcare inc. All rights reserved.
//

#ifndef HCDefine_h
#define HCDefine_h

// 判断机型
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define BLIsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// 屏幕适配
#ifndef kScreenWidth
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#endif

#ifndef kScreenHeight
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#endif

#ifndef kScreenScale
#define kScreenScale [UIScreen mainScreen].scale
#endif

#define kWidthScale ([UIScreen mainScreen].bounds.size.width/375.0)
#define kHeightScale ([UIScreen mainScreen].bounds.size.height/667.0)
#define kWEAdjustSize(value) (value * kWidthScale)
#define kWEAdjustHeight(value) (value * kHeightScale)
#define kWEAdjustIphoneSize(value) ((BLIsPad) ? value : (value * kWidthScale))
#define kWEAdjustIphoneXStatus(value) ((iPhoneX) ? ((value) + 24) : (value))

#define kWETabbarHeight (iPhoneX ? 83 : 49)
#define kWENavigationBarHeight (iPhoneX ? 88 : 64)
#define kWEStatusBarHeight (iPhoneX ? 44 : 20)
#define kWEIphoneXSafeMargin (iPhoneX ? 34 : 0)

#define kWEBundleVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define kWEBuildVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

// 颜色
// 获得RGB颜色
#define WEColorA(r, g, b ,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define WEColor(r, g, b) WEColorA(r, g, b ,1.0f)
#define UIColorFromHEXA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

// break-if 宏
#ifndef BREAK_IF
#define BREAK_IF(cond) if(cond) break
#endif

#ifdef DEBUG
#define HCLog(format, ...) \
do { \
NSLog(@"<%@ : %d : %s>-: %@", \
[[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
__LINE__, \
__FUNCTION__, \
[NSString stringWithFormat:format, ##__VA_ARGS__]); \
} while(0)
#else
#define HCLog(...)
#endif

// 强、弱指针转换
#ifndef WeakObj
#define WeakObj(obj) autoreleasepool{} __weak typeof(obj) obj##Weak = obj;
#endif

#ifndef StrongObj
#define StrongObj(obj) autoreleasepool{} __strong typeof(obj) obj = obj##Weak;
#endif

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#pragma mark - 常用字体字号
/********************************************常用字体字号********************************************/

#define kWEFontWithCustom(name,s)                       [UIFont fontWithName:name size:s]
#define kWEBoldFontSize(s)                              [UIFont boldSystemFontOfSize:s]
#define kWESystemFontSize(s)                            [UIFont systemFontOfSize:s]

#define kWESystemFont9                                  kWESystemFontSize(9)
#define kWESystemFont10                                 kWESystemFontSize(10)
#define kWESystemFont11                                 kWESystemFontSize(11)
#define kWESystemFont12                                 kWESystemFontSize(12)
#define kWESystemFont13                                 kWESystemFontSize(13)
#define kWESystemFont14                                 kWESystemFontSize(14)
#define kWESystemFont15                                 kWESystemFontSize(15)
#define kWESystemFont16                                 kWESystemFontSize(16)
#define kWESystemFont17                                 kWESystemFontSize(17)
#define kWESystemFont18                                 kWESystemFontSize(18)
#define kWESystemFont19                                 kWESystemFontSize(19)
#define kWESystemFont20                                 kWESystemFontSize(20)

#define kWEBoldFont10                                   kWEBoldFontSize(10)
#define kWEBoldFont11                                   kWEBoldFontSize(11)
#define kWEBoldFont12                                   kWEBoldFontSize(12)
#define kWEBoldFont13                                   kWEBoldFontSize(13)
#define kWEBoldFont14                                   kWEBoldFontSize(14)
#define kWEBoldFont15                                   kWEBoldFontSize(15)
#define kWEBoldFont16                                   kWEBoldFontSize(16)
#define kWEBoldFont17                                   kWEBoldFontSize(17)
#define kWEBoldFont18                                   kWEBoldFontSize(18)
#define kWEBoldFont19                                   kWEBoldFontSize(19)
#define kWEBoldFont20                                   kWEBoldFontSize(20)

/// >>> 苹方-简 纤细体
#define kWEThinFontSize(s)        [UIFont fontWithName:@"PingFangSC-Thin" size:s]
/// >>> 苹方-简 细体
#define kWELightFontSize(s)        [UIFont fontWithName:@"PingFangSC-Light" size:s]
/// >>> 苹方-简 中黑体
#define kWEMediumFontSize(s)        [UIFont fontWithName:@"PingFangSC-Medium" size:s]
/// >>> 苹方-简 常规体
#define kWERegularFontSize(s)        [UIFont fontWithName:@"PingFangSC-Regular" size:s]
/// >>> 苹方-简 中粗体
#define kWESemiboldFontSize(s)        [UIFont fontWithName:@"PingFangSC-Semibold" size:s]
/// >>> 苹方-简 极细体
#define kWEUltralightFontSize(s)        [UIFont fontWithName:@"PingFangSC-Ultralight" size:s]

/// >>> Roboto Mono
#define kWERobotoMonoFontSize(s)        [UIFont fontWithName:@"PingFangSC-Semibold" size:s]

#define kWEHelvetica(size_)    [UIFont fontWithName:@"Helvetica" size:size_]
#define kWEHelvetica_Bold(size_)    [UIFont fontWithName:@"Helvetica-Bold" size:size_]
#define kWEArialMT(size_)           [UIFont fontWithName:@"ArialMT" size:size_]
#define kWEArial_BoldMT(size_)      [UIFont fontWithName:@"Arial-BoldMT" size:size_]

#endif /* HCDefine_h */




















