//
// Created by Andrew Wang on 15/6/4.
// Copyright (c) 2015 Beijing Fitcare inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

- (NSString *)MD5;
- (NSData *)MD5CharData;

/// AES
- (NSString *)resultWithString:(NSString *)string;

/// DES
- (NSString *)customSimpleValueWithString:(NSString *)string;

/// 3DES
- (NSString *)customValueWithString:(NSString *)string;

@end
