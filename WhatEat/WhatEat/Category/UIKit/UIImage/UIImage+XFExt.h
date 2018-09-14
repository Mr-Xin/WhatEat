//
//  UIImage+XFExt.h
//  HoldCoin
//
//  Created by 辛峰 on 2018/9/8.
//  Copyright © 2018年 随写. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XFExt)

/**
 Returns a new image which is scaled from this image.
 The image will be stretched as needed.
 
 @param size  The new size to be scaled, values should be positive.
 
 @return      The new image with the given size.
 */
- (nullable UIImage *)imageByResizeToSize:(CGSize)size;

/**
 Returns a new image which is scaled from this image.
 The image content will be changed with thencontentMode.
 
 @param size        The new size to be scaled, values should be positive.
 
 @param contentMode The content mode for image content.
 
 @return The new image with the given size.
 */
- (nullable UIImage *)imageByResizeToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;

//- (UIImage *)imageScaletoKb:(NSInteger)kb;
@end
