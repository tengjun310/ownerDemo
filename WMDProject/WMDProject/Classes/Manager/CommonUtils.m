//
//  CommonUtils.m
//  Store
//
//  Created by 陆浩 on 15/8/4.
//  Copyright (c) 2015年 陆浩. All rights reserved.
//

#import "CommonUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>


@implementation CommonUtils

+ (MBProgressHUD *)showLoadingViewInWindowWithTitle:(NSString*)title
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    UIWindow *mainWin = windows[0];
    UIWindow *window = mainWin;
    for (NSInteger  i = windows.count-1; i >= 0; i--) {
        UIWindow *win = windows[i];
        if (CGRectEqualToRect(win.bounds, mainWin.bounds) && win.windowLevel == UIWindowLevelNormal) {
            window = win;
            break;
        }
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.labelText = title;
    hud.removeFromSuperViewOnHide = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(32 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!hud.isFinished) {
            hud.labelText = @"请求超时";
        }
    });
    [hud hide:YES afterDelay:33];
    
    return hud;
}

+ (MBProgressHUD *)showPromptViewInWindowWithTitle:(NSString*)title afterDelay:(NSTimeInterval)delay{
    NSArray *windows = [UIApplication sharedApplication].windows;
    UIWindow *keyWin = windows[0];
    if ([windows count]>1) {
        keyWin = windows[1];
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:keyWin];
    [keyWin addSubview:hud];
    if (title) {
        hud.labelText = title;
    }
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    if (delay > 0) {
        [hud hide:YES afterDelay:delay];
    }
    return hud;
}

+ (NSString *)jsonString:(id)value
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:value options:NSJSONWritingPrettyPrinted error:nil];
    NSString *string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return string;
}

+ (BOOL)isValidMobilePhone:(NSString *)value
{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:value];
    return isMatch;
}

+ (NSComparisonResult)compareFriendsNameWithName:(NSString *)name OtherName:(NSString *)otherName{
    NSUInteger len = [name length] > [otherName length]? [otherName length]:[name length];
    NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_hans"];
    NSComparisonResult ret = [name compare:otherName options:NSCaseInsensitiveSearch range:NSMakeRange(0, len) locale:local];
    return ret;
}
    
+ (BOOL)isValueIp:(NSString *)value{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|[1-9])\\.(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)\\.(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)\\.(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)$" options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:value options:0 range:NSMakeRange(0, [value length])];
    if (result) {
        return YES;
    }
    else{
        return NO;
    }
}

+ (NSString *)sha256:(NSString *)srcString {
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

+ (NSString *)md5:(NSString *)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

+ (NSString *)formatTime:(NSDate *)date FormatStyle:(NSString *)style{
    NSString * time = @"";
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:style];
    time = [formatter stringFromDate:date];

    return time;
}

+ (NSDate *)getFormatTime:(NSString *)dateStr FormatStyle:(NSString *)style{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:style];
    NSDate * time = [formatter dateFromString:dateStr];
    
    return time;
}

+ (NSString *)getMacAddress {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        free(buf);
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    
    // MAC地址带冒号
    // NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2),
    // *(ptr+3), *(ptr+4), *(ptr+5)];
    
    // MAC地址不带冒号
    NSString *outstring = [NSString
                           stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr + 1), *(ptr + 2), *(ptr + 3), *(ptr + 4), *(ptr + 5)];
    
    free(buf);
    
    return [outstring uppercaseString];
}

+ (NSUInteger)textLength:(NSString *)text{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

+ (NSString*)subTextString:(NSString*)str len:(NSInteger)len{
    if(str.length<=len)return str;
    int count=0;
    NSMutableString *sb = [NSMutableString string];
    
    for (int i=0; i<str.length; i++) {
        NSRange range = NSMakeRange(i, 1) ;
        NSString *aStr = [str substringWithRange:range];
        count += [aStr lengthOfBytesUsingEncoding:NSUTF8StringEncoding]>1?2:1;
        [sb appendString:aStr];
        if(count >= len*2) {
            return (i==str.length-1)?[sb copy]:[NSString stringWithFormat:@"%@...",[sb copy]];
        }
    }
    return str;
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    NSArray *weekdays = [NSArray arrayWithObjects:@"日", @"一", @"二", @"三", @"四", @"五", @"六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}

@end
