//
//  WERouterManager.h
//  HoldCoin
//
//  Created by Jason on 2018/6/23.
//  Copyright © 2018年 Hold. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WERouterProtocol.h"

#define HC_ROUTER_MODULE(url) \
+ (void)load { [WERouterManager registerRouterModule:[self class] forUrl:url];}
///  0 for push with animation , 1 for model with anim, 2 for push without anim , 3 for model without anim
#define HC_ROUTER_MODULE_JUMP(url, type) \
+ (void)load { [WERouterManager registerRouterModule:[self class] forUrl:url jump:type];}

typedef void(^openHandleBlock)(NSDictionary *para);

@interface WERouterManager : NSObject

+ (NSError *)registerRouterModule:(Class)class forUrl:(NSString *)url;
+ (NSError *)registerRouterModule:(Class)class forUrl:(NSString *)url jump:(NSInteger)type;
#pragma mark ------<打开URL页面>
/**
 *  打开URL页面
 *
 *  @param url  页面的url
 *  @param openPara 参数
 *
 *  @return 打开结果
 */
+ (NSError *)openURL:(NSString *)url withPara:(NSDictionary *)openPara;

#pragma mark ------<无参数打开URL>
/**
 *  打开URL页面
 *
 *  @param url url  页面的url
 *
 *  @return 打开结果
 */
+ (NSError *)openURL:(NSString *)url;

#pragma mark ------<获取当前Present的Controller>
/**
 *  获取当前Present的Controller
 *
 *  @return controller
 */
+ (UIViewController *)presentViewController;

#pragma mark ------<获取当前可用NavgationController>
/**
 *  获取当前可用NavgationController
 *
 *  @return NavgationController
 */
+ (UINavigationController *)navgationController;

@end
