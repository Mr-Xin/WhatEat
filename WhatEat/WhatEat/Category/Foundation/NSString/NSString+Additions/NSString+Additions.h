//
//  NSString+Additions.h
//  hotbody
//
//  Created by Mr.Yang on 15/10/8.
//  Copyright © 2015年 Beijing Fitcare inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

/**
 Json 字符串解析
 
 @return 返回字典或数组，若不是json字符串，返回nil
 */
- (id)jsonStringParse;
- (id)jsonStringMutableParse;
- (NSString *)base64EncodedString;
+ (NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString;
- (NSString *)stringByURLEncode;
- (NSString *)stringByURLDecode;
- (NSString *)stringByEscapingHTML;

- (NSString *)hmacMD5StringWithKey:(NSString *)key;

- (NSInteger)charLength;

- (CGFloat)heightOfStringWithMaxWidth:(CGFloat)width lineSpacing:(CGFloat)lineSpacing font:(UIFont *)font;

- (CGFloat)heightOfStringWithMaxWidth:(CGFloat)width font:(UIFont *)font;

///  将如 36.1% $88.2 转换为 36.1 88.2
- (CGFloat)valueOfFloat;

///  单位转换 ， 如将100000000转换为1亿
+ (NSString *)unitConvertWithFloat:(CGFloat)floatValue;

/**
 *  根据width，font，计算字符串的size
 */
- (CGSize)calculateSizeWithWidth:(CGFloat)width Font:(UIFont *)font;

/**
 *  根据height，font，计算字符串的size
 */
- (CGSize)calculateSizeWithHeight:(CGFloat)height Font:(UIFont *)font;

/**
 *  根据width，font，计算字符串的height
 */
- (CGFloat)calculateHeightWithWidth:(CGFloat)width Font:(UIFont *)font;

/**
 *  根据height，font，计算字符串的width
 */
- (CGFloat)calculateWidthWithHeihgt:(CGFloat)height Font:(UIFont *)font;

/**
 *  根据width，font，计算字符串有几行
 */
- (NSInteger)calculateLineNumberWithWidth:(CGFloat)width Font:(UIFont *)font;

/**
 *  根据width，font，计算一行中有几个字符串
 */
+ (NSInteger)calculateStringNumberAtOneLineWithLabelWidth:(CGFloat)width labelHeight:(CGFloat)height Font:(UIFont *)font;

/**
 Returns the size of the string if it were rendered with the specified constraints.
 
 @param font          The font to use for computing the string size.
 
 @param size          The maximum acceptable size for the string. This value is
 used to calculate where line breaks and wrapping would occur.
 
 @param lineBreakMode The line break options for computing the size of the string.
 For a list of possible values, see NSLineBreakMode.
 
 @return              The width and height of the resulting string's bounding box.
 These values may be rounded up to the nearest whole number.
 */
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

- (NSString *)stringByTrim;

@end
