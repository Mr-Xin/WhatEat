//
//  NSData+XFExt.h
//  HoldCoin
//
//  Created by 辛峰 on 2018/9/8.
//  Copyright © 2018年 随写. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (XFExt)

- (nullable NSString *)utf8String;
- (nullable NSString *)base64EncodedString;
+ (nullable NSData *)dataWithBase64EncodedString:(NSString *)base64EncodedString;

- (NSString *)hmacMD5StringWithKey:(NSString *)key;

@end
