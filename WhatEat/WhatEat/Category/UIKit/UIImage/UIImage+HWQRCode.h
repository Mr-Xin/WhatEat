//
//  UIImage+HWQRCode.h
//
//  Created by Song on 2017/7/25.
//  Copyright © 2017年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HWQRCode)

+ (UIImage *_Nonnull)hwcodeWithString:(NSString *_Nullable)string
								 size:(CGFloat)width
								color:(UIColor *_Nullable)color
								 icon:(UIImage *_Nullable)icon
							iconWidth:(CGFloat)iconWidth;

- (NSString *)stringOfQRCodeImage;
@end
