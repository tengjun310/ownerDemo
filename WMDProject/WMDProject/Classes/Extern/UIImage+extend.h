//
//  UIImage+extend.h
//  YDHS
//
//  Created by 陆浩 on 15/11/16.
//  Copyright © 2015年 陆浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIImage (extend)
- (UIImage *)rescaleImageToSize:(CGSize)size;
- (UIImage *)cropImageToRect:(CGRect)cropRect;
- (CGSize)calculateNewSizeForCroppingBox:(CGSize)croppingBox;
- (UIImage *)cropCenterAndScaleImageToSize:(CGSize)cropSize;
- (UIImage *)scaleImageDown:(CGSize)scaleSize;
- (UIImage *)cropCenterAndScaleImageToSize2:(CGSize)cropSize;

- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;

/**
 *  将图片转换成对应比例的图片
 *
 *  @param size 放置图片的Imageview的大小
 *
 *  @return 新图片
 */
- (UIImage *)resizeImageWithSize:(CGSize)size;

- (UIImage *)resizeLocalImageWithSize:(CGSize)size;

/**
 *  从相册或者拍照获取到的图片，将图片转正
 *
 *  @return 图片
 */
- (UIImage *)fixOrientation;

/**
 *  根据颜色画色块图片
 *
 *  @param color 颜色
 *
 *  @return 1x1的色块图片
 */
+ (UIImage *) createImageWithColor: (UIColor *) color;

+ (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

@end