//
//  UIColor+extend.h
//  YDHS
//
//  Created by 陆浩 on 15/11/16.
//  Copyright © 2015年 陆浩. All rights reserved.
//

#import <Foundation/Foundation.h>


// iphone/ipad不支持十六进制的颜色表示，对UIColor进行扩展
@interface UIColor(extend)

// 将十六进制颜色的字符串转化为复合iphone/ipad的颜色
// 字符串为"FFFFFF"
+ (UIColor *)hexChangeFloat:(NSString *) hexColor;

+ (UIColor *)hexChangeFloat:(NSString *)hexColor alpha:(CGFloat)alpha;

@end
