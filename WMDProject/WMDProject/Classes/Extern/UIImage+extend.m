//
//  UIImage+extend.m
//  YDHS
//
//  Created by 陆浩 on 15/11/16.
//  Copyright © 2015年 陆浩. All rights reserved.
//

#import "UIImage+extend.h"

#define isImageNilNull(obj)     (!obj || [obj isEqual:[NSNull null]])

CGFloat DegreesToRadians_(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees_(CGFloat radians) {return radians * 180/M_PI;};

@implementation UIImage (extend)

- (UIImage *)rescaleImageToSize:(CGSize)size {
	CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
	UIGraphicsBeginImageContext(rect.size);
	[self drawInRect:rect];  // scales image to rect
	UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return resImage;
}

- (UIImage *)cropImageToRect:(CGRect)cropRect {
	// Begin the drawing (again)
	UIGraphicsBeginImageContext(cropRect.size);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	// Tanslate and scale upside-down to compensate for Quartz's inverted coordinate system
	CGContextTranslateCTM(ctx, 0.0, cropRect.size.height);
	CGContextScaleCTM(ctx, 1.0, -1.0);
	
	// Draw view into context
	CGRect drawRect = CGRectMake(-cropRect.origin.x, cropRect.origin.y - (self.size.height - cropRect.size.height) , self.size.width, self.size.height);
	CGContextDrawImage(ctx, drawRect, self.CGImage);
	
	// Create the new UIImage from the context
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	
	// End the drawing
	UIGraphicsEndImageContext();
	
	return newImage;
}

- (CGSize)calculateNewSizeForCroppingBox:(CGSize)croppingBox {
	// Make the shortest side be equivalent to the cropping box.
	CGFloat newHeight, newWidth;
	if (self.size.width < self.size.height) {
		newWidth = croppingBox.width;
		newHeight = (self.size.height / self.size.width) * croppingBox.width;
	} else {
		newHeight = croppingBox.height;
		newWidth = (self.size.width / self.size.height) *croppingBox.height;
	}
	return CGSizeMake(newWidth, newHeight);
}

- (UIImage *)cropCenterAndScaleImageToSize:(CGSize)cropSize {
	UIImage *scaledImage = [self rescaleImageToSize:[self calculateNewSizeForCroppingBox:cropSize]];
	return [scaledImage cropImageToRect:CGRectMake((scaledImage.size.width-cropSize.width)/2, (scaledImage.size.height-cropSize.height)/2, cropSize.width, cropSize.height)];
}

-(UIImage *)scaleImageDown:(CGSize)scaleSize{
	CGSize imageSize = self.size;
	CGSize caledImageSize;
	if (imageSize.width>scaleSize.width&&imageSize.height>scaleSize.width) {
		CGFloat containerRatio = scaleSize.width/scaleSize.height;
		CGFloat imageRatio = imageSize.width/imageSize.height;
		if (imageRatio>containerRatio) {
			//采用container的width
			CGFloat displayedHeight = scaleSize.width*imageSize.height/imageSize.width;
			caledImageSize = CGSizeMake(scaleSize.width, displayedHeight);
		}else{
			//采用container的height
			CGFloat displayedWidth = scaleSize.height*imageSize.width/imageSize.height;
			caledImageSize = CGSizeMake(displayedWidth, scaleSize.height);
		}
	}else if(imageSize.width>scaleSize.width){
		CGFloat displayedHeight = scaleSize.width*imageSize.height/imageSize.width;
		caledImageSize = CGSizeMake(scaleSize.width, displayedHeight);
	}else if(imageSize.height>scaleSize.height){
		CGFloat displayedWidth = scaleSize.height*imageSize.width/imageSize.height;
		caledImageSize = CGSizeMake(displayedWidth, scaleSize.height);
	}else{
		caledImageSize = CGSizeMake(imageSize.width, imageSize.height);
	}
	return [self rescaleImageToSize:caledImageSize];
}

-(UIImage*)cropCenterAndScaleImageToSize2:(CGSize)cropSize{
    CGFloat cropRatio = cropSize.width/cropSize.height;
    CGFloat imageRatio = self.size.width/self.size.height;
    NSLog(@"cropRatio:%f,imageRatio:%f",cropRatio,imageRatio);
    CGSize newSize;
    if (cropRatio<imageRatio) {
        newSize = CGSizeMake(cropSize.width, (cropSize.width/self.size.width)*self.size.height);
    }else {
        newSize = CGSizeMake((cropSize.height/self.size.height)*self.size.width, cropSize.height);
    }
    UIImage *scaledImage = [self rescaleImageToSize:newSize];
    return [scaledImage cropImageToRect:CGRectMake(0, 0, cropSize.width, cropSize.height)];
}

- (UIImage *)imageRotatedByRadians:(CGFloat)radians
{
    return [self imageRotatedByDegrees:RadiansToDegrees_(radians)];
}

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{  
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians_(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
#if !__has_feature(objc_arc)
    [rotatedViewBox release];
#endif
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians_(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

//AddByLuhao
- (UIImage *)resizeImageWithSize:(CGSize)size{
    CGFloat newTmp = size.width/size.height;
    CGFloat height = self.size.height;
    CGFloat width = self.size.width;
    CGFloat oldTmp = width/height;
    
    CGFloat new_y = 0;
    CGFloat new_x = 0;
    CGFloat new_width = width;
    CGFloat new_height = height;
    
    if(oldTmp == newTmp)
    {
        
    }
    else if(oldTmp>newTmp)
    {
        new_width = height*newTmp;
        new_x = (width-new_width)/2.0;
    }
    else
    {
        new_height = width/newTmp;
        new_y = (height-new_height)/2.0;
    }
    return [UIImage imageWithCGImage:CGImageCreateWithImageInRect(self.CGImage, CGRectMake(new_x, new_y, new_width, new_height))];
}

//本地图片处理方式
- (UIImage *)resizeLocalImageWithSize:(CGSize)size{
    CGFloat newTmp = size.width/size.height;
    CGFloat height = self.size.height;
    CGFloat width = self.size.width;
    CGFloat oldTmp = width/height;
    
    CGFloat new_y = 0;
    CGFloat new_x = 0;
    CGFloat new_width = width;
    CGFloat new_height = height;
    
    if(oldTmp == newTmp)
    {
        
    }
    else if(oldTmp>newTmp)
    {
        new_width = height*newTmp;
        new_x = (width-new_width)/2.0;
    }
    else
    {
        new_height = width/newTmp;
        new_y = (height-new_height)/2.0;
    }
    return [UIImage imageWithCGImage:CGImageCreateWithImageInRect(self.CGImage, CGRectMake(new_x*2, new_y*2, new_width*2, new_height*2))];
}


- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end
