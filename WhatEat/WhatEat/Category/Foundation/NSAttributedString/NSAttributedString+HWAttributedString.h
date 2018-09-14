//
//  NSAttributedString+HWAttributedString.h
//
//  Created by Song on 2017/9/28.
//  Copyright © 2017年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (HWAttributedString)

+ (NSMutableAttributedString *)attributedStringWithBaseString:(NSString *)baseString
										 attributeDict:(NSDictionary *)attrDict
									placeHolderStrings:(NSArray<NSString *> *)placeHolderStrings
										 replaceImages:(NSArray<UIImage *> *)replaceImages
										   imageBounds:(NSArray<NSValue *> *)imageBounds;

@end
