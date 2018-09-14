//
//  WERouterManager.m
//  HoldCoin
//
//  Created by Jason on 2018/6/23.
//  Copyright © 2018年 Hold. All rights reserved.
//

#import "WERouterManager.h"
#import "WEBaseNavigationController.h"
#import "WEController.h"

typedef enum : NSUInteger {
    RouterURLTypeInvalid,
    RouterURLTypeWeb,
    RouterURLTypeLocal,
} RouterURLType;

static NSMutableDictionary *_urlCache;
static NSMutableDictionary *_mClassCache;
static NSMutableDictionary *_jumpTypeCache;
static NSMutableDictionary *_paraCache;
static NSMutableDictionary *_urlSwitch;
static NSString *_urlScheme;


@interface WERouterManager ()

@end

@implementation WERouterManager

#pragma mark ------<解析URL地址>
/**
 *  解析URL地址
 *
 *  @param handleBlock 处理Block
 *  @note  yueniu://home
 */
+ (BOOL)analysisUrl:(NSString *)url
         WithHandle:(void(^)(NSString *relativeUrl, NSDictionary *para, RouterURLType urlType))handleBlock {
    
    RouterURLType urlType = RouterURLTypeInvalid;
    NSString *path = url;
    
    if([url hasPrefix:@"http://"]) {
        urlType = RouterURLTypeWeb;
        path = [url substringFromIndex:[@"http://" length]];
    }
    
    if([url hasPrefix:[self urlScheme]]) {
        urlType = RouterURLTypeLocal;
        path = [url substringFromIndex:[[self urlScheme] length]];
    }
    
    if(urlType == RouterURLTypeInvalid) {
        return FALSE;
    }
    
    NSArray *components = [path componentsSeparatedByString:@"?"];
    NSString *relativeUrl = components.firstObject;
    __block NSMutableDictionary *paras = nil;
    if (components.count > 1) {
        /** 获取参数 */
        NSArray *paraComponents = [((NSString *)components[1]) componentsSeparatedByString:@"&"];
        paras = [NSMutableDictionary dictionaryWithCapacity:(paraComponents.count)];
        [paraComponents enumerateObjectsUsingBlock:^(NSString  *component, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *paraComponent = [component componentsSeparatedByString:@"="];
            NSString *key = [NSString stringWithString:paraComponent.firstObject];
            NSString *value = [NSString stringWithString:paraComponent.lastObject];
            if(paraComponent.count > 1) {
                [paras setObject:value forKey:key];
            }
        }];
    }
    
    handleBlock(relativeUrl, paras.copy, urlType);
    
    return TRUE;
}

+ (NSError *)registerRouterModule:(Class)class forUrl:(NSString *)url {
    __block NSError *error = nil;
    
    if(![class conformsToProtocol:@protocol(WERouterProtocol)]) {
        error = [NSError errorWithDomain:@"模块未遵守WERouterProtocol协议" code:501 userInfo:@{@"class":class}];
        HCLog(@"模块未遵守WERouterProtocol协议！");
        return error;
    }
    
    BOOL result = [self analysisUrl:url WithHandle:^(NSString *relativeUrl, NSDictionary *para, RouterURLType urlType) {
        
        if(![self mClassCache][relativeUrl]) {
            [[self mClassCache] setValue:class forKey:relativeUrl];
        }
        else {
            error = [NSError errorWithDomain:@"URL已注册!" code:403 userInfo:@{@"url":url}];
            HCLog(@"该URL已注册！");
        }
    }];
    
    if(!result) error = [NSError errorWithDomain:@"该URL不支持！" code:404 userInfo:nil];
    
    return error;
}

+ (NSError *)registerRouterModule:(Class)class forUrl:(NSString *)url jump:(NSInteger)type {
    NSError *error = [self registerRouterModule:class forUrl:url];
    if(!error) {
        [self analysisUrl:url WithHandle:^(NSString *relativeUrl, NSDictionary *para, RouterURLType urlType) {
            [[self jumpTypeCache] setValue:@(type) forKey:relativeUrl];
        }];
    }
    return error;
}

#pragma mark ------<打开URL页面>
/**
 *  打开URL页面
 *
 *  @param url  页面的url
 *  @param openPara 参数
 *
 *  @return 打开结果
 */
+ (NSError *)openURL:(NSString *)url withPara:(NSDictionary *)openPara {
    __block NSError *error = nil;
    
    BOOL result = [self analysisUrl:url WithHandle:^(NSString *relativeUrl, NSDictionary *para, RouterURLType urlType) {
        switch (urlType) {
            case RouterURLTypeLocal:        /** 本地URL跳转 */
            {
                NSMutableDictionary *mParas = [NSMutableDictionary dictionaryWithDictionary:para];
                [mParas addEntriesFromDictionary:openPara];
                
                Class moduleClass = [self mClassCache][relativeUrl];
                
                if(moduleClass) {
                    if([moduleClass respondsToSelector:@selector(routerCreateControllerInstance:)]) {
                        id result = [moduleClass routerCreateControllerInstance:mParas.copy];
                        if([[result class] isSubclassOfClass:[NSString class]]) {
                            [self openURL:result withPara:openPara];
                        } else if ([[result class] isSubclassOfClass:[UIViewController class]]){
                            [self goNextController:result relativeUrl:relativeUrl];
                        }
                        else {
                            error = [NSError errorWithDomain:@"目标控制器初始化错误/不需要跳转!" code:502 userInfo:@{@"result":result}];
                            HCLog(@"目标控制器初始化错误/不需要跳转!");
                        }
                    }
                }
                else {
                    error = [NSError errorWithDomain:@"URL未注册!" code:404 userInfo:@{@"url":url}];
                    HCLog(@"该URL未注册!");
                }
            }
                break;
            case RouterURLTypeWeb:      /** 网页URL跳转 */
            {
                if([self urlSwitch][relativeUrl]) {
                    NSMutableDictionary *mParas = [NSMutableDictionary dictionaryWithDictionary:para];
                    [mParas addEntriesFromDictionary:openPara];
                    
                    [self openURL:[self urlSwitch][relativeUrl] withPara:mParas];
                }
                else {
                    error = [self openURL:[NSString stringWithFormat:@"%@WebUrl", [self urlScheme]] withPara:@{@"url":url}];
                }
            }
                break;
            case RouterURLTypeInvalid:
            {
                
            }
                break;
            default:
                break;
        }
        
    }];
    
    if(!result) error = [NSError errorWithDomain:@"该URL不支持！" code:404 userInfo:nil];
    
    return error;
}

+ (void)goNextController:(id)nextController relativeUrl:(NSString *)relativeUrl {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSNumber *type = [self jumpTypeCache][relativeUrl];
        
        if(type && (type.integerValue == 1 || type.integerValue == 3)) {
            WEBaseNavigationController *naVc = [[WEBaseNavigationController alloc] initWithRootViewController:nextController];
            if ([[WERouterManager presentViewController] isKindOfClass:[WEController class]]) {
                WEController *tempVC = (WEController *)[WERouterManager presentViewController];
                [tempVC presentVC:naVc animationStyle:AnimationStyleNone completion:nil];
            } else {
                [[WERouterManager presentViewController] presentViewController:naVc animated:(type.integerValue==1) completion:nil];
            }
        }else{
            WEController *tempNextController;
            if ([nextController isKindOfClass:[WEController class]]) {
                tempNextController = nextController;
                tempNextController.customNavigationController = (WEBaseNavigationController *)[WERouterManager navgationController];
            }
            
            if ([[WERouterManager navgationController] isKindOfClass:[WEBaseNavigationController class]]) {
                WEBaseNavigationController *tempNaVc = (WEBaseNavigationController *)[WERouterManager navgationController];
                [tempNaVc pushViewController:nextController animatedStyle:AnimationStyleNone];
            } else {
                [[WERouterManager navgationController] pushViewController:nextController animated:YES];
            }
        }
    });
}

#pragma mark ------<无参数打开URL>
/**
 *  打开URL页面
 *
 *  @param url url  页面的url
 *
 *  @return 打开结果
 */
+ (NSError *)openURL:(NSString *)url {
    return [self openURL:url withPara:nil];
}

#pragma mark ------<获取当前Present的Controller>
/**
 *  获取当前Present的Controller
 *
 *  @return controller
 */
+ (UIViewController *)presentViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([appRootVC isKindOfClass:[WEBaseNavigationController class]]) {
        UIViewController *rootVC = [self currentViewController];

        return rootVC;
    } else {
        UIViewController *topVC = appRootVC;
        while (topVC.presentedViewController) {
            topVC = topVC.presentedViewController;
        }
        
        return topVC;
    }
}

#pragma mark ------<获取当前可用NavgationController>
/**
 *  获取当前可用NavgationController
 *
 *  @return NavgationController
 */
+ (UINavigationController *)navgationController {
    UIViewController *rootVC = [self currentViewController];
    
    if([[rootVC class] isSubclassOfClass:[UITabBarController class]]) {
        UITabBarController *tabVC = (UITabBarController *)rootVC;
        UIViewController *selectedVC = tabVC.selectedViewController;
        if([[selectedVC class] isSubclassOfClass:[UINavigationController class]]) {
            return (UINavigationController *)selectedVC;
        }
        else {
            return nil;
        }
    }
    else if([[rootVC class] isSubclassOfClass:[UINavigationController class]]) {
        return (UINavigationController *)rootVC;
    }
    else {
        return rootVC.navigationController;
    }
}

+ (UIViewController*)currentViewController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
            continue;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
            continue;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        } else {
            break;
        }
    }
    return vc;
}

+ (NSString *)urlScheme {
    if(!_urlScheme) {
        NSArray *urlTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
        [urlTypes enumerateObjectsUsingBlock:^(NSDictionary *urltype, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *urlSchemes = urltype[@"CFBundleURLSchemes"];
            NSString *urlScheme = urlSchemes.firstObject;
            [urlScheme hasPrefix:@"holdCoin"];
            _urlScheme = [NSString stringWithFormat:@"%@://", urlScheme];
            *stop = YES;
        }];
        if(!_urlScheme) HCLog(@"未设置URL Scheme，不能识别本地URL");
    }
    return _urlScheme;
}

+ (NSMutableDictionary *)mClassCache {
    if(!_mClassCache) {
        _mClassCache = [NSMutableDictionary dictionary];
    }
    return _mClassCache;
}

+ (NSMutableDictionary *)jumpTypeCache {
    if(!_jumpTypeCache) {
        _jumpTypeCache = [NSMutableDictionary dictionary];
    }
    return _jumpTypeCache;
}

+ (NSMutableDictionary *)urlSwitch {
    if(!_urlSwitch) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"URLSwitch.plist" ofType:nil];
        _urlSwitch = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    }
    return _urlSwitch;
}

@end
