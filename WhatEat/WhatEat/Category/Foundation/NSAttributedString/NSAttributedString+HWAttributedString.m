//
//  NSAttributedString+HWAttributedString.m
//
//  Created by Song on 2017/9/28.
//  Copyright © 2017年 . All rights reserved.
//

#import "NSAttributedString+HWAttributedString.h"

@implementation NSAttributedString (HWAttributedString)

+ (NSMutableAttributedString *)attributedStringWithBaseString:(NSString *)baseString
										 attributeDict:(NSDictionary *)attrDict
									placeHolderStrings:(NSArray<NSString *> *)placeHolderStrings
										 replaceImages:(NSArray<UIImage *> *)replaceImages
										   imageBounds:(NSArray<NSValue *> *)imageBounds{
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:attrDict];
	
	__block NSInteger offset = 0;
	[placeHolderStrings enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		NSRange	result = [baseString rangeOfString:obj];
		UIImage * image = replaceImages[idx];
		if (result.location != NSNotFound) {
			NSTextAttachment * imageTextAttachment = [[NSTextAttachment alloc]init] ;
			imageTextAttachment.image = image;
			imageTextAttachment.bounds = imageBounds[idx].CGRectValue;
			NSAttributedString * imageAttributeString = [NSAttributedString attributedStringWithAttachment:imageTextAttachment];
			[attributedString replaceCharactersInRange:NSMakeRange(result.location - offset, result.length) withAttributedString:imageAttributeString];
			offset += obj.length - 1;
		}
	}];
	
	return attributedString;
}

@end
