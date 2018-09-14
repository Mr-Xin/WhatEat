//
//  NSString+Additions.m
//  hotbody
//
//  Created by Mr.Yang on 15/10/8.
//  Copyright © 2015年 Beijing Fitcare inc. All rights reserved.
//

#import "NSString+Additions.h"
#import "NSData+XFExt.h"

@implementation NSString (Additions)
- (id)jsonStringParse {
    return [self jsonStringParseWithOptions:NSJSONReadingAllowFragments];
}

- (id)jsonStringMutableParse {
    return [self jsonStringParseWithOptions:NSJSONReadingMutableContainers];
}

- (id)jsonStringParseWithOptions:(NSJSONReadingOptions)opt {
    if (nil == self) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:opt error:&error];
    if (error) {
        HCLog(@"Json:%@>>>解析失败：%@", self, error);
        return nil;
    }
    
    return result;
}

- (NSInteger)charLength {
    NSInteger strLength = 0 ;
    char * p = ( char *)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for ( int i= 0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strLength++;
        }
        else {
            p++;
        }
    }
    return strLength;
}

- (CGFloat)valueOfFloat{
    NSCharacterSet *setToRemove = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."]invertedSet];
    NSString *newString =
    [[self componentsSeparatedByCharactersInSet:setToRemove]
     componentsJoinedByString:@""];
    return [newString floatValue];
}

+ (NSString *)unitConvertWithFloat:(CGFloat)floatValue{
    if (floatValue >= 100000000) {
        floatValue /= 100000000;
        return [NSString stringWithFormat:@"%.2f亿",floatValue];
    }else if (floatValue >= 10000 && floatValue < 100000000){
        floatValue /= 10000;
        return [NSString stringWithFormat:@"%.2f万",floatValue];
    }else if (floatValue > 0 && floatValue < 10000){
        return [self strmethodComma:[NSString stringWithFormat:@"%.2f",floatValue]];
    }else if (floatValue == 0){
        return @"0.00";
    }else if(floatValue <= 0.01){
        return [NSString stringWithFormat:@"%.2f",floatValue];
    }else{
        return [NSString stringWithFormat:@"%.2f",floatValue];
    }
}

+(NSString*)strmethodComma:(NSString*)str
{
    NSString *intStr;
    NSString *floStr;
    if ([str containsString:@"."]) {
        NSRange range = [str rangeOfString:@"."];
        floStr = [str substringFromIndex:range.location];
        intStr = [str substringToIndex:range.location];
    }else{
        floStr = @"";
        intStr = str;
    }
    
    if (intStr.length <=3) {
        return [intStr stringByAppendingString:floStr];
    }else{
        NSInteger length = intStr.length;
        NSInteger count = length/3;
        NSInteger y = length%3;
        NSString *tit = [intStr substringToIndex:y] ;
        NSMutableString *det = [[intStr substringFromIndex:y] mutableCopy];
        
        for (int i =0; i < count; i ++) {
            NSInteger index = i + i *3;
            [det insertString:@","atIndex:index];
        }

        if (y ==0) {
            det = [[det substringFromIndex:1]mutableCopy];
        }
        intStr = [tit stringByAppendingString:det];
        
        return [intStr stringByAppendingString:floStr];
    }
}

- (CGFloat)heightOfStringWithMaxWidth:(CGFloat)width lineSpacing:(CGFloat)lineSpacing font:(UIFont *)font {
    if (nil == font) {
        font = [UIFont systemFontOfSize:12];
    }
    
    CGFloat height = 0;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;// 字体的行间距
    NSDictionary *attribute = @{NSFontAttributeName: font,
                                NSParagraphStyleAttributeName:paragraphStyle};
    height = [self boundingRectWithSize:CGSizeMake(width, HUGE) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.height;
    
    return height;
}

- (CGFloat)heightOfStringWithMaxWidth:(CGFloat)width font:(UIFont *)font {
    if (nil == font) {
        font = [UIFont systemFontOfSize:12];
    }
    
    CGFloat height = 0;
    NSDictionary *attribute = @{NSFontAttributeName: font};
    height = [self boundingRectWithSize:CGSizeMake(width, HUGE) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.height;
    
    return height;
}

- (CGSize)calculateSizeWithWidth:(CGFloat)width Font:(UIFont *)font {
    
    if (nil == font) {
        font = [UIFont systemFontOfSize:12];
    }
    
    CGSize size = CGSizeMake(width, 0);
    CGSize tempSize;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3.0;// 字体的行间距
    NSDictionary *attribute = @{NSFontAttributeName: font,
                                NSParagraphStyleAttributeName:paragraphStyle};
    tempSize = [self boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return tempSize;
}

- (CGSize)calculateSizeWithHeight:(CGFloat)height Font:(UIFont *)font {
    CGSize size = CGSizeMake(0, height);
    CGSize tempSize;
    NSDictionary *attribute = @{NSFontAttributeName: font};
    tempSize = [self boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return tempSize;
}

- (CGFloat)calculateHeightWithWidth:(CGFloat)width Font:(UIFont *)font {
    return roundf([self calculateSizeWithWidth:width Font:font].height);
}

- (CGFloat)calculateWidthWithHeihgt:(CGFloat)height Font:(UIFont *)font {
    return roundf([self calculateSizeWithHeight:height Font:font].width);
}

- (NSInteger)calculateLineNumberWithWidth:(CGFloat)width Font:(UIFont *)font {
    CGFloat oneLineHeight = [@"一行" calculateHeightWithWidth:width Font:font];
    CGFloat allLineHeight = [self calculateHeightWithWidth:width Font:font];
    HCLog(@"oneLineHeight:%f----allLineHeight:%f",oneLineHeight,allLineHeight);
    return roundf(allLineHeight / oneLineHeight);
}

+ (NSInteger)calculateStringNumberAtOneLineWithLabelWidth:(CGFloat)width labelHeight:(CGFloat)height Font:(UIFont *)font {
    CGSize size = CGSizeMake(0, height);
    CGSize tempSize;
    NSDictionary *attribute = @{NSFontAttributeName: font};
    tempSize = [@"一" boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    CGFloat oneStringWidth = tempSize.width;
    return roundf(width / oneStringWidth);
}

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (NSString *)stringByURLEncode {
    if ([self respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
        /**
         AFNetworking/AFURLRequestSerialization.m
         
         Returns a percent-escaped string following RFC 3986 for a query string key or value.
         RFC 3986 states that the following characters are "reserved" characters.
         - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
         - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
         In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
         query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
         should be percent-escaped in the query string.
         - parameter string: The string to be percent-escaped.
         - returns: The percent-escaped string.
         */
        static NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
        static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
        
        NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
        [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
        static NSUInteger const batchSize = 50;
        
        NSUInteger index = 0;
        NSMutableString *escaped = @"".mutableCopy;
        
        while (index < self.length) {
            NSUInteger length = MIN(self.length - index, batchSize);
            NSRange range = NSMakeRange(index, length);
            // To avoid breaking up character sequences such as 👴🏻👮🏽
            range = [self rangeOfComposedCharacterSequencesForRange:range];
            NSString *substring = [self substringWithRange:range];
            NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
            [escaped appendString:encoded];
            
            index += range.length;
        }
        return escaped;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *encoded = (__bridge_transfer NSString *)
        CFURLCreateStringByAddingPercentEscapes(
                                                kCFAllocatorDefault,
                                                (__bridge CFStringRef)self,
                                                NULL,
                                                CFSTR("!#$&'()*+,/:;=?@[]"),
                                                cfEncoding);
        return encoded;
#pragma clang diagnostic pop
    }
}

- (NSString *)stringByURLDecode {
    if ([self respondsToSelector:@selector(stringByRemovingPercentEncoding)]) {
        return [self stringByRemovingPercentEncoding];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding en = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *decoded = [self stringByReplacingOccurrencesOfString:@"+"
                                                            withString:@" "];
        decoded = (__bridge_transfer NSString *)
        CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                NULL,
                                                                (__bridge CFStringRef)decoded,
                                                                CFSTR(""),
                                                                en);
        return decoded;
#pragma clang diagnostic pop
    }
}

- (NSString *)stringByEscapingHTML {
    NSUInteger len = self.length;
    if (!len) return self;
    
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return self;
    [self getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < len; i++) {
        unichar c = buf[i];
        NSString *esc = nil;
        switch (c) {
            case 34: esc = @"&quot;"; break;
            case 38: esc = @"&amp;"; break;
            case 39: esc = @"&apos;"; break;
            case 60: esc = @"&lt;"; break;
            case 62: esc = @"&gt;"; break;
            default: break;
        }
        if (esc) {
            [result appendString:esc];
        } else {
            CFStringAppendCharacters((CFMutableStringRef)result, &c, 1);
        }
    }
    free(buf);
    return result;
}

- (NSString *)base64EncodedString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
}

+ (NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString {
    NSData *data = [NSData dataWithBase64EncodedString:base64EncodedString];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)hmacMD5StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            hmacMD5StringWithKey:key];
}

- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}
@end
