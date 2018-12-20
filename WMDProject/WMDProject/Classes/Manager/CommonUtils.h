//
//  CommonUtils.h
//  Store
//
//  Created by 陆浩 on 15/8/4.
//  Copyright (c) 2015年 陆浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

#define HudShowTime     1.2

@interface CommonUtils : NSObject
/**
 *  创建一个显示在窗口中的提示view
 *
 *  @param title    提示文本信息
 *
 *  @return MBProgressHUD
 */
+ (MBProgressHUD *)showLoadingViewInWindowWithTitle:(NSString*)title;

/**
 *  创建一个自动消息的显示在窗口中的提示view
 *
 *  @param title 提示文本信息
 *  @param delay 延时消失时间
 *
 *  @return MBProgressHUD
 */
+ (MBProgressHUD *)showPromptViewInWindowWithTitle:(NSString*)title afterDelay:(NSTimeInterval)delay;

/**
 *  将常规对象转换成json字符串
 *
 *  @param value 数组或者字典
 *
 *  @return 返回json字符串
 */
+ (NSString *)jsonString:(id)value;

/**
 *  是否是手机号码
 *
 *  @param value 手机号码字符串
 *
 *  @return YES or NO
 */
+ (BOOL)isValidMobilePhone:(NSString *)value;


/**
 *  拼音排序
 */
+ (NSComparisonResult)compareFriendsNameWithName:(NSString *)name OtherName:(NSString *)otherName;


//校验ip地址是否合法
+ (BOOL)isValueIp:(NSString *)value;

/**
 *  sha256加密算法
 *
 *  @param srcString 待加密字符串（密码）
 *
 *  @return 加密之后的字符串
 */
+ (NSString *)sha256:(NSString *)srcString;

/**
 *  16位MD5加密算法
 *
 *  @param input 待加密字符串（密码）
 *
 *  @return 加密之后的字符串
 */
+ (NSString *)md5:(NSString *)input;

+ (NSString *)formatTime:(NSDate *)date FormatStyle:(NSString *)style;

+ (NSDate *)getFormatTime:(NSString *)dateStr FormatStyle:(NSString *)style;

+ (NSString *)getMacAddress;

//获取字符串字节长度
+ (NSUInteger)textLength:(NSString *)text;

//按字节长度截取字符串
//注：len为截取的字符长度
+ (NSString*)subTextString:(NSString*)str len:(NSInteger)len;

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
@end
