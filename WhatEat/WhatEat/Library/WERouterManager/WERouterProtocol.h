//
//  WERouterProtocol.h
//  HoldCoin
//
//  Created by Jason on 2018/6/23.
//  Copyright © 2018年 Hold. All rights reserved.
//

#ifndef WERouterProtocol_h
#define WERouterProtocol_h

@protocol WERouterProtocol <NSObject>

+ (id)routerCreateControllerInstance:(NSDictionary *)params;

@end

#endif /* WERouterProtocol_h */
